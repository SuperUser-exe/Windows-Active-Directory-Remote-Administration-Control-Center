# Windows AD Remote Administration Control Center — Enterprise Administration Suite
## Complete Operator Reference Manual & Architecture Guide (v2.6.5 / Coming Soon v2.7.0)
**Created & Developed by Askarali Mattummal**

---

### 📑 Table of Contents
1. [Overview & Architecture](#1-overview--architecture)
2. [Launching & Portability](#2-launching--portability)
3. [User Interface, Navigation & Visual Indicators](#3-user-interface-navigation--visual-indicators)
4. [Complete Right-Click Smart Context Menu Reference Guide](#4-complete-right-click-smart-context-menu-reference-guide)
   - [A. Single Computer Context Menu (Full Directory)](#a-single-computer-context-menu-full-directory)
   - [B. Bulk Computers Context Menu (Multi-Device Operations)](#b-bulk-computers-context-menu-multi-device-operations)
5. [Remote Desktop Access & Session Management](#5-remote-desktop-access--session-management)
   - [A. Remote Shadow Session (Screen Mirroring)](#a-remote-shadow-session-screen-mirroring)
   - [B. Pre-Shadow Toast Alert Notification](#b-pre-shadow-toast-alert-notification)
   - [C. Standard Remote Desktop (RDP) & Console Session](#c-standard-remote-desktop-rdp--console-session)
   - [D. Quick Assist Remote Assistance](#d-quick-assist-remote-assistance)
   - [E. UAC Shadow Session Compatibility & Black Screen Remediation](#e-uac-shadow-session-compatibility--black-screen-remediation)
   - [F. Comparison Table of Connection Modes](#f-comparison-table-of-connection-modes)
6. [Interactive Remote Terminal Console (CMD & PowerShell)](#6-interactive-remote-terminal-console-cmd--powershell)
7. [Hardware Specs & Real-Time Performance Diagnostics Monitor](#7-hardware-specs--real-time-performance-diagnostics-monitor)
8. [Systems Administration & Controllers](#8-systems-administration--controllers)
   - [A. Remote Task Manager (Process Controller)](#a-remote-task-manager-process-controller)
   - [B. Remote Windows Services Controller & Print Spooler Fix](#b-remote-windows-services-controller--print-spooler-fix)
   - [C. Remote Startup Applications (Autorun Manager)](#c-remote-startup-applications-autorun-manager)
   - [D. Remote System Restore Point Manager](#d-remote-system-restore-point-manager)
   - [E. Remote Computer Management & Task Scheduler MMC Snap-ins](#e-remote-computer-management--task-scheduler-mmc-snap-ins)
   - [F. Enable Windows Server Task Manager Disk Performance Counters](#f-enable-windows-server-task-manager-disk-performance-counters)
   - [G. Rename Remote Computer](#g-rename-remote-computer)
   - [H. Edit / Set Computer Description in Active Directory](#h-edit--set-computer-description-in-active-directory)
9. [Installed Software Inventory & Silent Uninstaller](#9-installed-software-inventory--silent-uninstaller)
10. [Remote Windows Event Log Viewer & Security Audit Hub](#10-remote-windows-event-log-viewer--security-audit-hub)
11. [Remote Printers, Print Queue & Ink/Toner Level Telemetry](#11-remote-printers-print-queue--inktoner-level-telemetry)
12. [Per-User Printing Report & Fleet Consumption Analytics Studio](#12-per-user-printing-report--fleet-consumption-analytics-studio)
13. [Active Directory User Profile Inspector & Attribute Editor](#13-active-directory-user-profile-inspector--attribute-editor)
14. [Active Directory Account Security & Password Management](#14-active-directory-account-security--password-management)
    - [A. Active Directory Account Unlocker](#a-active-directory-account-unlocker)
    - [B. Active Directory Password Reset](#b-active-directory-password-reset)
    - [C. Password Expiration Date Inspection](#c-password-expiration-date-inspection)
    - [D. Windows LAPS Local Administrator Password Management](#d-windows-laps-local-administrator-password-management)
    - [E. BitLocker Drive Encryption & Recovery Keys](#e-bitlocker-drive-encryption--recovery-keys)
15. [Local Computer Users & Security Manager](#15-local-computer-users--security-manager)
16. [Remote File Explorer Quick Links & Mapped Drives Manager](#16-remote-file-explorer-quick-links--mapped-drives-manager)
    - [A. Administrative Share & User Folder Quick Links](#a-administrative-share--user-folder-quick-links)
    - [B. Remote Mapped Network Drives Manager](#b-remote-mapped-network-drives-manager)
17. [Customization, Automation & Software Deployment](#17-customization-automation--software-deployment)
    - [A. Silent Software & Script Deployer](#a-silent-software--script-deployer)
    - [B. Remote File & Script Transfer (Push to Remote PC)](#b-remote-file--script-transfer-push-to-remote-pc)
    - [C. Remote Group Policy Refresh (GPUpdate /force)](#c-remote-group-policy-refresh-gpupdate-force)
    - [D. Windows God Mode & Power Tweaks](#d-windows-god-mode--power-tweaks)
    - [E. Desktop Info HUD (BgInfo & Floating Companion Widget)](#e-desktop-info-hud-bginfo--floating-companion-widget)
    - [F. Remote Desktop Wallpaper Changer & Manager](#f-remote-desktop-wallpaper-changer--manager)
    - [G. Remote Screen Saver Configuration](#g-remote-screen-saver-configuration)
18. [Inactivity & Idle Monitor Agent (Enterprise Feature)](#18-inactivity--idle-monitor-agent-enterprise-feature)
19. [Network Diagnostics & Connectivity Tools](#19-network-diagnostics--connectivity-tools)
    - [A. Ping Host & Latency Query](#a-ping-host--latency-query)
    - [B. Remote Network & IP Configuration Manager](#b-remote-network--ip-configuration-manager)
    - [C. DNS Name Resolution & Reverse Lookup (nslookup)](#c-dns-name-resolution--reverse-lookup-nslookup)
    - [D. Flush Remote DNS Resolver Cache](#d-flush-remote-dns-resolver-cache)
    - [E. One-Click Network Repair & Reset](#e-one-click-network-repair--reset)
    - [F. Enable Remote ICMP Ping Echo (Windows Firewall)](#f-enable-remote-icmp-ping-echo-windows-firewall)
    - [G. Remote Browser URL & Application Launcher](#g-remote-browser-url--application-launcher)
20. [Domain Controller & DNS Server Troubleshooting Suite](#20-domain-controller--dns-server-troubleshooting-suite)
21. [Remote Power Actions & Scheduled Task Operations](#21-remote-power-actions--scheduled-task-operations)
    - [A. Immediate Remote Power Actions](#a-immediate-remote-power-actions)
    - [B. Remote Workstation Lock & Unlock Controller](#b-remote-workstation-lock--unlock-controller)
    - [C. Scheduled Remote Power Operations](#c-scheduled-remote-power-operations)
22. [Deep Temporary Files Cleaner (4-Path Cleanup)](#22-deep-temporary-files-cleaner-4-path-cleanup)
23. [Reverse-Chronological Activity Audit Log & Notification Broadcasts](#23-reverse-chronological-activity-audit-log--notification-broadcasts)
    - [A. Endpoint Activity Audit Log](#a-endpoint-activity-audit-log)
    - [B. Toast Notifications & In-App Broadcast Studio with Read Receipts](#b-toast-notifications--in-app-broadcast-studio-with-read-receipts)
24. [Seamless In-App GitHub Auto-Updater](#24-seamless-in-app-github-auto-updater)
25. [Universal Keyboard Shortcuts](#25-universal-keyboard-shortcuts)
26. [Group Policy, Firewall & Endpoint Setup Guide](#26-group-policy-firewall--endpoint-setup-guide)
27. [Enterprise Security & Role-Based Access Governance](#27-enterprise-security--role-based-access-governance)
28. [Community, Support & Feedback](#28-community-support--feedback)

---

### 1. Overview & Architecture

**Windows AD Remote Administration Control Center** (v2.6.5 / Coming Soon v2.7.0) is a standalone, high-performance Windows systems administration and remote assistance suite built specifically for Active Directory Domain Administrators, Systems Engineers, and IT Helpdesk specialists.

Unlike commercial remote assistance tools that require installing proprietary background services or paying recurring cloud subscriptions, Windows AD Remote Administration Control Center operates **100% agentlessly**. It interacts natively with Windows endpoints using standard enterprise protocols:
- **Active Directory / LDAP (ADSI)**: Discovers all domain-joined workstations and servers in real-time.
- **Terminal Services APIs**: Initiates Remote Shadow sessions and RDP console attachments.
- **Windows Management Instrumentation (WMI / DCOM / RPC)**: Executes remote commands, inspects hardware sensors, queries installed software across all user profiles, manages services, and controls processes.
- **Windows Event Log RPC**: Streams live event records reverse-chronologically.
- **SMB Administrative Shares (C$)**: Enables 1-click folder navigation and administrative file cleanup.
- **ICMP & ARP**: Performs concurrent real-time ping latency and MAC address resolution.

---

### 2. Launching & Portability

#### Single-File Native Executable
Launch the application simply by executing:
```text
"Windows AD-Admin Control Center.exe"
```
Or use the launcher batch file (which automatically launches the versioned executable):
```text
Run_AD_Remote_Control.bat
```

#### Zero External Dependencies
**Windows AD-Admin Control Center.exe** is compiled as a self-contained 64-bit Windows executable with the application icon and user guide embedded directly within the binary. You can copy the single .exe file to your Desktop, an IT management jump box, or a read-only network share (\\Domain\SYSVOL\IT_Tools\). No installers or third-party DLLs are required.

#### Structured Package Architecture
When extracting or deploying the public release package, assets are organized into dedicated subdirectories:
- **Release Root**: Contains the primary executable (Windows AD-Admin Control Center v2.7.0.exe), the 1-click convenience launcher (Run_AD_Remote_Control.bat), cryptographic integrity hashes (CHECKSUMS.txt), and quick start notes.
- **Documentation/**: Complete administrator reference manuals, version changelogs, architecture documentation, and software license files.
- **Tools/**: Auxiliary endpoint utilities, including the Activity & Inactivity Monitor Agent (ADRC_IdleAgent.exe).
- **PS Scripts/**: Automated domain deployment scripts, including the Group Policy and Windows Firewall setup utility (Configure_Endpoint_GPO.ps1).
- **Images/**: High-resolution interface previews and branding assets.

---

### 3. User Interface, Navigation & Visual Indicators

#### Top Header & Navigation Bar
- **🌓 Theme Selection Menu (🌓 Auto / 🌙 Dark / ☀️ Light)**: Dynamically switches the entire application theme between Auto (follows Windows system setting), Dark Mode, and Light Mode.
- **🚀 In-App GitHub Auto-Updater (🚀 Updates / 🏷️ v2.6.5 Notes)**: Opens version notes or checks GitHub releases for 1-click zero-browser updates.
- **📜 Endpoint Activity Audit Log (📜 Activity Log)**: Opens the reverse-chronological administrative action audit trail.
- **📊 CSV Data Export (📊 Export CSV)**: Exports the currently displayed computer grid view to a structured CSV file.
- **💬 In-App Feedback & Star Rating (💬 Feedback)**: Submit 1-to-5 star ratings, bug reports, or feature requests directly to developers.

#### Workstation State & Operational Presence Reference Table

The central table displays real-time presence indicators with standardized color coding, condition criteria, and duration formatting:

| Indicator Badge | State Name | Color Theme | Operating Condition | Duration Formatting Examples |
| :--- | :--- | :--- | :--- | :--- |
| 🟢 Active | **Active** | 🟢 Emerald Green | User actively moving mouse or typing within the last 5 minutes | Active session (< 5m) |
| 🔷 💤 Idle | **Idle** | 🔷 Sky Blue | User session inactive with no mouse or keyboard input for 5+ minutes | Idle (13m), Idle (1h 30m), Idle (1d 4h) |
| 🟡 🔒 Locked | **Locked** | 🟡 Amber Gold | Workstation screen is locked by user (Win + L) or screen saver | Locked (18m), Locked (1h 30m), Locked (1d 4h) |
| 🌹 🚪 Disconnected | **Disconnected** | 🌹 Coral Red | User session is disconnected (RDP disconnect or session switch) | Disconnected session |
| ⚪ Logged Off | **Logged Off** | ⚪ Slate Gray | Workstation is powered on and online, but no interactive user is logged on | Console at Windows login screen |
| 🔴 Offline | **Offline** | 🔴 Crimson Red | Workstation is turned off, sleeping, or unreachable over ICMP/network | System unreachable |

#### Inventory DataGrid Columns Reference

| Column Name | Type / Format | Description & Interactivity |
| :--- | :--- | :--- |
| **Computer Name** | String / Hostname | NetBIOS computer name. Features agent dot: 🟢 Active, 🟡 Stale, ⚫ Not Installed, 🔴 Offline. Double-click opens AD User Profile Card. |
| **IP Address** | IPv4 String | Real-time IP address resolved over ICMP/DNS queries. |
| **Ping Latency** | Numeric (ms) | Round-trip ping response time in milliseconds. Color-coded green (<30ms) or amber. |
| **Workstation State** | Dynamic Presence | Live user state (🟢 Active, 💤 Idle, 🔒 Locked, 🚪 Disconnected, ⚪ Logged Off, 🔴 Offline) with exact duration format. |
| **Logged-in User** | Domain Account | Authenticated console or RDP interactive user (DOMAIN\User). |
| **Logon Time** | Date / Time | Timestamp of when the active user logged on to the session. |
| **Uptime** | Elapsed Time | Live system uptime (⏱️ 3d 12h). Click header for accurate numeric sorting. Hover tooltip reveals exact boot date/time. |
| **Operating System** | String / Edition | Windows edition, release version, and architecture (e.g. Windows 11 Pro 64-bit). |
| **Last User** | String / History | Most recently logged-on user account retrieved from historical directory attributes. |

#### Fast Action Search Bar & Multi-Selection Filtering
- **Quick Search Bar (Ctrl + S / Ctrl + F)**: Filter computer records in real-time by hostname, IP address, user name, or OS.
- **Organizational Unit / Category Filter**: Filter workstation list by Active Directory OU or functional category.
- **Multi-Selection Support**: Select multiple workstations using Shift + Click or Ctrl + Click to perform bulk actions (wallpaper change, deep temp clean, remote restart, software deployment, RDP enablement).

---

### 4. Complete Right-Click Smart Context Menu Reference Guide

Right-clicking any workstation or server row in the inventory grid opens the **Smart Context Menu**. The menu dynamically tailors its actions based on whether a single computer or multiple computers are selected, and whether the target is an Active Directory Domain Controller / DNS Server.

Both Single and Bulk context menus feature an embedded **Fast Action Search Box** at the top (🔍 Type to filter menu actions...). Simply start typing any keyword (e.g. ping, event, wallpaper, laps, restore, reboot) to instantly filter all available actions in real time.

#### A. Single Computer Context Menu (Full Directory)

| Submenu Category | Action Title | Visual Accent | Purpose & Operational Capability |
| :--- | :--- | :--- | :--- |
| **Top-Level Remote Access** | ⚡ Shadow Session (Screen Mirror) | 🟢 Emerald Green | Attaches directly to the interactive display session without user logoff. |
| **Top-Level Remote Access** | 🛡️ Fix UAC Black Screen... | 🟢 Emerald Green | Configures UAC elevation consent prompt compatibility for shadowing. |
| **Top-Level Remote Access** | 🖥️ Remote Desktop (RDP Login) | 🔵 Royal Blue | Launches standard mstsc.exe session directly to the target machine. |
| **Top-Level Remote Access** | 🔓 Enable Remote Desktop (RDP) on Host... | 🟢 Emerald Green | Remotely configures Terminal Server registry, starts service, opens firewall. |
| **Top-Level Remote Access** | 💻 Remote Console Terminal (CMD & PS) | 🔷 Sky Cyan | Opens interactive remote command-line terminal for CMD and PowerShell. |
| **⚙️ Administration & Management** | 📊 Remote Task Manager / End Process | 🌸 Rose Pink | Live process list, working set memory, CPU time, and 1-click process termination. |
| **⚙️ Administration & Management** | ⚙️ Remote Services Manager | 🟡 Amber Gold | Full service inventory; Start, Stop, Restart, and change service startup modes. |
| **⚙️ Administration & Management** | 📦 Installed Software & Silent Uninstaller | 🟣 Indigo | 64-bit/32-bit/HKU software scan with 1-click silent uninstallation. |
| **⚙️ Administration & Management** | 🚀 Remote Startup Applications (Autorun Manager) | 🌸 Rose Pink | Inspects and manages autorun registry keys and startup folders. |
| **⚙️ Administration & Management** | 🖨️ Remote Printers & Print Queue Manager | 🌊 Ocean Teal | Manage printer queues, pause/resume, test print, and consumable supply chips. |
| **⚙️ Administration & Management** | 📊 Per-User Printing Report & Fleet Statistics | 🔵 Ocean Blue | Launches comprehensive print server auditing and consumption analytics. |
| **⚙️ Administration & Management** | 👥 Local Computer Users & Accounts Manager | 🔵 Royal Blue | Manage local users, create accounts with policy check, and reset passwords. |
| **⚙️ Administration & Management** | ⏮️ Remote System Restore Management | 🟣 Royal Purple | Inspect, create, and restore system checkpoints remotely. |
| **⚙️ Administration & Management** | 💻 Remote Computer Management MMC (compmgmt.msc) | 🔷 Sky Blue | Launches native Computer Management console connected to remote host. |
| **⚙️ Administration & Management** | ⏰ Remote Task Scheduler MMC (taskschd.msc) | 🟡 Amber Gold | Launches native Task Scheduler snap-in connected to remote host. |
| **⚙️ Administration & Management** | 📈 Enable Windows Server Task Manager Disk Counters | 🟢 Emerald Green | Invokes diskperf -Y to activate disk performance counters on Windows Server. |
| **⚙️ Administration & Management** | 🏷️ Rename Remote Computer (Domain / Workgroup)... | 🟡 Amber Gold | Remotely renames the computer hostname with optional automatic reboot. |
| **⚙️ Administration & Management** | 📝 Edit / Set Computer Description (Active Directory)... | 🔷 Sky Blue | Reads and updates the computer description attribute in Active Directory. |
| **🌐 DC & DNS Troubleshooting** *(DCs Only)* | 🔄 Restart DNS Server Service (DNS) | 🟡 Amber Gold | Restarts the Windows DNS Server service on the Domain Controller. |
| **🌐 DC & DNS Troubleshooting** *(DCs Only)* | 🔄 Restart DNS Client Cache Service (Dnscache) | 🔷 Sky Cyan | Restarts the local DNS client resolver cache service. |
| **🌐 DC & DNS Troubleshooting** *(DCs Only)* | 🧹 Clear DNS Client Resolver Cache | 🟢 Emerald Green | Flushes the local DNS client resolver cache. |
| **🌐 DC & DNS Troubleshooting** *(DCs Only)* | 🔍 Resolve DNS Name (Custom Query Host)... | 🔷 Sky Blue | Executes custom DNS name resolution lookups against the DC. |
| **🌐 DC & DNS Troubleshooting** *(DCs Only)* | 📡 Ping 8.8.8.8 (External DNS Reachability Test) | 🟣 Royal Purple | Verifies external internet WAN gateway connectivity from the server. |
| **📊 Diagnostics & Health** | 📈 Live Performance & Hardware Monitor (Real-Time) | 🟢 Emerald Green | Real-time CPU, RAM, Network, and Disk graphs with deep history view. |
| **📊 Diagnostics & Health** | 📋 Remote Windows Event Logs (System & App) | 🟡 Amber Gold | High-speed reverse streaming event log viewer with 35+ presets. |
| **📊 Diagnostics & Health** | 📜 Group Policy & GPUpdate Event Logs | 🌊 Dark Teal | Scopes event viewer directly to Group Policy processing events. |
| **📊 Diagnostics & Health** | 🔋 Laptop Battery & Power Health... | 🟢 Emerald Green | Battery charge level, health/wear percentage, cycle count, and AC state. |
| **📊 Diagnostics & Health** | 🔍 Check Inactivity Agent Status & Diagnostics... | 🟢 Emerald Green | Four-tier diagnostic verification of the activity monitoring agent. |
| **📊 Diagnostics & Health** | 🛠️ Repair Remote WMI Repository (mofcomp / resync)... | 🟡 Amber Gold | Recompiles MOF definitions and resynchronizes corrupt WMI performance counters. |
| **📊 Diagnostics & Health** | 📜 Open Activity Log for This Computer | 🟣 Royal Purple | Filters application activity audit log specifically to the targeted machine. |
| **🌐 Network & Connectivity** | 📡 Ping Host & Query Info | 🔷 Sky Cyan | Real-time ICMP ping test with latency and packet loss metrics. |
| **🌐 Network & Connectivity** | 🌐 Remote Network & IP Configuration... | 🔷 Sky Blue | Inspect and configure IP addresses, DHCP vs. Static mode, and DNS servers. |
| **🌐 Network & Connectivity** | 🔍 DNS Name Resolution & Reverse Lookup (nslookup)... | 🟢 Emerald Green | Performs forward and reverse DNS queries for hostname/IP verification. |
| **🌐 Network & Connectivity** | 🌐 Flush Remote DNS (ipconfig /flushdns) | 🔷 Sky Cyan | Clears the remote endpoint's DNS resolver cache. |
| **🌐 Network & Connectivity** | ⚡ One-Click Network Repair & Reset... | 🟢 Emerald Green | Automated sequence: release, renew, flushdns, winsock reset, adapter reset. |
| **🌐 Network & Connectivity** | 📶 Enable Remote ICMP Ping Echo (Windows Firewall)... | 🟡 Amber Gold | Unblocks inbound ICMPv4 echo requests in Windows Defender Firewall. |
| **🌐 Network & Connectivity** | 🔗 Open Website URL in Remote User's Browser... | 🔷 Sky Blue | Spawns web URLs or web applications in the remote user's browser session. |
| **🌐 Network & Connectivity** | ⚡ Wake-on-LAN (WOL Wakeup) | 🟡 Amber Gold | Sends magic packets to power on sleeping workstations. |
| **👤 Active Directory & User Session** | 👤 View AD User Profile Card | 🟣 Indigo | 360° inspector with 40+ directory attributes and group membership management. |
| **👤 Active Directory & User Session** | ✏️ Edit AD User Profile Attributes... | 🟡 Amber Gold | In-app editor for First Name, Last Name, Title, Dept, Phone, Email, Office. |
| **👤 Active Directory & User Session** | 🔓 Unlock User Account (Active Directory) | 🟢 Emerald Green | Clears locked-out account flags in Active Directory immediately. |
| **👤 Active Directory & User Session** | 🔑 Reset User Password (Active Directory) | 🟡 Amber Gold | Sets new temporary password with optional force-change-at-logon toggle. |
| **👤 Active Directory & User Session** | ⏰ Check User Password Expiration Date... | 🟡 Amber Gold | Displays exact password expiration timestamp and days remaining. |
| **👤 Active Directory & User Session** | 💬 Send Toast Notification to User | 🟣 Royal Purple | Sends Windows Action Center toast alert with chime sound. |
| **👤 Active Directory & User Session** | 🚪 Logoff Active User Session | 🟠 Deep Orange | Gracefully terminates the remote user's interactive session. |
| **📁 Files & Shared Folders** | 💾 Open C$ Root Drive Share | 🔵 Royal Blue | Opens Explorer directly into \\Host\C$. |
| **📁 Files & Shared Folders** | 🖥️ Open Desktop Folder | 🟢 Emerald Green | Opens active user's remote Desktop directory. |
| **📁 Files & Shared Folders** | 📥 Open Downloads Folder | 🔷 Sky Cyan | Opens active user's remote Downloads directory. |
| **📁 Files & Shared Folders** | 📄 Open Documents Folder | 🟣 Royal Purple | Opens active user's remote Documents directory. |
| **📁 Files & Shared Folders** | 🗄️ Remote Mapped Network Drives Manager | 🔵 Royal Blue | Inspect, map new drive letters, edit paths, or disconnect remote drives. |
| **📁 Files & Shared Folders** | 📁 Push File / Script to Remote PC (C$\Temp)... | 🔵 Royal Blue | Uploads local files or scripts directly to remote C$\Temp folder. |
| **🛠️ Customization, Automation & Deploy** | 📦 Silent Software / Script Deployer | 🟣 Royal Purple | Silent execution of MSI, EXE, BAT, or PS1 packages with exit codes. |
| **🛠️ Customization, Automation & Deploy** | 🔄 Force Remote GPUpdate (gpupdate /force) | 🟢 Emerald Green | Forces immediate Group Policy evaluation strictly on the remote target. |
| **🛠️ Customization, Automation & Deploy** | 📜 View GPUpdate & GPO Event Logs | 🌊 Dark Teal | Direct jump to Event Log Viewer scoped to Group Policy processing events. |
| **🛠️ Customization, Automation & Deploy** | 👑 Windows God Mode & Power Tweaks... | 🟡 Amber Gold | Remote access to Windows God Mode shortcuts and power plan tweaks. |
| **🛠️ Customization, Automation & Deploy** | 🖥️ Desktop Info HUD (BgInfo)... | 🔷 Sky Cyan | Composites live computer telemetry directly into the desktop wallpaper. |
| **🛠️ Customization, Automation & Deploy** | 🖼️ Change Desktop Wallpaper... | 🔷 Sky Blue | Remotely sets corporate branded wallpaper across single or multiple PCs. |
| **🛠️ Customization, Automation & Deploy** | 🖥️ Remote Screen Saver Configuration... | 🟣 Royal Purple | Enables/disables screen savers, timeout durations, and password lockout. |
| **🛠️ Customization, Automation & Deploy** | 🚀 Deploy / 🛑 Uninstall Inactivity Agent | 🟢 Emerald / 🔴 Red | Installs or removes the lightweight presence monitoring agent. |
| **⚡ Security & Power Control** | 🔐 BitLocker Recovery Keys & Drive Encryption... | 🟡 Amber Gold | Queries Active Directory for backed-up BitLocker recovery keys and status. |
| **⚡ Security & Power Control** | 🔑 LAPS Local Administrator Password... | 🟢 Emerald Green | Decrypts managed LAPS password, shows expiration countdown, rotate now. |
| **⚡ Security & Power Control** | 🧹 Deep Temp Clean (Temp, Recent, Prefetch) | 🟡 Amber Gold | 4-path automated disk cleanup with total freed megabytes reporting. |
| **⚡ Security & Power Control** | 🔒 Remote Workstation Lock & Unlock Controller | 🔴 Crimson Red | Interactively locks or unlocks workstation input controls and display. |
| **⚡ Security & Power Control** | 🔒 Instant Lock Workstation Screen | 🌹 Dark Rose | Immediately locks the physical screen without session termination. |
| **⚡ Security & Power Control** | 🔄 Restart Computer (Reboot) | 🌹 Dark Rose | Reboots the remote computer with a 5-second countdown. |
| **⚡ Security & Power Control** | 🛑 Shutdown Computer (Power Off) | 🔴 Crimson Red | Powers off the remote computer with a 5-second countdown. |
| **⚡ Security & Power Control** | ⏰ Schedule Power Action (Restart, Shutdown, Lock)... | 🟣 Royal Purple | Schedules future power actions with calendar picker and countdown notice. |

#### B. Bulk Computers Context Menu (Multi-Device Operations)

When selecting multiple computers in the inventory grid (via Shift + Click, Ctrl + Click, or Ctrl + A), right-clicking presents the dedicated **Bulk Operations Context Menu**:

| Bulk Category | Action Title | Visual Accent | Purpose & Multi-Host Execution |
| :--- | :--- | :--- | :--- |
| **Customization** | 🖼️ Change Desktop Wallpaper (Bulk)... | 🔷 Sky Blue | Pushes corporate wallpaper to all selected computers simultaneously. |
| **Customization** | 🖥️ Remote Screen Saver Configuration (Bulk)... | 🟣 Royal Purple | Configures timeout, screen saver type, and password lock across selected PCs. |
| **Customization** | 👑 Windows God Mode & Power Tweaks (Bulk)... | 🟡 Amber Gold | Applies performance power plans and master settings across all targets. |
| **Customization** | 🖥️ Desktop Info HUD Overlay (BgInfo Bulk)... | 🔷 Sky Cyan | Deploys desktop telemetry overlay watermarks across selected computers. |
| **Maintenance** | 🧹 Deep Temp Clean (Bulk) | 🟡 Amber Gold | Cleans Temp, Recent, and Prefetch files across all selected workstations. |
| **Maintenance** | 🔄 Force Remote GPUpdate (Bulk) | 🟢 Emerald Green | Triggers concurrent gpupdate /force on all selected machines. |
| **Maintenance** | 📦 Silent Software / Script Deployer (Bulk)... | 🟣 Royal Purple | Deploys software packages or setup scripts across multiple computers. |
| **Maintenance** | 📁 Push File / Script to Remote PCs (Bulk)... | 🔵 Royal Blue | Uploads files or scripts directly to C$\Temp on all selected targets. |
| **Maintenance** | 🛡️ Configure UAC Shadow Compatibility (Bulk)... | 🟢 Emerald Green | Enables shadow compatibility settings across all selected machines. |
| **Maintenance** | 🔓 Enable Remote Desktop (RDP) (Bulk)... | 🔵 Royal Blue | Enables RDP, starts services, and unblocks port 3389 across all targets. |
| **Maintenance** | 🚀 Deploy Inactivity & Idle Monitor Agent (Bulk)... | 🟢 Emerald Green | Deploys presence monitoring agent across selected machines concurrently. |
| **Maintenance** | 🛑 Uninstall Inactivity & Idle Monitor Agent (Bulk)... | 🔴 Crimson Red | Removes presence monitoring agent across selected machines. |
| **Network & Messaging** | 💬 Send Toast Notification to All Users (Bulk)... | 🟣 Royal Purple | Dispatches Action Center toast alerts or modal announcements to all targets. |
| **Network & Messaging** | 📡 Ping All Selected Hosts (Bulk) | 🔷 Sky Cyan | Concurrently pings all selected hosts and updates latency metrics. |
| **Network & Messaging** | 🌐 Flush Remote DNS Cache (Bulk) | 🔷 Sky Blue | Flushes client DNS resolver caches across all selected computers. |
| **Network & Messaging** | 📶 Enable Remote ICMP Firewall Rule (Bulk) | 🟡 Amber Gold | Unblocks inbound ping echo requests in firewalls across all targets. |
| **Network & Messaging** | ⚡ Wake-on-LAN Broadcast (Bulk) | 🟡 Amber Gold | Transmits magic packets to power on all selected sleeping machines. |
| **Security & Power** | 🔒 Lock Active Sessions (Bulk) | 🔴 Crimson Red | Instantly locks desktop screens across all selected workstations. |
| **Security & Power** | 🚪 Logoff Active Users (Bulk) | 🟠 Deep Orange | Gracefully logs off active user sessions across all selected targets. |
| **Security & Power** | 🔄 Restart Computers (Bulk) | 🌹 Dark Rose | Concurrently reboots all selected machines with countdown alerts. |
| **Security & Power** | 🛑 Shutdown Computers (Bulk) | 🔴 Crimson Red | Concurrently powers off all selected machines with countdown alerts. |
| **Security & Power** | ⏰ Schedule Power Action (Bulk)... | 🟣 Royal Purple | Schedules future restart, shutdown, or lock actions across selected PCs. |

---

### 5. Remote Desktop Access & Session Management

#### A. Remote Shadow Session (Screen Mirroring)
Remote Desktop Shadowing attaches directly to an active physical display session using native Windows terminal services without logging the user out or interrupting their work.

- **Auto-Attended (/noConsentPrompt)**:
  - **Checked** (default: enabled): Connects immediately without prompting the remote user (requires Domain Group Policy permission).
  - **Unchecked**: Prompts the user on their screen: *"Administrator is requesting remote control of your desktop. Do you allow this?"*.
- **Full Control (/control)**:
  - **Checked** (default: enabled): Enables remote mouse and keyboard interactivity.
  - **Unchecked**: View-only mode for observation or training.
- **Full Screen (/f)**: Launches the viewer in fullscreen mode.
- **Multi-Monitor (/multimon)**: Spans across multi-monitor setups.
- **Automatic Session Detection**:
  - Automatically identifies active console session IDs without requiring manual entry.

#### B. Pre-Shadow Toast Alert Notification
- When **🔔 Alert User** is checked (default: enabled), the application automatically transmits a modern Windows Action Center Toast notification accompanied by a chime sound directly to the user's taskbar clock:
  ```text
  IT Support Alert
  An administrator is connecting to your desktop session to assist with your technical request.
  ```
- If WinRM is unavailable, it smoothly falls back to native messaging options.

#### C. Standard Remote Desktop (RDP) & Console Session
Connects via standard Remote Desktop.
- **Admin Session (/admin)**:
  - Connects directly to the physical console / administrative session.
  - On Windows Servers, it connects to dedicated administrative slots and bypasses RDS Client Access License (CAL) limits.
  - On Windows Workstations, it attaches to the console session, locking the physical screen.
- **Automated Pre-Flight Port Reachability & Smart Activation Prompt**:
  - When launching an RDP connection, the application automatically performs an instantaneous pre-flight check on TCP port 3389.
  - If the port is open and listening, Remote Desktop launches immediately with zero delay.
  - If Remote Desktop is disabled or blocked by firewall, a dedicated smart assistance prompt appears offering to automatically configure the service, open the firewall, and connect with a single click.
- **Remote Desktop Configuration & Diagnostic Center**:
  - Click the dropdown arrow (▼) next to **🖥️ Connect RDP Session** on the bottom connection bar or right-click any computer and select **🔓 Enable Remote Desktop (RDP) on Host...** to open the interactive configuration center.
  - **Live Diagnostics**: Automatically inspects whether Remote Desktop connections are enabled, checks Network Level Authentication (NLA) enforcement, and probes TCP port 3389 reachability.
  - **1-Click Enablement**: Remotely configures Terminal Services settings, ensures background services are started, and adds inbound firewall rules for TCP port 3389.
  - **Bulk Configuration**: Select multiple computers in the inventory grid, right-click, and choose **🔓 Enable Remote Desktop (RDP) (Bulk)...** to enable Remote Desktop across dozens of workstations simultaneously.

#### D. Quick Assist Remote Assistance
Located on the primary bottom connection toolbar directly between **⚡ Connect Shadow Session** and **🖥️ Connect RDP Session**, the **🚀 Quick Assist** button provides immediate, 1-click access to Microsoft Quick Assist (Ctrl + Win + Q).

- **When to Use Quick Assist**:
  - **Cross-Subnet & VPN Support**: Ideal when managing remote laptops connecting through restricted guest Wi-Fi, home VPN tunnels, or multi-tenant DMZs where inbound RDP or RPC/SMB ports may be blocked by firewalls.
  - **Co-Piloted Interactive Support**: Allows technicians to guide end-users interactively using Microsoft cloud session codes without requiring pre-configured Group Policy permissions.

#### E. UAC Shadow Session Compatibility & Black Screen Remediation
Right-click any computer -> **🛡️ Fix UAC Black Screen...** (or bulk configure multiple computers).
- Resolves the common issue where screen shadowing screens freeze or turn black when an User Account Control (UAC) administrative prompt appears.
- Configures client compatibility settings so administrators can interact with elevated UAC prompts seamlessly during remote assistance sessions.

#### F. Comparison Table of Connection Modes

| Mode Name | Visual Badge | Protocol / Port | Remote User Experience | Primary Use Case |
| :--- | :--- | :--- | :--- | :--- |
| **Remote Shadow Session** | ⚡ Shadow | Terminal Services / TCP 3389 | Screen mirrored in real-time; user stays logged in and sees cursor | Helpdesk user support, co-piloting, training, troubleshooting |
| **Standard Remote Desktop** | 🖥️ RDP | MSTSC / TCP 3389 | Physical screen is locked; user session taken over exclusively | Administrative maintenance, server administration, off-hours work |
| **Quick Assist** | 🚀 Quick Assist | HTTPS / Cloud Tunnel | User grants control via 6-digit Microsoft assistance code | Remote workers over Internet, VPN users, laptops off-domain |
| **Remote Console** | 💻 Terminal | WMI / RPC / WinRM | Completely invisible; background execution with zero display impact | Quick scripts, silent commands, service diagnostics |

---

### 6. Interactive Remote Terminal Console (CMD & PowerShell)

Click **💻 Console (CMD/PS)** on the toolbar or right-click any computer and select **💻 Remote Terminal Console** (Ctrl + T).

- **Agentless Execution**:
  - Spawns commands invisibly on the remote workstation, capturing output and streaming it back into the styled terminal window.
- **Quick Preset Actions**:
  - **👤 whoami**: Shows execution context.
  - **🔄 gpupdate /force**: Forces immediate Group Policy refresh.
  - **🌐 ipconfig /all**: Dumps full network adapter and DNS configurations.
  - **🛡️ sfc /scannow**: Runs system file integrity checks.
  - **📡 ping 8.8.8.8**: Verifies remote internet connectivity.
  - **⚡ PowerShell**: Toggles PowerShell command execution mode.
- **Export & Copy**: Copy terminal output to clipboard or export execution logs.

---

### 7. Hardware Specs & Real-Time Performance Diagnostics Monitor

Click **📊 Live Perf** or **📈 Specs** on the toolbar (or press Ctrl + Shift + M / Ctrl + I) or right-click any computer and select **📈 Live Workstation Performance & Resource Monitor**.

- **Consolidated Unified Diagnostics Architecture**:
  - Integrates underlying hardware specifications, BIOS identity, operating system details, and storage volumes directly alongside real-time performance telemetry.
- **Real-Time Streaming Performance Graphs**:
  - Live sub-second sparkline charts for CPU utilization, RAM memory allocation, dual-channel network bandwidth (upload/download), and disk I/O activity.
- **Full-Screen Deep History Monitoring View**:
  - **Double-Click or Expand Button**: Double-clicking any of the 4 live charts maximizes that single metric into a full-window deep monitoring view with a rolling buffer of up to 10 minutes of historical telemetry.
  - **Timeline Axis Markings**: Visual time markers spanning deep rolling history.
  - **KPI Metric Cards**: Displays Current Reading, Peak/Max, Low/Min, and Rolling Average.
  - **Seamless Restoration**: Double-clicking anywhere on the expanded view, clicking **🗗 Restore View**, or pressing **Escape** returns to the 4-panel overview.
- **Comprehensive Hardware & Subsystems Inventory**:
  - **Hardware Identity & Service Tag**: Motherboard manufacturer, computer model, BIOS version, and Serial Number / Service Tag with a 1-click **📋 Copy Serial** button.
  - **Operating System & Continuous Uptime Tracker**: OS edition, build number, 64-bit architecture, system boot timestamp, and continuous uptime counter.
  - **Processor Architecture**: CPU model, physical core and logical thread counts, maximum clock speed, and L3 cache size.
  - **Physical Memory Modules**: Total installed RAM, technology (DDR4/DDR5), clock speed in MHz, and per-slot physical DIMM module breakdown.
  - **Logical Storage Volumes**: Drive letters, volume names, file systems, capacity progress bars, free space percentages, and health status badges.
  - **Network Adapters & Link Speeds**: Network interface description, link speed (e.g. 1.0 Gbps), IPv4 address, default gateway, MAC address, and DHCP status.
- **One-Click System Specifications Export**:
  - Click **📋 Copy Specs** in the window footer to copy a complete, structured summary of the computer's identity, OS, CPU, RAM, disks, and network configuration to the Windows clipboard.

---

### 8. Systems Administration & Controllers

#### A. Remote Task Manager (Process Controller)
Click **📊 Task Mgr** on the toolbar or right-click any computer -> **⚙️ Administration & Management** -> **📊 Remote Task Manager / End Process**.
- Live process list with PID, Name, Working Set Memory (MB), and CPU time.
- Search filter box to find specific executables instantly.
- **🛑 End Process**: Remotely terminates hung or unresponsive applications with instant remote process termination.

#### B. Remote Windows Services Controller & Print Spooler Fix
Click **⚙️ Services** on the toolbar or right-click any computer -> **⚙️ Administration & Management** -> **⚙️ Remote Services Manager**.
- Inventory of all Windows services with Display Name, Service Name, Current State (Running/Stopped), and Start Mode (Auto/Manual/Disabled).
- Color-coded state indicators (🟢 Running, 🔴 Stopped).
- **Controls**: **Start**, **Stop**, **Restart**, and set Start Mode.
- **1-Click Print Spooler Fix**: Toolbar button **🔄 Restart Print Spooler** restarts the spooler service in one click across selected computers.

#### C. Remote Startup Applications (Autorun Manager)
Right-click any computer -> **⚙️ Administration & Management** -> **🚀 Remote Startup Applications (Autorun Manager)**.
- Scans system and user registry run locations, startup folders, and scheduled autoruns.
- Identifies background applications configured to launch on system boot.
- Enables administrators to inspect, disable, or remove startup applications to improve boot performance and system responsiveness.

#### D. Remote System Restore Point Manager
Right-click any target computer -> **⚙️ Administration & Management** -> **⏮️ Remote System Restore Management**.
- **System Protection Status & Remote Toggle**: Queries whether System Restore protection is enabled on the system drive (C:\) and allows enabling/disabling protection remotely.
- **On-Demand Restore Point Creation**: Click **➕ Create Restore Point** to stage an immediate system checkpoint before performing software installations or updates.
- **Chronological Checkpoint History**: Lists all available restore points in a clear DataGrid with Sequence Number, Description, Creation Date & Time, and Event Type.
- **Remote Rollback & Recovery**: Select any restore point and click **⏪ Restore to Selected Point** to stage a system recovery.

#### E. Remote Computer Management & Task Scheduler MMC Snap-ins
Right-click any computer -> **⚙️ Administration & Management**:
- **💻 Remote Computer Management MMC (compmgmt.msc)**: Launches the native Microsoft Management Console Computer Management snap-in targeted at the remote workstation.
- **⏰ Remote Task Scheduler MMC (taskschd.msc)**: Launches the native Task Scheduler MMC snap-in connected directly to the remote computer's task scheduler daemon.

#### F. Enable Windows Server Task Manager Disk Performance Counters
Right-click any computer -> **⚙️ Administration & Management** -> **📈 Enable Windows Server Task Manager Disk Counters**.
- On Windows Server systems (2012/2016/2019/2022/2025), Task Manager hides disk performance metrics by default. This action remotely invokes diskperf -Y to enable disk throughput counters and refreshes performance counter libraries.

#### G. Rename Remote Computer
Right-click any computer -> **⚙️ Administration & Management** -> **🏷️ Rename Remote Computer (Domain / Workgroup)...**.
- Prompts for a new NetBIOS hostname and optional reboot toggle to rename domain-joined or workgroup endpoints remotely.

#### H. Edit / Set Computer Description in Active Directory
Right-click any computer -> **⚙️ Administration & Management** -> **📝 Edit / Set Computer Description (Active Directory)...**.
- Reads and updates the computer's Active Directory description attribute in real time, synchronizing immediately with the computer inventory table.

---

### 9. Installed Software Inventory & Silent Uninstaller

Click **📦 Software** on the toolbar or right-click any computer -> **⚙️ Administration & Management** -> **📦 Installed Software & Silent Uninstaller**.

- **Multi-Architecture 64-Bit & 32-Bit Deep Scan**:
  - Scans 64-bit and 32-bit uninstall registries.
  - Iterates across loaded user profile hives, discovering per-user applications (e.g. Microsoft Teams, Zoom, Slack, VS Code).
- **1-Click Silent Remote Uninstallation**:
  - Select any application and click **🗑️ Silent Uninstall**.
  - Automatically parses uninstall commands to execute silently without user disruption.

---

### 10. Remote Windows Event Log Viewer & Security Audit Hub

Click **📋 Events** on the toolbar or right-click any workstation -> **📊 Diagnostics & Health** -> **📋 Remote Windows Event Logs**.

- **High-Speed Reverse Streaming & Remote Server-Side Filtering**:
  - Communicates directly with the remote computer's native Event Log RPC subsystem, querying newest records first.
- **Categorized Quick Presets Dropdown (Over 35 Enterprise Presets)**:
  - Presets organized across 8 operational categories:
    - **Windows LAPS**: LAPS Events, Password Read/Retrieved, Password Rotated/Updated, and Password Rotation Failures.
    - **User Account Lifecycle**: Account Created, Deleted, Enabled, Disabled, Locked Out, Unlocked, Modified, Admin Password Reset, User Password Change.
    - **Security Groups & Membership**: Member Added, Member Removed, Group Created, Group Deleted, Group Modified, Group Membership Changes.
    - **Network File Shares & File Access**: Share Object Accessed, File Deleted, File Created, File Modified, Permissions Modified.
    - **Logon, Kerberos & Authentication**: Successful Logons, Failed Logons / Bad Password, Admin Logon, Alternate Credentials (RunAs), Kerberos Errors, RDP Sessions.
    - **Security, Threats & Tampering**: New Windows Service Installed, Audit Policy Tampering, Firewall Rules Changed, Windows Defender Alerts, PowerShell Executions, Process Creation.
    - **System Reliability & Hardware**: Reboots, Normal Shutdowns, Unexpected Power Loss, BSOD Crashes, Application Crashes, Service Crashes, Storage Bad Blocks, BitLocker Encryption / Backup.
    - **Group Policy & GPUpdate Diagnostics**: Group Policy Activity, Policy Errors & Failures, Software Installation CSE, Successful Policy Refreshes.
- **Instant Type-to-Find Preset Search with Continuous Typing**:
  - Type any keyword into the search box beside the preset dropdown (e.g. laps, lockout, share, reboot, or any event number) to filter presets in real-time without losing cursor focus.
- **Forensic Entity Filtering Toolbar & Authoritative Deep Search**:
  - **👤 User / Account Filter**: Search and isolate events generated by or targeting a specific user account.
  - **🖥️ Client / Source PC Filter**: Search events originating from a specific client workstation or caller machine.
  - **🌐 IP Address Filter**: Track down specific caller network IP addresses across authentication and network events.
  - **📁 File / Object Path Filter**: Search file operations by file name or directory path across audited network shares.
  - **Exact Match Checkbox**: Toggle exact matching mode for file operations to eliminate partial substring noise.
  - **Authoritative Date-Ranged Search Scope**: Filter criteria actively query through all events within the selected date range on the remote machine, returning matching records up to your selected display limit rather than only filtering previously fetched rows.
  - **🔍 Search Logs Action Button & Instant Enter Key**: Click **🔍 Search Logs** or press **Enter** in any filter box to immediately execute an authoritative search across the remote log stream.
  - **Strict Local & Company-Internal Privacy**: All file share and user activity auditing runs strictly on your local administrative console, ensuring company file operations remain confidential and within your enterprise network.
- **Severity Color Badges Reference**:

| Severity Badge | Audit Type / Level | Meaning & Application Focus |
| :--- | :--- | :--- |
| 🟢 Audit Success | Success Audit | Verified authentications, authorized access, clean GPO refresh, account creation. |
| 🔴 Audit Failure | Failure Audit | Rejected logons, bad password attempts, access denied, security policy blocks. |
| 🛑 Critical & Error | Error / Critical | System crashes, blue screens (BSOD), failed services, hardware faults. |
| 🟡 Warning | Warning | Disk space alerts, transient network disconnects, print spooler delays. |
| ℹ️ Information | Informational | Routine service status, software installs, clean user logons/logoffs. |

- **Date Range & Precision Custom Range Picker**:
  - Standard ranges: All Dates, Today Only, Last 24 Hours, Last 7 Days, Last 30 Days.
  - **Custom Range...**: Selecting Custom Range unveils dedicated date and time pickers for **From Date**, **From Time** (`HH:mm:ss`), **To Date**, and **To Time** (`HH:mm:ss`) with an **Apply** button, allowing forensic analysis of exact incident windows.
  - High-performance reverse-chronological traversal automatically skips events outside the upper boundary and terminates scanning immediately once events reach the lower boundary.
  - Display record limits: 50 to 10,000 events.
- **Rapid-Access Emergency Action Pills**:
  - Single-click action buttons for urgent investigations: 🔴 Errors, 🔒 Lockouts, 👤 Users, 👥 Groups, 📁 File Shares, 🔑 LAPS, 📜 GPUpdate, 💥 BSOD, 🔄 Reboots.
- **Export & Detail Inspection**:
  - Inspect structured entity metadata in the details panel and click **📊 Export CSV** to export audit records.

---

### 11. Remote Printers, Print Queue & Ink/Toner Level Telemetry

Click **🖨️ Printers** on the toolbar or right-click any workstation -> **⚙️ Administration & Management** -> **🖨️ Remote Printers & Print Queue Manager**.

- **Parallel Asynchronous Spooler Engine**:
  - Executes printer discovery and queue event enumeration in parallel background threads for fast loading.
- **Comprehensive Printer Inventory**:
  - Local physical printers, USB devices, virtual/PDF printers, and domain shared network printers.
  - Columns: Printer Name, Type, Print Server / IP, Default status (⭐), Queued Jobs, Status, Location, Comment, Driver Name, Port Name, Ink / Toner Level.
- **Direct Network Printer Supplies & Ink/Toner Level Telemetry**:
  - Automatically queries network-connected printers for consumable marker supply levels (Black, Cyan, Magenta, Yellow toners, drums, and maintenance units).
  - Renders individual color-coded cartridge chips using a standardized 6-tier percentage severity scale:

| Consumable Level Scale | Visual Chip Badge | Health Status | Recommended Operator Action |
| :--- | :--- | :--- | :--- |
| **100% – 50%** | 🟢 Good | Healthy / Optimal | Supplies plentiful; no action required. |
| **49% – 25%** | 🟡 Low | Low Supply | Schedule replacement cartridge order. |
| **24% – 10%** | 🟠 Very Low | Warning | Stage replacement toner cartridge at printer. |
| **9% – 1%** | 🔴 Critical | Critical Alert | Replace supply cartridge immediately. |
| **0%** | 🛑 Empty | Depleted / Empty | Printer halted; replace consumable now. |
| **Unknown / N/A** | ⚪ Unknown | Offline / Virtual | Powered off, unreachable, or PDF printer. |

- **Live Queued Jobs & Document Isolation**:
  - Selecting any printer instantly isolates its active queue and completed document log in the lower DataGrid pane.
- **Printer Controls & Operations**:
  - **➕ Add Printer...**: Connect a shared network printer (\\PrintServer\PrinterShare).
  - **🗑️ Remove Printer**: Safely uninstalls any printer queue.
  - **ℹ️ Properties...**: View detailed hardware/driver metrics and edit Location, Comment, or Default status.
  - **⭐ Set Default**: Set selected printer as default.
  - **⏸️ Pause / ▶️ Resume**: Pause or resume print queues remotely.
  - **🖨️ Test Print**: Dispatches a native Windows test page.
  - **🗑️ Cancel Job**: Cancels individual stalled print jobs.
  - **🧹 Purge All Jobs**: Flushes all pending print jobs.
  - **🔄 Spooler Service**: Restarts the remote Print Spooler service.

---

### 12. Per-User Printing Report & Fleet Consumption Analytics Studio

Click **📈 Reports...** on the Printer Manager toolbar or right-click **🖨️ Printers** -> **📊 Per-User Printing Report & Fleet Statistics**.

- **Centralized Print Server Audit Analytics**:
  - Automatically queries Windows Print Server operational event audit streams to parse successful print jobs, user identities, client workstations, spooler byte sizes, page counts, and printer queue destinations.
- **Print Server Auto-Detection & Guidance Banner**:
  - Automatically detects the primary domain Print Server name and IP address from Active Directory.
  - Displays an accuracy guidance banner: *"For the most accurate and complete report, please check directly on your Printer Server: [ServerName]"* with a 1-click **🖨️ Switch to [ServerName]** button.
- **Multi-Dimensional Dropdown Filtering**:
  - Scope queries by **Print Server / Host**, **User Account**, **Target Printer Queue**, **Date Range** (Today, Yesterday, This Week, This Month, Last 30/90 Days, This Year), **Minimum Page Threshold**, **Job Status** (Completed, Failed, Cancelled), and **Document Name Keyword Search**.
- **Executive Summary Dashboard & KPI Fleet Metrics**:
  - KPI Cards: Total Pages Printed, Total Print Jobs, Completed Jobs, Failed/Cancelled Jobs, Active Printing Users, Active Printers Utilized, Fleet Average Pages per Job, Top Printing User.
  - Top High-Volume Consumer tables for Users and Printers.
- **Categorized Analysis Tabs**:
  - **👤 User Summary**, **🖨️ Printer Summary**, **📅 Date-Wise Trends**, **💻 Workstations**, **📄 Detailed Print Jobs**.
- **Document Name Masking & Windows Privacy Policy Guide**:
  - Explains why document titles show as `"Print Document"` by default in Windows 10/11/Server log settings and provides step-by-step instructions for enabling full document titles via Group Policy (Allow job name in print event logs) or Windows Registry (ShowJobTitleInEventLogs = 1).
- **Event Log Buffer Capacity & Sizing**:
  - Provides PowerShell commands (wevtutil sl Microsoft-Windows-PrintService/Operational /ms:...) to expand print log buffer sizes (e.g. 100 MB or 500 MB) for multi-month or year-round audit retention.
- **Reporting & Export**:
  - Export CSV data, copy clean tables to clipboard, or click **🖨️ Print / Save HTML Report** to generate an executive-ready HTML/PDF print report.

---

### 13. Active Directory User Profile Inspector & Attribute Editor

#### Enterprise 360° AD User Profile Inspector (👤 View Profile)
Click **👤 User Profile** on the toolbar or right-click any computer -> **👤 Active Directory & User Session** -> **👤 View AD User Profile Card** (Ctrl + Shift + U).
- Inspects over 40+ directory attributes across categorized views:
  - **👤 Identity**: Display Name, Given Name, Surname, SamAccountName, UPN, SID, Object GUID, DN, Description.
  - **🏢 Organization**: Job Title, Department, Company, Division, Office Location, Employee ID, Manager Name.
  - **📞 Contact**: Telephone, Mobile, Email, Street Address, City, State, Postal Code.
  - **🔒 Security**: Account Status, Bad Password Count, Last Bad Attempt, Password Last Set, Password Expiration Date, Last Logon.
  - **👥 Member of Groups**: Complete list of security and distribution group memberships.
- **Interactive AD Group Membership Management**:
  - **➕ Add to Group**: Search and add the user to any domain group.
  - **➖ Remove from Group**: Remove the user from selected groups (protecting primary groups).
  - **🔄 Refresh Groups**: Re-queries Active Directory in real-time.
- Toolbar actions: **🔓 Unlock Account**, **🔑 Reset Password**, **📋 Copy Summary**, **📊 Export Report**, **✏️ Edit Profile**.

#### In-App Active Directory User Profile Editor (✏️ Edit Profile)
Right-click any computer -> **👤 Active Directory & User Session** -> **✏️ Edit AD User Profile Attributes...** (or click **✏️ Edit Profile** inside the User Profile Card).
- Update First Name, Last Name, Display Name, Job Title, Department, Company, Office Location, Telephone, Mobile, Email, Street Address, City, State, Postal Code directly in Active Directory Domain Services.

---

### 14. Active Directory Account Security & Password Management

#### A. Active Directory Account Unlocker (🔓 Unlock User)
- Inspects the logged-in user account in Active Directory (Ctrl + U).
- If the account is locked out, the toolbar button turns vibrant red: **⚠️ Account Locked (Unlock)**.
- Click the button to unlock the account immediately in Active Directory.

#### B. Active Directory Password Reset (🔑 Reset Pass)
- Opens a secure password reset dialog (Ctrl + Shift + P).
- Specify a new temporary password and optionally check **"User must change password at next logon"**.

#### C. Password Expiration Date Inspection
- Right-click any computer -> **👤 Active Directory & User Session** -> **⏰ Check User Password Expiration Date...**.
- Displays exact password expiration timestamps and remaining validity days for the logged-in user.

#### D. Windows LAPS Local Administrator Password Management
Right-click any computer -> **⚡ Security & Power Control** -> **🔑 LAPS Local Administrator Password...**.
- **Automatic Decryption**: Queries Active Directory for managed local administrator credentials across modern Windows LAPS (encrypted/plaintext) and legacy Microsoft LAPS deployments.
- **Account Identification**: Displays the managed local admin username (e.g. Administrator).
- **Show/Hide & Clipboard Actions**:
  - Passwords masked by default. Click **👁️ Show** / **🙈 Hide** to toggle visibility.
  - Click **📋 Copy Pass**, **📋 Copy .\User** (formats .\AccountName), or **📑 Copy All**.
- **Expiration Countdown & Scheduling**:
  - Displays expiration timestamp alongside a live countdown badge.
  - Select future expiration dates using the date picker or quick presets (**+7d**, **+30d**, **+60d**, **+90d**).
- **Instant Password Rotation ("Expire Now & Rotate")**:
  - Click **⚡ Expire Now & Rotate** to force immediate credential rotation in Active Directory.

#### E. BitLocker Drive Encryption & Recovery Keys
Right-click any computer -> **⚡ Security & Power Control** -> **🔐 BitLocker Recovery Keys & Drive Encryption...**.
- Queries Active Directory for backed-up BitLocker recovery passwords, volume GUIDs, key protectors, and drive encryption status.

---

### 15. Local Computer Users & Security Manager

Right-click any computer -> **⚙️ Administration & Management** -> **👥 Local Computer Users & Accounts Manager** (or click **👥 Local Users** on toolbar).

#### Local Account Inventory & Management
- Lists all local user accounts registered on the target computer with Full Name, Account Type, Enabled Status, and Group Memberships.

#### Creating Local Users (➕ Create Local User)
- **Show / Hide Password Toggle**: Click **👁️ Show** / **🙈 Hide** to toggle password field masking.
- **Copy Password**: Click **📋 Copy** to copy the entered password value to clipboard.
- **Live Password Policy Banner**: Displays detected workstation password complexity rules (minimum length, uppercase, lowercase, numbers, symbols).
- **Pre-Validation**: Automatically checks password length and complexity before submitting to prevent remote errors.

#### Resetting Local Passwords (🔑 Reset Password)
- Select any local account and click **🔑 Reset Password**. Includes password masking toggle and copy support.

#### Secure User Deletion (🗑️ Delete User)
- Opens a safeguard confirmation window displaying full account details.
- Requires administrative confirmation typing **DELETE** before account removal.
- Shields built-in system accounts (Administrator, Guest, active session) from accidental deletion.

---

### 16. Remote File Explorer Quick Links & Mapped Drives Manager

#### A. Administrative Share & User Folder Quick Links
Toolbar and context menu shortcuts open Windows Explorer directly into remote administrative shares:
- **📁 Open C:/**: Opens \\<ComputerName>\C$.
- **📁 Desktop**: Opens active user's Desktop folder.
- **📁 Downloads**: Opens active user's Downloads folder.
- **📁 Documents**: Opens active user's Documents folder.

#### B. Remote Mapped Network Drives Manager (Ctrl + D)
Click **🗄️ Mapped Drives** on toolbar, press **Ctrl + D**, or right-click any computer -> **📁 Files & Shared Folders** -> **🗄️ Remote Mapped Network Drives Manager**.

- **Dual-Engine Discovery**:
  - **Registry Profile Scanner**: Scans network registry hives across all user profiles to discover persistent drive mappings even when screen is locked.
  - **Storage Inspector**: Inspects active mounted network disks for free space, total capacity, volume labels, and connection status.
- **Adding a Drive Mapping (➕ Add Drive Mapping)**:
  - **Drive Letter Selector**: Selects first available letter (Z: down to D:), flagging used letters.
  - **UNC Path & Test Button**: Enter \\server\share and click **"🔍 Test Path"** to verify reachability.
  - **Target User Profile**: Target specific loaded user profiles or active interactive session.
  - **Persistence Toggle**: Toggle reconnect at sign-in.
- **Editing & Disconnecting**:
  - Click **✏️ Edit Mapping** to update UNC path or persistence.
  - Click **🗑️ Disconnect & Remove** to clean registry entries and unmount the share.
- **Local Explorer Integration & Export**:
  - Double-click any mapped drive or click **📂 Open Share Locally** to open the UNC path in local Windows Explorer.
  - Click **📊 Export CSV** to export drive inventory.

---

### 17. Customization, Automation & Software Deployment

#### A. Silent Software & Script Deployer
Right-click any computer (or bulk select) -> **🛠️ Customization, Automation & Deploy** -> **📦 Silent Software / Script Deployer**.
- Remotely deploys MSI installers, EXE setup packages, PowerShell scripts (.ps1), or batch files (.bat / .cmd).
- Supports silent install switches (/qn, /quiet, /s, etc.) and returns real-time execution exit codes.

#### B. Remote File & Script Transfer (Push to Remote PC)
Right-click any computer (or bulk select) -> **📁 Files & Shared Folders** -> **📁 Push File / Script to Remote PC (C$\Temp)...**.
- Copies local files, scripts, or installation binaries directly to \\<Host>\C$\Temp\ on single or multiple target computers simultaneously.

#### C. Remote Group Policy Refresh (GPUpdate /force)
Click **🔄 GPUpdate** on toolbar or right-click computer -> **🛠️ Customization, Automation & Deploy** -> **🔄 Force Remote GPUpdate**.
- Guarantees execution strictly on the remote target endpoint.
- Displays progress indicators and provides direct links to inspect the remote event log to verify policy enforcement.

#### D. Windows God Mode & Power Tweaks
Right-click any computer (or bulk select) -> **🛠️ Customization, Automation & Deploy** -> **👑 Windows God Mode & Power Tweaks...**.
- Remotely configures Windows System settings, Control Panel master shortcuts, high-performance power plans, and system performance tweaks across single or multiple computers.

#### E. Desktop Info HUD (BgInfo & Floating Companion Widget)
Click **🖥️ HUD (BgInfo)** on toolbar or right-click computer -> **🛠️ Customization, Automation & Deploy** -> **🖥️ Desktop Info HUD (BgInfo)...**.
- **Classic Sysinternals BgInfo Mode**: Composites live system telemetry directly onto desktop wallpaper without intrusive frames, using high-contrast text and drop shadows.
- **Deployment Target Modes**:
  1. **Wallpaper Overlay Only**: Stamps wallpaper directly (no background process).
  2. **Floating HUD Widget Only**: Displays a sleek translucent on-screen companion widget.
  3. **Both (Wallpaper Overlay + Floating Widget)**: Applies wallpaper overlay and floating widget simultaneously.
- **Theme-Accurate Preview**: Dynamic preview matching Classic, Cyber Emerald, Midnight Violet, Solar Flare, and other color schemes.
- **1-Click Wallpaper Backup & Restore**: Automatically backs up original wallpaper before first application and allows restoring original desktop backgrounds in one click.

#### F. Remote Desktop Wallpaper Changer & Manager
Click **🖼️ Wallpaper** on toolbar or right-click computer (or bulk select) -> **🛠️ Customization, Automation & Deploy** -> **🖼️ Change Desktop Wallpaper...**.
- Remotely updates desktop wallpaper image backgrounds across single or multiple computers for corporate branding, security announcements, or policy updates.

#### G. Remote Screen Saver Configuration
Right-click any computer (or bulk select) -> **🛠️ Customization, Automation & Deploy** -> **🖥️ Remote Screen Saver Configuration...**.
- Enables or disables Windows screen savers remotely, customizes inactivity timeouts, and enforces password lockout upon resume across single or multiple workstations.

---

### 18. Inactivity & Idle Monitor Agent (Enterprise Feature)

Right-click any computer -> **🛠️ Customization, Automation & Deploy** -> **🚀 Deploy Inactivity & Idle Monitor Agent...** (or **🛑 Uninstall Inactivity Agent**).

- **Deployment & Lifecycle**:
  - Deploy or uninstall the lightweight monitoring module (ADRC_IdleAgent.exe) across single or bulk workstation selections in seconds.
- **Real-Time Presence Tracking**:
  - Tracks user input activity (mouse and keyboard) to compute continuous active, idle, and display lock durations with high accuracy.
- **Four-Tier Health & Diagnostics Inspector**:
  - Right-click any computer -> **📊 Diagnostics & Health** -> **🔍 Check Inactivity Agent Status & Diagnostics...**.
  - Evaluates monitoring agent health using a four-state diagnostic model: Installed & Active, Installed but Not Active / Not Reporting, Not Installed, Unknown / Unable to Detect.
  - Inspects background service registration, live process execution, binary filesystem integrity, and telemetry heartbeat freshness, with 1-click repair actions.

---

### 19. Network Diagnostics & Connectivity Tools

#### A. Ping Host & Latency Query (Ctrl + P)
Click **📡 Ping** on toolbar or press **Ctrl + P**.
- Performs real-time ICMP ping tests, returning round-trip latency (ms), packet loss metrics, and reachability status.

#### B. Remote Network & IP Configuration Manager
Click **🌐 Net Config** on toolbar or right-click computer -> **🌐 Network & Connectivity** -> **🌐 Remote Network & IP Configuration...**.
- Inspects network adapters, IPv4 addresses, subnet masks, default gateways, DNS servers, and DHCP configurations.
- Allows remotely toggling adapters between DHCP and Static IP configurations.

#### C. DNS Name Resolution & Reverse Lookup (nslookup)
Right-click any computer -> **🌐 Network & Connectivity** -> **🔍 DNS Name Resolution & Reverse Lookup (nslookup)...**.
- Executes forward and reverse DNS resolution lookups to verify hostname-to-IP and IP-to-hostname mappings across domain DNS servers.

#### D. Flush Remote DNS Resolver Cache
Right-click any computer -> **🌐 Network & Connectivity** -> **🌐 Flush Remote DNS (ipconfig /flushdns)**.
- Clears the client DNS resolver cache on the remote workstation to resolve stale IP routing issues.

#### E. One-Click Network Repair & Reset
Right-click any computer -> **🌐 Network & Connectivity** -> **⚡ One-Click Network Repair & Reset...**.
- Sequentially executes IP release/renew, DNS cache flush, Winsock catalog reset, and network adapter refresh in one automated action.

#### F. Enable Remote ICMP Ping Echo (Windows Firewall)
Right-click any computer -> **🌐 Network & Connectivity** -> **📶 Enable Remote ICMP Ping Echo (Windows Firewall)...**.
- Enables inbound ICMPv4 echo request rules in Windows Defender Firewall so unreachable workstations respond to network pings.

#### G. Remote Browser URL & Application Launcher
Right-click any computer -> **🌐 Network & Connectivity** -> **🔗 Open Website URL in Remote User's Browser...**.
- Launches specified web URLs or application paths directly in the active remote user's web browser session.

---

### 20. Domain Controller & DNS Server Troubleshooting Suite

When selecting an Active Directory Domain Controller or DNS Server, a specialized context menu automatically appears under **🌐 Active Directory & DNS Server Troubleshooting**:

- **🔄 Restart DNS Server Service (DNS)**: Restarts the DNS Server service (DNS) on the Domain Controller.
- **🔄 Restart DNS Client Cache Service (Dnscache)**: Restarts the local DNS resolver cache service (Dnscache).
- **🧹 Clear DNS Client Resolver Cache**: Flushes the local DNS client resolver cache.
- **🔍 Resolve DNS Name (Custom Query Host)...**: Executes custom DNS name resolution queries against the server.
- **📡 Ping 8.8.8.8 (External DNS Reachability Test)**: Verifies external WAN internet gateway reachability from the server.

---

### 21. Remote Power Actions & Scheduled Task Operations

#### A. Immediate Remote Power Actions

Located on the main bottom toolbar and right-click menus:

| Power Action | Toolbar Button | Context Menu Path | User Impact & Behavior |
| :--- | :--- | :--- | :--- |
| **Wake-on-LAN** | ⚡ WOL | 🌐 Network & Connectivity ▸ ⚡ Wake-on-LAN | Transmits UDP magic packets to wake sleeping machines. |
| **Instant Lock** | 🔒 Lock | ⚡ Security & Power Control ▸ 🔒 Instant Lock | Immediately locks desktop display; user session remains active. |
| **Logoff User** | 🚪 Logoff | 👤 Active Directory & User Session ▸ 🚪 Logoff Active User Session | Gracefully closes user applications and ends session. |
| **Reboot / Restart** | 🔄 Restart | ⚡ Security & Power Control ▸ 🔄 Restart Computer | Reboots workstation with clean 5-second notification countdown. |
| **Shutdown** | 🛑 Shutdown | ⚡ Security & Power Control ▸ 🛑 Shutdown Computer | Powers off workstation with clean 5-second notification countdown. |

#### B. Remote Workstation Lock & Unlock Controller
Right-click any computer -> **⚡ Security & Power Control** -> **🔒 Remote Workstation Lock & Unlock Controller**.
- Interactively locks or unlocks workstation input controls and display screens during administrative maintenance.

#### C. Scheduled Remote Power Operations (Reboot, Shutdown, Logoff, Lock)
Right-click any computer (or bulk select) -> **⚡ Security & Power Control** -> **⏰ Schedule Power Action...**.
- Allows scheduling future power actions (Restart, Shutdown, Logoff, Lock) for single or multiple computers.
- Select exact date and time using visual calendar pickers, configure optional on-screen countdown warnings for logged-in users, view scheduled tasks, or cancel pending jobs in one click.

---

### 22. Deep Temporary Files Cleaner (4-Path Cleanup)

Click **🧹 Temp Clean** on the toolbar or right-click any computer (or bulk select) -> **⚡ Security & Power Control** -> **🧹 Deep Temp Clean**.

Executes automated cleanup across 4 system paths:
1. C:\Windows\Temp
2. C:\Users\<User>\AppData\Local\Temp (cleaned across all user profiles)
3. C:\Users\<User>\AppData\Roaming\Microsoft\Windows\Recent (cleaned across all user profiles)
4. C:\Windows\Prefetch

Calculates exact file counts removed, megabytes freed, and records results in the Activity Log.

---

### 23. Reverse-Chronological Activity Audit Log & Notification Broadcasts

#### A. Endpoint Activity Audit Log
Click **📜 Activity Log** on the top header or right-click any computer -> **📊 Diagnostics & Health** -> **📜 Open Activity Log for This Computer**.
- Displays administrative actions in reverse-chronological order (newest first).
- Tracks action type, timestamp, target host, administrator identity, and outcome (SUCCESS, FAILED, CANCELLED).
- Isolates administrative actions from background routine checks for clean auditing.

#### B. Toast Notifications & In-App Broadcast Studio with Read Receipts
Click **💬 Message** on toolbar (Ctrl + M) or right-click computer (or bulk select) -> **👤 Active Directory** -> **💬 Send Toast Notification to User**.

- **Delivery Modes**:
  - **Standard Action Center Toast**: Transmits Windows Action Center alerts accompanied by a notification chime.
  - **Modal Broadcast Notice**: Displays prominent on-screen announcement dialogs.
- **Mandatory Read Receipts & Acknowledgement Tracker**:
  - Tracks broadcast notifications through full lifecycle: Sent, Received, Read, Acknowledged.
  - Launches real-time delivery dashboard displaying recipient usernames, delivery status, and exact timestamps when recipients click **✓ Acknowledge**.
  - Displays completion banner when all targeted recipients acknowledge the broadcast.

---

### 24. Seamless In-App GitHub Auto-Updater

Click **🚀 Updates** on the top header bar.

- **Automatic Version Check**: Compares local version against latest GitHub Release tag.
- **Changelog Preview**: Displays formatted release notes and update details.
- **Zero-Browser In-Place Update**:
  - Clicking **⚡ Update & Restart Now** downloads updated PE binary in background.
  - Automatically overwrites executable and restarts application in ~1.5 seconds without browser downloads or installer wizards.

---

### 25. Universal Keyboard Shortcuts

The application provides universal keyboard shortcuts for high-frequency operations:

| Keyboard Shortcut | Action Description | Operational Scope |
| :--- | :--- | :--- |
| Ctrl + S / Ctrl + F | Focus Quick Search Bar & Select All Text | Main Inventory Window |
| F5 / Ctrl + R | Refresh Computer Inventory from Active Directory | Main Inventory Window |
| Enter | Connect Remote Shadow Session (Screen Mirror) | Main Inventory DataGrid |
| Ctrl + Enter | Connect Remote Desktop (Standard RDP Login) | Main Inventory Window |
| Ctrl + Win + Q | Launch Microsoft Quick Assist | Main Inventory Window |
| Ctrl + P | Ping Selected Host with live ICMP latency | Main Inventory Window |
| Ctrl + T | Open Remote Console (Interactive CMD / PowerShell) | Main Inventory Window |
| Ctrl + I | Open System Specs & Hardware Diagnostics | Main Inventory Window |
| Ctrl + D | Open Remote Mapped Drives Manager | Main Inventory Window |
| Ctrl + M | Open Send Toast Notification Message Dialog | Main Inventory Window |
| Ctrl + U | Unlock User Account in Active Directory | Main Inventory Window |
| Ctrl + Shift + P | Reset User Password Modal Dialog | Main Inventory Window |
| Ctrl + Shift + U | View 360° AD User Profile Inspector Card | Main Inventory Window |
| Ctrl + Shift + M | Open Live Performance & Hardware Diagnostics Monitor | Main Inventory Window |
| ESC | Dismiss/Close any popup modal, or Clear Search Box | Universal across all windows |

---

### 26. Group Policy, Firewall & Endpoint Setup Guide

#### Required Inbound Network Protocols & Ports

| Protocol / Feature | Port / Rule Name | Direction | Purpose in Windows AD Remote Control |
| :--- | :--- | :--- | :--- |
| **Remote Desktop** | TCP 3389 | Inbound | Remote Shadowing screen mirror and RDP sessions. |
| **WMI & DCOM** | TCP 135 + Dynamic RPC Ports | Inbound | Hardware specs, Task Manager, Services, software discovery, remote terminal, drive mapping. |
| **File and Printer Sharing** | TCP 445, TCP 139 | Inbound | SMB administrative shares (C$), 4-path deep temp cleaning, file browsing. |
| **Windows Remote Management** | TCP 5985 (WinRM HTTP) | Inbound | Action Center Toast notifications transmitted to user clock. |
| **Remote Registry Service** | RPC Dynamic Ports | Inbound | Software discovery and user profile registry inspection. |
| **ICMPv4 Echo Request** | ICMPv4 Type 8 | Inbound | Real-time ping latency and online/offline status detection. |

#### Automated 1-Click Endpoint Setup Script (PowerShell)

Run in elevated PowerShell or deploy via Group Policy Startup Script:

```powershell
# =========================================================================
# Windows AD Remote Control - Automated Endpoint Configuration Script
# Enables: RDP Shadowing (Full Control without consent), Firewall Ports, Services
# =========================================================================

Write-Host "[*] Configuring Remote Desktop and Shadowing..." -ForegroundColor Cyan
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name "UserAuthentication" -Value 0

# Configure Shadow GPO Policy: Full Control without User Permission (Value = 2)
$shadowKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
if (!(Test-Path $shadowKey)) { New-Item -Path $shadowKey -Force | Out-Null }
Set-ItemProperty -Path $shadowKey -Name "Shadow" -Value 2

Write-Host "[*] Enabling Windows Defender Firewall Rules..." -ForegroundColor Cyan
Enable-NetFirewallRule -DisplayGroup "Remote Desktop" -ErrorAction SilentlyContinue
Enable-NetFirewallRule -DisplayGroup "Windows Management Instrumentation (WMI)" -ErrorAction SilentlyContinue
Enable-NetFirewallRule -DisplayGroup "File and Printer Sharing" -ErrorAction SilentlyContinue
Enable-NetFirewallRule -DisplayGroup "Windows Remote Management" -ErrorAction SilentlyContinue
Enable-NetFirewallRule -Name "FPS-ICMP4-ERQ-In" -ErrorAction SilentlyContinue

Write-Host "[*] Configuring Remote Services..." -ForegroundColor Cyan
Set-Service -Name "RemoteRegistry" -StartupType Automatic -ErrorAction SilentlyContinue
Start-Service -Name "RemoteRegistry" -ErrorAction SilentlyContinue
winrm quickconfig -q -force 2>$null

Write-Host "[SUCCESS] Workstation is fully configured for Windows AD Remote Control!" -ForegroundColor Green
```

---

### 27. Enterprise Security & Role-Based Access Governance

- **Startup Authorization Guard**:
  - Verifies that the launching user belongs to genuine Domain or Enterprise administrative tiers (Domain Admins, Enterprise Admins, Schema Admins, Account Operators, Server Operators, IT Admins). Standard workstation users with local admin are strictly blocked on domain networks.
- **Binary Integrity & Hardening**:
  - The compiled executable is a native PE binary hardened with code compilation and Authenticode signatures to prevent reverse engineering or tampering.
- **Separately Provisioned Enterprise Fleet Governance**:
  - Advanced fleet governance features are managed through a separately provisioned enterprise service. Contact your system administrator for access information.

---

### 28. Community, Support & Feedback

#### 💬 Submitting In-App Feedback & Star Ratings
Administrators and technical operators can share immediate workflow feedback, submit star ratings, report technical issues, or request new features directly inside the application:
1. Click the **💬 Feedback** button located on the top header navigation bar.
2. Select an overall satisfaction rating from **1 to 5 Stars**.
3. Choose an appropriate category (General Experience, Feature Request, Bug Report, Performance / Speed).
4. Enter detailed comments and click **🚀 Submit Feedback**.

#### 👥 Official Support & Community Channels
- **Official GitHub Releases**: [SuperUser-exe/Windows-Active-Directory-Remote-Administration-Control-Center](https://github.com/SuperUser-exe/Windows-Active-Directory-Remote-Administration-Control-Center/releases)
- **Telegram Community Group**: Join [t.me/WADRACC](https://t.me/WADRACC) for real-time chat, instant support, updates, and feature suggestions.
- **GitHub Discussions**: [Community Discussions & Feature Ideas](https://github.com/SuperUser-exe/Windows-Active-Directory-Remote-Administration-Control-Center/discussions)
- **Developer Attribution**: Askarali Mattummal
