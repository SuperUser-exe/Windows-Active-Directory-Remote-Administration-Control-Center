# ⚡ Windows AD Remote Administration Control Center — Enterprise Remote Control & Administration Suite

[![Release](https://img.shields.io/badge/Release-v2.6.5-blue.svg?style=for-the-badge&logo=github)](https://github.com/SuperUser-exe/Windows-Active-Directory-Remote-Administration-Control-Center/releases)
[![Platform](https://img.shields.io/badge/Platform-Windows%2010%20%7C%2011%20%7C%20Server-0078D6.svg?style=for-the-badge&logo=windows)](https://microsoft.com)
[![Framework](https://img.shields.io/badge/.NET%20Framework-4.0%2B-512BD4.svg?style=for-the-badge&logo=dotnet)](https://dotnet.microsoft.com)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](LICENSE)
[![Zero Dependencies](https://img.shields.io/badge/Dependencies-Zero%20External%20DLLs-success.svg?style=for-the-badge)](README.md)

> **Created & Developed by [Askarali Mattummal](https://github.com/SuperUser-exe)**  
> *A high-performance, 100% agentless Windows & Active Directory remote management, screen mirroring, diagnostics, and IT helpdesk suite.*

---

## 👋 Welcome to Windows AD Remote Administration Control Center!

### 💡 Background, Motivation & Why I Created This
As a systems engineer managing active enterprise Active Directory environments, I frequently found myself frustrated by the constant friction of daily IT administration. Performing routine support tasks meant constantly switching between a dozen separate tools:
- Opening **Active Directory Users & Computers (ADUC)** just to unlock an account or check a user's department and group memberships;
- Launching multiple **MMC snap-ins** (Computer Management, Services, Event Viewer, Print Management);
- Opening command prompts for `shadow.exe`, `net use`, `ipconfig`, `gpupdate`, or PowerShell remoting;
- Relying on heavy, commercial remote support tools that require background client services, third-party cloud relays, and expensive recurring licenses.

To solve this, I originally designed and built **Windows AD Remote Administration Control Center** as my own personal, all-in-one administrative workstation console. My goal was simple: **a single, blazing-fast, lightweight, portable executable (~580 KB) that connects directly to domain computers using native Windows protocols (LDAP, WMI, RPC, SMB, Terminal Services) with zero external dependencies and zero agents to install.**

### 🎯 Who Is This Application For?
This suite was crafted specifically for IT professionals, including:
* **Active Directory & Windows Domain Administrators** managing enterprise domain workstations and servers.
* **Systems Engineers & Network Administrators** needing fast remote diagnostics, live hardware telemetry, IP configuration, and event log auditing.
* **IT Helpdesk & Desktop Support Specialists** who need to shadow user sessions instantly, reset passwords, clear print queues, and clean temporary junk without interrupting users.
* **Managed Service Providers (MSPs)** who want a 100% portable, agentless tool that runs from a USB flash drive or secure administrative share.

### 🌍 Purpose of the Public Release
After colleagues and fellow sysadmin friends used the tool and experienced how much time it saved them daily, they urged me to release it publicly. I decided to publish this project so that the wider IT administration community can benefit from it freely.

---

### 🛡️ Official Release & Authenticity Notice

> [!IMPORTANT]
> The **only official and authentic release source** for this project is:  
> 👉 **https://github.com/SuperUser-exe/Windows-Active-Directory-Remote-Administration-Control-Center**  
>
> * **Do not trust unofficial copies**: If downloaded from third-party sites, file-sharing platforms, or re-hosted mirrors, the author assumes no responsibility for modified, corrupted, or repackaged binaries.
> * **Integrity Check**: Always verify the official release SHA-256 checksums provided in `CHECKSUMS.txt`.
> * **Community & Discussions**: We have enabled **[GitHub Discussions](https://github.com/SuperUser-exe/Windows-Active-Directory-Remote-Administration-Control-Center/discussions)**! Come say hello, share workflow feedback, report issues, or suggest new features.

---

## 🌟 Why Windows AD Remote Administration Control Center?

Commercial remote support tools (TeamViewer, AnyDesk, ScreenConnect) require client background services, third-party cloud relays, and expensive recurring licenses. 

**Windows AD Remote Administration Control Center** eliminates all of that. It is a **single, portable, self-contained executable (~340 KB)** that connects directly to any Active Directory domain computer using native Windows protocols (LDAP, Terminal Services, WMI, RPC, SMB).

### 🚀 Key Highlights
- **⚡ Instant Screen Shadowing**: Mirror remote user displays without disconnecting or logging them off.
- **🔔 Modern Pre-Shadow Alerts**: Transmits unobtrusive Action Center Toast notifications near the system clock with sound chimes.
- **🚀 Remote Startup Applications Manager**: Inspect and manage machine and per-profile startup programs, toggle Enable / Disable via Windows `StartupApproved` without deleting entries (`🚀 Startup`).
- **👥 Local Computer Users & Accounts Manager**: Agentless local account management—provision users, reset passwords, and toggle active status (`👥 Local Users`).
- **📈 Sub-Second Real-Time Live Performance Monitor**: High-frequency CPU, RAM, Network (RX/TX), Disk I/O telemetry with historical sparklines and hardware specs (`📈 Live Perf`).
- **🌐 Remote Network & IP Configuration Hub**: Switch DHCP ⇄ Static IP remotely, flush DNS, release/renew lease, and safe adapter restart (`🌐 IP Config`).
- **🔒 Remote Workstation Lock & Unlock Controller**: Real-time lock screen detection, session locking, console reconnect, and direct session unlock.
- **🗄️ Remote Mapped Drives Manager**: Inspect, add, edit, and disconnect mapped network drives across all remote user profiles with live storage gauges (`Ctrl + D`).
- **💻 Interactive Remote Terminal**: Agentless CMD & PowerShell execution with instant preset commands (`whoami`, `gpupdate`, `sfc`, `ipconfig`).
- **💻 Graphical Specs Dashboard**: Visual sensor cards with progress gauges for CPU, RAM, Disk usage, BIOS Serial Number, and Uptime.
- **📦 Full Software Inventory**: Dual-engine scanning across `HKLM` (64-bit & 32-bit) and all `HKEY_USERS` profiles with silent 1-click uninstaller.
- **📋 Advanced Event Log Viewer**: High-speed reverse streaming of System and Application event logs with vivid severity color badges and date range filters.
- **🖨️ Remote Printers & Queue Manager**: Inspects local and domain print server shared printers with live print job management.
- **👤 Active Directory User Controls**: Dynamic account lockout detection with 1-click unlocking and password resets.
- **🧹 4-Path Deep Temp Cleaner**: Purges Temp, AppData Temp across all profiles, Recent files, and Prefetch in 1-click with byte counters.
- **🔄 Seamless In-App Auto-Updater**: Directly updates the application in-place from GitHub Releases without browser redirects or installer wizards!
- **⌨️ Universal Keyboard Ergonomics**: Dismiss any popup window with `ESC`, open Drive Manager with `Ctrl + D`.

---

## 🛠️ Complete Feature Matrix

| Category | Features & Capabilities |
| :--- | :--- |
| **🖥️ Remote Display** | • Remote Shadowing (Attended & Auto-Attended `/noConsentPrompt`)<br>• Full Control (Keyboard & Mouse) or View-Only<br>• Fullscreen & Multi-Monitor spanning<br>• Standard RDP & Server Console Admin (`/admin`) sessions |
| **🔔 User Alerts** | • Action Center Toast Notifications near the taskbar clock<br>• Audio chime notification<br>• Automated fallback to `msg.exe` |
| **🚀 Startup Apps** | • **Remote Startup Applications & Autoruns Manager (`🚀 Startup`)**<br>• Machine (`HKLM`) and per-user profile (`HKU`) startup enumeration<br>• Dynamic **Enable / Disable** toggling via Windows `StartupApproved\Run`<br>• Preserves user registry configurations without deletion<br>• 1-Click delete orphaned autorun entries and CSV export |
| **👥 Local Users** | • **Local Computer Users & Accounts Manager (`👥 Local Users`)**<br>• Works without active logon session (direct ADSI / SAM connection)<br>• Account type badging: 👑 Administrator, 👤 Standard User, 🚼 Guest<br>• Remote user creation, password reset, and enable/disable toggle |
| **📈 Live Monitor** | • **Sub-Second Live Performance Monitor (`📈 Live Perf`)**<br>• Kernel-level high-frequency CPU, RAM, Network (RX/TX), Disk active I/O<br>• 60-second historical sparkline graphs & performance charts<br>• Motherboard DIMM module slot inspector (DDR4/DDR5, MHz, part numbers)<br>• Physical storage drives, link speeds, and network adapter telemetry |
| **🌐 Network & IP Hub** | • **Remote Network & IP Configuration Hub (`🌐 IP Config`)**<br>• Remote DHCP ⇄ Static IPv4 switching with format validation<br>• Remote `ipconfig /flushdns`, `/registerdns`, `/release`, `/renew`<br>• Safe network adapter reset script with automatic re-enable |
| **🔒 Lock & Unlock** | • **Workstation Lock & Unlock Controller (`🔒 Lock Screen`)**<br>• Real-time lock screen state detection (`LogonUI.exe` & session telemetry)<br>• Remote workstation lock, console session reconnect, and direct session unlock<br>• Embedded live diagnostic execution console |
| **🗄️ Network Drives** | • **Remote Mapped Network Drives Manager (`Ctrl + D`)**<br>• Dual-engine inspection: `HKEY_USERS` registry + WMI `Win32_LogicalDisk`<br>• Real-time storage capacity gauge (Free / Total GB)<br>• 1-Click **Add Drive Mapping** with automatic free letter selection (Z-D) & UNC test<br>• **Edit Mapping** and modify persistence (Reconnect at sign-in)<br>• **Disconnect & Remove** mapping from registry and active session<br>• 1-Click Explorer launcher into remote UNC share |
| **💻 Remote Terminal** | • WMI-powered interactive command console (CMD & PowerShell)<br>• 1-click presets: `whoami`, `gpupdate /force`, `ipconfig /all`, `sfc /scannow`, `ping`<br>• Output logging and clipboard export |
| **💻 Diagnostics** | • Visual sensor dashboard with CPU, RAM, and Disk storage gauges<br>• Motherboard, BIOS, Serial Number / Dell Service Tag inspection<br>• System boot timestamp and continuous uptime health tracker |
| **📊 Processes & Services**| • Remote Task Manager: view processes, memory usage, terminate hung apps<br>• Windows Services Controller: query status, Start, Stop, Restart services<br>• 1-Click Remote Print Spooler restart |
| **📦 Software Inventory** | • Dual-engine scanner: `HKLM` (64-bit & 32-bit) + `HKEY_USERS` (all profiles)<br>• Discovers per-user apps: Teams, Zoom, Slack, WhatsApp, Canva, VS Code<br>• WMI `StdRegProv` fallback when `RemoteRegistry` service is disabled<br>• 1-click silent remote uninstaller for MSI and EXE packages |
| **📋 Event Log Viewer** | • Reverse-chronological streaming (`ReverseDirection = true`)<br>• Vivid color badges for Critical, Error, Warning, Information<br>• Date range filter: `All Dates`, `Today Only`, `Last 24h`, `Last 7d`, `Last 30d`<br>• One-click presets: Reboots (1074), Shutdowns (6006), Power Loss (41/6008), BSOD (1001), App Crashes (1000), Service Crashes (7031), Disk/NTFS errors |
| **🖨️ Printer Management**| • Inspect local printers and domain print server shared printers<br>• Accurate active user default printer detection (`⭐ Default`) via remote registry<br>• Real-time Test Print (`🖨️ Test Print`) execution via WMI & `printui.dll`<br>• Live **Pending Jobs** column cross-referenced with active queue<br>• Real-time queue inspection: Document, Owner, Pages, Size, Submission Time<br>• 1-Click `Cancel Job`, `Purge All Jobs`, and `Restart Spooler` |
| **📁 File Explorer** | • 1-Click Explorer access into `\\<host>\C$`<br>• Direct navigation to remote user's `Desktop`, `Downloads`, and `Documents` |
| **👤 AD Account Actions**| • **Enterprise 360° AD User Profile Inspector**: 40+ directory attributes, hierarchy, contact, & security group memberships<br>• Real-time lockout detection: button turns red (`⚠️ Account Locked`)<br>• 1-click AD account unlocking via `UserPrincipal.UnlockAccount()`<br>• Remote password reset with optional forced password change at next logon |
| **🧹 Deep Temp Cleaner** | • Purges 4 administrative paths: `C:\Windows\Temp`, User `AppData\Local\Temp`, `Recent` files across all profiles, and `Prefetch`<br>• Reports exact file count and MB disk space freed |
| **⚡ Power Management** | • Wake-on-LAN (WOL) magic packets<br>• Lock remote screen without logging off<br>• Graceful remote user session logoff<br>• Remote reboot and shutdown with 5-second countdown |
| **📜 Audit Logging** | • Reverse-chronological activity log (newest records always on top)<br>• Isolated single-machine audit filtering<br>• Outcome logging: `SUCCESS`, `FAILED`, `CANCELLED` with error messages |
| **🔄 Auto-Updater** | • Direct GitHub Releases API integration with `SuperUser-exe/Windows-Active-Directory-Remote-Administration-Control-Center`<br>• In-app release notes viewer<br>• In-place download, detached update script, and automatic restart (0 browser redirect!) |

---

## 📁 Repository Structure

```text
Windows_AD_Remote_Administration_Control_Center/
├── Windows AD Remote Administration Control Center v2.6.5.exe  # Standalone portable Windows executable (~600 KB)
├── Configure_Endpoint_GPO.ps1          # Automated endpoint GPO & firewall configuration script
├── Run_AD_Remote_Control.bat           # 1-Click launcher script (auto-launches versioned exe)
├── CHECKSUMS.txt                      # Official SHA-256 integrity checksums
├── README.md                          # Complete project documentation & quick start
├── USAGE_GUIDE.md                     # In-depth operator reference manual & GPO guide
├── USAGE_GUIDE.txt                    # Plain text version for in-app fallback viewer
├── CHANGELOG.md                       # Detailed version release notes & history
└── LICENSE                            # MIT License
```

---

## 🚀 How to Run

### Option 1: Standalone Portable Executable
Download the latest `Windows AD Remote Administration Control Center v2.6.5.exe` from [GitHub Releases](https://github.com/SuperUser-exe/Windows-Active-Directory-Remote-Administration-Control-Center/releases).  
Right-click `Windows AD Remote Administration Control Center v2.6.5.exe` and select **Run as Administrator** (using Domain Admin credentials):
```cmd
"Windows AD Remote Administration Control Center v2.6.5.exe"
```

### Option 2: 1-Click Convenience Launcher
Alternatively, run the included launcher script:
```cmd
Run_AD_Remote_Control.bat
```

---

## ⚙️ Group Policy & Administrator Setup Requirements

### 1. Administrator Account Permissions
- **Running the Application**: Launch `Windows AD Remote Administration Control Center v2.6.5.exe` (or `Run_AD_Remote_Control.bat`). Administrative privileges are verified automatically on launch. Non-admin users are blocked from executing the utility.
- **Domain Admins**: Fully privileged across all domain endpoints, Active Directory user objects, and admin shares out of the box.
- **Delegated Helpdesk Technicians**: If operators are not Domain Admins:
  1. Add their security group to the local **Administrators** group on domain workstations (via GPO Restricted Groups or Group Policy Preferences).
  2. Delegate Active Directory permissions on target user OUs in `dsa.msc` for:
     - *Reset user passwords and force password change at next logon*
     - *Read and write Account Restrictions* (enables unlocking locked-out accounts).

### 2. Enable Remote Shadowing (Auto-Attended & Attended)
To enable shadowing without disconnecting active users:
1. Open `gpmc.msc` on your Domain Controller and edit your Workstations Policy.
2. Navigate to:  
   `Computer Configuration -> Policies -> Administrative Templates -> Windows Components -> Remote Desktop Services -> Remote Desktop Session Host -> Connections`
3. Configure:
   - **Set rules for remote control of Remote Desktop Services user sessions**:
     - Set to **Enabled**.
     - Choose **Full Control without user's permission** (for instant unattended screen mirror) or **Full Control with user's permission** (prompts user to allow/deny).
   - **Allow users to connect remotely by using Remote Desktop Services**:
     - Set to **Enabled**.
4. Run `gpupdate /force` on client workstations.

### 3. Windows Defender Firewall Rules (Domain Profile)
Ensure the following ports and predefined rule groups are enabled via GPO:
- **TCP 3389**: Remote Desktop & Remote Shadowing
- **TCP 445 & 139**: SMB File Sharing (`C$` access, remote folder navigation, deep temp clean)
- **TCP 135 & Dynamic RPC**: WMI Management (Hardware Specs, Task Manager, Services, Remote Console, Drive Mapping)
- **TCP 5985**: WinRM HTTP (for Action Center Toast notifications)
- **ICMPv4**: Ping echo request for live online/offline latency detection
- **Remote Registry Service**: Startup type set to **Automatic** for instant cross-profile software and drive mapping scans.

---

## 🔄 Seamless In-App Auto-Updating

When you publish a new version on GitHub Releases:
1. Users click **`🚀 Updates`** in the application header (or the app notifies them automatically).
2. The changelog and release notes appear inside the app.
3. Clicking **`⚡ Update & Restart Now`** downloads the new `.exe` and updates the app in-place in ~1.5 seconds.
4. **No browser redirection, no manual file copying, no installers!**

---

## ⌨️ Universal Shortcuts

| Shortcut | Action |
| :--- | :--- |
| **`Ctrl + S` / `Ctrl + F`** | Focus Quick Search box and select all text |
| **`F5` / `Ctrl + R`** | Refresh computer inventory from Active Directory |
| **`Enter`** | Connect Shadow Session (screen mirror) to selected computer |
| **`Ctrl + Enter`** | Connect Remote Desktop (RDP) login |
| **`Ctrl + P`** | Ping selected computer and display latency |
| **`Ctrl + T`** | Open interactive in-app Remote Console (CMD / PowerShell) |
| **`Ctrl + I`** | Open System Hardware Diagnostics & Specs |
| **`Ctrl + D`** | Open Remote Mapped Network Drives Manager (Add / Edit / Remove) |
| **`Ctrl + M`** | Open Send User Notification Message dialog |
| **`Ctrl + U`** | Unlock logged-in user account in Active Directory |
| **`Ctrl + Shift + P`** | Reset domain user password |
| **`Ctrl + Shift + U`** | Open 360° Active Directory User Profile Inspector |
| **`ESC`** | Clear search text (when focused), or close any open popup modal |

---

## 📄 License, Legal & Ethical Use Notice

Developed with ❤️ by **Askarali Mattummal**.  
Licensed under the [MIT License & Distribution Terms](LICENSE).

> [!CAUTION]
> **Authorized IT Administrative Use Only**: This software is designed, developed, and published strictly for authorized IT systems administrators and certified support personnel to maintain, monitor, and troubleshoot authorized enterprise domain infrastructure. Any unauthorized deployment, surveillance, privacy violation, or malicious use is strictly prohibited. The author assumes no responsibility or liability for damages or legal consequences arising from misuse. Please consult the [LICENSE](LICENSE) for complete terms of use and liability disclaimers.
