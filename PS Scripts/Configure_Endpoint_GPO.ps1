<#
================================================================================
  Windows AD Remote Administration Control Center - Endpoint GPO & Shadow Setup
  Created & Developed by Askarali Mattummal
================================================================================
  Purpose:
  Configures a target Windows endpoint (or Domain GPO Computer Startup Policy)
  for zero-friction remote assistance, Desktop Shadowing (screen mirroring),
  WMI diagnostics, Remote Registry, Ping/ICMPv4, and WinRM toast alerts.

  Key Features Configured:
  1. Enables Remote Desktop Connections (fDenyTSConnections = 0).
  2. Sets NLA (UserAuthentication = 0) and restores Termsrv ServiceDll if missing,
     preventing Shadow RPC timeouts and NLA handshake blocks.
  3. Configures Desktop Shadow Policy (Full Control without user prompt by default).
  4. Disables UAC Secure Desktop Prompt Dimming (PromptOnSecureDesktop = 0)
     so technicians never see a black screen during UAC elevation prompts.
  5. Enables inbound Windows Defender Firewall rules (RDP 3389, WMI/RPC 135,
     SMB 445, WinRM 5985, Remote Service Management, and ICMPv4 Echo Ping).
  6. Configures and starts RemoteRegistry, TermService, UmRdpService, and WinRM.

  Optional Parameters:
  -ShadowMode <1|2|3|4>        1=Full+Prompt, 2=Full+Silent, 3=View+Prompt, 4=View+Silent
  -DisableUACSecureDesktop     $true (Default) or $false
  -Revert                      Restore default Windows restrictions and firewall state
  -Force                       Skip interactive confirmation prompt
  -NoPause                     Do not wait for keypress at exit (for GPO/automation)
================================================================================
#>

[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [ValidateSet(1, 2, 3, 4)]
    [int]$ShadowMode = 2,

    [switch]$DisableUACSecureDesktop = $true,

    [switch]$Revert = $false,

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

function Set-VerifiedDwordRegistry {
    param(
        [string]$Label,
        [string]$RegPath,
        [string]$ValueName,
        [int]$DesiredValue
    )
    try {
        if (-not (Test-Path -LiteralPath $RegPath)) {
            New-Item -Path $RegPath -Force -ErrorAction Stop | Out-Null
        }
        Set-ItemProperty -LiteralPath $RegPath -Name $ValueName -Value $DesiredValue -Type DWord -Force -ErrorAction Stop
        $readBack = (Get-ItemProperty -LiteralPath $RegPath -Name $ValueName -ErrorAction Stop).$ValueName
        if ([int]$readBack -eq $DesiredValue) {
            Add-StepResult $Label "SUCCESS" "$RegPath\$ValueName verified = $readBack"
            return $true
        } else {
            Add-StepResult $Label "FAILED" "Expected $ValueName = $DesiredValue, actual = $readBack"
            $script:ExitCode = 1
            return $false
        }
    } catch {
        Add-StepResult $Label "FAILED" "Registry update failed ($RegPath\$ValueName): $($_.Exception.Message)"
        $script:ExitCode = 1
        return $false
    }
}

try {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $isAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    $currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
    $computerName = $env:COMPUTERNAME
    $shadowModeDesc = Get-ShadowModeDescription $ShadowMode

    $osCaption = "Windows"
    try {
        $osInfo = Get-CimInstance -ClassName Win32_OperatingSystem -ErrorAction SilentlyContinue
        if ($osInfo) { $osCaption = "$($osInfo.Caption) ($($osInfo.Version))" }
    } catch { }

    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host "  Windows AD Remote Administration Control Center - Endpoint Provisioning Tool" -ForegroundColor Cyan
    Write-Host "  Created & Developed by Askarali Mattummal" -ForegroundColor Gray
    Write-Host "================================================================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "PURPOSE:" -ForegroundColor Yellow
    if ($Revert) {
        Write-Host "  Revert Desktop Shadowing, UAC, and remote firewall customizations back" -ForegroundColor White
        Write-Host "  to default restricted Windows settings on this computer." -ForegroundColor White
    } else {
        Write-Host "  Prepare this Windows workstation or server for agentless ADRC remote" -ForegroundColor White
        Write-Host "  management: screen shadowing (mstsc /shadow), WMI telemetry, remote" -ForegroundColor White
        Write-Host "  services/registry, ICMP Ping, and WinRM toast notifications." -ForegroundColor White
    }
    Write-Host ""
    Write-Host "TARGET MACHINE & SESSION:" -ForegroundColor Yellow
    Write-Host "  Computer Name       : $computerName" -ForegroundColor White
    Write-Host "  Operating System    : $osCaption" -ForegroundColor White
    Write-Host "  Current User        : $currentUser" -ForegroundColor White
    Write-Host "  Privilege Level     : $(if ($isAdmin) { 'Elevated (Administrator)' } else { 'Standard User (NOT Elevated)' })" -ForegroundColor $(if ($isAdmin) { 'Green' } else { 'Red' })
    Write-Host ""

    Write-Host "[PRE-FLIGHT] Checking permissions and Windows subsystems..." -ForegroundColor Yellow
    if (-not $isAdmin) {
        Add-StepResult "Administrator Check" "FAILED" "This script modifies HKLM registry keys, firewall rules, and Windows services."
        Write-Host ""
        Write-Host "HOW TO FIX:" -ForegroundColor Cyan
        Write-Host "  Right-click Windows PowerShell (or Terminal) and choose 'Run as Administrator'," -ForegroundColor White
        Write-Host "  then run this script again." -ForegroundColor White
        $script:ExitCode = 1
        return
    }
    Add-StepResult "Administrator Check" "SUCCESS" "Running with local Administrator privileges on '$computerName'."

    $hasNetSecurity = $null -ne (Get-Module -ListAvailable -Name "NetSecurity")
    if ($hasNetSecurity) {
        Add-StepResult "NetSecurity Module" "SUCCESS" "Windows Defender Firewall cmdlets available."
    } else {
        Add-StepResult "NetSecurity Module" "WARNING" "NetSecurity module unavailable; firewall rule cmdlets may fall back or report warnings."
    }

    # Planned changes summary
    $shadowKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
    $tsKey = "HKLM:\System\CurrentControlSet\Control\Terminal Server"
    $rdpTcpKey = "HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp"
    $uacKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
    $termParamsKey = "HKLM:\System\CurrentControlSet\Services\TermService\Parameters"
    $firewallGroups = @(
        "Remote Desktop",
        "Windows Management Instrumentation (WMI)",
        "File and Printer Sharing",
        "Windows Remote Management",
        "Remote Service Management"
    )

    Write-Host ""
    Write-Host "================================================================================" -ForegroundColor DarkCyan
    Write-Host "  SUMMARY OF PLANNED CHANGES ON '$computerName'" -ForegroundColor Yellow
    Write-Host "================================================================================" -ForegroundColor DarkCyan
    if ($Revert) {
        Write-Host "  Mode               : REVERT ENDPOINT TO RESTRICTED DEFAULTS" -ForegroundColor Yellow
        Write-Host "  1. Remove Shadow Override  : Delete $shadowKey\Shadow" -ForegroundColor Gray
        Write-Host "  2. Restore UAC Secure Desk : $uacKey\PromptOnSecureDesktop = 1" -ForegroundColor Gray
        Write-Host "  3. Disable Remote Desktop  : $tsKey\fDenyTSConnections = 1, UserAuthentication = 1" -ForegroundColor Gray
        Write-Host "  4. Disable Firewall Groups : Remote Desktop, WMI, Remote Service Management" -ForegroundColor Gray
    } else {
        Write-Host "  Mode               : CONFIGURE ENDPOINT FOR ADRC REMOTE MANAGEMENT" -ForegroundColor Cyan
        Write-Host "  1. Enable Remote Desktop   : fDenyTSConnections = 0, UserAuthentication = 0 + Termsrv ServiceDll check" -ForegroundColor Gray
        Write-Host "  2. Desktop Shadow Policy   : $shadowKey\Shadow = $ShadowMode ($shadowModeDesc)" -ForegroundColor Gray
        if ($DisableUACSecureDesktop) {
            Write-Host "  3. UAC Elevation Display   : $uacKey\PromptOnSecureDesktop = 0 (prevents black screen on UAC prompts)" -ForegroundColor Gray
        } else {
            Write-Host "  3. UAC Elevation Display   : Unchanged (-DisableUACSecureDesktop:$false)" -ForegroundColor DarkGray
        }
        Write-Host "  4. Windows Firewall Groups : $($firewallGroups -join ', '), plus FPS-ICMP4-ERQ-In (Ping)" -ForegroundColor Gray
        Write-Host "  5. Windows Services        : Set Automatic & Start -> RemoteRegistry, TermService, UmRdpService" -ForegroundColor Gray
        Write-Host "  6. WinRM Remote Mgmt       : Run 'winrm quickconfig -q -force' for remote PS & toast notifications" -ForegroundColor Gray
    }
    Write-Host "================================================================================" -ForegroundColor DarkCyan
    Write-Host ""

    if ((-not $Force) -and (-not $WhatIfPreference)) {
        $confirm = Read-Host "Do you want to apply these changes to '$computerName'? Type 'Y' or 'Yes' to continue"
        if ($confirm -notin @('Y', 'y', 'YES', 'Yes', 'yes')) {
            Write-Host ""
            Write-Host "[CANCELLED] Operation cancelled by user. No system changes were made." -ForegroundColor Yellow
            $script:ExitCode = 0
            return
        }
    }

    Write-Host ""

    # REVERT MODE
    if ($Revert) {
        Write-Host "[REVERT] Restoring default Windows security and connectivity settings..." -ForegroundColor Yellow

        if ($PSCmdlet.ShouldProcess($computerName, "Revert ADRC Endpoint GPO & Firewall Settings")) {
            try {
                if (Test-Path -LiteralPath $shadowKey) {
                    $hasProp = (Get-ItemProperty -LiteralPath $shadowKey -ErrorAction SilentlyContinue).PSObject.Properties.Name -contains "Shadow"
                    if ($hasProp) {
                        Remove-ItemProperty -LiteralPath $shadowKey -Name "Shadow" -ErrorAction Stop
                    }
                }
                $checkAfter = (Get-ItemProperty -LiteralPath $shadowKey -Name "Shadow" -ErrorAction SilentlyContinue).Shadow
                if ($null -eq $checkAfter) {
                    Add-StepResult "Remove Shadow Override" "SUCCESS" "Shadow registry override removed/absent."
                } else {
                    Add-StepResult "Remove Shadow Override" "FAILED" "Shadow property still present (value=$checkAfter)."
                    $script:ExitCode = 1
                }
            } catch {
                Add-StepResult "Remove Shadow Override" "FAILED" $_.Exception.Message
                $script:ExitCode = 1
            }

            Set-VerifiedDwordRegistry -Label "Restore UAC Secure Desktop" -RegPath $uacKey -ValueName "PromptOnSecureDesktop" -DesiredValue 1 | Out-Null
            Set-VerifiedDwordRegistry -Label "Disable Remote Desktop" -RegPath $tsKey -ValueName "fDenyTSConnections" -DesiredValue 1 | Out-Null
            Set-VerifiedDwordRegistry -Label "Enable NLA Requirement" -RegPath $rdpTcpKey -ValueName "UserAuthentication" -DesiredValue 1 | Out-Null

            foreach ($revGrp in @("Remote Desktop", "Windows Management Instrumentation (WMI)", "Remote Service Management")) {
                try {
                    $rules = @(Get-NetFirewallRule -DisplayGroup $revGrp -ErrorAction SilentlyContinue)
                    if ($rules.Count -eq 0) {
                        Add-StepResult "Firewall [$revGrp]" "WARNING" "No firewall rules found in display group '$revGrp'."
                    } else {
                        Disable-NetFirewallRule -DisplayGroup $revGrp -ErrorAction Stop
                        Add-StepResult "Firewall [$revGrp]" "SUCCESS" "Disabled $($rules.Count) rule(s)."
                    }
                } catch {
                    Add-StepResult "Firewall [$revGrp]" "WARNING" "Could not disable firewall group '$revGrp': $($_.Exception.Message)"
                }
            }
        }
        return
    }

    # CONFIGURATION MODE
    if ($PSCmdlet.ShouldProcess($computerName, "Configure Endpoint for ADRC Remote Administration & Shadowing")) {
        Write-Host "[1/6] Configuring Remote Desktop & Session Host Services..." -ForegroundColor Yellow
        Set-VerifiedDwordRegistry -Label "Enable Remote Desktop" -RegPath $tsKey -ValueName "fDenyTSConnections" -DesiredValue 0 | Out-Null
        Set-VerifiedDwordRegistry -Label "Shadow NLA Compatibility" -RegPath $rdpTcpKey -ValueName "UserAuthentication" -DesiredValue 0 | Out-Null

        try {
            if (-not (Test-Path -LiteralPath $termParamsKey)) {
                New-Item -Path $termParamsKey -Force -ErrorAction Stop | Out-Null
            }
            $currentDll = (Get-ItemProperty -LiteralPath $termParamsKey -Name "ServiceDll" -ErrorAction SilentlyContinue).ServiceDll
            if ([string]::IsNullOrWhiteSpace($currentDll)) {
                Set-ItemProperty -LiteralPath $termParamsKey -Name "ServiceDll" -Value "%SystemRoot%\System32\termsrv.dll" -Type ExpandString -Force -ErrorAction Stop
                $verifyDll = (Get-ItemProperty -LiteralPath $termParamsKey -Name "ServiceDll" -ErrorAction Stop).ServiceDll
                Add-StepResult "Termsrv ServiceDll" "SUCCESS" "Restored ServiceDll = '$verifyDll'."
            } else {
                Add-StepResult "Termsrv ServiceDll" "SUCCESS" "ServiceDll present ('$currentDll')."
            }
        } catch {
            Add-StepResult "Termsrv ServiceDll" "FAILED" "Could not verify/restore TermService ServiceDll: $($_.Exception.Message)"
            $script:ExitCode = 1
        }

        Write-Host ""
        Write-Host "[2/6] Configuring Desktop Shadow Policy..." -ForegroundColor Yellow
        Set-VerifiedDwordRegistry -Label "Desktop Shadow Policy" -RegPath $shadowKey -ValueName "Shadow" -DesiredValue $ShadowMode | Out-Null

        Write-Host ""
        Write-Host "[3/6] Configuring UAC Elevation Visibility..." -ForegroundColor Yellow
        if ($DisableUACSecureDesktop) {
            Set-VerifiedDwordRegistry -Label "UAC Secure Desktop" -RegPath $uacKey -ValueName "PromptOnSecureDesktop" -DesiredValue 0 | Out-Null
        } else {
            Add-StepResult "UAC Secure Desktop" "SKIPPED" "Retained existing UAC Secure Desktop setting (-DisableUACSecureDesktop:$false)."
        }

        Write-Host ""
        Write-Host "[4/6] Enabling Windows Defender Firewall Inbound Rules..." -ForegroundColor Yellow
        foreach ($fwGroup in $firewallGroups) {
            try {
                $existingRules = @(Get-NetFirewallRule -DisplayGroup $fwGroup -ErrorAction SilentlyContinue)
                if ($existingRules.Count -eq 0) {
                    Add-StepResult "Firewall [$fwGroup]" "WARNING" "No firewall rules found for display group '$fwGroup' (may differ by OS localization)."
                } else {
                    Enable-NetFirewallRule -DisplayGroup $fwGroup -ErrorAction Stop
                    $enabledCount = @((Get-NetFirewallRule -DisplayGroup $fwGroup -ErrorAction SilentlyContinue) | Where-Object { $_.Enabled -eq 'True' }).Count
                    if ($enabledCount -eq $existingRules.Count) {
                        Add-StepResult "Firewall [$fwGroup]" "SUCCESS" "Verified all $enabledCount/$($existingRules.Count) rule(s) enabled."
                    } else {
                        Add-StepResult "Firewall [$fwGroup]" "WARNING" "Enabled $enabledCount of $($existingRules.Count) rule(s)."
                    }
                }
            } catch {
                Add-StepResult "Firewall [$fwGroup]" "WARNING" "Could not enable firewall group '$fwGroup': $($_.Exception.Message)"
            }
        }

        try {
            $icmpRule = Get-NetFirewallRule -Name "FPS-ICMP4-ERQ-In" -ErrorAction SilentlyContinue
            if ($icmpRule) {
                Enable-NetFirewallRule -Name "FPS-ICMP4-ERQ-In" -ErrorAction Stop
                $icmpCheck = Get-NetFirewallRule -Name "FPS-ICMP4-ERQ-In" -ErrorAction Stop
                if ($icmpCheck.Enabled -eq 'True') {
                    Add-StepResult "Firewall [ICMPv4 Ping]" "SUCCESS" "Verified FPS-ICMP4-ERQ-In is enabled."
                } else {
                    Add-StepResult "Firewall [ICMPv4 Ping]" "WARNING" "FPS-ICMP4-ERQ-In state reported Enabled=$($icmpCheck.Enabled)."
                }
            } else {
                Add-StepResult "Firewall [ICMPv4 Ping]" "WARNING" "Rule FPS-ICMP4-ERQ-In was not found on this OS build."
            }
        } catch {
            Add-StepResult "Firewall [ICMPv4 Ping]" "WARNING" "Could not configure FPS-ICMP4-ERQ-In: $($_.Exception.Message)"
        }

        Write-Host ""
        Write-Host "[5/6] Configuring Required Remote Management Services..." -ForegroundColor Yellow
        foreach ($svcName in @("RemoteRegistry", "TermService", "UmRdpService")) {
            try {
                $svc = Get-Service -Name $svcName -ErrorAction Stop
                if ($svc.StartType -ne 'Automatic' -and $svcName -ne 'UmRdpService') {
                    Set-Service -Name $svcName -StartupType Automatic -ErrorAction Stop
                } elseif ($svc.StartType -eq 'Disabled') {
                    Set-Service -Name $svcName -StartupType Automatic -ErrorAction Stop
                }
                if ($svc.Status -ne 'Running') {
                    Start-Service -Name $svcName -ErrorAction Stop
                }
                $svcVerify = Get-Service -Name $svcName -ErrorAction Stop
                if ($svcVerify.Status -eq 'Running') {
                    Add-StepResult "Service [$svcName]" "SUCCESS" "Running (StartType: $($svcVerify.StartType))."
                } else {
                    Add-StepResult "Service [$svcName]" "WARNING" "Current Status = $($svcVerify.Status) (StartType: $($svcVerify.StartType))."
                }
            } catch {
                $sev = if ($svcName -eq 'UmRdpService') { "WARNING" } else { "FAILED" }
                Add-StepResult "Service [$svcName]" $sev $_.Exception.Message
                if ($sev -eq "FAILED") { $script:ExitCode = 1 }
            }
        }

        Write-Host ""
        Write-Host "[6/6] Configuring Windows Remote Management (WinRM)..." -ForegroundColor Yellow
        try {
            $winrmOut = & winrm quickconfig -q -force 2>&1
            $winrmSvc = Get-Service -Name "WinRM" -ErrorAction SilentlyContinue
            if ($LASTEXITCODE -eq 0 -and $winrmSvc -and $winrmSvc.Status -eq 'Running') {
                Add-StepResult "WinRM Service" "SUCCESS" "WinRM quickconfig succeeded and service is Running."
            } elseif ($winrmSvc -and $winrmSvc.Status -eq 'Running') {
                Add-StepResult "WinRM Service" "WARNING" "WinRM service is Running, but quickconfig exited $LASTEXITCODE (check Private/Public network profile): $($winrmOut -join ' ')"
            } else {
                Add-StepResult "WinRM Service" "WARNING" "WinRM did not complete cleanly (exit $LASTEXITCODE): $($winrmOut -join ' ')"
            }
        } catch {
            Add-StepResult "WinRM Service" "WARNING" "WinRM configuration notice: $($_.Exception.Message)"
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
        Write-Host "  FINAL RESULT: SUCCESS ($okCount check(s) applied & verified)" -ForegroundColor Green
    }
    Write-Host "================================================================================" -ForegroundColor Cyan

    if (-not $Revert -and $failedCount -eq 0 -and $script:ExitCode -eq 0) {
        Write-Host ""
        Write-Host "POST-EXECUTION VERIFICATION COMMANDS:" -ForegroundColor Yellow
        Write-Host "  1. Verify Shadow Policy : reg query ""HKLM\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"" /v Shadow" -ForegroundColor Gray
        Write-Host "  2. Verify Services      : sc query TermService & sc query RemoteRegistry & sc query WinRM" -ForegroundColor Gray
        Write-Host "  3. Active User Sessions : qwinsta" -ForegroundColor Gray
        Write-Host "  4. Remote Test Command  : mstsc.exe /shadow:1 /v:$($env:COMPUTERNAME) /control /noConsentPrompt" -ForegroundColor Gray
    }

    Wait-ClosePrompt
    if ($script:ExitCode -ne 0) { exit $script:ExitCode }
}
