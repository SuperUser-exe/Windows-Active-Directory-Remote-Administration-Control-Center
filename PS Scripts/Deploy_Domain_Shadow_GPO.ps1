<#
================================================================================
  Windows AD Remote Administration Control Center - Domain Shadow GPO Provisioner
  Created & Developed by Askarali Mattummal
================================================================================
  Purpose:
  Automated Active Directory Domain Controller provisioning script to create,
  configure, verify, and optionally link a dedicated Group Policy Object (GPO)
  enabling Desktop Shadowing (MSTSC /shadow) and administrative compatibility
  across your target domain Organizational Units.

  Configures the following GPO Registry Policies (Computer Configuration):
  1. Set rules for remote control of Remote Desktop Services user sessions:
     -> Path  : HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services
     -> Value : Shadow = <1|2|3|4> (Default 2 = Full Control without consent)
  2. Allow users to connect remotely by using Remote Desktop Services:
     -> Path  : HKLM\System\CurrentControlSet\Control\Terminal Server
     -> Value : fDenyTSConnections = 0
  3. Disable NLA requirement so /shadow attaches directly without NLA blocking:
     -> Path  : HKLM\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp
     -> Value : UserAuthentication = 0
  4. Turn off UAC PromptOnSecureDesktop dimming during elevated admin prompts:
     -> Path  : HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System
     -> Value : PromptOnSecureDesktop = 0

  Requirements:
  - Must be executed on an Active Directory Domain Controller or domain-joined
    workstation with RSAT Group Policy Management Tools installed.
  - Requires permissions to create, edit, and link GPOs (e.g. Domain Admins or
    delegated Group Policy Creator Owners + Link GPO rights on target OU).

  Optional Parameters:
  -GPOName <string>            Name of Domain GPO
  -TargetOU <string>           DistinguishedName of OU to link (optional)
  -ShadowMode <1|2|3|4>        1=Full+Prompt, 2=Full+Silent, 3=View+Prompt, 4=View+Silent
  -DisableUACSecureDesktop     $true (Default) or $false
  -RemoveGPO                   Delete the specified GPO cleanly
  -Force                       Skip interactive confirmation prompt
  -NoPause                     Do not wait for keypress at exit (for CI/automation)
================================================================================
#>

[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [string]$GPOName = "ADRC - Remote Desktop Shadow & Administration Policy",

    [string]$TargetOU = "",

    [ValidateSet(1, 2, 3, 4)]
    [int]$ShadowMode = 2,

    [switch]$DisableUACSecureDesktop = $true,

    [switch]$RemoveGPO = $false,

    [switch]$Force = $false,

    [switch]$NoPause = $false
)

$ErrorActionPreference = "Stop"
$script:StepResults = New-Object System.Collections.Generic.List[object]
$script:ExitCode = 0

function Add-StepResult {
    param(
        [string]$Step,
        [ValidateSet("SUCCESS", "WARNING", "FAILED", "INFO", "SKIPPED")]
        [string]$Status,
        [string]$Detail
    )
    $script:StepResults.Add([PSCustomObject]@{
        Step   = $Step
        Status = $Status
        Detail = $Detail
    }) | Out-Null

    $color = switch ($Status) {
        "SUCCESS" { "Green" }
        "WARNING" { "Yellow" }
        "FAILED"  { "Red" }
        "SKIPPED" { "DarkGray" }
        default   { "Cyan" }
    }
    Write-Host ("  [{0,-7}] {1}: {2}" -f $Status, $Step, $Detail) -ForegroundColor $color
}

function Wait-ClosePrompt {
    if ($NoPause) { return }
    Write-Host ""
    Write-Host "Press any key to close this window..." -ForegroundColor Cyan
    try {
        if ($Host.UI -and $Host.UI.RawUI -and (-not [Console]::IsInputRedirected)) {
            $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
            Write-Host ""
            return
        }
    } catch { }
    try { Read-Host "Press Enter to close" | Out-Null } catch { }
}

function Get-ShadowModeDescription([int]$mode) {
    switch ($mode) {
        1 { return "Full Control with user consent prompt (Shadow = 1)" }
        2 { return "Full Control without user consent prompt (Shadow = 2) [Recommended]" }
        3 { return "View Session with user consent prompt (Shadow = 3)" }
        4 { return "View Session without user consent prompt (Shadow = 4)" }
        default { return "Full Control without user consent prompt (Shadow = 2)" }
    }
}

try {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $isLocalAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    $currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
    $computerName = $env:COMPUTERNAME
    $shadowModeDesc = Get-ShadowModeDescription $ShadowMode

    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "  Windows AD Remote Administration Control Center - Domain Shadow GPO Provisioner" -ForegroundColor Cyan
    Write-Host "  Created & Developed by Askarali Mattummal" -ForegroundColor Gray
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "PURPOSE:" -ForegroundColor Yellow
    if ($RemoveGPO) {
        Write-Host "  Safely locate and remove the specified Active Directory Shadow GPO." -ForegroundColor White
    } else {
        Write-Host "  Create/update an Active Directory Group Policy Object (GPO) so domain" -ForegroundColor White
        Write-Host "  computers accept remote IT screen shadowing (mstsc /shadow) cleanly," -ForegroundColor White
        Write-Host "  optionally disable UAC Secure Desktop blackout, and link to a target OU." -ForegroundColor White
    }
    Write-Host ""
    Write-Host "EXECUTION ENVIRONMENT:" -ForegroundColor Yellow
    Write-Host "  Executed On Machine : $computerName" -ForegroundColor White
    Write-Host "  Current User        : $currentUser" -ForegroundColor White
    Write-Host "  Local Elevation     : $(if ($isLocalAdmin) { 'Elevated (Administrator)' } else { 'Standard User (Non-Elevated)' })" -ForegroundColor $(if ($isLocalAdmin) { 'Green' } else { 'Yellow' })
    Write-Host "  Target GPO Name     : $GPOName" -ForegroundColor White
    Write-Host "  Target Link Scope   : $(if ([string]::IsNullOrWhiteSpace($TargetOU)) { '(None - Create/Update GPO only; link manually or pass -TargetOU)' } else { $TargetOU })" -ForegroundColor White
    Write-Host ""

    # Pre-flight checks
    Write-Host "[PRE-FLIGHT] Checking Active Directory & Group Policy prerequisites..." -ForegroundColor Yellow

    if (-not (Get-Module -ListAvailable -Name "GroupPolicy")) {
        Add-StepResult "RSAT GroupPolicy Module" "FAILED" "Module 'GroupPolicy' not installed on '$computerName'."
        Write-Host ""
        Write-Host "HOW TO FIX:" -ForegroundColor Cyan
        Write-Host "  - On Domain Controller / Windows Server: Install-WindowsFeature GPMC" -ForegroundColor Gray
        Write-Host "  - On Windows 10 / 11 Admin PC: Add-WindowsCapability -Online -Name Rsat.GroupPolicy.Management.Tools~~~~0.0.1.0" -ForegroundColor Gray
        $script:ExitCode = 1
        return
    }
    Import-Module GroupPolicy -ErrorAction Stop
    Add-StepResult "RSAT GroupPolicy Module" "SUCCESS" "GroupPolicy PowerShell module loaded."

    $domainDns = ""
    try {
        $domainObj = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
        $domainDns = $domainObj.Name
        Add-StepResult "Active Directory Context" "SUCCESS" "Connected to domain '$domainDns' (PDC: $($domainObj.PdcRoleOwner.Name))."
    } catch {
        Add-StepResult "Active Directory Context" "FAILED" "Unable to contact Active Directory domain: $($_.Exception.Message)"
        $script:ExitCode = 1
        return
    }

    $existingGpo = Get-GPO -Name $GPOName -ErrorAction SilentlyContinue
    if ($existingGpo) {
        Add-StepResult "GPO Pre-Check" "INFO" "Found existing GPO '$GPOName' (ID: $($existingGpo.Id), Domain: $($existingGpo.DomainName))."
    } else {
        Add-StepResult "GPO Pre-Check" "INFO" "GPO '$GPOName' does not yet exist."
    }

    if ((-not $RemoveGPO) -and (-not [string]::IsNullOrWhiteSpace($TargetOU))) {
        try {
            $null = Get-GPInheritance -Target $TargetOU -ErrorAction Stop
            Add-StepResult "Target OU Validation" "SUCCESS" "Verified target container '$TargetOU' is reachable."
        } catch {
            Add-StepResult "Target OU Validation" "WARNING" "Could not inspect target '$TargetOU': $($_.Exception.Message)"
        }
    }

    # Planned changes preview
    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor DarkCyan
    Write-Host "  SUMMARY OF PLANNED CHANGES" -ForegroundColor Yellow
    Write-Host "================================================================================" -ForegroundColor DarkCyan
    if ($RemoveGPO) {
        Write-Host "  Mode               : REMOVE / DELETE DOMAIN GPO" -ForegroundColor Red
        Write-Host "  Target GPO         : '$GPOName' in domain '$domainDns'" -ForegroundColor White
        Write-Host "  Action             : Permanently delete GPO and all its OU links." -ForegroundColor Gray
    } else {
        Write-Host "  Mode               : CREATE / UPDATE DOMAIN GPO" -ForegroundColor Cyan
        Write-Host "  Target Domain      : $domainDns" -ForegroundColor White
        Write-Host "  GPO Display Name   : $GPOName" -ForegroundColor White
        Write-Host "  1. Terminal Services Shadowing :" -ForegroundColor White
        Write-Host "     HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services\Shadow = $ShadowMode ($shadowModeDesc)" -ForegroundColor Gray
        Write-Host "  2. Enable Remote Connections   :" -ForegroundColor White
        Write-Host "     HKLM\System\CurrentControlSet\Control\Terminal Server\fDenyTSConnections = 0" -ForegroundColor Gray
        Write-Host "  3. Direct Shadow Compatibility :" -ForegroundColor White
        Write-Host "     HKLM\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp\UserAuthentication = 0" -ForegroundColor Gray
        if ($DisableUACSecureDesktop) {
            Write-Host "  4. UAC Elevation Visibility    :" -ForegroundColor White
            Write-Host "     HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\PromptOnSecureDesktop = 0" -ForegroundColor Gray
        } else {
            Write-Host "  4. UAC Elevation Visibility    : Unchanged (-DisableUACSecureDesktop:$false)" -ForegroundColor DarkGray
        }
        if (-not [string]::IsNullOrWhiteSpace($TargetOU)) {
            Write-Host "  5. GPO Link Target             : $TargetOU (LinkEnabled = Yes)" -ForegroundColor White
        } else {
            Write-Host "  5. GPO Link Target             : None (No -TargetOU specified)" -ForegroundColor DarkGray
        }
        Write-Host ""
        Write-Host "  NOTE: Client Firewall inbound rules (TCP 3389 / 445 / 135) must also be enabled" -ForegroundColor DarkYellow
        Write-Host "        via GPO Windows Firewall Policies or PS Scripts\Configure_Endpoint_GPO.ps1." -ForegroundColor DarkYellow
    }
    Write-Host "================================================================================" -ForegroundColor DarkCyan
    Write-Host ""

    if ((-not $Force) -and (-not $WhatIfPreference)) {
        $confirm = Read-Host "Do you want to apply these changes? Type 'Y' or 'Yes' to continue"
        if ($confirm -notin @('Y', 'y', 'YES', 'Yes', 'yes')) {
            Write-Host ""
            Write-Host "[CANCELLED] Operation cancelled by user. Zero changes were applied." -ForegroundColor Yellow
            $script:ExitCode = 0
            return
        }
    }

    Write-Host ""

    # Execute operation
    if ($RemoveGPO) {
        if (-not $existingGpo) {
            Add-StepResult "Delete Domain GPO" "INFO" "GPO '$GPOName' does not exist in '$domainDns'; nothing to remove."
        } elseif ($PSCmdlet.ShouldProcess($GPOName, "Remove-GPO")) {
            Remove-GPO -Name $GPOName -Confirm:$false -ErrorAction Stop
            $verifyGone = Get-GPO -Name $GPOName -ErrorAction SilentlyContinue
            if ($null -eq $verifyGone) {
                Add-StepResult "Verify GPO Removal" "SUCCESS" "Confirmed '$GPOName' has been permanently deleted from '$domainDns'."
            } else {
                Add-StepResult "Verify GPO Removal" "FAILED" "GPO '$GPOName' still appears in Active Directory after removal attempt."
                $script:ExitCode = 1
            }
        }
        return
    }

    # Apply / Update Mode
    $gpo = $existingGpo
    if ($null -eq $gpo) {
        if ($PSCmdlet.ShouldProcess($GPOName, "New-GPO")) {
            $gpo = New-GPO -Name $GPOName -Comment "Configured for Windows Active Directory Remote Administration Control Center - Desktop Shadowing & Remote Assistance." -ErrorAction Stop
            Add-StepResult "Create Domain GPO" "SUCCESS" "Created GPO '$GPOName' (ID: $($gpo.Id))."
        }
    } else {
        Add-StepResult "Locate Domain GPO" "SUCCESS" "Using existing GPO '$GPOName' (ID: $($gpo.Id))."
    }

    $regRules = @(
        @{
            Label = "Terminal Services Shadow Policy"
            Key   = "HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
            Name  = "Shadow"
            Type  = "DWord"
            Value = $ShadowMode
        },
        @{
            Label = "Enable Remote Desktop Connections"
            Key   = "HKLM\System\CurrentControlSet\Control\Terminal Server"
            Name  = "fDenyTSConnections"
            Type  = "DWord"
            Value = 0
        },
        @{
            Label = "Remote Shadow NLA Compatibility"
            Key   = "HKLM\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp"
            Name  = "UserAuthentication"
            Type  = "DWord"
            Value = 0
        }
    )

    if ($DisableUACSecureDesktop) {
        $regRules += @{
            Label = "Disable UAC Secure Desktop Blackout"
            Key   = "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
            Name  = "PromptOnSecureDesktop"
            Type  = "DWord"
            Value = 0
        }
    }

    foreach ($rule in $regRules) {
        try {
            if ($PSCmdlet.ShouldProcess("$GPOName -> $($rule.Key)\$($rule.Name)", "Set-GPRegistryValue=$($rule.Value)")) {
                Set-GPRegistryValue -Name $GPOName -Key $rule.Key -ValueName $rule.Name -Type $rule.Type -Value $rule.Value -ErrorAction Stop | Out-Null
                Add-StepResult "Apply $($rule.Label)" "SUCCESS" "$($rule.Name) = $($rule.Value)"
            }
        } catch {
            Add-StepResult "Apply $($rule.Label)" "FAILED" $_.Exception.Message
            $script:ExitCode = 1
        }
    }

    if (-not [string]::IsNullOrWhiteSpace($TargetOU)) {
        try {
            if ($PSCmdlet.ShouldProcess("$TargetOU", "New-GPLink $GPOName")) {
                $existingInh = Get-GPInheritance -Target $TargetOU -ErrorAction SilentlyContinue
                $alreadyLinked = $false
                if ($existingInh -and $existingInh.GpoLinks) {
                    $matchedLink = $existingInh.GpoLinks | Where-Object { $_.DisplayName -eq $GPOName } | Select-Object -First 1
                    if ($matchedLink) {
                        $alreadyLinked = $true
                        if (-not $matchedLink.Enabled) {
                            Set-GPLink -Name $GPOName -Target $TargetOU -LinkEnabled Yes -ErrorAction Stop | Out-Null
                            Add-StepResult "Enable Existing GPO Link" "SUCCESS" "Enabled existing GPO link on '$TargetOU'."
                        } else {
                            Add-StepResult "Link GPO to OU" "SUCCESS" "GPO '$GPOName' is already linked and enabled on '$TargetOU'."
                        }
                    }
                }
                if (-not $alreadyLinked) {
                    New-GPLink -Name $GPOName -Target $TargetOU -LinkEnabled Yes -ErrorAction Stop | Out-Null
                    Add-StepResult "Link GPO to OU" "SUCCESS" "Linked GPO '$GPOName' to '$TargetOU'."
                }
            }
        } catch {
            Add-StepResult "Link GPO to OU" "FAILED" "Could not link to '$TargetOU': $($_.Exception.Message)"
            $script:ExitCode = 1
        }
    } else {
        Add-StepResult "Link GPO to OU" "SKIPPED" "No -TargetOU provided; link '$GPOName' to your Computer OU via gpmc.msc."
    }

    # Live Read-Back Verification
    if (-not $WhatIfPreference) {
        Write-Host ""
        Write-Host "[VERIFICATION] Reading back live GPO policy values from Active Directory..." -ForegroundColor Yellow

        $verifiedGpo = Get-GPO -Name $GPOName -ErrorAction SilentlyContinue
        if ($null -eq $verifiedGpo) {
            Add-StepResult "Verify GPO Exists" "FAILED" "Get-GPO did not return '$GPOName' after configuration."
            $script:ExitCode = 1
        } else {
            Add-StepResult "Verify GPO Exists" "SUCCESS" "Confirmed '$($verifiedGpo.DisplayName)' (Status: $($verifiedGpo.GpoStatus), Rev: Computer $($verifiedGpo.Computer.DSVersion))."
        }

        foreach ($rule in $regRules) {
            try {
                $readBack = Get-GPRegistryValue -Name $GPOName -Key $rule.Key -ValueName $rule.Name -ErrorAction Stop
                if ($null -ne $readBack -and ([string]$readBack.Value -eq [string]$rule.Value)) {
                    Add-StepResult "Verify $($rule.Name)" "SUCCESS" "Live GPO value confirmed = $($readBack.Value)"
                } else {
                    $actualVal = if ($null -eq $readBack) { "<missing>" } else { $readBack.Value }
                    Add-StepResult "Verify $($rule.Name)" "FAILED" "Expected $($rule.Value), read back '$actualVal'."
                    $script:ExitCode = 1
                }
            } catch {
                Add-StepResult "Verify $($rule.Name)" "FAILED" "Read-back failed: $($_.Exception.Message)"
                $script:ExitCode = 1
            }
        }

        if (-not [string]::IsNullOrWhiteSpace($TargetOU)) {
            try {
                $inhCheck = Get-GPInheritance -Target $TargetOU -ErrorAction Stop
                $linkCheck = $inhCheck.GpoLinks | Where-Object { $_.DisplayName -eq $GPOName } | Select-Object -First 1
                if ($linkCheck -and $linkCheck.Enabled) {
                    Add-StepResult "Verify OU Link" "SUCCESS" "GPO link confirmed ACTIVE & ENABLED on '$TargetOU'."
                } else {
                    Add-StepResult "Verify OU Link" "FAILED" "GPO link on '$TargetOU' was not found enabled after read-back."
                    $script:ExitCode = 1
                }
            } catch {
                Add-StepResult "Verify OU Link" "WARNING" "Could not verify link on '$TargetOU': $($_.Exception.Message)"
            }
        }
    }
}
catch {
    Add-StepResult "Unhandled Error" "FAILED" $_.Exception.Message
    $script:ExitCode = 1
}
finally {
    $failedCount = @($script:StepResults | Where-Object { $_.Status -eq "FAILED" }).Count
    $warnCount = @($script:StepResults | Where-Object { $_.Status -eq "WARNING" }).Count
    $okCount = @($script:StepResults | Where-Object { $_.Status -eq "SUCCESS" }).Count

    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
    if ($failedCount -gt 0 -or $script:ExitCode -ne 0) {
        Write-Host "  FINAL RESULT: COMPLETED WITH ERRORS ($failedCount failed, $warnCount warning(s), $okCount passed)" -ForegroundColor Red
        $script:ExitCode = 1
    } elseif ($warnCount -gt 0) {
        Write-Host "  FINAL RESULT: COMPLETED WITH WARNINGS ($warnCount warning(s), $okCount passed)" -ForegroundColor Yellow
    } else {
        Write-Host "  FINAL RESULT: SUCCESS ($okCount step(s) verified)" -ForegroundColor Green
    }
    Write-Host "================================================================================" -ForegroundColor Cyan

    if (-not $RemoveGPO -and $failedCount -eq 0 -and $script:ExitCode -eq 0) {
        Write-Host ""
        Write-Host "NEXT STEPS & VERIFICATION COMMANDS ON TARGET WORKSTATIONS:" -ForegroundColor Yellow
        Write-Host "  1. Refresh Group Policy : gpupdate /force" -ForegroundColor Gray
        Write-Host "  2. Verify Applied GPO   : gpresult /r /scope computer" -ForegroundColor Gray
        Write-Host "  3. Inspect Shadow Key   : reg query ""HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"" /v Shadow" -ForegroundColor Gray
        if ([string]::IsNullOrWhiteSpace($TargetOU)) {
            Write-Host "  4. Link Policy in AD    : Open gpmc.msc and link '$GPOName' to your Workstations OU." -ForegroundColor Gray
        }
    }

    Wait-ClosePrompt
    if ($script:ExitCode -ne 0) { exit $script:ExitCode }
}
