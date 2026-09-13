# ⚡ Windows AD Remote Administration Control Center — Enterprise Remote Control & Administration Suite

[![Release](https://img.shields.io/badge/Release-v2.7.0-blue.svg?style=for-the-badge&logo=github)](https://github.com/SuperUser-exe/Windows-Active-Directory-Remote-Administration-Control-Center/releases)
[![Platform](https://img.shields.io/badge/Platform-Windows%2010%20%7C%2011%20%7C%20Server-0078D6.svg?style=for-the-badge&logo=windows)](https://microsoft.com)
[![Framework](https://img.shields.io/badge/.NET%20Framework-4.0%2B-512BD4.svg?style=for-the-badge&logo=dotnet)](https://dotnet.microsoft.com)
[![License](https://img.shields.io/badge/License-MIT-green.svg?style=for-the-badge)](LICENSE)
[![Zero Dependencies](https://img.shields.io/badge/Dependencies-Zero%20External%20DLLs-success.svg?style=for-the-badge)](README.md)
[![Telegram Community](https://img.shields.io/badge/Telegram-Join%20Chat-2CA5E0.svg?style=for-the-badge&logo=telegram)](https://t.me/WADRACC)

> **Created & Developed by [Askarali Mattummal](https://www.linkedin.com/in/askaralimattummal/)** ([LinkedIn](https://www.linkedin.com/in/askaralimattummal/) | [GitHub](https://github.com/SuperUser-exe) | [Telegram](https://t.me/WADRACC))  
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
> * **Telegram Community Chat**: Join our active Telegram group at **[t.me/WADRACC](https://t.me/WADRACC)** for instant community chat, direct feedback, updates, and IT discussions.

---

## 🧠 How the Application Works & Why It’s a Game Changer

> ### 🚀 *"Try my application once — then tell me how it is! This tool will help you and your IT team 100,000%!"*

### 💡 The Problem with Modern IT Support Tools
Most remote management tools (RMMs) and commercial support platforms force you to install bloated background services on every single computer, set up complex web portals, configure SQL databases, or pay exorbitant monthly subscriptions per endpoint.

### ⚡ The Breakthrough: Pure Native Windows, WMI & Active Directory Power
**Windows AD Remote Administration Control Center** works on a fundamentally different, ultra-lightweight architectural principle:
- **100% Agentless & Fully Portable**: No client software, drivers, or background services are ever installed on managed endpoints. Everything runs on-demand from a single, self-contained portable executable (~600 KB).
- **Background WMI, CIM & LDAP In-Memory Engine**: Under the hood, the application executes pure, native Windows management pipelines—reading and modifying WMI/CIM classes (`Win32_Process`, `Win32_Service`, `Win32_Printer`, `Win32_UserProfile`, `StdRegProv`), LDAP directories, and Windows management APIs. It only reads and writes native Windows and Active Directory attributes in memory.
- **Zero Foreign Binaries or Residual Payloads**: There are no temporary batch scripts, remote agents, or third-party background daemons left behind on client computers.
- **Direct RDS Screen Shadowing**: Hooks directly into built-in Windows Terminal Services (`query.exe session` + `mstsc.exe /shadow`), allowing IT administrators to mirror and control user screens in real-time with zero latency—without kicking users off, disturbing their session, or locking their screen.

---

### 🏛️ Under-the-Hood Architecture: How It Actually Works

```text
                        ┌────────────────────────────────────────────────────────┐
                        │   Windows AD Remote Administration Control Center      │
                        │        Single Standalone Portable Executable           │
                        │       Native C# / WPF + In-Memory Windows APIs         │
                        └───────────────────────────┬────────────────────────────┘
                                                    │
         ┌──────────────────────────────────────────┼──────────────────────────────────────────┐
         ▼                                          ▼                                          ▼
 ┌───────────────────────┐                  ┌───────────────────────┐                  ┌───────────────────────┐
 │ Active Directory      │                  │ Workstation & WMI     │                  │ Remote Desktop /      │
 │ (LDAP / ADSI Layer)   │                  │ (CIM & Registry Layer)│                  │ Terminal Services     │
 └───────────┬───────────┘                  └───────────┬───────────┘                  └───────────┬───────────┘
             │ Reads / Writes Direct Attributes         │ Remote Management Pipelines              │ Native Shadow & RDP
             ▼                                          ▼                                          ▼
 ┌───────────────────────┐                  ┌───────────────────────┐                  ┌───────────────────────┐
 │ • User Objects & OU   │                  │ • Win32_Process       │                  │ • query.exe session   │
 │ • Account Lockouts    │                  │ • Win32_Service       │                  │ • mstsc.exe /shadow   │
 │ • Password Resets     │                  │ • Win32_Printer / Q   │                  │ • Instant Screen Mirr │
 │ • 40+ User Attributes │                  │ • StdRegProv Registry │                  │ • No-Kickoff Control  │
 └───────────────────────┘                  └───────────────────────┘                  └───────────────────────┘
```

#### 1. 👤 Active Directory Layer (ADSI / LDAP / Kerberos)
- **Direct Domain Controller Queries**: Communicates directly with domain controllers using native .NET `System.DirectoryServices` and `DirectorySearcher` over secure LDAP/Kerberos.
- **Real-Time Attribute Inspection**: Reads user properties dynamically (`lockoutTime`, `badPwdCount`, `userAccountControl`, `pwdLastSet`, `memberOf`, contact metadata, hierarchy).
- **Instant Account Unlocking & Resets**: Writes `lockoutTime = 0` to immediately unlock accounts, or triggers secure password resets natively over Kerberos/LDAP without requiring RSAT on the technician's workstation.

#### 2. ⚙️ Workstation Management & Telemetry Layer (WMI, CIM & Remote Registry)
- **Live Hardware Telemetry**: Queries hardware specifications, active processes, system services, and installed software directly from `root\cimv2` (`Win32_Processor`, `Win32_OperatingSystem`, `Win32_LogicalDisk`, `Win32_PhysicalMemory`).
- **Per-Printer Queue Management**: Enumerates printer drivers and queries `Win32_PrintJob` locally, clearing hung documents with precision without affecting other printers.
- **Cross-Profile Software & Drive Auditing**: Inspects system `HKLM` (64-bit and 32-bit) and queries all loaded user profiles in `HKEY_USERS` via WMI `StdRegProv` to discover per-user apps (Teams, Zoom, VS Code) and mapped network drives (`Ctrl + D`) even when remote users are idle.
- **Dynamic Profile Path Resolution**: Queries WMI `Win32_UserProfile` matching the interactive user's SID to resolve the physical directory on disk (`LocalPath`), ensuring wallpaper changes and telemetry overlays (BgInfo) apply correctly even across renamed or migrated profiles.

#### 3. 🖥️ Session Layer (Native Windows Remote Desktop Services Shadowing)
- **Console Session Discovery**: Uses native Windows `query.exe session` to instantly detect the logged-in user's active console or RDP session ID.
- **Zero-Lag Hardware Screen Control**: Launches native Microsoft `mstsc.exe /shadow:<id> /control /noConsentPrompt` for zero-lag, hardware-accelerated remote control without installing third-party VNC servers or display capture drivers.

---

### 🚀 Key Highlights
- **⚡ Sub-Second Cold Startup & Telemetry Persistence**: High-speed TSV caching engine with 24-thread parallel network endpoint scanning; hydrates and verifies 40+ endpoints with real-time green/red statuses and active user accounts in under 1.5 seconds.
- **💬 Advanced Remote User Messaging Hub**: Enforce exact character limits, Title/Subtitle/XL modes with contextual Large Text font toggle, non-clipping cards, and vibrant multi-icon badge containers.
- **🖨️ Remote Shared & Network Printer Infrastructure Manager**: Remotely attach UNC shared print queues, execute machine-wide connection purge, inspect properties, and pause/resume spoolers without rebooting.
- **👥 Active Directory Group Membership Manager**: Live interactive security group management (Add to Group, Remove from Group, Refresh) with built-in primary group safeguards directly from the Profile Card.
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
- **🖥️ Desktop Info HUD (Sysinternals BgInfo Engine)**: Directly stamp system telemetry onto desktop wallpapers in 2 crisp columns with drop shadows, or launch an optional floating widget (`🖥️ HUD (BgInfo)`).
- **🖼️ Remote Desktop Wallpaper Changer & Manager (Single & Bulk)**: Remotely apply custom background images (JPG, PNG, BMP) across one or multiple remote PCs with display fit styles (Fill, Fit, Stretch, Tile, Center, Span), live image preview, and 1-click original backup restoration.
- **👑 Windows God Mode & Power Tweaks Hub (Single & Bulk)**: Enable or remove Windows Master Control Panel on User & Public Desktop, context menus, and direct admin launcher, plus 1-click power tweaks (Take Ownership, Classic Win11 Menu, Ultimate Performance, CompactOS, Show File Extensions, Disable Telemetry, 1-Click RDP Enable, Disable Bing Search) across single or multiple remote computers.
- **🎯 Dynamic Smart Context Menu (Single vs Bulk)**: Right-clicking multi-selected computers dynamically displays only bulk-supported actions (Wallpaper, God Mode, HUD, Deep Clean, GPUpdate, Deployer, File Push, Messaging, Power & WOL). Right-clicking a single computer presents the full administrative console with informative messages when features are not configured or supported.
- **🌐 Remote Browser URL & File Launcher**: Launch web URLs in Default Browser, Microsoft Edge, or Google Chrome directly inside the remote user's interactive session.
- **🔄 Seamless In-App Auto-Updater**: Directly updates the application in-place from GitHub Releases without browser redirects or installer wizards!
- **⌨️ Universal Keyboard Ergonomics**: Dismiss any popup window with `ESC`, open Drive Manager with `Ctrl + D`.

---

## 🛠️ Complete Feature Matrix

| Category | Features & Capabilities |
| :--- | :--- |
| **🎯 Smart Context Menu** | • **Dynamic Context Menu Architecture (Single vs Multi-Device)**<br>• Automatically detects multi-selection to show only bulk-compatible operations<br>• Protects against accidental single-host tool execution in bulk<br>• Full rich menu on single selection with clean "Not Configured / Not Supported" feedback on hardware or policy limitations (Battery, BitLocker, LAPS) |
| **🖥️ Remote Display** | • Remote Shadowing (Attended & Auto-Attended `/noConsentPrompt`)<br>• Full Control (Keyboard & Mouse) or View-Only<br>• Fullscreen & Multi-Monitor spanning<br>• Standard RDP & Server Console Admin (`/admin`) sessions |
| **🔔 User Alerts** | • Action Center Toast Notifications near the taskbar clock<br>• Audio chime notification<br>• Automated fallback to `msg.exe` |
| **👑 God Mode & Tweaks**| • **Windows God Mode (Master Control Panel) Remote Controller (Single & Bulk)**<br>• Deploy/remove God Mode folder shortcut on User & Public Desktop<br>• Native desktop background right-click context menu integration<br>• 1-Click live interactive launch on remote user's screen (God Mode, Device Mgr, SecPol, Disk Mgr, Services, Regedit, Firewall, etc.)<br>• **"Take Ownership"** context menu injector (`takeown` + `icacls`)<br>• **Classic Windows 11 Context Menu** restorer (bypasses "Show more options")<br>• **"Ultimate Performance"** power plan activator (e9a42b02 scheme)<br>• **CompactOS** storage compression (free 3-5 GB on SSD)<br>• **Disable Consumer Bloatware** & promotional tiles<br>• **Always Show File Extensions & Hidden Files** in Explorer<br>• **Disable Windows Diagnostic Telemetry** (`AllowTelemetry = 0`)<br>• **1-Click Enable Remote Desktop (RDP)**, NLA & Firewall<br>• **Disable Bing Web Search** in Start Menu |
| **🖼️ Wallpaper Changer**| • **Remote Desktop Wallpaper Changer & Manager (Single & Bulk)**<br>• Remotely apply custom corporate wallpaper (JPG, PNG, BMP) to single or multi-selected computers<br>• Fit styles: Fill (Default), Fit, Stretch, Tile, Center, Span<br>• Embedded in-app image preview before applying<br>• Automatic backup of original wallpaper prior to replacement<br>• 1-Click restore original wallpaper on single or bulk target computers<br>• Seamless updates across active console and RDP user sessions |
| **🖥️ Desktop Info HUD** | • **Sysinternals BgInfo Wallpaper Engine (`🖥️ HUD (BgInfo)`)**<br>• Direct-to-wallpaper stamping matching classic Sysinternals BgInfo<br>• Two-column telemetry with drop shadows for 100% legibility on any wallpaper<br>• 3 deployment modes: Wallpaper Overlay, Floating HUD Widget, or Both<br>• Dynamic profile path discovery via `Win32_UserProfile`<br>• Theme-accurate live preview and 1-click wallpaper restoration |
| **🌐 Browser & App Run** | • **Remote Browser URL & Program Launcher**<br>• Launch URLs in Default Browser, Microsoft Edge, or Google Chrome<br>• Non-interactive execution directly inside user session |
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
| **👤 AD Account Actions**| • **Enterprise 360° AD User Profile Inspector & In-App Editor**: 40+ directory attributes, organizational hierarchy, contact information, and security group memberships<br>• **✏️ Edit AD User Profile Attributes**: In-place editing of First/Last/Display Name, Title, Department, Company, Office, Phone, Mobile, Email, and Address with direct LDAP commit<br>• **📝 Edit / Set Computer Description**: Live Active Directory computer description updater synchronized to the computer grid<br>• Real-time lockout detection: button turns red (`⚠️ Account Locked`)<br>• 1-click AD account unlocking via `UserPrincipal.UnlockAccount()`<br>• Remote password reset with optional forced password change at next logon |
| **🧹 Deep Temp Cleaner** | • Purges 4 administrative paths: `C:\Windows\Temp`, User `AppData\Local\Temp`, `Recent` files across all profiles, and `Prefetch`<br>• Reports exact file count and MB disk space freed |
| **⚡ Power Management** | • Wake-on-LAN (WOL) magic packets<br>• Lock remote screen without logging off<br>• Graceful remote user session logoff<br>• Remote reboot and shutdown with 5-second countdown |
| **📜 Audit Logging** | • Reverse-chronological activity log (newest records always on top)<br>• Isolated single-machine audit filtering<br>• Outcome logging: `SUCCESS`, `FAILED`, `CANCELLED` with error messages |
| **🔄 Auto-Updater** | • Direct GitHub Releases API integration with `SuperUser-exe/Windows-Active-Directory-Remote-Administration-Control-Center`<br>• In-app release notes viewer<br>• In-place download, detached update script, and automatic restart (0 browser redirect!) |

---

## 📁 Repository Structure

```text
Windows_AD_Remote_Administration_Control_Center/
├── Windows AD-Admin Control Center v2.7.0.exe  # Standalone portable Windows executable (~600 KB)
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
Download the latest `Windows AD-Admin Control Center v2.7.0.exe` from [GitHub Releases](https://github.com/SuperUser-exe/Windows-Active-Directory-Remote-Administration-Control-Center/releases).  
Right-click `Windows AD-Admin Control Center v2.7.0.exe` and select **Run as Administrator** (using Domain Admin credentials):
```cmd
"Windows AD-Admin Control Center v2.7.0.exe"
```

### Option 2: 1-Click Convenience Launcher
Alternatively, run the included launcher script:
```cmd
Run_AD_Remote_Control.bat
```

---

## ⚙️ Group Policy & Administrator Setup Requirements

### 1. Administrator Account Permissions & Authorization Policy

> [!IMPORTANT]
> **Strict Domain / Enterprise Administrative Authorization Enforcement**:  
> To safeguard domain environments and prevent unauthorized workstation management, the application verifies the security identity of the launching user at startup. The application will **ONLY** launch if the user belongs to at least one of the following Domain / Enterprise administrative accounts:
> - **Domain Admins** (Well-Known SID ending in `-512`)
> - **Enterprise Admins** (Well-Known SID ending in `-519`)
> - **Schema Admins** (Well-Known SID ending in `-518`)
> - **Account Operators** (Well-Known SID ending in `-548`)
> - **Server Operators** (Well-Known SID ending in `-549`)
> - **Authorized Active Directory Administrative Groups** (e.g., `IT-Admins`, `IT Admins`, `IT Administrators`, `Server Admins`, `System Admins`, `Security Admins`, `Network Admins`, `Cloud Admins`).
>
> ⚠️ **Local Administrators are strictly disallowed on Domain-Joined Machines**: Users who are only granted local workstation administrative privileges (`BUILTIN\Administrators` / `Local Administrators`) are blocked from executing this suite to maintain enterprise governance.
>
> 💡 **Need custom groups added or removed?** If your organization uses specialized administrative group names or specific role requirements, please [request a feature or open an issue on GitHub](https://github.com/SuperUser-exe/Windows-Active-Directory-Remote-Administration-Control-Center/issues) or reach out via [Telegram](https://t.me/WADRACC), and the author will gladly make the changes for your environment!

- **Domain Admins**: Fully privileged across all domain endpoints, Active Directory user objects, and admin shares out of the box.
- **Delegated Helpdesk Technicians**: Ensure support staff are members of an authorized domain administrative group (e.g. `Domain Admins` or `IT-Admins`) with delegated Active Directory permissions on target user OUs in `dsa.msc` for password resets and account unlocking.

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

## 🌟 How to Showcase, Support & Community Discussions

If this application saves you and your IT team hours of tedious administrative work:
- ⭐ **Star the Repository**: Drop a star on [GitHub](https://github.com/SuperUser-exe/Windows-Active-Directory-Remote-Administration-Control-Center) to help other sysadmins discover this free tool!
- 💬 **Join the Discussion**: Share workflow feedback, request custom administrative group authorizations, or submit feature requests on [GitHub Discussions](https://github.com/SuperUser-exe/Windows-Active-Directory-Remote-Administration-Control-Center/discussions) and [Telegram](https://t.me/WADRACC).
- 📢 **Share with Fellow Sysadmins**: Mention it on Reddit (`r/sysadmin`, `r/PowerShell`), LinkedIn, or your internal IT engineering channels.

---

## 📄 License, Legal & Ethical Use Notice

Developed with ❤️ by **[Askarali Mattummal](https://www.linkedin.com/in/askaralimattummal/)** ([LinkedIn Profile](https://www.linkedin.com/in/askaralimattummal/) | [GitHub](https://github.com/SuperUser-exe) | [Telegram Community](https://t.me/WADRACC)).  
Licensed under the [MIT License & Distribution Terms](LICENSE).

> [!CAUTION]
> **Authorized IT Administrative Use Only**: This software is designed, developed, and published strictly for authorized IT systems administrators and certified support personnel to maintain, monitor, and troubleshoot authorized enterprise domain infrastructure. Any unauthorized deployment, surveillance, privacy violation, or malicious use is strictly prohibited. The author assumes no responsibility or liability for damages or legal consequences arising from misuse. Please consult the [LICENSE](LICENSE) for complete terms of use and liability disclaimers.
