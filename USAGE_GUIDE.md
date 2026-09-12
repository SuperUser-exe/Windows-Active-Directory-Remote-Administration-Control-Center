# Windows AD Remote Administration Control Center — Enterprise Administration Suite
## Complete Operator Reference Manual & Architecture Guide (v2.6.5)
**Created & Developed by Askarali Mattummal**

---

### 📑 Table of Contents
1. [Overview & Architecture](#1-overview--architecture)
2. [Launching & Portability](#2-launching--portability)
3. [Connection Modes](#3-connection-modes)
   - [A. Remote Shadow Session (Screen Mirroring)](#a-remote-shadow-session-screen-mirroring)
   - [B. Pre-Shadow Toast Alert Notification](#b-pre-shadow-toast-alert-notification)
   - [C. Standard Remote Desktop (RDP) & Console Session](#c-standard-remote-desktop-rdp--console-session)
4. [Interactive Remote Terminal Console (CMD & PowerShell)](#4-interactive-remote-terminal-console-cmd--powershell)
5. [Graphical Hardware Specs & Diagnostics Dashboard](#5-graphical-hardware-specs--diagnostics-dashboard)
6. [Process & Windows Services Controllers](#6-process--windows-services-controllers)
   - [Remote Task Manager (Process Controller)](#remote-task-manager-process-controller)
   - [Remote Windows Services Controller](#remote-windows-services-controller)
7. [Installed Software Inventory & Silent Uninstaller](#7-installed-software-inventory--silent-uninstaller)
8. [Remote Windows Event Log Viewer](#8-remote-windows-event-log-viewer)
9. [Remote Printers & Active Print Queue Manager](#9-remote-printers--active-print-queue-manager)
10. [Remote File Explorer Quick Links](#10-remote-file-explorer-quick-links)
11. [Active Directory Account Management](#11-active-directory-account-management)
12. [4-Path Deep Temporary Files Cleaner](#12-4-path-deep-temporary-files-cleaner)
13. [Reverse-Chronological Activity Audit Log](#13-reverse-chronological-activity-audit-log)
14. [Remote Power & Session Management](#14-remote-power--session-management)
15. [Seamless In-App GitHub Auto-Updater](#15-seamless-in-app-github-auto-updater)
16. [Remote Mapped Network Drives Manager](#16-remote-mapped-network-drives-manager-ctrl--d)
17. [Group Policy, Firewall & Administrator Setup Guide](#17-group-policy-firewall--administrator-setup-guide)
18. [Universal Keyboard Shortcuts](#18-universal-keyboard-shortcuts)
19. [Security & Access Authorization](#19-security--access-authorization)

---

### 1. Overview & Architecture
**Windows AD Remote Administration Control Center** (v2.6.5) is a standalone, high-performance Windows systems administration and remote assistance suite built specifically for Active Directory Domain Administrators, Systems Engineers, and IT Helpdesk specialists.

Unlike commercial remote assistance tools (such as TeamViewer, AnyDesk, or ScreenConnect) that require installing proprietary background services or paying recurring cloud subscriptions, Windows AD Remote Administration Control Center operates **100% agentlessly**. It interacts natively with Windows endpoints using standard enterprise protocols:
- **Active Directory / LDAP (ADSI)**: Discovers all domain-joined workstations and servers in real-time.
- **Terminal Services APIs**: Initiates Remote Shadow sessions and RDP console attachments.
- **Windows Management Instrumentation (WMI / DCOM / RPC)**: Executes remote commands, inspects hardware sensors, queries installed software across all user profiles, manages services, and controls processes.
- **Windows Event Log RPC (`EventLogSession`)**: Streams live event records reverse-chronologically.
- **SMB Administrative Shares (`C$`)**: Enables 1-click folder navigation and administrative file cleanup.
- **ICMP & ARP**: Performs concurrent real-time ping latency and MAC address resolution.

---

### 2. Launching & Portability

#### Single-File Native Executable
Launch the application simply by executing:
```text
"Windows AD Remote Administration Control Center v2.6.5.exe"
```
Or use the launcher batch file (which automatically launches the versioned executable):
```text
Run_AD_Remote_Control.bat
```

#### Zero External Dependencies
`Windows AD Remote Administration Control Center v2.6.5.exe` is compiled as a self-contained 64-bit Windows PE executable with the application icon and user guide embedded directly within the binary. You can copy the single `.exe` file to your Desktop, an IT management jump box, or a read-only network share (`\\Domain\SYSVOL\IT_Tools\`). No installers or third-party DLLs are required.

---

### 3. Connection Modes

#### A. Remote Shadow Session (Screen Mirroring)
Remote Desktop Shadowing attaches directly to an active physical display session using native Windows terminal services without logging the user out or interrupting their work.

- **Auto-Attended (`/noConsentPrompt`)**:
  - **Checked**: Connects immediately without prompting the remote user (requires Domain Group Policy permission).
  - **Unchecked**: Prompts the user on their screen: *"Administrator is requesting remote control of your desktop. Do you allow this?"*.
- **Full Control (`/control`)**:
  - **Checked**: Enables remote mouse and keyboard interactivity.
  - **Unchecked**: View-only mode for observation or training.
- **Full Screen (`/f`)**: Launches the viewer in fullscreen mode.
- **Multi-Monitor (`/multimon`)**: Spans across multi-monitor setups.
- **Automatic Session Detection**:
  - Queries `query.exe session /server:<host>` to automatically identify the active console session ID (e.g. Session `1` or `2`).

#### B. Pre-Shadow Toast Alert Notification
- When **🔔 Alert User** is checked (default: enabled), the application automatically transmits a modern Windows Action Center Toast notification accompanied by a chime sound directly to the user's taskbar clock:
  ```text
  IT Support Alert
  An administrator is connecting to your desktop session to assist with your technical request.
  ```
- If WinRM is unavailable, it smoothly falls back to native `msg.exe` broadcast.

#### C. Standard Remote Desktop (RDP) & Console Session
Connects via standard Remote Desktop (`mstsc.exe /v:<ComputerName>`).
- **Admin Session (`/admin`)**:
  - Connects directly to the physical console / administrative session.
  - On Windows Servers (Domain Controllers, File Servers), it connects to dedicated administrative slots and bypasses RDS Client Access License (CAL) limits.
  - On Windows Workstations, it attaches to the console session, locking the physical screen.

---

### 4. Interactive Remote Terminal Console (CMD & PowerShell)
Click **💻 Console (CMD/PS)** on the toolbar or right-click any computer and select **💻 Remote Terminal Console**.

- **Agentless Execution**:
  - Utilizes native WMI `Win32_Process` to spawn commands invisibly on the remote workstation, capturing stdout/stderr and streaming the output back into the styled terminal window.
- **Quick Preset Actions**:
  - `👤 whoami`: Shows execution context (explaining difference between Domain Admin token and desktop interactive user).
  - `🔄 gpupdate /force`: Forces immediate Group Policy refresh.
  - `🌐 ipconfig /all`: Dumps full network adapter and DNS configurations.
  - `🛡️ sfc /scannow`: Runs system file integrity checks.
  - `📡 ping 8.8.8.8`: Verifies remote internet connectivity.
  - `⚡ PowerShell`: Toggles PowerShell command execution mode.
- **Export & Copy**: Easily copy terminal output to clipboard or export execution logs.

---

### 5. Graphical Hardware Specs & Diagnostics Dashboard
Click **💻 Specs** on the toolbar or right-click any computer and select **💻 System Specs & Diagnostics**.

- **Visual Sensor Cards**:
  - **CPU Gauge**: Processor model, core count, architecture, and clock speed.
  - **Memory Usage Bar**: Total installed physical RAM, free memory, and percentage used.
  - **C: Storage Bar**: Visual storage gauge with color-coded warning thresholds (green `< 85%`, yellow `85-95%`, red `> 95%`).
  - **Uptime & Health**: System boot time and continuous uptime counter (flags warning if system has not rebooted in over 14 days).
  - **BIOS & Asset Identification**: Motherboard manufacturer, BIOS version, and Serial Number / Service Tag (Dell, HP, Lenovo).
- **Raw Diagnostics Toggle**:
  - Switch between the graphical card dashboard and the full raw WMI diagnostics text view at any time.

---

### 6. Process & Windows Services Controllers

#### Remote Task Manager (Process Controller)
Click **📊 Task Mgr** on the toolbar to inspect:
- Live process list with PID, Name, Working Set Memory (MB), and CPU time.
- Search filter box to find specific executables instantly.
- **`🛑 End Process`**: Remotely terminates hung or malicious processes via WMI `Win32_Process.Terminate()`.

#### Remote Windows Services Controller
Click **⚙️ Services** on the toolbar to inspect:
- Comprehensive inventory of all Windows services with Display Name, Service Name, Current State (Running/Stopped), and Start Mode (Auto/Manual/Disabled).
- Color-coded state indicators (🟢 Running, 🔴 Stopped).
- **Controls**: **Start**, **Stop**, **Restart**, and set Start Mode.
- **1-Click Print Spooler Fix**: Toolbar button **`🔄 Restart Print Spooler`** restarts the `spooler` service in one click across any selected computer.

---

### 7. Installed Software Inventory & Silent Uninstaller
Click **📦 Software** on the toolbar to inspect installed software.

- **Dual-Engine Registry Discovery**:
  - **HKLM Scan**: Scans 64-bit and 32-bit (`Wow6432Node`) uninstall keys.
  - **HKEY_USERS Profile Scan**: Iterates across all loaded user profile SIDs, reliably discovering per-user modern applications (e.g. Microsoft Teams, Zoom, Slack, WhatsApp, Canva, VS Code).
  - **WMI `StdRegProv` Fallback**: If the `RemoteRegistry` Windows service is disabled on client workstations, the application automatically falls back to WMI RPC methods to query registry keys with 100% reliability.
- **1-Click Silent Remote Uninstallation**:
  - Select any application and click **`🗑️ Silent Uninstall`**.
  - Automatically invokes MSI `msiexec.exe /x <ProductCode> /qn /norestart` or the vendor's registered quiet uninstall command string.

---

### 8. Remote Windows Event Log Viewer
Click **📋 Events** on the toolbar to open the Event Viewer.

- **High-Speed Reverse Streaming**:
  - Communicates directly with the remote machine's Windows Event Log RPC subsystem (`EventLogSession`) with reverse chronological streaming (`ReverseDirection = true`), loading the newest events instantly without scanning through gigabytes of older logs.
- **Vivid Severity Color Badges**:
  - 🔴 **Critical & Error**: Distinct red badges.
  - 🟡 **Warning**: Distinct amber/gold badges.
  - 🔵 **Information**: Crisp blue badges.
- **Date Range Filter**:
  - Dropdown options: `All Dates`, `Today Only`, `Last 24 Hours`, `Last 7 Days`, `Last 30 Days`.
- **Diagnostic Presets**:
  - `🔄 Reboots (1074)`: Clean system restarts.
  - `🛑 Shutdown (6006)`: Clean system shutdowns.
  - `🚨 Power Loss (41/6008)`: Sudden unexpected power cuts or dirty shutdowns.
  - `💥 BSOD (1001)`: Blue screen BugCheck memory dumps.
  - `🚫 App Crashes (1000)`: Application fault reports.
  - `⚙️ Svc Crashes (7031)`: Service Control Manager crashes.
  - `⚠️ Disk / NTFS`: Filesystem and drive corruption warnings.
- **Multi-Token Keyword Search**: Search across multiple Event IDs or keywords simultaneously using comma or pipe delimiters (e.g. `41, 6008`).

---

### 9. Remote Printers & Active Print Queue Manager
Click **🖨️ Printers** on the toolbar to inspect:
- **Printer Inventory**:
  - Local printers and domain print server shared network printers (discovered across user profiles via `HKU\<SID>\Printers\Connections`).
  - Columns: Printer Name, Driver Name, Type (Local/Network Shared), Print Server / IP, Default status (⭐), and Queued job count.
- **Active & Stuck Print Queue Manager**:
  - Queries `Win32_PrintJob` in real-time to show Job ID, Document Name, Submitting User, Total Pages, Document Size, and Timestamp.
  - **`🗑️ Cancel Selected Job`**: Cancels any individual hung print job without affecting other users.
  - **`🧹 Purge All Jobs`**: Flushes all pending print jobs across all queues in 1-click.
  - **`🔄 Restart Spooler`**: Restarts the remote Print Spooler service and auto-refreshes the list.

---

### 10. Remote File Explorer Quick Links
Toolbar and context menu shortcuts open Windows Explorer directly into remote administrative shares:
- **`📁 Open C:/`**: Opens `\\<ComputerName>\C$`.
- **`📁 Desktop`**: Opens active user's Desktop folder.
- **`📁 Downloads`**: Opens active user's Downloads folder.
- **`📁 Documents`**: Opens active user's Documents folder.

---

### 11. Active Directory Account Management

#### Smart Dynamic Account Unlocker (`🔓 Unlock User`)
- Inspects the logged-in user account in Active Directory.
- If the account is locked out, the button turns vibrant red: **`⚠️ Account Locked (Unlock)`**.
- Clicking the button unlocks the account immediately in Active Directory (`UserPrincipal.UnlockAccount()`).

#### Password Reset (`🔑 Reset Pass`)
- Opens a secure password reset dialog.
- Allows specifying a new temporary password and optionally checking **"User must change password at next logon"**.

---

### 12. 4-Path Deep Temporary Files Cleaner
Click **🧹 Temp Clean** on the toolbar to execute a 4-path cleanup:
1. `C:\Windows\Temp`
2. `\\<Host>\C$\Users\<User>\AppData\Local\Temp` (cleaned across **all** user profiles)
3. `\\<Host>\C$\Users\<User>\AppData\Roaming\Microsoft\Windows\Recent` (cleaned across **all** user profiles)
4. `C:\Windows\Prefetch`

Calculates the exact number of files removed, total megabytes freed, and records results in the Activity Log.

---

### 13. Reverse-Chronological Activity Audit Log
Click **📜 Activity Log** on the top header or right-click any computer to view audit history.
- Newest actions appear at the **very top**.
- Records action type, timestamp, target host, initiating administrator, and detailed outcome status (`SUCCESS`, `FAILED`, `CANCELLED`).
- Single-computer context menu automatically filters the log to that specific machine.

---

### 14. Remote Power & Session Management

| Action | Protocol / Command | Description |
| :--- | :--- | :--- |
| **⚡ Wake-on-LAN (WOL)** | UDP Broadcast (Port 7/9) | Sends magic packets to power on sleeping workstations. |
| **🔒 Lock Screen** | WMI `user32.dll!LockWorkStation` | Instantly locks the remote desktop without logging user off. |
| **🚪 Logoff User** | `logoff.exe` via WMI | Gracefully terminates active session. |
| **🔄 Reboot** | `shutdown.exe /r /t 5` | Clean reboot with 5-second countdown. |
| **🛑 Shutdown** | `shutdown.exe /s /t 5` | Clean power-off with 5-second countdown. |

---

### 15. Seamless In-App GitHub Auto-Updater
Click **🚀 Updates** on the top header toolbar or inside the Version Notes window.
- **Automatic Version Detection**:
  - Queries GitHub Releases API in the background.
  - Compares the remote release tag against the current application version.
- **What's New Display**:
  - Shows formatted release notes and changelog before updating.
- **Zero-Browser In-Place Update**:
  - Clicking **`⚡ Update & Restart Now`** downloads the new `.exe` binary in the background.
  - Spawns a detached updater script that waits for the running app to exit, overwrites the target `.exe`, and relaunches the updated application in ~1.5 seconds.
  - **No web browser redirection, no MSI wizards, 100% seamless!**

---

### 16. Remote Mapped Network Drives Manager (`Ctrl + D`)
Click **🗄️ Mapped Drives** on the toolbar, press **`Ctrl + D`**, or right-click any computer and choose **"🗄️ Remote Mapped Network Drives Manager"**.

- **Dual-Engine Discovery**:
  - **Engine 1 (Remote Registry via WMI `StdRegProv`)**: Scans `HKEY_USERS\<UserSID>\Network` across all detected user profiles on the machine. Uncovers persistent drive mappings (`RemotePath`, `UserName`, `ConnectionType`, `ProviderName`) even when the user is idle or screen is locked.
  - **Engine 2 (WMI `Win32_LogicalDisk WHERE DriveType = 4`)**: Inspects active mounted network disks to gather live free space, total storage capacity, volume labels, and active connection status.
- **Adding a New Drive Mapping (`➕ Add Drive Mapping`)**:
  - **Drive Letter Selector**: Pre-selects the first available drive letter from `Z:` down to `D:`, flagging letters that are already in use.
  - **Remote Share UNC Path**: Specify `\\server\share` or `\\192.168.x.x\folder`. Includes a **"🔍 Test Path"** button to verify accessibility directly from the admin console.
  - **Target User Profile**: Automatically detects loaded user profiles (e.g. `DOMAIN\username (SID)`), allowing admins to target a specific user or the active interactive session.
  - **Reconnect at Sign-in**: Toggles persistent mapping in `HKEY_USERS\<SID>\Network` so the drive reconnects automatically upon user sign-in.
  - **Instant Session Execution**: Concurrently executes `net use <Drive>: "<UNC>" /persistent:yes` via `Win32_Process.Create` so logged-in users see the drive mounted immediately without signing out.
- **Editing a Drive Mapping (`✏️ Edit Mapping`)**:
  - Update the remote UNC share path or modify persistence settings.
- **Disconnecting & Removing (`🗑️ Disconnect & Remove`)**:
  - Prompts admin confirmation, cleans the registry entry from `HKEY_USERS\<SID>\Network\<Drive>`, and runs remote `net use <Drive>: /delete /y` to unmount the drive cleanly.
- **Local Windows Explorer Integration**:
  - Double-clicking any mapped drive or clicking **`📂 Open Share Locally`** directly launches the UNC share in Windows Explorer on the technician's workstation.
- **Export Inventory**:
  - Export the full drive mapping table across users to CSV with one click.

---

### 17. Group Policy, Firewall & Administrator Setup Guide

#### A. Active Directory & Administrator Privilege Requirements
To manage domain computers agentlessly, the technician or operator account must satisfy the following permissions:

1. **Local Elevation**:
   - The application binary (`Windows AD Remote Administration Control Center v2.6.5.exe`) must be launched with administrative privileges (**Run as Administrator**). Administrative authorization is enforced automatically on startup.
2. **Domain Administrator vs. Delegated Helpdesk Role**:
   - **Domain Admins**: Have complete administrative access to all domain workstations, member servers, Active Directory user objects, and admin shares out of the box.
   - **Delegated Helpdesk / Systems Support Accounts**:
     If operators are not Domain Admins, configure the following three requirements via GPO:
     1. **Workstation Local Administrators Membership**:
        - Push the Helpdesk Security Group into the local `Administrators` group on workstations via GPO:
          `Computer Configuration -> Policies -> Windows Settings -> Security Settings -> Restricted Groups` (or Group Policy Preferences: `Local Users and Groups`).
     2. **Active Directory Delegation (Account Unlock & Password Reset)**:
        - In **Active Directory Users and Computers** (`dsa.msc`), right-click the target Users OU -> **Delegate Control**.
        - Add the Helpdesk Security Group and delegate:
          - *Reset user passwords and force password change at next logon*
          - *Read and write UserAccountControl* (unlock locked-out user accounts).
     3. **Remote Desktop Users Group**:
        - Add the Helpdesk group to `Remote Desktop Users` on target machines via GPO Restricted Groups if non-admin RDP access is required.

---

#### B. Remote Desktop Shadowing GPO Configuration
To allow administrators to mirror and control user screens without disconnecting their sessions:

1. Open **Group Policy Management** (`gpmc.msc`) on your Domain Controller.
2. Create or edit a GPO linked to your Workstations / Computers OU (e.g., `Workstation-RemoteControl-Policy`).
3. Navigate to:
   ```text
   Computer Configuration -> Policies -> Administrative Templates -> Windows Components -> Remote Desktop Services -> Remote Desktop Session Host -> Connections
   ```
4. Configure the following policies:

   - **Set rules for remote control of Remote Desktop Services user sessions**:
     - State: **Enabled**
     - Options: Choose your preferred mode:
       - `Full Control without user's permission` *(Recommended for instant unattended IT support)*
       - `Full Control with user's permission` *(Prompts the logged-in user with an Accept/Deny prompt)*
       - `View Session without user's permission` *(Passive observation/auditing mode)*
       - `View Session with user's permission` *(Passive observation with consent prompt)*

   - **Allow users to connect remotely by using Remote Desktop Services**:
     - State: **Enabled**

5. Run `gpupdate /force` on target workstations (or reboot them) to apply the policy.

---

#### C. Windows Defender Firewall GPO Configuration (Domain Profile)
The target computers must allow inbound administrative RPC, SMB, WMI, and RDP traffic.

In `gpmc.msc`, navigate to:
```text
Computer Configuration -> Policies -> Windows Settings -> Security Settings -> Windows Defender Firewall with Advanced Security -> Inbound Rules
```

Enable the following predefined rule groups or create custom inbound rules:

| Protocol / Feature | Port / Rule Name | Purpose in Windows AD Remote Administration Control Center |
| :--- | :--- | :--- |
| **Remote Desktop** | TCP `3389` | Remote Shadowing screen mirror and RDP sessions. |
| **WMI & DCOM** | TCP `135` + Dynamic RPC Ports (`49152-65535`) | Hardware specs, Task Manager, Services, software discovery, remote terminal, drive mapping. |
| **File and Printer Sharing** | TCP `445`, TCP `139` | SMB administrative shares (`C$`), 4-path deep temp cleaning, file browsing. |
| **Windows Remote Management** | TCP `5985` (WinRM HTTP) | Action Center Toast notifications transmitted to user system clock. |
| **Remote Registry Service** | RPC Dynamic Ports | Software discovery and user profile registry inspection. |
| **ICMPv4 Echo Request** | ICMPv4 Type 8 | Real-time ping latency and online/offline status detection. |

> [!TIP]
> In GPMC, you can right-click **Inbound Rules -> New Rule -> Predefined** and easily enable:
> - `File and Printer Sharing`
> - `Remote Desktop`
> - `Windows Management Instrumentation (WMI)`
> - `Windows Remote Management`

---

#### D. Target Computer System Services
Verify or set the following services to start automatically via GPO:
- **Remote Registry (`RemoteRegistry`)**: Set to **Automatic** under `Computer Configuration -> Windows Settings -> Security Settings -> System Services`. *(Allows instant reading of installed apps and drive mappings across profiles).*
- **Windows Remote Management (`WinRM`)**: Run `winrm quickconfig -q` or enable WinRM service via GPO for Action Center Toast notifications.

---

#### E. Automated 1-Click Endpoint Setup Script (PowerShell)
Sysadmins can push this script via GPO Startup Script, Microsoft Intune, or run it locally in elevated PowerShell to configure any Windows workstation in under 30 seconds:

```powershell
# =========================================================================
# Windows AD Remote Administration Control Center - Automated Endpoint Configuration Script
# Enables: RDP Shadowing (Full Control without consent), Firewall Ports, Services
# =========================================================================

Write-Host "[*] Configuring Remote Desktop and Shadowing..." -ForegroundColor Cyan
# 1. Enable Remote Desktop
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name "UserAuthentication" -Value 0

# 2. Configure Shadow GPO Policy: Full Control without User Permission (Value = 2)
# 0 = No Remote Control, 1 = Full Control with Consent, 2 = Full Control without Consent, 3 = View with Consent, 4 = View without Consent
$shadowKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
if (!(Test-Path $shadowKey)) { New-Item -Path $shadowKey -Force | Out-Null }
Set-ItemProperty -Path $shadowKey -Name "Shadow" -Value 2

Write-Host "[*] Enabling Windows Defender Firewall Rules..." -ForegroundColor Cyan
# 3. Enable Predefined Firewall Rule Groups
Enable-NetFirewallRule -DisplayGroup "Remote Desktop" -ErrorAction SilentlyContinue
Enable-NetFirewallRule -DisplayGroup "Windows Management Instrumentation (WMI)" -ErrorAction SilentlyContinue
Enable-NetFirewallRule -DisplayGroup "File and Printer Sharing" -ErrorAction SilentlyContinue
Enable-NetFirewallRule -DisplayGroup "Windows Remote Management" -ErrorAction SilentlyContinue

# 4. Enable ICMPv4 Ping Echo Request
Enable-NetFirewallRule -Name "FPS-ICMP4-ERQ-In" -ErrorAction SilentlyContinue

Write-Host "[*] Configuring Remote Services..." -ForegroundColor Cyan
# 5. Enable & Start Remote Registry Service
Set-Service -Name "RemoteRegistry" -StartupType Automatic -ErrorAction SilentlyContinue
Start-Service -Name "RemoteRegistry" -ErrorAction SilentlyContinue

# 6. Configure WinRM for Toast Notifications
winrm quickconfig -q -force 2>$null

Write-Host "[SUCCESS] Workstation is fully configured for Windows AD Remote Administration Control Center!" -ForegroundColor Green
```

---

### 18. Universal Keyboard Shortcuts

| Shortcut | Action | Scope |
| :--- | :--- | :--- |
| **`Ctrl + S` / `Ctrl + F`** | **Focus Quick Search Bar** & Select All Text | Main Window |
| **`F5` / `Ctrl + R`** | **Refresh Computer Inventory** from Active Directory | Main Window |
| **`Enter`** | **Connect Remote Shadow Session** (Screen Mirror) | Main Window (Computer Grid) |
| **`Ctrl + Enter`** | **Connect Remote Desktop** (Standard RDP Login) | Main Window |
| **`Ctrl + P`** | **Ping Selected Host** with live ICMP latency | Main Window |
| **`Ctrl + T`** | **Open Remote Console** (Interactive CMD / PowerShell) | Main Window |
| **`Ctrl + I`** | **Open System Specs** & Hardware Diagnostics | Main Window |
| **`Ctrl + D`** | **Open Remote Mapped Drives Manager** (Add / Edit / Remove) | Main Window |
| **`Ctrl + M`** | **Open Send Toast Notification** Message Dialog | Main Window |
| **`Ctrl + U`** | **Unlock User Account** in Active Directory | Main Window |
| **`Ctrl + Shift + P`** | **Reset User Password** Modal Dialog | Main Window |
| **`Ctrl + Shift + U`** | **View 360° AD User Profile** Inspector Card | Main Window |
| **`ESC`** | **Dismiss/Close any popup modal**, or Clear Search Box | Universal across all windows |

---

### 19. Security & Access Authorization
- **Startup Authorization Guard**:
  - Verifies that the launching user has elevated administrative privileges (`WindowsBuiltInRole.Administrator`) and belongs to authorized Domain / Enterprise Admin groups.
  - Unauthorized launches are immediately blocked with a modal security notification and logged to the audit trail.
- **Binary Integrity & Obfuscation**:
  - The compiled `.exe` is a native PE binary. Source code is compiled and cannot be extracted with archiving tools such as WinRAR or 7-Zip.
  - For public distribution, production binaries are hardened with automated obfuscation and Authenticode signatures to prevent reverse engineering and unauthorized tampering.
