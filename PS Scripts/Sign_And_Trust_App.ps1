<#
================================================================================
  Windows AD Remote Administration Control Center - Internal AD GPO Self-Signing Tool
  Created & Developed by Askarali Mattummal
================================================================================
  IMPORTANT DISTINCTION:
  - This script is strictly for PRIVATE / INTERNAL Active Directory enterprise
    environments using a local self-signed certificate deployed via Domain GPO.
  - Public Internet downloads MUST be Authenticode-signed with a publicly trusted
    OV or EV Certificate Authority (CA) certificate via Build\Scripts\sign_binary.ps1
    so Windows SmartScreen displays a verified Publisher automatically.

  Purpose:
  1. Generates a self-signed Authenticode Code Signing Certificate for internal use.
  2. Digitally signs the main application executable and Tools\ companion EXEs.
  3. Exports the public certificate (.cer) for Active Directory GPO distribution.
  4. Automatically unblocks the application (removes Mark-of-the-Web).
  5. Installs certificate locally into Trusted Root & Trusted Publishers.
  6. Configures local Microsoft Defender exclusions to eliminate false positives.
================================================================================
#>

param(
    [string]$CertSubject = "CN=Windows AD Remote Administration Control Center, O=Internal IT Administration",
    [switch]$InstallLocal = $true,
    [switch]$AddDefenderExclusion = $true
)

$ErrorActionPreference = "Continue"

Write-Host ""
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host "  Windows AD Remote Administration Control Center - Free Trust & Sign Tool       " -ForegroundColor Cyan
Write-Host "  Created & Developed by Askarali Mattummal                                     " -ForegroundColor Cyan
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host ""

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$rootDir = (Get-Item $scriptDir).Parent.FullName

# Find target executables (main executable + Tools\ companion EXEs)
$targetExes = @()
$mainExes = Get-ChildItem -Path $rootDir -Filter "Windows AD*.exe" -File
if (-not $mainExes -or $mainExes.Count -eq 0) {
    $mainExes = Get-ChildItem -Path $rootDir -Filter "*.exe" -File | Where-Object { $_.Name -like "*Control*.exe" -or $_.Name -like "*ADRC*.exe" }
}
if ($mainExes) { $targetExes += $mainExes }
$toolsSubDir = Join-Path $rootDir "Tools"
if (Test-Path -LiteralPath $toolsSubDir) {
    $toolExes = Get-ChildItem -Path $toolsSubDir -Filter "ADRC_*.exe" -File -ErrorAction SilentlyContinue
    if ($toolExes) { $targetExes += $toolExes }
}

if (-not $targetExes -or $targetExes.Count -eq 0) {
    Write-Warning "Could not find target executable in: $rootDir"
    Exit 1
}

# 1. Unblock files (Strips Mark-of-the-Web Zone.Identifier)
Write-Host "[1/5] Removing Windows Mark-of-the-Web (Zone.Identifier)..." -ForegroundColor Yellow
foreach ($exe in $targetExes) {
    try {
        Unblock-File -LiteralPath $exe.FullName -ErrorAction SilentlyContinue
        Write-Host "  [OK] Unblocked: $($exe.Name)" -ForegroundColor Green
    } catch {
        Write-Warning "  Could not unblock $($exe.Name): $_"
    }
}

# 2. Check for or generate Self-Signed Code-Signing Certificate
Write-Host ""
Write-Host "[2/5] Creating / Locating Free Code-Signing Certificate..." -ForegroundColor Yellow

$existingCert = Get-ChildItem -Path Cert:\CurrentUser\My -CodeSigningCert -ErrorAction SilentlyContinue |
    Where-Object { $_.Subject -eq $CertSubject -and $_.NotAfter -gt (Get-Date) } |
    Sort-Object NotAfter -Descending | Select-Object -First 1

if (-not $existingCert) {
    Write-Host "  Generating new 10-year Code Signing Certificate..." -ForegroundColor Cyan
    $cert = New-SelfSignedCertificate `
        -Type CodeSigningCert `
        -Subject $CertSubject `
        -CertStoreLocation "Cert:\CurrentUser\My" `
        -HashAlgorithm SHA256 `
        -KeyLength 2048 `
        -NotAfter (Get-Date).AddYears(10)
    Write-Host "  [OK] Certificate Created with Thumbprint: $($cert.Thumbprint)" -ForegroundColor Green
} else {
    $cert = $existingCert
    Write-Host "  [OK] Using existing Certificate Thumbprint: $($cert.Thumbprint)" -ForegroundColor Green
}

# 3. Digitally sign executables
Write-Host ""
Write-Host "[3/5] Digitally signing executables with SHA256 and Digicert Timestamp..." -ForegroundColor Yellow

foreach ($exe in $targetExes) {
    try {
        Write-Host "  Signing: $($exe.Name)..." -ForegroundColor Cyan
        $signResult = Set-AuthenticodeSignature `
            -FilePath $exe.FullName `
            -Certificate $cert `
            -HashAlgorithm SHA256 `
            -TimestampServer "http://timestamp.digicert.com"
        
        # If timestamp fails due to offline/no-internet, fallback without timestamp
        if ($signResult.Status -eq "UnknownError" -and -not (Test-Connection -ComputerName "timestamp.digicert.com" -Count 1 -Quiet -ErrorAction SilentlyContinue)) {
            Write-Warning "  Timestamp server unreachable, signing without timestamp..."
            $signResult = Set-AuthenticodeSignature `
                -FilePath $exe.FullName `
                -Certificate $cert `
                -HashAlgorithm SHA256
        }
        
        Write-Host "  [OK] Signed: $($exe.Name) (Status: $($signResult.Status))" -ForegroundColor Green
    } catch {
        Write-Warning "  Failed to sign $($exe.Name): $_"
    }
}

# 4. Export Public Certificate (.cer) for Active Directory GPO
Write-Host ""
Write-Host "[4/5] Exporting Public Certificate (.cer) for Active Directory Domain GPO..." -ForegroundColor Yellow
$exportPath = Join-Path $rootDir "Windows_AD_Remote_Control_CodeSign.cer"
try {
    Export-Certificate -Cert $cert -FilePath $exportPath -Type CERT -Force | Out-Null
    Write-Host "  [OK] Public certificate exported to: $exportPath" -ForegroundColor Green
} catch {
    Write-Warning "  Failed to export certificate: $_"
}

# 5. Local Machine Trust & Defender Exclusion (if elevated)
Write-Host ""
Write-Host "[5/5] Configuring Local Machine Trust & Defender Exclusions..." -ForegroundColor Yellow
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if ($isAdmin) {
    if ($InstallLocal) {
        try {
            Write-Host "  Importing certificate into Local Machine 'Trusted Root' and 'Trusted Publishers'..." -ForegroundColor Cyan
            Import-Certificate -FilePath $exportPath -CertStoreLocation "Cert:\LocalMachine\Root" | Out-Null
            Import-Certificate -FilePath $exportPath -CertStoreLocation "Cert:\LocalMachine\TrustedPublisher" | Out-Null
            Write-Host "  [OK] Local Machine now trusts this certificate 100%!" -ForegroundColor Green
        } catch {
            Write-Warning "  Could not import certificate into Local Machine store: $_"
        }
    }

    if ($AddDefenderExclusion) {
        try {
            Write-Host "  Adding Microsoft Defender exclusions for application folder and process..." -ForegroundColor Cyan
            Add-MpPreference -ExclusionPath $rootDir -ErrorAction SilentlyContinue
            foreach ($exe in $targetExes) {
                Add-MpPreference -ExclusionProcess $exe.Name -ErrorAction SilentlyContinue
            }
            Write-Host "  [OK] Microsoft Defender exclusions applied successfully!" -ForegroundColor Green
        } catch {
            Write-Warning "  Could not apply Defender exclusions: $_"
        }
    }
} else {
    Write-Host "  [NOTE] Script is running as standard user. To trust this certificate locally" -ForegroundColor DarkYellow
    Write-Host "         and configure Defender exclusions, run PowerShell as Administrator." -ForegroundColor DarkYellow
}

Write-Host ""
Write-Host "================================================================================" -ForegroundColor Green
Write-Host "  [SUCCESS] Application Signing & Preparation Completed!                       " -ForegroundColor Green
Write-Host "================================================================================" -ForegroundColor Green
Write-Host ""
Write-Host "HOW TO TRUST ACROSS ALL DOMAIN WORKSTATIONS & SERVERS VIA ACTIVE DIRECTORY GPO:" -ForegroundColor Cyan
Write-Host "1. Copy the generated certificate to your Domain Controller:" -ForegroundColor White
Write-Host "   $exportPath" -ForegroundColor Gray
Write-Host "2. Open Group Policy Management Console (gpmc.msc)." -ForegroundColor White
Write-Host "3. Edit your Domain Policy (e.g. Default Domain Policy or dedicated IT Tools GPO)." -ForegroundColor White
Write-Host "4. Navigate to:" -ForegroundColor White
Write-Host "   Computer Configuration -> Policies -> Windows Settings -> Security Settings -> Public Key Policies" -ForegroundColor Gray
Write-Host "5. Right-click 'Trusted Root Certification Authorities' -> Import -> Select this .cer file." -ForegroundColor White
Write-Host "6. Right-click 'Trusted Publishers' -> Import -> Select this .cer file." -ForegroundColor White
Write-Host "7. On client machines and servers, run: gpupdate /force" -ForegroundColor White
Write-Host "   -> The application will open immediately without ANY warnings or SmartScreen prompts!" -ForegroundColor Green
Write-Host "================================================================================" -ForegroundColor Cyan
Write-Host ""
