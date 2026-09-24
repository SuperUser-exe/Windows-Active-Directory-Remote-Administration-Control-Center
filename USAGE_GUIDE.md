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
28. [In-App Broadcast Studio & Notification Delivery Tracking](#28-in-app-broadcast-studio--notification-delivery-tracking)
29. [Enterprise Security Policies & Multi-Tier Lockout Governance](#29-enterprise-security-policies--multi-tier-lockout-governance)
30. [Windows LAPS & Local Administrator Password Management Suite](#30-windows-laps--local-administrator-password-management-suite)
31. [Local Computer Users & Security Manager](#31-local-computer-users--security-manager--password-visibility-policy-enforcement--accurate-logging)
32. [Remote System Restore Point Manager](#32-remote-system-restore-point-manager--checkpoints--system-rollback)
33. [Master Mode — Fleet Gateway API & Cloud Settings](#33-master-mode--fleet-gateway-api--cloud-settings)
34. [Comprehensive Installed Software Inventory Discovery](#34-comprehensive-installed-software-inventory-discovery)
35. [Remote Group Policy Refresh Architecture](#35-remote-group-policy-refresh-architecture)
36. [New Administrative Tools & Diagnostics (v2.7.0 Coming Soon)](#36-new-administrative-tools--diagnostics-v270-coming-soon)

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
- **`Computer Name`**: NetBIOS hostname with double-click quick actions and real-time monitoring agent status dot: 🟢 Green for active agent, 🟡 Amber for stale reporting, ⚫ Black for not installed, 🔴 Red for unknown/offline, with full hover tooltips.
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
  - **Checked** (default: enabled): Connects immediately without prompting the remote user (requires Domain Group Policy permission).
  - **Unchecked**: Prompts the user on their screen: *"Administrator is requesting remote control of your desktop. Do you allow this?"*.
- **Full Control (`/control`)**:
  - **Checked** (default: enabled): Enables remote mouse and keyboard interactivity.
  - **Unchecked**: View-only mode for observation or training.
- **Full Screen (`/f`)**: Launches the viewer in fullscreen mode.
- **Multi-Monitor (`/multimon`)**: Spans across multi-monitor setups.
- **Privacy Mode (Blank Screen)**:
  - Curtains and blanks the physical monitor on the remote endpoint by locking the console while granting the administrator exclusive remote session control, preventing unauthorized onlookers from observing sensitive administrative tasks or confidential employee data.
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
- **Automated Pre-Flight Port Reachability & Smart Activation Prompt**:
  - When launching an RDP connection, the application automatically performs an instantaneous pre-flight check on TCP port 3389.
  - If the port is open and listening, Remote Desktop launches immediately with zero delay.
  - If Remote Desktop is disabled, blocked by the Windows Defender Firewall, or the Remote Desktop service is stopped, a dedicated smart assistance prompt appears offering to automatically configure the service, open the firewall, and connect with a single click.
- **Remote Desktop Configuration & Diagnostic Center**:
  - Click the dropdown arrow (`▼`) next to **🖥️ Connect RDP Session** on the bottom connection bar or right-click any computer and select **🔓 Enable Remote Desktop (RDP) on Host...** to open the interactive configuration center.
  - **Live Diagnostics**: Automatically inspects whether Remote Desktop connections are enabled, checks Network Level Authentication (NLA) enforcement, and probes TCP port 3389 reachability.
  - **1-Click Enablement**: Remotely configures the Terminal Server registry, ensures background services are set to Automatic and started, and adds inbound Windows Defender Firewall rules for TCP port 3389.
  - **Disable / Lockdown**: Allows administrators to remotely turn off Remote Desktop connections and close firewall rules when securing decommissioned or quarantined endpoints.
  - **Bulk Configuration**: Select multiple computers in the inventory grid, right-click, and choose **🔓 Enable Remote Desktop (RDP) (Bulk)...** to configure and enable Remote Desktop across dozens of workstations simultaneously with live progress reporting.
  - **Lock Screen Takeover Integration**: Enables administrators to activate Remote Desktop directly from the Physical Lock Screen Takeover Controller when recovering locked workstations.

#### D. Quick Assist Remote Assistance
Located on the primary bottom connection toolbar directly between **⚡ Connect Shadow Session** and **🖥️ Connect RDP Session**, the **🚀 Quick Assist** button provides immediate, 1-click access to Microsoft Quick Assist (`quickassist.exe` / `ms-quick-assist:`).

- **When to Use Quick Assist**:
  - **Cross-Subnet & VPN Support**: Ideal when managing remote laptops connecting through restricted guest Wi-Fi, home VPN tunnels, or multi-tenant DMZs where inbound TCP 3389 (RDP) or RPC/SMB ports may be blocked by firewalls.
  - **Co-Piloted Interactive Support**: Allows technicians to guide end-users interactively using Microsoft cloud session codes without requiring Active Directory credentials or pre-configured Group Policy permissions.
  - **Alternative to Shadowing**: Complements native RDS Screen Shadowing (`mstsc.exe /shadow`) when working with remote workers outside the local corporate LAN.

#### E. Privacy Mode (Curtain & Blank Physical Screen)
Located in the connection options row immediately below Multi-Monitor, the **🛡️ Privacy Mode (Blank Screen)** toggle allows administrators to perform remote troubleshooting with complete physical confidentiality.

- **Confidential Maintenance & Privacy Curtain**:
  - When enabled, remote connections lock and blank the remote physical monitor while granting the administrator interactive control.
  - Anyone walking past or sitting in front of the remote computer cannot view on-screen actions, confidential records, or administrative credentials.
- **Default Connection Options**:
  - For optimal administrative speed and user courtesy, the bottom toolbar defaults to:
    - **🔔 Alert User**: Enabled by default (dispatches a pre-session notification to the remote display).
    - **✋ Ask User Permission**: Enabled by default (prompts user to accept or decline the session).
    - **Full Control (Keyboard & Mouse)**: Enabled by default (provides interactive control immediately upon connection approval).

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

### 5. Live Workstation Performance & Hardware Diagnostics Monitor (`Ctrl + Shift + M` / `Ctrl + I`)
Click **📈 Live Perf** on the toolbar or right-click any computer and select **📈 Live Workstation Performance & Resource Monitor**.

- **Consolidated Unified Diagnostics Architecture**:
  - Eliminates separate popup windows by integrating underlying hardware specifications, BIOS identity, operating system details, and storage volumes directly alongside real-time performance telemetry.
- **Real-Time Streaming Performance Graphs**:
  - Live sub-second sparkline charts for CPU utilization, RAM memory allocation, dual-channel network bandwidth (upload/download), and disk I/O activity without disturbing the logged-in user.
- **Full-Screen Deep Monitoring View**:
  - **Double-Click or Expand Button**: Double-clicking any of the 4 live charts immediately maximizes that single metric into a full-window deep monitoring view with high-resolution sparkline visualization.
  - **Timeline Axis Markings**: Visual time markers spanning from `-60s ago`, `-45s`, `-30s`, `-15s` to `Now (0s)`.
  - **4 Real-Time KPI Metric Cards**: Live display of Current Reading, Peak/Max, Low/Min, and Rolling 60-Second Average.
  - **Seamless Restoration**: Double-clicking anywhere on the expanded view, clicking `🗗 Restore View`, or pressing `Escape` instantly returns to the 4-panel overview.
- **Comprehensive Hardware & Subsystems Inventory**:
  - **Hardware Identity & Service Tag**: Motherboard manufacturer, computer model, BIOS firmware version, and Serial Number / Service Tag (Dell, HP, Lenovo) with a 1-click **📋 Copy Serial** button.
  - **Operating System & Continuous Uptime Tracker**: Operating system edition, build number, 64-bit architecture, system boot timestamp, and continuous uptime counter with an automated amber warning badge when a workstation has not rebooted in over 14 days.
  - **Processor Architecture**: CPU model, physical core and logical thread counts, maximum clock speed, and L3 cache size.
  - **Physical Memory Modules**: Total installed RAM, memory technology (DDR4/DDR5), clock speed in MHz, and per-slot physical DIMM module breakdown.
  - **Logical Storage Volumes**: Drive letters, volume names, file systems, visual capacity progress bars, free space percentages, and visual health status badges (Healthy, Warning, Low Disk Space).
  - **Physical Disk Drives**: Storage media model, NVMe/SATA interface type, total capacity, and partition count.
  - **Network Adapters & Link Speeds**: Network interface controller description, hardware link connection speed (e.g. 1.0 Gbps or 100 Mbps), IPv4 address, default gateway, MAC address, and DHCP status.
- **One-Click System Specifications Export**:
  - Clicking **📋 Copy Specs** in the window footer copies a complete, cleanly structured summary of the computer's identity, OS, CPU, RAM, disks, and network configuration to the Windows clipboard for ticketing and asset records.
- **Running Processes & Resource Consumers**:
  - Identifies top running applications and background tasks by memory consumption with 1-click remote process termination.
- **Windows Core Services**:
  - Full service inventory with live status indicators, responsive action controls, and 1-click Start, Stop, and Restart operations.
- **High-Resilience Telemetry Engine**:
  - Automatically engages fail-safe performance fallbacks and timeout safeguards, ensuring live telemetry streams reliably even on workstations with long uptimes without requiring reboots.

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

### 8. Remote Windows Event Log Viewer & Security Audit Hub
Click **📋 Events** on the toolbar (or right-click any workstation -> **📋 Remote Windows Event Logs**) to open the Event Viewer.

- **High-Speed Reverse Streaming & Remote Server-Side Filtering**:
  - Communicates directly with the remote computer's native Windows Event Log RPC subsystem with reverse-chronological streaming, querying newest records first.
  - Automatically executes native server-side filtering on the remote host, ensuring queries return exact matching records in milliseconds without network delays or missing historical events.
- **Categorized Quick Presets Dropdown with Rich Visual Styling (Over 35 Enterprise Presets)**:
  - High-contrast color-coded badges, Segoe UI Emoji icons, clean display titles, and dedicated event identification pill tags organized across 8 operational categories:
    - **Windows LAPS**: All LAPS Events, Password Read/Retrieved, Password Rotated/Updated, and Password Rotation Failures.
    - **User Account Lifecycle**: Account Created, Deleted, Enabled, Disabled, Locked Out, Unlocked, Modified, Admin Password Reset, and User Password Change.
    - **Security Groups & Membership**: Member Added, Member Removed, Group Created, Group Deleted, Group Modified, and All Group Membership Changes.
    - **Network File Shares & File Access**: Share Object Accessed, Detailed Share Access Checked, File Deleted, File Created/Added, File Modified/Edited, Permissions/SACL Modified, and Share Created/Deleted.
    - **Logon, Kerberos & Authentication**: Successful Logons, Failed Logons / Bad Password, Admin Logon with Special Privileges, Explicit Alternate Credentials (RunAs), Kerberos Pre-Authentication Errors, and Remote Desktop (RDP) Sessions.
    - **Security, Threats & Tampering**: New Windows Service Installed, Audit Policy Tampering, Firewall Rules or State Changed, Windows Defender Malware Alerts, PowerShell Script Executions, and Process Creation.
    - **System Reliability & Hardware**: Reboots, Normal Shutdowns, Unexpected Shutdown / Power Loss, Blue Screen of Death (BSOD), Application Crashes & Hangs, Service Crashes, Storage Errors / Bad Blocks, and BitLocker Encryption / Recovery Key Backup to Active Directory.
    - **Group Policy & GPUpdate Diagnostics**: All Group Policy & GPUpdate Activity (policy refreshes, software assignments, and processing faults), Policy Errors & Failures (domain controller timeouts, network loss, and SYSVOL access denied), Software Installation (Client-Side Extension deployment, assigned software, removals, and installation failures), and Successful Policy Refreshes (clean updates and newly applied settings).
    - **Operations & Network**: Completed Print Jobs, Print Failures, Network IP Conflicts, DNS Name Resolution Timeouts, Windows Update Patches, Group Policy Processing Errors, and Task Scheduler Failures.
- **Instant Type-to-Find Preset Search with Continuous Typing**:
  - Type any keyword into the search box beside the preset dropdown (e.g. `gp`, `laps`, `lockout`, `delete`, `share`, `group`, `reboot`, or any event number) to immediately filter the presets list in real-time. Keyboard focus remains smoothly in the search box as you type multiple characters without interruption.
  - Press the Down Arrow key to move directly into the filtered dropdown list, or press Enter to immediately activate the top matching preset.
- **Forensic Entity Filtering Toolbar (User, Host, IP & File Operations)**:
  - **`👤 User / Account`**: Isolate events generated by or targeting a specific user account in real-time, backed by live auto-suggestions from loaded event records and the Active Directory computer catalog.
  - **`🖥️ Client / Source PC`**: Filter events originating from a specific client workstation, server, or caller machine name, with instant auto-suggestions.
  - **`🌐 IP Address`**: Track down specific caller or client network IP addresses across logon and network events, with live auto-suggestions.
  - **`📁 File / Object Path`**: Filter file and object operations by file name, directory, or network share path, with auto-suggestions populated from audited file operations.
  - **`Exact Match Checkbox`**: Toggle exact matching mode for file operations to match precise file names or full paths, eliminating partial substring noise.
  - **`Target Counter Badge`**: Real-time counter displaying current filtered records versus total loaded events (e.g. `🎯 Filtered: 14 of 1,000 events`).
  - **`🔄 Clear Entity Filters`**: 1-Click reset for all forensic entity filter textboxes and toggles.
- **Dedicated Sortable Forensic Columns**:
  - The main event table features dedicated columns for **`User / Account`**, **`Client / Source PC`**, **`IP Address`**, and **`File / Object Path`**.
  - Click any column header to sort ascending or descending instantly across all loaded records.
- **Full Multi-Channel Auditing**:
  - Dropdown options: `All Default Channels (Sys+App+Sec)`, `System Log`, `Application Log`, `Security Log`, `Group Policy (Operational)`, `Windows LAPS (Operational)`, `Setup Log`, `RDP & Terminal Services`, `Print Spooler (Operational)`, `Task Scheduler (Operational)`, `Windows Defender (Operational)`, `DNS Client (Operational)`, `Directory Service (Domain Controller)`, and `DNS Server (Domain DNS)`.
- **Vivid Severity Color Badges**:
  - 🟢 **Audit Success**: Vibrant emerald green badge for verified authentications, account creations, and authorized access.
  - 🔴 **Audit Failure**: High-visibility rose red badge for rejected logons, access denied, and security policy blocks.
  - 🔴 **Critical & Error**: Distinct crimson red badge for system errors and kernel crashes.
  - 🟡 **Warning**: Distinct amber badge for non-critical warnings and performance flags.
  - 🔵 **Information**: Crisp sky blue badge for standard operational records.
  - 🟣 **Verbose / Debug**: Purple badge for deep diagnostic traces.
- **Date Range Filter**:
  - Dropdown options: `All Dates`, `Today Only`, `Last 24 Hours`, `Last 7 Days`, `Last 30 Days`.
- **Expanded Event Record Limits**:
  - Dropdown options: `50 Events`, `100 Events`, `250 Events`, `500 Events`, `1,000 Events`, `2,000 Events`, `5,000 Events`, and `10,000 Events`.
- **Rapid-Access Emergency Action Pills**:
  - Single-click action buttons for urgent investigations: `🔴 Errors`, `🔒 Lockouts`, `👤 Users`, `👥 Groups`, `📁 File Shares`, `🔑 LAPS`, `📜 GPUpdate`, `💥 BSOD`, and `🔄 Reboots`.
- **Live Group Policy Update (GPUpdate) Verification**:
  - When forcing a remote policy refresh on any computer, the application offers an immediate option to open the Remote Windows Event Viewer with the GPUpdate diagnostic preset pre-selected, allowing sysadmins to verify in real-time whether policies refreshed successfully, which client-side extensions were executed, or what errors/reboot warnings occurred.
  - All retrieved Group Policy refresh and client-side extension events appear immediately in the audit grid without interference from filter field text, accompanied by instant completion confirmation in the details pane.
- **Enhanced Forensic Technical Details & CSV Audit Export**:
  - Selecting any row in the table reveals structured entity metadata (User, Host, IP, and File Path) in the technical details inspector.
  - 1-Click **📊 Export CSV** writes all displayed records with full entity columns to a formatted CSV spreadsheet for security audit and compliance documentation.

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
  - Columns: Printer Name, Type (Local / Network Shared), Print Server / IP, Default status (⭐), Queued Jobs, Status, Location, Comment, Driver Name, Port Name, and Ink / Toner Level.
- **Direct Network Printer Supplies & Ink/Toner Level Telemetry**:
  - Automatically queries network-connected printers for consumable marker supply levels (Black, Cyan, Magenta, Yellow toners, drums, and maintenance units) directly via agentless network queries.
  - Highlights consumable supply levels with color-coded badges: 🟢 Green for healthy supplies, 🟡 Amber for low supplies (<20%), and 🔴 Red for critical replenishment (<10%). Hovering over any supply level displays a comprehensive breakdown tooltip with exact percentages, raw capacity metrics, and device model information. Virtual and PDF printers cleanly display "Not Available / Unsupported".
- **Horizontal Scrolling & Adjustable High-Density Data Grids**:
  - Independent horizontal scrollbars and resizable columns on both the Installed Printers grid and the Print Queue & Job History table allow operators to seamlessly inspect long printer names, network paths, driver specifications, and document titles without text clipping regardless of screen resolution.
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
  - **Remote Share UNC Path**: Specify `\\server\share` or `\\192.168.x.x\folder`. Includes a **"🔍 Test Path"** button to verify accessibility directly from the application.
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
Right-clicking computers in the workstation inventory grid provides instant access to all remote troubleshooting, management, and diagnostics capabilities. The context menu dynamically adapts based on single or multi-device selection, featuring an integrated Fast Action Search bar for instant tool execution:

- **Integrated Fast Action Search Bar**:
  - **Auto-Focus on Launch**: Opening the right-click menu automatically places keyboard focus into the search bar, allowing operators to type immediately without an extra mouse click.
  - **Dynamic Real-Time Filtering**: Typing any keyword (e.g. `ping`, `event`, `temp`, `reboot`, `rdp`, `uac`, `service`, `task`, `god`, `wallpaper`) instantly scans across all 50+ administrative actions and displays matching tools in a flat, convenient list with category badges (such as `[Network]`, `[Security]`, `[Diagnostics]`, `[Administration]`).
  - **Rapid Keyboard Execution**:
    - **`Enter`**: Instantly triggers the top matching action and dismisses the menu.
    - **`Down Arrow`**: Shifts focus to the search results list to select a specific tool.
    - **`Escape`**: Clears the current search query, or closes the context menu if the field is empty.
  - **Instant Reset**: Clearing the search bar restores the standard categorized menu hierarchy immediately.

- **Target Device Header Banner**:
  - Located at the very top of the context menu, clearly displaying the target machine's computer name, IP address, and active connection status (`Online` / `Offline`), ensuring total certainty before performing critical actions.

- **Single-Device Selection Mode (`1` Computer Selected)**:
  - **Direct Top-Tier Remote Access**:
    - ⚡ Screen Shadowing (Interactive Screen Mirror)
    - 🛡️ Fix UAC Black Screen (Shadow Preparation)
    - 🖥️ Remote Desktop (Standard RDP Login)
    - 💻 Remote Console Terminal (Command Prompt & PowerShell)
  - **7 Streamlined, Deduplicated Submenus**:
    1. ⚙️ **System Administration & Management**: Remote Task Manager, Remote Services Manager, Installed Software & Uninstaller, Startup Applications Manager, Remote Printers & Spooler, Local Computer Users & Accounts, Computer Management MMC (`compmgmt.msc`), Task Scheduler MMC (`taskschd.msc`), Rename Remote Computer, and Active Directory Computer Description.
    2. 📊 **Diagnostics & Health**: Live Workstation Performance & Hardware Diagnostics Monitor, Remote Windows Event Logs, Group Policy & GPUpdate Event Logs, Laptop Battery & Power Health, Repair Remote WMI Repository, and Computer Activity Log.
    3. 🌐 **Network & Connectivity**: Ping Host & Query Info, Remote Network & IP Configuration (DHCP / Static IP), One-Click Network Repair & Reset Suite, DNS Lookup & Reverse Resolution (`nslookup`), Flush Remote DNS Cache (`ipconfig /flushdns`), Enable Remote ICMP Firewall Rule, Open Website in Remote User's Browser, and Wake-on-LAN (WOL).
    4. 👤 **Active Directory & User Session**: View AD User Profile Card, Edit AD User Profile Attributes, Unlock User Account, Reset User Password, Check Password Expiration Date, Send Toast Notification to User, and Logoff Active User Session.
    5. 📁 **Files & Shared Folders**: Open C$ Root Administrative Share, Open Desktop Folder, Open Downloads Folder, Open Documents Folder, Remote Mapped Network Drives Manager, and Push File / Script to Remote PC.
    6. 🛠️ **Customization, Automation & Deploy**: Silent Software / Script Deployer, Force Remote Group Policy Update (`gpupdate /force`), View GPUpdate & GPO Event Logs, Windows God Mode & Power Tweaks, Desktop Info HUD Overlay (BgInfo), Change Desktop Wallpaper, and Inactivity & Idle Monitor Agent (Deploy / Status / Uninstall).
    7. ⚡ **Security & Power Control**: BitLocker Recovery Keys & Drive Encryption, LAPS Local Administrator Password, 4-Path Deep Temp Clean, Remote Workstation Lock & Unlock Controller, Instant Screen Lock, Restart Computer (Reboot), and Shutdown Computer (Power Off).
  - **Graceful Hardware & Policy Feedback**: If a feature is not applicable or configured on the chosen endpoint (e.g. Battery Health on a stationary desktop tower, BitLocker when unencrypted, LAPS when not deployed), the application displays a friendly, clear informational dialog explaining why the feature is not active on that machine.

- **Multi-Device Selection Mode (`> 1` Computers Selected)**:
  - Displays a dedicated bulk banner indicating the exact number of selected workstations.
  - Includes the Fast Action Search bar customized for multi-computer fleet operations.
  - Reorganized into focused categories: High-Value Customizations, Bulk Maintenance & Software Deployment, Network & User Messaging, and Security & Power Controls.

---

### 21. Remote Desktop Wallpaper Changer & Manager (Single & Bulk)
Access by right-clicking any computer(s) -> **`🖼️ Change Desktop Wallpaper (Single / Bulk)...`** (located under `Customization, Automation & Deploy ▸`).

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
- **Computer Name Agent Status Dot & Comprehensive Hover Tooltip**:
  - Located beside the computer hostname in the central inventory table, providing instant four-tier deployment visibility:
    - 🟢 **Green**: Agent installed, service active, and actively streaming fresh telemetry.
    - 🟡 **Amber**: Agent installed but inactive or reporting stale telemetry.
    - ⚫ **Dark Slate / Black**: Agent not installed (distinguished from network outages with a crisp border in both dark and light modes).
    - 🔴 **Red**: Unknown / unable to detect (e.g. host powered off or blocked by firewall).
  - Hovering over the status dot or computer name displays a multi-line status tooltip detailing the service state, background worker process, and last recorded heartbeat.
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
   - In the top **Bulk Actions** bar, click **`⏱️ Inactivity Monitor`** (or **`Install Monitor`**) with one, multiple, or all computers listed.
   - The deployment engine copies the binary to `\\host\C$\Windows\System32\ADRemoteControl\ADRC_IdleAgent.exe`, configures strict NTFS ACLs, registers and starts the `ADRC_IdleMonitor` Windows Service, and configures the interactive session helper.
3. **Single Computer Deployment via Context Menu**:
   - Right-click any workstation in the DataGrid -> navigate to `🛠️ Customization, Automation & Deploy ▸` -> click **`🚀 Deploy Inactivity & Idle Monitor Agent`** (or type "Monitor" into the fast action search bar).
4. **Intelligent Skip Logic**:
   - The engine automatically inspects target endpoints prior to deployment. If the agent service is already running and up-to-date, the host is automatically skipped (`[SKIPPED]`), preventing unnecessary file transfers or service restarts.
5. **Targeted Retry Capability (`Retry Monitor`)**:
   - If one or more machines fail or are skipped (e.g. machine offline or network timeout), subsequent clicks on the button automatically target **only** the uninstalled or failed endpoints.
6. **Dynamic Toggle to Removal (`Remove Monitor`)**:
   - When 100% of the listed computers in your inventory have the agent installed, the bulk action button automatically flips to **`Remove Monitor`**.
7. **Clean Multi-Stage Uninstallation**:
   - Clicking **`Remove Monitor`** (or selecting **`Uninstall Inactivity & Idle Monitor Agent`** via context menu) cleanly disables and deletes the background service, purges scheduled tasks across interactive sessions, terminates all running agent instances across user sessions, normalizes file permissions, deletes agent binaries and runtime metrics files with strict verification, and resets workstation state columns immediately.
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

### 23. Remote Computer Rename & Identity Administration
Access by right-clicking any workstation -> **`⚙️ System Administration & Management ▸`** -> **`🏷️ Rename Remote Computer...`**.

- **Packet-Level Encrypted Administrative Channel**:
  - Communicates with the remote computer over fully encrypted administrative channels with packet privacy, ensuring sensitive identity operations and credential handshakes comply with enterprise security standards.
- **Support for Both Local Session & Alternate Domain Admin Credentials**:
  - Seamlessly performs the rename operation using either the administrator's current elevated session token or designated alternate Domain Administrator credentials (`DOMAIN\Admin`).
- **Comprehensive Pre-Flight Privileges Diagnostic**:
  - Click **`🔍 Check Privileges & Rights`** to test process elevation, ICMP ping reachability, RPC endpoint availability (Port 135), and domain membership before attempting to rename the machine.
- **Automatic Post-Rename System Restart Option**:
  - Check **`Restart remote computer automatically after renaming`** to issue an automated reboot with a friendly warning banner so the new NetBIOS and Active Directory hostname take effect without manual intervention.

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

#### 💬 Submitting In-App Feedback & Star Ratings
Administrators and technical operators can share immediate workflow feedback, submit star ratings, report technical issues, or request new features directly inside the application:
1. Click the **`💬 Feedback`** button located on the top header navigation bar.
2. Select an overall satisfaction rating from **1 to 5 Stars**.
3. Choose an appropriate category:
   - **General Experience & Praise**: Share overall impressions, speed feedback, or positive workflow experiences.
   - **Feature Request / Enhancement**: Propose new administrative tools, columns, or workflow automations.
   - **Bug Report / Technical Issue**: Report unexpected errors, display quirks, or network timeout behavior.
   - **Performance / Speed Suggestion**: Suggest optimizations for large-scale Active Directory forests or high-latency branch offices.
4. Enter detailed comments or suggestions in the text area.
5. Both a star rating (1 to 5 stars) and a written feedback message are required to ensure complete, actionable input.
6. Click **`🚀 Submit Feedback`** to submit your feedback.

#### 👥 Official Support & Community Channels
- **Official GitHub Releases**: [SuperUser-exe/Windows-Active-Directory-Remote-Administration-Control-Center](https://github.com/SuperUser-exe/Windows-Active-Directory-Remote-Administration-Control-Center/releases)
- **Telegram Community Group**: Join [t.me/WADRACC](https://t.me/WADRACC) for real-time chat, instant support, updates, and feature suggestions.
- **GitHub Discussions**: [Community Discussions & Feature Ideas](https://github.com/SuperUser-exe/Windows-Active-Directory-Remote-Administration-Control-Center/discussions)
- **Developer Attribution**: [Askarali Mattummal on LinkedIn](https://www.linkedin.com/in/askaralimattummal/)

---

### 28. In-App Broadcast Studio & Notification Delivery Tracking

The **In-App Broadcast Studio & Notification Dispatcher** enables administrators to broadcast urgent system notices, maintenance schedules, and security advisories across domain workstations with real-time delivery and receipt tracking.

#### A. Notification Lifecycle Stages
Unlike traditional broadcast tools that merely dispatch alerts without verification, the suite tracks each notification through a complete, verifiable lifecycle:
1. **Sent / Pending**: The broadcast has been created and queued for distribution across target endpoints.
2. **Received**: The notification has reached the client application on the target workstation and is actively displayed on the operator's screen.
3. **Read**: The user has viewed the notification and dismissed it by clicking Close.
4. **Acknowledged**: For critical notices requiring mandatory confirmation, the operator has clicked the explicit **`✓ Acknowledge`** button.
5. **Expired / Revoked**: The broadcast reached its configured expiration time or was manually deactivated by an administrator.

#### B. Mandatory Acknowledgment Mode & Single-Action Verification
To guarantee accountability and eliminate unconfirmed dismissals across domain workstations:
- Every broadcast notification displayed on remote client screens presents a dedicated **`✓ Acknowledge`** action button.
- The standard close icon has been eliminated so that operators cannot casually bypass alerts without creating an interactive confirmation record.
- When **Require Explicit Acknowledgment** is enabled in the composer, this confirmation is formally registered as an administrative acknowledgment receipt in the audit ledger.

#### C. Real-Time Fleet Reach & Receipts Audit Ledger
- **Live Fleet Reach Progress**: View dynamic progress bars showing the exact percentage of workstations that have received and confirmed the notification.
- **Contextual Action Management**: The **Deactivate** action is available only while broadcasts are actively pending or circulating on workstations. Once all targeted machines have confirmed receipt, the record automatically transitions to **`✓ Completed`**.
- **Per-Workstation Audit Receipts**: Click **`📋 Receipts`** on any broadcast in the history ledger to inspect an itemized compliance audit trail detailing computer names, logged-in operators, Active Directory domains, delivery timestamps, and receipt statuses.

---

### 29. Enterprise Security Policies & Multi-Tier Lockout Governance

The **Enterprise Security Policy Governance** architecture provides centralized policy enforcement across corporate endpoints, safeguarding workstations against outdated software versions, device loss, or expired licensing.

#### A. Multi-Tier Security Policy States
When an enterprise security policy requires endpoint access to be suspended, the client application presents a specialized, user-friendly security interface tailored to the exact policy condition:
1. **Version Retirement Policy**:
   - **Visual Cue**: High-contrast gold alert styling with an amber warning badge.
   - **Purpose**: Informs operators that their installed application version has reached its planned end-of-support milestone and requires an update to remain compliant.
   - **Incident Reference**: Displays a clear reference tracking identifier (such as `POL-MIN-VER-2.7.0`).
2. **Workstation Quarantined**:
   - **Visual Cue**: Deep charcoal card layout with a laptop icon and glowing cyan accents.
   - **Purpose**: Triggered when a device has been flagged as missing, unverified, or placed under temporary quarantine pending security review.
   - **Incident Reference**: Displays the machine-specific tracking reference (such as `INC-HOST-LT-FIELD-01`).
3. **Domain Access Suspended**:
   - **Visual Cue**: Deep charcoal card layout with an enterprise building icon and coral accents.
   - **Purpose**: Applied when domain-wide evaluation periods conclude or organizational licensing policies require renewal.
   - **Incident Reference**: Displays the domain-specific incident reference (such as `INC-DOMAIN-TECHCORP.IO`).
4. **Access Restricted (Domain Administrators Only)**:
   - **Visual Cue**: Deep charcoal card layout with a coral red shield icon, draggable header, and red status highlights.
   - **Purpose**: Displayed upon application startup when a non-administrative user attempts to launch the console. Clearly alerts the operator that elevated Active Directory Domain Administrator privileges are required.
   - **Incident Reference**: Displays the operator account, access status, client machine, and enterprise role-based access policy, with interactive `🔄 Verify Authorization` and `✕ Close Application` actions.

#### B. Confidential Client Architecture (Zero Information Disclosure)
To maintain operational security and prevent unauthorized reconnaissance on enterprise endpoints:
- All client-side policy screens and alert dialogs operate in a strictly confidential mode.
- Notifications do not reveal backend management endpoints, internal cloud infrastructure, or remote control mechanics.
- The interface presents only clean enterprise policy guidance, the assigned incident reference, and clear instructions for reaching corporate IT support.

#### C. Master Authorization & Request Unlock Procedure
For emergency maintenance scenarios or authorized temporary bypasses:
1. **Request Unlock Flow**:
   - Operators can click **`🔑 Request Unlock`** directly on the security alert screen.
   - On unmanaged endpoints or during connectivity interruptions, this opens the **Master Authorization & Request Unlock** dialog.
2. **Administrator Verification & Centrally Enforced Duration**:
   - The authorization engine verifies whether the operating account possesses elevated Active Directory Domain or Enterprise Administrator credentials.
   - The operator enters the master authorization passcode.
   - The authorized bypass duration (such as 30 Minutes, 1 Hour, 4 Hours, 24 Hours, 7 Days, Single Session, or Permanent Bypass) is centrally assigned and enforced by Enterprise Security Administrators in the Cloud Admin Console. The client application automatically validates the passcode, applies the assigned duration window, and confirms the active duration to the operator.
3. **Audit Trail**:
   - Every unlock authorization is immutably logged with the administrator's identity, hostname, resolved duration window, and timestamp.

#### D. Granular Scope Lockout Policies & Targeted Workstation Hardware Lock
For precise operational governance without disrupting unaffected fleet nodes:
- **Targeted Workstation Hardware Lock**:
  - Administrators can select specific workstations from an enrolled fleet dropdown or type machine names with live autocomplete.
  - Adding a workstation immediately verifies its status against Active Directory inventory, network connectivity, assigned user, and client version.
- **Instant Persistence & Zero Input Interruption**:
  - Clicking **`💾 Save Rules`** pushes policies across the fleet with instant status feedback.
  - Form fields remain stable during periodic background fleet synchronization so operators can type and configure policies without resets.

#### E. Cloud Admin Console Policy Matrix & Interactive Simulator
Administrators managing policies through the Cloud Admin Console can preview and test all policy visual states:
- **Interactive Simulator**:
  - The live Admin Console includes a pixel-accurate Desktop Client Simulator.
  - Preview mode tabs allow administrators to toggle between **Live Computed Policy**, **Version Retirement**, **Workstation Quarantine**, **Domain Suspension**, **Global Lockout**, and **Access Restricted**.
- **Action Testing**:
  - Test simulated connectivity probes (`🔄 Check Connection Now`), unlock request workflows (`🔑 Request Unlock`), and domain authorization checks (`🔄 Verify Authorization`) directly in the browser before deploying policies fleet-wide.

#### F. Salted Master Security Key & Hash Push Targeting (Fleet-Wide, Domain Level, or Targeted Workstation)
To achieve strict zero-trust operational security, the deployment of emergency unlock passcodes and SHA-256 integrity verification hashes can be constrained by scope:
1. **Target Deployment Scope Options**:
   - **🌐 All Devices (Fleet-Wide)**: Deploys the active Master Security Key and integrity hash globally to all client endpoints across all enrolled networks and domains.
   - **🏢 Domain Level**: Restricts the Master Security Key exclusively to endpoints belonging to a specific Active Directory Domain (such as `SMS.LOCAL`). Passcode attempts from machines outside this domain are immediately rejected with an explicit scope authorization notice.
   - **💻 Single Workstation**: Locks the Master Security Key down to a single targeted workstation machine name (such as `WS-FINANCE-01`). Unlocks attempted on any other machine are blocked.
2. **Real-Time Deployment & Push Filtering**:
   - In the Cloud Admin Console Security & Policy Governance studio, administrators select the desired deployment scope before clicking **Push Key to Selected Scope**.
   - Connected desktop endpoints receive real-time push synchronization signals filtered by their machine identity and active domain membership.
   - Both online API validation and local offline authorization engines enforce the designated scope, guaranteeing that bypass authority cannot spread beyond its authorized operational boundary.

#### G. Starting the Cloud Admin Console Service Locally
To run and access the Cloud Admin Console web portal and governance gateway locally on your workstation:
1. **1-Click Startup Launcher**:
   - Double-click **`Start_Local_AdminConsole.bat`** located in the root repository folder (or `AdminConsole/Start_Server.bat`).
   - The launcher automatically verifies dependencies and starts the Node.js server on `http://localhost:3000`.
2. **Command Line Startup**:
   - Open PowerShell or Command Prompt, navigate to `AdminConsole\public_html`, and run `node server.js` (or `npm start`).
3. **Accessing the Console**:
   - Open your browser and navigate to **`http://localhost:3000`** to access the Fleet Pulse dashboard, IT Admins directory, and Security Policy Matrix.

---

### 30. Windows LAPS & Local Administrator Password Management Suite
Access by right-clicking any target computer -> **`🔑 LAPS Local Administrator Password...`** (located under `Security & Power Control ▸`).

- **Multi-Tier Architecture & Automatic Decryption**:
  - Automatically queries Active Directory for managed local administrator credentials across modern Windows LAPS (with native password encryption enabled or in plaintext mode) and legacy Microsoft LAPS deployments.
  - Transparently contacts the domain controller and decrypts protected credentials using enterprise administrative authorization rights, eliminating manual directory attribute lookups.
- **Local Administrator Account Identification**:
  - Displays the specific managed local administrator account name (such as `Administrator` or a customized local management account) alongside the detected security solution architecture.
- **Plain-Text Password Viewing & Clipboard Actions**:
  - Passwords are securely masked by default with bullet characters for privacy during screen sharing or helpdesk operations.
  - Click **`👁️ Show`** to reveal the password in clear text, or **`🙈 Hide`** to return to masked view.
  - Click **`📋 Copy Pass`** to copy the managed password directly to the Windows clipboard.
  - Click **`📋 Copy .\User`** to copy the managed username pre-formatted as `.\AccountName` (e.g. `.\Administrator`) for direct local logon without domain prefix conflicts.
  - Click **`📑 Copy All`** to copy the complete formatted credentials (username and password together) with a single click.
- **Real-Time Expiration Tracking & Countdown Badge**:
  - Displays the current password expiration timestamp alongside a live countdown badge (such as `⏱️ 29d 23h remaining` or `⚠️ EXPIRED`).
  - Displays the last time the password was generated or synchronized with Active Directory, along with the authorized security group allowed to decrypt credentials.
- **Custom Calendar Expiration Scheduling**:
  - Select an exact future expiration date using the integrated visual calendar date picker.
  - Use convenient quick preset buttons (**`+7d`**, **`+30d`**, **`+60d`**, **`+90d`**) to instantly advance expiration by common administrative intervals.
  - Click **`📅 Set Expiration Date`** to commit the updated expiration timestamp directly to Active Directory.
- **Instant Password Rotation ("Expire Now & Rotate")**:
  - Click **`⚡ Expire Now & Rotate`** to force an immediate credential refresh.
  - Sets the expiration timestamp to immediate in Active Directory and prompts the remote workstation to generate a fresh password and synchronize it back to the directory.
  - The dialog automatically reloads and displays the newly rotated credentials once the workstation reports back.
- **Instant Refresh & Troubleshooting Assistance**:
  - Click **`🔄 Refresh`** in the header at any time to re-query the domain controller for updated status.
  - If a computer lacks LAPS configuration or requires elevated decryption permissions, clear troubleshooting guidance outlines the exact policy and permission steps required.

---

### 31. Local Computer Users & Security Manager — Password Visibility, Policy Enforcement & Accurate Logging

Access by right-clicking any target computer → **`👤 Local Computer Users & Accounts Manager`** (located under `🔒 Security & Access Control ▸` or via the Fast Action search bar).

#### Showing & Copying Passwords in Create Local User & Reset Password Dialogs

- **Show / Hide Password Toggle**:
  - In both the **Create Local User** dialog and the **Reset Password** dialog, a **`👁️ Show`** button is displayed next to the password input field.
  - By default, the password is masked for privacy during screen sharing or over-the-shoulder situations.
  - Click **`👁️ Show`** to reveal the exact characters entered. The button label changes to **`🙈 Hide`**. Click again to return to masked view.
  - The toggle works seamlessly in both directions — switching between masked and visible views without losing the password value.

- **One-Click Copy to Clipboard**:
  - Click **`📋 Copy`** to place the current password directly onto the Windows clipboard.
  - Copy works regardless of whether the field is in masked or visible mode — the actual password value is always copied.
  - Use this to paste the password into a credential manager, a secure note, or a remote session window without retyping.

#### Live Password Policy Banner (Create Local User)

- When the **Create Local User** dialog opens, the application automatically queries the active password security policy from the target workstation in the background.
- A live banner is displayed below the password fields showing the detected requirements, for example:
  - `🔒 Password policy on WS-FINANCE-01: minimum 8 characters; uppercase + lowercase + number + symbol required.`
  - `🔒 No strict password policy detected on WS-RECEPTION-02.`
- If the policy cannot be read (for example, due to limited permissions), the banner notes this and the creation attempt proceeds normally.

#### Password Policy Pre-Validation Before Creating an Account

- Before submitting a new account creation, the application automatically validates the entered password against the detected policy:
  - **Minimum Length**: If the password is shorter than the required minimum, a clear warning dialog displays the exact requirement (e.g. "The minimum required length is 8 characters"). The creation attempt is cancelled and the administrator can correct the password without any network call being made.
  - **Complexity Requirements**: If complexity is enforced, the password must contain characters from at least 3 of the following 4 categories: uppercase letters, lowercase letters, numbers, and symbols. If the entered password falls short, a dialog lists exactly which categories are missing and how many are satisfied.
- These checks happen instantly, before any account creation is attempted on the remote workstation — preventing confusing failure states and wasted time.

#### Accurate Activity Logging

- The Activity Log now accurately reflects the **actual outcome** of every local account operation:
  - **`[SUCCESS]`**: Recorded only after the account is verified to exist on the target workstation following creation.
  - **`[FAILED]`**: Recorded with the actual rejection reason returned by Windows (such as policy violation, duplicate account, or access denied).
  - **`[REJECTED]`**: Recorded when the application's own pre-validation check blocks the submission due to an identified policy violation, before any network call is made.
- Password reset operations record the precise method used (direct or fallback) and the actual Windows error message on failure.

#### Secure User Deletion & Safeguards

- **Safeguard Confirmation Window**:
  - Selecting any local user and clicking **`🗑️ Delete User`** (or right-clicking the user in the list) opens a high-security deletion dialog.
  - Displays the full account details (Username, Full Name, Account Type, Group Memberships, and Security Identifier) accompanied by a prominent warning banner:
    ```text
    Are you sure you want to delete this user?
    Once deleted, the user account cannot be restored.
    ```
  - **Multi-Factor Administrative Confirmation**:
    - Requires the IT Administrator to enter their administrative account password.
    - Requires typing `DELETE` into the confirmation field before the final deletion action is enabled.
- **Built-in System Account Protection**:
  - The application automatically detects and shields essential system accounts (such as built-in Administrator, Guest, DefaultAccount, and the currently authenticated operator session).
  - Deletion attempts on protected accounts are blocked immediately with a descriptive advisory notice to prevent workstation lockout.

---

### 32. Remote System Restore Point Manager — Checkpoints & System Rollback

Access by right-clicking any target computer → **`⏱️ Remote System Restore Manager...`** (located under `Customization, Automation & Deployment ▸` and `Diagnostics & Health ▸` or via the Fast Action search bar).

- **System Protection Status & Remote Toggle**:
  - Automatically queries whether System Restore protection is enabled on the target workstation's system drive (`C:\`).
  - Allows administrators to enable or disable System Restore protection remotely with a single click.
- **On-Demand Restore Point Creation**:
  - Click **`➕ Create Restore Point`** to stage an immediate system checkpoint before performing software installations, driver upgrades, or configuration adjustments.
  - Allows entering a custom description (e.g., *"Pre-Upgrade Backup - ERP Client"*).
- **Chronological Checkpoint History**:
  - Lists all available restore points in a clear DataGrid with Sequence Number, Description, Creation Date & Time, and Event Type.
- **Remote Rollback & Recovery**:
  - Select any previous restore point and click **`⏪ Restore to Selected Point`**.
  - Prompts with a confirmation dialog warning that the target machine will restart automatically to complete the restoration.
  - Enables recovery of misconfigured or non-booting remote endpoints without dispatching on-site support technicians.

---

### 33. Master Mode — Fleet Gateway API & Cloud Settings

Access by pressing **`Ctrl + Shift + Alt + F12`** and entering the master administrator authorization passcode.

- **Dedicated API Settings Management**:
  - The Master Administration action button is clearly labeled **`⚙️ API Settings`** with an intuitive gear icon.
  - Configures the central cloud telemetry gateway endpoint, synchronization addresses, heartbeat frequencies, and cloud policy integration.
- **Cloud Gateway Health & Connectivity Status**:
  - Inspects real-time connection status with the enterprise Cloud Admin Console.
  - Displays currently active encryption certificates, API keys, and synchronization latency.

---

### 34. Comprehensive Installed Software Inventory Discovery

Click **`📦 Software`** on the toolbar or right-click any computer → **`📦 Installed Software & Silent Uninstaller`**.

- **Multi-Architecture 64-Bit & 32-Bit Deep Scan**:
  - Thoroughly inspects both 64-bit and 32-bit software registries across the entire operating system.
  - Scans user-specific application directories across all loaded profiles to uncover per-user installations (such as web browsers, desktop communication apps, and user-space utilities).
- **Automated Fallback Discovery**:
  - If standard software registry entries are missing or customized, the engine initiates automated secondary discovery to ensure zero business applications are missed.
- **Silent Remote Uninstallation**:
  - Supports silent uninstallation with one click, automatically parsing uninstall commands to execute silently without user disruption.

---

### 35. Remote Group Policy Refresh Architecture

Access via the toolbar **`🔄 GPUpdate`** button or the right-click menu.

- **Guaranteed Remote Target Execution**:
  - The group policy update engine guarantees that refresh commands execute strictly on the remote target endpoint rather than the administrator's local machine.
- **Progress Reporting & Event Verification**:
  - Displays real-time progress indicators while group policies are being evaluated and applied on the target machine.
  - Provides instant status reports and direct links to inspect the remote machine's event log to verify that user and computer policies applied successfully.

---

### 36. New Administrative Tools & Diagnostics (v2.7.0 Coming Soon)

#### A. Remote Shadow Session Disconnect Notification
- **End-of-Support User Confirmation**:
  - When an administrator terminates an interactive screen shadowing session where user notification or permission was active, the remote computer displays an on-screen notice: "IT Support Helpdesk remote support session has ended."
  - Provides clear assurance to the end user that the remote assistance session is concluded, remote viewing has ended, and their desktop and input controls are fully private.

#### B. Real-Time Remote Printer Queue Monitor with Smart Switching
- **Live Print Job Polling**:
  - The Remote Printers & Print Queue Manager automatically streams live print job changes for the selected printer every 2 seconds without requiring manual refresh clicks.
- **Low-Overhead Device Switching**:
  - Selecting any printer instantly redirects the live queue inspector with zero UI latency and without loading heavy remote system event logs.

#### C. Scheduled Remote Power Operations (Reboot, Shutdown, Log Off, Lock)
- **Interactive Date/Time Task Scheduling**:
  - Available under the Security & Power Control menu for single workstations and bulk computer selections.
  - Allows administrators to select an exact execution date and time using calendar and clock pickers, configure an optional countdown warning message for active users, view currently scheduled power jobs, and cancel pending actions in a single click.

#### D. Remote Screen Saver & Desktop Wallpaper Central Manager
- **Centralized Lockout & Branding Control**:
  - Provides centralized Remote Screen Saver configuration alongside bulk Wallpaper management, accessible via the context menu and a dedicated top toolbar button.
  - IT administrators can remotely enable or disable the Windows screen saver, customize inactivity timeout durations, enforce password lockout upon resume, and deploy branded desktop backgrounds across single or multiple computers with detailed delivery reports.

#### E. Remote Windows Server Task Manager Disk Performance Counters
- **One-Click Disk Counter Activation**:
  - Located under the Administration context menu.
  - Activates built-in Task Manager disk throughput metrics and refreshes performance libraries on remote Windows Server systems where disk counters are disabled by default out-of-the-box.

#### F. Active Directory Domain Controller & DNS Server Troubleshooting
- **Dedicated Identity & Name Resolution Diagnostics**:
  - A specialized troubleshooting submenu automatically appears when selecting Domain Controllers or DNS servers.
  - Provides 1-click actions to restart the DNS Server service, restart the DNS Client resolver cache, clear the client DNS cache, test external DNS reachability (pinging 8.8.8.8), and perform custom DNS name lookups with real-time diagnostic output.

#### G. Modal On-Screen Message Delivery & Acknowledgement Tracker
- **Real-Time Read Receipts & Acknowledgement Audit**:
  - When broadcasting urgent modal messages, the system launches an interactive delivery and user acknowledgement dashboard.
  - Monitors each target computer in real time, displaying the logged-in username, delivery status, and exact timestamp when each user clicks "OK" to acknowledge the message.
  - When all recipients have confirmed, a completion banner displays: "The message has been acknowledged by everyone."

#### H. Real-Time Performance Monitor High-Density Deep History
- **Full-Window Canvas Expansion & 10-Minute Historical Buffers**:
  - Upgraded the Live Performance & Hardware Monitor with a 600-sample historical rolling buffer.
  - Clicking any metric chart (CPU, RAM, Network, Disk) maximizes it across the entire window width, dynamically adjusting time resolution to show up to 10 minutes of deep rolling telemetry with an informative duration header.
  - Clicking again returns smoothly to the standard 4-quadrant layout.

#### I. Inactivity & Presence Monitoring Agent Health & Diagnostics
- **Four-Tier Deployment & Telemetry Verification**:
  - Located under the Diagnostics & Health context menu as "Check Inactivity Agent Status & Diagnostics...".
  - Instantly verifies the endpoint's background activity monitoring module using a rigorous four-state diagnostic model: "Installed & Active", "Installed but Not Active / Not Reporting", "Not Installed", and "Unknown / Unable to Detect".
  - Inspects background system service registration, live process activity, binary filesystem integrity, and telemetry heartbeat freshness, with one-click actions to start services, deploy, or reinstall the agent.
- **Benefit**:
  - Eliminates guesswork when an endpoint displays idle status or lacks recent telemetry, giving sysadmins immediate clarity on whether the monitoring module is functioning, stopped, uninstalled, or unreachable due to network permissions.

#### J. Network Printer Supplies & Ink/Toner Level Telemetry
- **Standardized Device Marker Telemetry**:
  - Integrated into the Remote Printers & Print Queue Manager interface.
  - Queries network-connected printers for consumable levels (ink cartridges, toner cartridges, and drum units) via standard hardware management protocols.
  - Displays color-coded consumable health gauges (Green for healthy, Amber for low supplies, Red for critical) alongside descriptive supply status.
  - For local virtual printers, software print engines, or unsupported hardware, the interface cleanly displays "Not Available / Unsupported".
- **Benefit**:
  - Enables proactive replenishment of enterprise printing supplies before print queues stall and prevents unnecessary helpdesk dispatches to investigate empty toner cartridges.


