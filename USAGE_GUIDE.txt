# Windows AD Remote Administration Control Center — Enterprise Administration Suite
## Complete Operator Reference Manual & Architecture Guide (v2.6.5 / Coming Soon v2.7.0)
**Created & Developed by [Askarali Mattummal](https://www.linkedin.com/in/askaralimattummal/)**

---

### 📑 Table of Contents
1. [Overview & Architecture](#1-overview--architecture)
2. [Launching & Portability](#2-launching--portability)
3. [Connection Modes](#3-connection-modes)
   - [A. Remote Shadow Session (Screen Mirroring)](#a-remote-shadow-session-screen-mirroring)
   - [B. Pre-Shadow Toast Alert Notification](#b-pre-shadow-toast-alert-notification)
   - [C. Standard Remote Desktop (RDP) & Console Session](#c-standard-remote-desktop-rdp--console-session)
   - [D. Quick Assist Remote Assistance](#d-quick-assist-remote-assistance)
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
17. [Desktop Info HUD (Sysinternals BgInfo & Floating Widget)](#17-desktop-info-hud-sysinternals-bginfo--floating-widget)
18. [Remote Browser URL & File Launcher](#18-remote-browser-url--file-launcher)
19. [Windows God Mode & Enterprise System Power Tweaks](#19-windows-god-mode--enterprise-system-power-tweaks-single--bulk)
20. [Dynamic Smart Context Menu Architecture](#20-dynamic-smart-context-menu-architecture-single-vs-multi-device)
21. [Remote Desktop Wallpaper Changer & Manager](#21-remote-desktop-wallpaper-changer--manager-single--bulk)
22. [Inactivity & Idle Monitor Agent (Enterprise Feature)](#22-inactivity--idle-monitor-agent-enterprise-feature)
23. [Automatic 1-Minute Background Telemetry Refresh Engine](#23-automatic-1-minute-background-telemetry-refresh-engine)
24. [Group Policy, Firewall & Administrator Setup Guide](#24-group-policy-firewall--administrator-setup-guide)
25. [Universal Keyboard Shortcuts](#25-universal-keyboard-shortcuts)
26. [Security & Access Authorization](#26-security--access-authorization)
27. [Community, Support & Feedback](#27-community-support--feedback)

---

### 1. Overview & Architecture
**Windows AD-Admin Control Center** (v2.6.5) is a standalone, high-performance Windows systems administration and remote assistance suite built specifically for Active Directory Domain Administrators, Systems Engineers, and IT Helpdesk specialists.

Unlike commercial remote assistance tools (such as TeamViewer, AnyDesk, or ScreenConnect) that require installing proprietary background services or paying recurring cloud subscriptions, Windows AD Remote Administration Control Center operates **100% agentlessly**. It interacts natively with Windows endpoints using standard enterprise protocols:
- **Active Directory / LDAP (ADSI)**: Discovers all domain-joined workstations and servers in real-time.
- **Terminal Services APIs**: Initiates Remote Shadow sessions and RDP console attachments.
- **Windows Management Instrumentation (WMI / DCOM / RPC)**: Executes remote commands, inspects hardware sensors, queries installed software across all user profiles, manages services, and controls processes.
- **Windows Event Log RPC (`EventLogSession`)**: Streams live event records reverse-chronologically.
- **SMB Administrative Shares (`C$`)**: Enables 1-click folder navigation and administrative file cleanup.
- **ICMP & ARP**: Performs concurrent real-time ping latency and MAC address resolution.

#### Main Inventory DataGrid & Live Telemetry Columns
The central interface table presents live operational telemetry for every computer in the domain:
- **`Computer Name`**: NetBIOS hostname with double-click quick actions.
- **`IP Address`**: Real-time IP address resolved over ICMP/DNS.
- **`Ping Latency`**: Real-time round-trip latency in milliseconds (`ms`), color-coded green (<30ms) or amber.
- **`Workstation State`**: Real-time presence indicator with smart human-readable duration formatting:
  - `🟢 Active`: User actively moving mouse or typing (`< 5m`).
  - `💤 Idle (...)`: Inactivity duration formatted in compact lowercase units:
    - `< 60m`: e.g. `💤 Idle (13m)`
    - `1h to 24h`: e.g. `💤 Idle (1h 30m)`, `💤 Idle (15h 16m)`, `💤 Idle (17h)`
    - `1d to 30d`: e.g. `💤 Idle (1d 4h)`, `💤 Idle (2d)`
    - `≥ 30d`: e.g. `💤 Idle (1mo 2d)`
  - `🔒 Locked (...)`: Display lock duration formatted identically (e.g. `🔒 Locked (18m)`, `🔒 Locked (1h 30m)`, `🔒 Locked (17h)`, `🔒 Locked (1d 4h)`, `🔒 Locked (1mo 2d)`).
  - `🚪 Logged Off`: Computer powered on with no interactive user session.
  - `🔴 Offline`: Workstation unreachable.
- **`Logged-in User`**: Authenticated console or RDP username (`DOMAIN\User`).
- **`Logon Time`**: Interactive session logon timestamp.
- **`Uptime`**: Dedicated live system uptime column (`⏱️ 3d 12h`, `⏱️ 18d 6h`, `⏱️ 1mo 5d`):
  - **Numeric Sorting**: 1-click header click sorts computers accurately by total elapsed uptime.
  - **Health Coloring**: Vibrant green (`#10B981`) for normal uptimes; amber alert (`#F59E0B`) for systems exceeding 30 days without reboot.
  - **Boot Timestamp Tooltip**: Hovering reveals the exact last boot date and time (`Last Boot: yyyy-MM-dd HH:mm`).
  - **Cold Start Persistence**: Stored in `%LocalAppData%\WindowsADRemoteControlHub\ad_computers_cache.tsv` for instant loading on application startup.
- **`Operating System`**: OS edition, version build, and architecture (e.g. `Windows 11 Pro 64-bit`).
- **`Last User`**: Most recently logged-on username retrieved from directory history.

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
`Windows AD-Admin Control Center.exe` is compiled as a self-contained 64-bit Windows PE executable with the application icon and user guide embedded directly within the binary. You can copy the single `.exe` file to your Desktop, an IT management jump box, or a read-only network share (`\\Domain\SYSVOL\IT_Tools\`). No installers or third-party DLLs are required.

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

#### D. Quick Assist Remote Assistance
Located on the primary bottom connection toolbar directly between **⚡ Connect Shadow Session** and **🖥️ Connect RDP Session**, the **🚀 Quick Assist** button provides immediate, 1-click access to Microsoft Quick Assist (`quickassist.exe` / `ms-quick-assist:`).

- **When to Use Quick Assist**:
  - **Cross-Subnet & VPN Support**: Ideal when managing remote laptops connecting through restricted guest Wi-Fi, home VPN tunnels, or multi-tenant DMZs where inbound TCP 3389 (RDP) or RPC/SMB ports may be blocked by firewalls.
  - **Co-Piloted Interactive Support**: Allows technicians to guide end-users interactively using Microsoft cloud session codes without requiring Active Directory credentials or pre-configured Group Policy permissions.
  - **Alternative to Shadowing**: Complements native RDS Screen Shadowing (`mstsc.exe /shadow`) when working with remote workers outside the local corporate LAN.

---

### 4. Interactive Remote Terminal Console (CMD & PowerShell)
Click **💻 Console (CMD/PS)** on the toolbar or right-click any computer and select **💻 Remote Terminal Console**.

- **Agentless Execution**:
  - Utilizes native remote execution protocols to spawn commands invisibly on the remote workstation, capturing stdout/stderr and streaming the output back into the styled terminal window.
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
  - Switch between the graphical card dashboard and the full raw diagnostics text view at any time.

---

### 6. Process & Windows Services Controllers

#### Remote Task Manager (Process Controller)
Click **📊 Task Mgr** on the toolbar to inspect:
- Live process list with PID, Name, Working Set Memory (MB), and CPU time.
- Search filter box to find specific executables instantly.
- **`🛑 End Process`**: Remotely terminates hung or malicious processes with instant remote process termination.

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
  - **Automatic Registry Query Fallback**: If the `RemoteRegistry` Windows service is disabled on client workstations, the application automatically falls back to secure remote query protocols to inspect registry keys with 100% reliability.
- **1-Click Silent Remote Uninstallation**:
  - Select any application and click **`🗑️ Silent Uninstall`**.
  - Automatically invokes silent package uninstallers or the vendor's registered quiet uninstall command string.

---

### 8. Remote Windows Event Log Viewer
Click **📋 Events** on the toolbar to open the Event Viewer.

- **High-Speed Reverse Streaming**:
  - Communicates directly with the remote machine's Windows Event Log subsystem with reverse-chronological streaming, loading the newest events instantly without scanning through gigabytes of older logs.
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
Click **🖨️ Printers** on the toolbar (or right-click any workstation -> **🖨️ Remote Printers & Print Queue Manager**) to inspect and administer:
- **Modern In-Window Loading Splash Overlay**:
  - Centered translucent card featuring real-time connection telemetry, animated progress indicator, and active host status.
  - Automatically fades out smoothly once remote spooler metrics and driver databases arrive.
- **Parallel Asynchronous Spooler Engine**:
  - Executes printer driver discovery and print queue event enumeration in parallel background threads, cutting remote query latency by over 50%.
- **Comprehensive Printer Inventory**:
  - Local physical printers, USB devices, virtual/PDF printers, and domain print server shared network printers (discovered across all user profiles).
  - Columns: Printer Name, Type (Local / Network Shared), Print Server / IP, Default status (⭐), Queued Jobs, Status, Location, Comment, Driver Name, and Port Name.
- **Accurate Live Queued Jobs & Document Queue Isolation**:
  - The **Queued Jobs** column accurately cross-references active spooler jobs against print queue history. Idle printers cleanly display `0` rather than misleading historical counts. Active documents are highlighted dynamically with `⚠️ {N} Pending`.
  - Selecting any printer in the top list instantly isolates its active queue and completed document log in the lower DataGrid pane.
- **Remote Shared / Network Printer Connection**:
  - **`➕ Add Printer...`**: Connect a shared network printer to the remote endpoint by specifying its UNC path (`\\PrintServer\PrinterShare`). Automatically connects and mounts network printer queues with enterprise reliability.
- **Complete Printer Removal**:
  - **`🗑️ Remove Printer`**: Safely and thoroughly uninstalls any printer (network, USB, virtual, or PDF) from the target endpoint with complete machine-wide connection cleanup.
- **Printer Properties & Metadata Editor**:
  - **`ℹ️ Properties...`**: View detailed hardware, driver, and queue metrics, and edit the remote printer's **Location**, **Comment**, or toggle **Set as Default Printer**.
- **Printer Controls & Queue Management**:
  - **`⭐ Set Default`**: Immediately configure the selected printer as default on the remote machine.
  - **`⏸️ Pause / ▶️ Resume`**: Remotely pause or resume printing on the target queue.
  - **`🖨️ Test Print`**: Dispatches a native Windows test page via the remote print spooler. For domain shared printers, automatically routes the test submission through the authoritative print server host.
  - **`🗑️ Cancel Job`**: Cancels individual stalled print jobs without disrupting other documents.
  - **`🧹 Purge All Jobs`**: Flushes all pending print jobs across all queues in 1-click.
  - **`🔄 Spooler Service`**: Restarts the remote Print Spooler service and auto-refreshes the list.

---

### 10. Remote File Explorer Quick Links
Toolbar and context menu shortcuts open Windows Explorer directly into remote administrative shares:
- **`📁 Open C:/`**: Opens `\\<ComputerName>\C$`.
- **`📁 Desktop`**: Opens active user's Desktop folder.
- **`📁 Downloads`**: Opens active user's Downloads folder.
- **`📁 Documents`**: Opens active user's Documents folder.

---

### 11. Active Directory Account Management & In-App Profile Editor

#### Enterprise 360° AD User Profile Inspector (`👤 View Profile`)
- Click **`👤 User Profile`** on the left toolbar or right-click any computer -> **`👤 Active Directory & User Session`** -> **`👤 View AD User Profile Card`**.
- Inspects over 40+ directory attributes across categorized views:
  - **👤 Identity**: Display Name, Given Name, Surname, SamAccountName, UPN, SID, Object GUID, DN, Description.
  - **🏢 Organization**: Job Title, Department, Company, Division, Office Location, Employee ID / Number, Manager Name.
  - **📞 Contact**: Telephone, Mobile, Email, Street Address, City, State, Postal Code.
  - **🔒 Security**: Account Status, Bad Password Count, Last Bad Attempt, Password Last Set, Password Never Expires, Cannot Change Password, Smartcard Required, Account Expiration Date, Last Logon (Local DC & Replicated).
  - **👥 Member of Groups**: Complete list of security and distribution group memberships with active group management controls.
- **Interactive AD Group Membership Management**:
  - **`➕ Add to Group`**: Search and add the user to any domain security or distribution group.
  - **`➖ Remove from Group`**: Safely remove the user from selected groups, with built-in safeguards protecting primary groups (e.g. `Domain Users`).
  - **`🔄 Refresh Groups`**: Re-queries Active Directory in real-time.
- **Theme-Consistent Modern Interface**:
  - Fully supports Light and Dark themes with zero Aero white hover flashes on tab navigation.
- Includes 1-Click toolbar actions: **`🔓 Unlock Account`**, **`🔑 Reset Password`**, **`📋 Copy Summary`**, **`📊 Export Report`**, and **`✏️ Edit Profile`**.

#### In-App Active Directory User Profile Editor (`✏️ Edit Profile`)
- Access directly by right-clicking any computer -> **`👤 Active Directory & User Session`** -> **`✏️ Edit AD User Profile Attributes...`**, or click **`✏️ Edit Profile`** inside the User Profile Card viewer.
- Allows real-time editing of user attributes across two organized sections:
  - **👤 Identity & Organization**: First Name (Given Name), Last Name (Surname), Display Name, Job Title, Department, Company, Office Location.
  - **📞 Contact & Location**: Telephone Number, Mobile Phone, Email Address, Street Address, City, State / Province, Postal Code.
- Clicking **`💾 Save Changes to Active Directory`** commits updates directly to Active Directory Domain Services, records the change in the Activity Log, and automatically updates the active profile view.

#### Smart Dynamic Account Unlocker (`🔓 Unlock User`)
- Inspects the logged-in user account in Active Directory.
- If the account is locked out, the button turns vibrant red: **`⚠️ Account Locked (Unlock)`**.
- Clicking the button unlocks the account immediately in Active Directory.

#### Password Reset (`🔑 Reset Pass`)
- Opens a secure password reset dialog.
- Allows specifying a new temporary password and optionally checking **"User must change password at next logon"**.

#### Edit / Set Computer Description (`📝 Edit Description`)
- Right-click any computer -> **`⚙️ Administration & Management`** -> **`📝 Edit / Set Computer Description (Active Directory)...`**.
- Reads and updates the computer's Active Directory `description` attribute in real time, synchronizing immediately with the computer grid.

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
| **🔒 Lock Screen** | Native Remote Desktop Lock | Instantly locks the remote desktop without logging user off. |
| **🚪 Logoff User** | Remote Session Termination | Gracefully terminates active session. |
| **🔄 Reboot** | Remote System Restart | Clean reboot with 5-second countdown. |
| **🛑 Shutdown** | Remote System Shutdown | Clean power-off with 5-second countdown. |

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
  - **Engine 1 (Remote Registry Profile Scanner)**: Scans network registry hives across all detected user profiles on the machine. Uncovers persistent drive mappings (remote paths, usernames, connection types, and provider details) even when the user is idle or screen is locked.
  - **Engine 2 (Remote Network Storage Inspector)**: Inspects active mounted network disks to gather live free space, total storage capacity, volume labels, and active connection status.
- **Adding a New Drive Mapping (`➕ Add Drive Mapping`)**:
  - **Drive Letter Selector**: Pre-selects the first available drive letter from `Z:` down to `D:`, flagging letters that are already in use.
  - **Remote Share UNC Path**: Specify `\\server\share` or `\\192.168.x.x\folder`. Includes a **"🔍 Test Path"** button to verify accessibility directly from the admin console.
  - **Target User Profile**: Automatically detects loaded user profiles (e.g. `DOMAIN\username (SID)`), allowing admins to target a specific user or the active interactive session.
  - **Reconnect at Sign-in**: Toggles persistent mapping so the drive reconnects automatically upon user sign-in.
  - **Instant Session Execution**: Mounts the drive dynamically in the active user's session so logged-in users see the drive mounted immediately without signing out.
- **Editing a Drive Mapping (`✏️ Edit Mapping`)**:
  - Update the remote UNC share path or modify persistence settings.
- **Disconnecting & Removing (`🗑️ Disconnect & Remove`)**:
  - Prompts admin confirmation, cleans the persistent user profile registry entry, and unmounts the network drive cleanly from the remote session.
- **Local Windows Explorer Integration**:
  - Double-clicking any mapped drive or clicking **`📂 Open Share Locally`** directly launches the UNC share in Windows Explorer on the technician's workstation.
- **Export Inventory**:
  - Export the full drive mapping table across users to CSV with one click.

---

### 17. Desktop Info HUD (Sysinternals BgInfo & Floating Companion Widget)
Access by right-clicking any computer -> **`🖥️ Desktop Info HUD (BgInfo)...`** or clicking **`🖥️ HUD (BgInfo)`** on the toolbar.

- **Classic Sysinternals BgInfo Mode (Direct on Desktop Wallpaper)**:
  - Composites live computer telemetry directly into the active user's desktop wallpaper without an intrusive background frame or box (matching classic Sysinternals BgInfo).
  - Clean two-column alignment: sky-blue metadata labels on the left, pure white telemetry values on the right, backed by deep drop shadows for 100% legibility on any wallpaper image.
- **Deployment Target Modes**:
  1. `Wallpaper Overlay Only (Direct on Desktop Wallpaper - No popup window)` *(Default)*: Directly stamps the wallpaper; no background process or floating window is launched.
  2. `Floating HUD Widget Only (Interactive Companion Window)`: Displays a sleek, translucent floating on-screen widget without altering desktop wallpaper.
  3. `Both (Wallpaper Overlay + Floating Companion Widget)`: Stamps the wallpaper and launches the floating companion window simultaneously.
- **Dynamic Profile Folder Resolution**:
  - Automatically resolves the physical user profile folder path on disk matching the interactive user's security identifier (e.g. `C:\Users\sMs` when account name is `DOMAIN\Test`), ensuring desktop wallpaper and theme cache files update reliably in domain user sessions and RDP connections.
- **Theme-Accurate High-Contrast Live Preview**:
  - Preview card dynamically updates in real time to match the selected visual theme (Classic BgInfo, Cyber Emerald, Matrix Console, Midnight Violet, Solar Flare, Crimson Alert, Nordic Frost, Monochrome, Modern Cyber).
  - Protected against theme inversion, ensuring high-contrast visibility in both Light Mode and Dark Mode.
- **1-Click Pristine Wallpaper Backup & Restore**:
  - Automatically backs up the original desktop wallpaper (`AD_Wallpaper_Backup.jpg`) before first application.
  - Clicking **`↩️ Restore Original Wallpaper`** restores the pristine original wallpaper and triggers an immediate desktop display refresh without requiring user logoff.

---

### 18. Remote Browser URL & File Launcher
Access by right-clicking any computer -> **`🌐 Open Browser URL...`** or **`📂 Open File / App on Remote PC...`**.

- **Multi-Browser Support**:
  - Launch web URLs in the remote user's interactive session with **Default Windows Browser**, **Microsoft Edge**, or **Google Chrome**.
  - Includes robust execution handling to ensure URLs open immediately without path-not-found errors.
- **Remote File & Program Launcher**:
  - Executes document files, executables, scripts, or URLs directly within the active interactive desktop session without user prompting.

---

### 19. Windows God Mode & Enterprise System Power Tweaks (Single & Bulk)
Access by right-clicking any computer -> **`👑 Windows God Mode & Power Tweaks...`** (located under both `⚙️ Administration & Management ▸` and `🛠️ Remote Maintenance & Automation ▸`).

- **Windows God Mode (Master Control Panel)**:
  - Centralizes over 200+ operating system control applets, administrative tools, troubleshooting wizards, and advanced hardware configurations in a unified Windows master control panel namespace.
  - **User Desktop Shortcut**: Deploys the God Mode folder shortcut directly onto the active logged-in user's personal Desktop (`<UserProfile>\Desktop`).
  - **Public Desktop Shortcut**: Deploys the God Mode folder shortcut onto `C:\Users\Public\Desktop` so all current and future users on the workstation have immediate access.
  - **Desktop Right-Click Context Menu**: Adds *"Windows God Mode (Master Control Panel)"* into the desktop background context menu.
  - **1-Click Live Launch on Remote PC**: Direct remote dispatching to immediately pop open the **Windows God Mode (Master Control Panel)** window live on the remote user's interactive desktop.
- **Enterprise System Power Tweaks**:
  - **"Take Ownership" Context Menu Injector**: Injects a 1-click "Take Ownership" context menu into files and directories to instantly repair corrupted permissions.
  - **Classic Windows 11 Context Menu Restorer**: Bypasses the Windows 11 "Show more options" (`Shift+F10`) restriction and restores the full classic Windows 10 right-click menu.
  - **"Ultimate Performance" Power Plan Activator**: Unlocks and activates the hidden Windows high-performance workstation power scheme for zero-latency CPU and GPU throughput.
  - **Compact OS Storage Compressor**: Enables Windows OS binary compression, freeing 3 to 5 GB of disk space on small SSDs.
  - **Disable Windows Consumer Bloatware**: Prevents automatic background installation of promotional consumer apps.
  - **Always Show File Extensions & Hidden Files**: Configures Windows Explorer to always display file extensions and hidden system files across all user profiles.
  - **Disable Windows Diagnostic Telemetry**: Enforces enterprise diagnostic telemetry suppression for privacy and corporate compliance.
  - **1-Click Enable Remote Desktop (RDP)**: Remotely activates RDP and enables Network Level Authentication with inbound firewall rules for seamless remote access.
  - **Disable Bing Web Search in Start Menu**: Eliminates sluggish cloud web queries from the Windows Start Menu for instant local file and app search results.
- **Asynchronous Status Detection & Bulk Actions**:
  - Live visual status badge detects current machine state.
  - Supports single-machine configuration and concurrent bulk application across multiple selected Active Directory endpoints.
  - 1-Click clean reversal (`[↩️ Remove / Disable All Tweaks]`).

---

### 20. Dynamic Smart Context Menu Architecture (Single vs Multi-Device)
Right-clicking computers in the workstation inventory grid automatically adjusts the context menu based on the number of selected machines:

- **Multi-Device Selection Mode (`> 1` Computers Selected)**:
  - Displays a clean, dedicated bulk menu headed with `⚡ BULK ACTIONS (X COMPUTERS SELECTED)`.
  - Hides non-bulk single-host actions (such as interactive Screen Shadowing, live specs dashboard, remote task manager, battery health, drive mapping, etc.) to prevent accidental operational confusion.
  - Provides instant access to all **16 Bulk-Supported Operations**:
    1. 🖼️ Apply Corporate Wallpaper in Bulk
    2. 👑 Deploy / Remove God Mode & Power Tweaks in Bulk
    3. 🖥️ Stamp Desktop Info HUD (BgInfo) in Bulk
    4. 🧹 4-Path Deep Temp Clean across all selected PCs
    5. 🔄 Force Remote Group Policy Update (`gpupdate /force`) concurrently
    6. 📦 Silent Software Package Deployer (MSI / EXE)
    7. 📤 Administrative File & Script Push
    8. 🏓 Concurrent Ping Latency & Reachability Test
    9. 🌐 Flush Remote DNS Cache (`ipconfig /flushdns`)
    10. 🧱 Enable Inbound ICMP Echo Firewall Rule
    11. ⚡ Send Wake-on-LAN (WOL) Magic Packets
    12. 💬 Send Action Center Toast Message to all logged-in users
    13. 🔒 Lock Workstation Display Sessions simultaneously
    14. 🚪 Logoff Active Console & RDP User Sessions
    15. 🔄 Reboot Selected Computers (with countdown)
    16. 🛑 Shutdown Selected Computers (with countdown)
- **Single-Device Selection Mode (`1` Computer Selected)**:
  - Displays the full, unabridged administrative console organized logically into categorized flyout submenus:
    - 🖥️ Screen Shadow & Remote Control
    - ⚙️ Administration & Management
    - 📊 Diagnostics & Telemetry
    - 🛠️ Remote Maintenance & Automation
    - ⚡ Power & Session Controls
  - **Graceful Hardware & Policy Feedback**: If a feature is not applicable or configured on the chosen endpoint (e.g. Battery Health on a stationary desktop tower, BitLocker when unencrypted, LAPS when not deployed), the application displays a friendly, clear informational dialog explaining why the feature is not active on that machine.

---

### 21. Remote Desktop Wallpaper Changer & Manager (Single & Bulk)
Access by right-clicking any computer(s) -> **`🖼️ Change Desktop Wallpaper (Single / Bulk)...`** (located under both `Diagnostics & Telemetry ▸` and `Remote Maintenance & Automation ▸`).

- **Single & Multi-Computer Bulk Deployment**:
  - Select one or multiple target computers from the main workstation inventory grid (`Ctrl+Click` or `Shift+Click`).
  - Deploy corporate wallpapers, branding graphics, or incident alert banners simultaneously across all selected endpoints with real-time progress indicators and activity logging.
- **Image File Picker & In-App Preview**:
  - Supports `.jpg`, `.jpeg`, `.png`, and `.bmp` files.
  - Embedded preview container displays the selected image before deploying across the network.
- **Display Fit Styles**:
  - `Fill (Recommended - Scales & Fills Screen)`: Zooms and fills display boundaries.
  - `Fit (Maintains Proportions)`: Displays entire picture preserving aspect ratio.
  - `Stretch (Stretches to Screen Bounds)`: Stretches image to exact monitor dimensions.
  - `Tile (Repeats Image in Grid)`: Repeats smaller images across the display grid.
  - `Center (Centers Original Size)`: Centers image at 1:1 scale without stretching.
  - `Span (Spans Across Multiple Monitors)`: Spans a wide wallpaper across multi-monitor setups.
- **Automated Backup & 1-Click Restoration**:
  - Pre-checked backup option automatically preserves the current wallpaper before applying changes.
  - One-click **`↩️ Restore Original Wallpaper`** restores the backup image on single or bulk target computers.
- **Active Console & RDP Session Wallpaper Sync Engine**:
  - Copies the image directly over admin SMB share (`\\<host>\C$\Users\Public\AD_Custom_Wallpaper.ext`).
  - Configures per-user wallpaper registry values across current and targeted user profiles.
  - Disables RDP policy wallpaper suppression.
  - Dynamically updates active user profile theme cache.
  - Triggers instant desktop refresh within the logged-in user's interactive desktop session for instantaneous visual update without signing off.

---

### 22. Inactivity & Idle Monitor Agent (Enterprise Feature)
The **Inactivity & Idle Monitor Agent** is an ultra-lightweight, non-intrusive Windows background service designed specifically to provide continuous 24/7 real-time user presence, idle timing, and workstation lifecycle telemetry across domain endpoints.

#### A. Purpose & Operational Benefits
- **Continuous 24/7 Presence Intelligence**: Provides real-time visibility into whether a workstation is actively in use, idle, locked, or logged off before initiating remote assistance, transmitting urgent alerts, or scheduling maintenance tasks.
- **Full Workstation Lifecycle Tracking**: Unlike simple logon-only utilities, the agent starts at Windows system boot and monitors continuously across all lifecycle states:
  - **Pre-Logon / System Boot**: Operates immediately as Windows starts, before any user credentials have been entered.
  - **Windows Login Screen (`LogonUI`)**: Reports when the PC is powered on and waiting at the Windows sign-in screen.
  - **Active User Sessions**: Tracks real-time user activity via native Windows hardware input timers.
  - **Screen Lock / Unlock**: Detects session locking events in real time.
  - **User Logout & Multi-User Switching**: Seamlessly tracks transitions as users log out, switch accounts, or disconnect.
  - **No User Logged In (`🚪 Logged Off`)**: Confirms the endpoint is operational with no active user session.
  - **System Shutdown & Restart**: Gracefully logs terminal events before the operating system powers down.
- **Live Workstation Presence States in DataGrid**:
  - `🟢 Active`: The user is actively typing, moving the mouse, or interacting with the machine (last user input was `< 5 minutes` ago).
  - `💤 Idle (...)`: The user has been away from their input devices, formatted in human-readable units (e.g. `💤 Idle (18m)`, `💤 Idle (1h 30m)`, `💤 Idle (15h 16m)`).
  - `🔒 Locked (...)`: The workstation display screen is locked, formatted in human-readable units (e.g. `🔒 Locked (18m)`, `🔒 Locked (1h 30m)`, `🔒 Locked (17h)`, `🔒 Locked (1d 4h)`).
  - `🚪 Logged Off`: No interactive user session is logged into the local console.
  - `🔴 Offline`: The computer is powered off, sleeping, or unreachable over the network.
  - `⏳ Detecting...`: Background probe in progress.
- **100% Privacy-Preserving Architecture**:
  - Strictly non-invasive: The agent **never** records keystrokes, captures screen images, monitors clipboard contents, logs visited URLs, or accesses personal files.
  - It strictly queries native Windows input timestamps and session state change notifications to compute idle durations and session states entirely in memory.

#### B. Installation Location & System-Level Service Architecture
Based on Windows security best practices and enterprise administration standards:
- **System-Managed Installation Path**:
  - The agent executable is installed directly into:
    `%SystemRoot%\System32\ADRemoteControl\ADRC_IdleAgent.exe`
  - Runtime telemetry state is written to:
    `%ProgramData%\ADRemoteControl\idle.json`
- **Why This System Location Was Chosen**:
  - **Pre-Logon System Execution**: By installing into the Windows system directory and running as a native Windows Service (`ADRC_IdleMonitor`) configured with `start= auto` under `NT AUTHORITY\SYSTEM`, the agent starts automatically during Windows system boot, well before any user signs in.
  - **Robust Permissions & Security**: Avoids user-specific folders (`%AppData%` / `%LocalAppData%`) and standard application folders (`%ProgramFiles%`). `%SystemRoot%\System32` is inherently protected by Windows operating system access controls.
  - **Isolated Runtime Data**: Operational metrics (`idle.json`) are stored in `%ProgramData%\ADRemoteControl\`, ensuring atomic, low-overhead file writes that do not require administrative elevation to read over network shares.
- **Dual-Mode Hybrid Engine**:
  - **Session 0 Windows Service (`ADRC_IdleMonitor`)**: Manages the service lifecycle, tracks system boot, handles session logon/logoff/lock/unlock/disconnect events, and persists presence data.
  - **Interactive Session Worker (`--session`)**: Registered as an elevated logon task that runs inside the interactive user session to capture native hardware input timestamps and feed them to the service.

#### C. In-App Automated Deployment Workflow
The application eliminates the need for manual agent installations, MSI deployment packages, or complex GPO scripting:
1. **Fully Embedded Deployment (Zero External Files)**:
   - The monitoring agent executable is embedded directly within the main application binary. When deployed, the application extracts and transfers the agent over standard administrative SMB (`C$`).
2. **Bulk Actions 1-Click Deployment (`Install Monitor`)**:
   - In the top **Bulk Actions** bar, click **`⏱️ Idle Agent`** (or **`Install Monitor`**) with one, multiple, or all computers listed.
   - The deployment engine copies the binary to `\\host\C$\Windows\System32\ADRemoteControl\ADRC_IdleAgent.exe`, configures strict NTFS ACLs, registers and starts the `ADRC_IdleMonitor` Windows Service, and configures the interactive session helper.
3. **Single Computer Deployment via Context Menu**:
   - Right-click any workstation in the DataGrid -> navigate to `🛠️ Remote Maintenance & Automation ▸` -> click **`⏱️ Inactivity & Idle Monitor Agent`**.
4. **Intelligent Skip Logic**:
   - The engine automatically inspects target endpoints prior to deployment. If the agent service is already running and up-to-date, the host is automatically skipped (`[SKIPPED]`), preventing unnecessary file transfers or service restarts.
5. **Targeted Retry Capability (`Retry Monitor`)**:
   - If one or more machines fail or are skipped (e.g. machine offline or network timeout), subsequent clicks on the button automatically target **only** the uninstalled or failed endpoints.
6. **Dynamic Toggle to Removal (`Remove Monitor`)**:
   - When 100% of the listed computers in your inventory have the agent installed, the bulk action button automatically flips to **`Remove Monitor`**.
7. **Clean Uninstallation**:
   - Clicking **`Remove Monitor`** (or selecting it via context menu) cleanly stops and deletes the `ADRC_IdleMonitor` service, removes scheduled tasks, terminates running agent processes, and deletes the agent directories from the remote system.
8. **Itemized Diagnostic Audit Logging**:
   - Every deployment and removal action generates structured records in the Activity Log:
     - `[SUCCESS]`: Service created, configured, and started successfully.
     - `[SKIPPED]`: Host already running active monitor service.
     - `[NO ACCESS]`: Administrative share `C$` or Service Control Manager access denied.
     - `[OFFLINE]`: Host is powered off or unreachable on the network.
     - `[FAILED]` / `[ERROR]`: Specific error code or exception details for troubleshooting.

#### D. Enterprise Tamper Protection & Security Hardening
The monitoring architecture implements multi-tiered security to prevent tampering or unauthorized termination:
- **Hidden from Standard Installed Apps**:
  - Registered silently as an internal system service without creating entries under standard uninstall registry locations.
  - Does not appear in Windows **Settings > Installed Apps** or Control Panel **Programs and Features**.
- **NTFS File System Lockdown**:
  - Installed in `%SystemRoot%\System32\ADRemoteControl\`.
  - Strict NTFS Access Control Lists applied:
    - `BUILTIN\Administrators`: Full Control (`F`)
    - `NT AUTHORITY\SYSTEM`: Full Control (`F`)
    - `BUILTIN\Users`: Read & Execute (`RX`)
  - Standard non-admin users cannot modify, rename, overwrite, or delete the executable.
- **Eliminated from Task Manager Startup Apps**:
  - Operates as a Windows Service and elevated task; does **not** register under standard `Run` registry keys.
  - Does not appear in Task Manager's **Startup Apps** tab, preventing users from disabling it.
- **Win32 Process Termination Hardening**:
  - The process applies a hardened security descriptor to its process handle.
  - Standard users are explicitly denied termination rights. Attempting to click "End Task" in Task Manager returns **`Access is denied`**.
- **Centralized IT Control**:
  - Only authorized Domain Administrators executing the Control Center suite can deploy, update, or remove the monitoring agent.

#### E. Prerequisites & Permissions
- **Administrative Privileges**: Launch the application with Domain Admin or authorized administrative group credentials.
- **Network Ports**: SMB (`TCP 445`), RPC / Service Control Manager (`TCP 135` & dynamic RPC range).
- **Target OS**: Compatible with Windows 11, Windows 10, Windows Server 2025, 2022, 2019, and 2016.

---

### 23. Automatic 1-Minute Background Telemetry Refresh Engine
To ensure that workstation inventory, network health, and presence data remain continuously up-to-date without requiring manual operator intervention, the suite incorporates a lightweight, automated background refresh engine:

- **1-Minute Silent Execution Cycle**:
  - The background engine triggers automatically every 60 seconds across all listed computers in the inventory grid.
- **Atomic Concurrency Guard**:
  - A thread-safe execution guard ensures that if a previous background scan is still completing, the next scheduled cycle will gracefully yield. Scans never overlap, preventing thread contention or excessive network traffic.
- **Non-Intrusive Worker Thread Probing**:
  - Network reachability and ICMP latency probes operate with an accelerated 650ms timeout.
  - Active presence checks query lightweight RPC endpoints with a 450ms connect timeout.
  - Entire scanning workflow executes on dedicated background thread pools, completely isolating the WPF graphical user interface from network I/O.
- **Silent In-Memory Telemetry Synchronization**:
  - Updates Online/Offline status, live ICMP ping latency, active Logged-in User, Workstation State (`🟢 Active`, `💤 Idle`, `🔒 Locked`), and Idle Agent presence silently.
  - **Zero User Disruption**: Does not clear or re-draw the DataGrid, does not deselect the operator's highlighted rows, does not interfere with text typed into the Search box, and does not overwrite temporary status bar alert messages.

---

### 24. Group Policy, Firewall & Administrator Setup Guide

#### A. Active Directory & Administrator Privilege Requirements
To manage domain computers agentlessly, the technician or operator account must satisfy the following permissions:

1. **Local Elevation**:
   - The application binary (`Windows AD-Admin Control Center.exe`) must be launched with administrative privileges (**Run as Administrator**). Administrative authorization is enforced automatically on startup.
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

### 25. Universal Keyboard Shortcuts

| Shortcut | Action | Scope |
| :--- | :--- | :--- |
| **`Ctrl + S` / `Ctrl + F`** | **Focus Quick Search Bar** & Select All Text | Main Window |
| **`F5` / `Ctrl + R`** | **Refresh Computer Inventory** from Active Directory | Main Window |
| **`Enter`** | **Connect Remote Shadow Session** (Screen Mirror) | Main Window (Computer Grid) |
| **`Ctrl + Enter`** | **Connect Remote Desktop** (Standard RDP Login) | Main Window |
| **`Ctrl + Win + Q`** | **Launch Microsoft Quick Assist** (or click dedicated **Quick Assist** button) | Main Window |
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

### 26. Security & Access Authorization
- **Startup Authorization Guard**:
  - Verifies that the launching user belongs to genuine Domain or Enterprise administrative tiers. Standard workstation users with local admin (`BUILTIN\Administrators`) are strictly blocked on domain networks.
  - **Required Administrative Groups**:
    - **Domain Admins** (SID ending in `-512`)
    - **Enterprise Admins** (SID ending in `-519`)
    - **Schema Admins** (SID ending in `-518`)
    - **Account Operators** (SID ending in `-548`)
    - **Server Operators** (SID ending in `-549`)
    - **Authorized AD Administrative Groups** (e.g. `IT-Admins`, `IT Admins`, `Server Admins`, `System Admins`, `Security Admins`).
  - *Custom Group Modification*: If you need to add or remove authorized administrative groups, please request a feature or open an issue on GitHub, or message the author on Telegram, and the changes will be made for you.
  - Unauthorized launches are immediately halted with the red modal security screen and logged to the session audit trail.
- **Binary Integrity & Hardening**:
  - The compiled `.exe` is a native PE binary. Source code is compiled and cannot be extracted with archiving tools such as WinRAR or 7-Zip.
  - For public distribution, production binaries are hardened with automated obfuscation and Authenticode signatures to prevent reverse engineering and unauthorized tampering.

---

### 27. Community, Support & Feedback
- **Official GitHub Releases**: [SuperUser-exe/Windows-Active-Directory-Remote-Administration-Control-Center](https://github.com/SuperUser-exe/Windows-Active-Directory-Remote-Administration-Control-Center/releases)
- **Telegram Community Group**: Join [t.me/WADRACC](https://t.me/WADRACC) for real-time chat, instant support, updates, and feature suggestions.
- **GitHub Discussions**: [Community Discussions & Feature Ideas](https://github.com/SuperUser-exe/Windows-Active-Directory-Remote-Administration-Control-Center/discussions)
- **Developer Attribution**: [Askarali Mattummal on LinkedIn](https://www.linkedin.com/in/askaralimattummal/)


