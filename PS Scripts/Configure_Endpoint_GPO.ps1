<#
================================================================================
  Windows AD Remote Administration Control Center - Automated Endpoint & GPO Configuration Script
  Created & Developed by Askarali Mattummal
================================================================================
  Purpose:
  Configures target Windows workstations/servers for 100% agentless remote
  assistance, RDP shadowing, WMI diagnostics, firewall rules, and services.
================================================================================
#>

# Requires Run as Administrator
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Please run this script as an elevated Administrator!"
    Exit 1
}

Write-Host ""
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "  Windows AD Remote Administration Control Center - Setup" -ForegroundColor Cyan
Write-Host "  Created & Developed by Askarali Mattummal            " -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host ""

# 1. Enable Remote Desktop & Terminal Services Listener
Write-Host "[1/5] Configuring Remote Desktop Services..." -ForegroundColor Yellow
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0 -Force
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name "UserAuthentication" -Value 0 -Force

# 2. Configure Remote Shadow GPO: Full Control without User Permission
Write-Host "[2/5] Enabling Remote Desktop Shadowing (Full Control without user prompt)..." -ForegroundColor Yellow
$shadowKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
if (!(Test-Path $shadowKey)) { 
    New-Item -Path $shadowKey -Force | Out-Null 
}
Set-ItemProperty -Path $shadowKey -Name "Shadow" -Value 2 -Force

# 3. Enable Inbound Firewall Rules across all profiles
Write-Host "[3/5] Enabling Windows Defender Firewall inbound rules..." -ForegroundColor Yellow
Enable-NetFirewallRule -DisplayGroup "Remote Desktop" -ErrorAction SilentlyContinue
Enable-NetFirewallRule -DisplayGroup "Windows Management Instrumentation (WMI)" -ErrorAction SilentlyContinue
Enable-NetFirewallRule -DisplayGroup "File and Printer Sharing" -ErrorAction SilentlyContinue
Enable-NetFirewallRule -DisplayGroup "Windows Remote Management" -ErrorAction SilentlyContinue
Enable-NetFirewallRule -Name "FPS-ICMP4-ERQ-In" -ErrorAction SilentlyContinue

# 4. Enable & Start Target Services
Write-Host "[4/5] Configuring Remote Registry and WinRM Services..." -ForegroundColor Yellow
Set-Service -Name "RemoteRegistry" -StartupType Automatic -ErrorAction SilentlyContinue
Start-Service -Name "RemoteRegistry" -ErrorAction SilentlyContinue

# 5. Quick Configure WinRM for Toast Notifications
Write-Host "[5/5] Configuring Windows Remote Management (WinRM)..." -ForegroundColor Yellow
winrm quickconfig -q -force 2>$null

Write-Host ""
Write-Host "========================================================" -ForegroundColor Green
Write-Host "  [SUCCESS] Endpoint is fully configured and ready!    " -ForegroundColor Green
Write-Host "========================================================" -ForegroundColor Green
Write-Host ""
