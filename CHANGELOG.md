# 📜 Windows AD Remote Administration Control Center - Version History & Changelog
**Created & Developed by [Askarali Mattummal](https://www.linkedin.com/in/askaralimattummal/)**

All notable changes and upgrades to **Windows AD Remote Administration Control Center** are documented in this file.

## 🏷️ Version 2.7.0 (Coming Soon — In Active Development & Testing)

> [!NOTE]
> **Release Status Notice**: The latest officially released public version of this suite is **Version 2.6.5**. Version 2.7.0 is currently in active development and testing (If you have any idea and suggessions please send me will try to add on the next update). The features, enhancements, and upgrades below are **Coming Soon** in the upcoming v2.7.0 release.

---

### 🌟 New Features (Introduced in v2.7.0 - Coming Soon)

#### 🖥️ Desktop Info HUD (Sysinternals BgInfo Wallpaper Engine & Floating Companion Widget)
* **Classic Sysinternals BgInfo Direct-Wallpaper Stamping**:
  - Directly stamps live system telemetry onto the active desktop wallpaper without intrusive frames, dark boxes, or border lines (matching classic Sysinternals BgInfo layout).
  - Clean two-column layout: Left column features bold sky-blue telemetry labels (`Hostname:`, `IP Address:`, `Logged User:`, `Operating System:`, `Processor:`, `Memory:`, `System Disk:`, etc.), while the right column displays live values in crisp white.
  - Composited with high-contrast drop shadows ensuring 100% legibility on any desktop wallpaper image.
* **Flexible 3-Way Deployment Target Mode**:
  1. `Wallpaper Overlay Only (Direct on Desktop Wallpaper - No popup window)` *(Default)*: Directly composites telemetry into the wallpaper with zero desktop popup windows.
  2. `Floating HUD Widget Only (Interactive Companion Window)`: Displays a sleek, translucent floating on-screen widget without altering desktop wallpaper.
  3. `Both (Wallpaper Overlay + Floating Companion Widget)`: Stamps the wallpaper and launches the floating companion widget simultaneously.
* **Dynamic Active User Profile Discovery**:
  - Automatically discovers the active interactive user's profile directory on disk, ensuring wallpaper changes and telemetry overlays apply accurately across all user sessions and remote RDP connections.
* **1-Click Pristine Wallpaper Backup & Restore**:
  - Automatically captures and backs up the original desktop wallpaper before first overlay.
  - Clicking **`↩️ Restore Original Wallpaper`** restores the pristine original wallpaper and triggers an immediate desktop refresh without requiring user sign-out.
* **Theme-Accurate High-Contrast Live Preview**:
  - In-dialog live preview with exact theme label colors (Emerald, Matrix Green, Sky Blue, Gold, Red) and contrasting values.
  - Enhanced preview contrast across both Dark Mode and Light Mode.
* **Clean Unicode Companion Widget**:
  - Ensures clean typography and visual rendering in the floating companion widget with sub-2-second remote execution turnaround.

#### 👑 Windows God Mode & Enterprise System Power Tweaks Controller
* **Remote Windows Master Control Panel (God Mode) Management**:
  - Centralizes over 200+ operating system control applets, administrative tools, troubleshooting wizards, and advanced hardware configurations in a unified Master Control Panel.
  - **Public Desktop Shortcut Deployment**: Automatically creates or deletes the special God Mode folder shortcut on `C:\Users\Public\Desktop`, making it instantly accessible to every user logged into the target computer.
  - **Native Desktop Context Menu Integration**: Injects or removes *"Windows God Mode (Master Control Panel)"* directly into the desktop background right-click menu with the official control panel icon.
  - **1-Click Live Session Launch**: Opens the full Master Control Panel window directly on the remote user's physical or RDP display session using verified session dispatching.
* **Curated Enterprise Power Tweaks**:
  - **"Take Ownership" Context Menu Injector**: Injects a 1-click "Take Ownership" right-click shortcut into Explorer context menus, enabling technicians to instantly reclaim administrative permissions on locked or corrupted folders.
  - **Classic Windows 11 Context Menu Restorer**: Bypasses the Windows 11 "Show more options" restriction and restores the full classic Windows 10 right-click menu.
  - **"Ultimate Performance" Power Plan Activator**: Unlocks and activates the hidden Windows Ultimate Performance power scheme for zero-latency CPU and GPU throughput on engineering and CAD workstations.
  - **CompactOS Storage Compressor**: Enables Windows CompactOS system binary compression, freeing **3 to 5 GB of disk space** on small system drives without performance penalty.
  - **Disable Windows Consumer Bloatware & Recommendations**: Disables automatic background installation of promotional consumer apps and sponsored suggestions.
  - **Always Show File Extensions & Hidden Files**: Configures Windows Explorer to always display file extensions and hidden files for immediate administrative transparency.
  - **Disable Diagnostic Telemetry**: Suppresses Windows background telemetry collection for strict enterprise privacy and compliance.
  - **1-Click Enable Remote Desktop (RDP)**: Remotely activates Remote Desktop, Network Level Authentication (NLA), and Windows Firewall rules in one operation.
  - **Disable Bing Web Search**: Disables web search results and suggestions from appearing in the Windows Start Menu.
* **Asynchronous Detection & Bulk Operations**:
  - Real-time status detection with visual badge indicators (`🟢 God Mode: Active` or `⚪ God Mode: Inactive`).
  - Supports single-machine configuration and concurrent bulk application across multiple selected Active Directory endpoints.
  - 1-Click clean reversal to remove or restore tweaks.

#### 🚀 Dedicated Quick Assist Remote Assistance Button & Local Offline Fluent Icon
* **Dedicated Bottom Action Toolbar Button**: Features a prominent **Quick Assist** action button positioned strategically in the bottom primary connection bar immediately after **⚡ Connect Shadow Session** and before **🖥️ Connect RDP Session**.
* **Instant 1-Click Launch**: Launches Microsoft Quick Assist with a single click, eliminating the need for technicians or remote users to memorize keyboard shortcuts (`Ctrl + Win + Q`).
* **Offline Fluent Icon**: Includes the official Microsoft Fluent Quick Assist icon embedded locally as an offline resource, ensuring 100% visual fidelity in air-gapped domain networks.
* **Automatic Fallback Discovery**: Automatically resolves standard system executables and modern Windows Store package locations with clear diagnostic feedback.

#### ⏱️ Inactivity & Presence Monitor — Native Windows System Service & Top Bulk Actions Controller
* **Native Windows System Service Architecture**:
  - Installed in the core Windows system-managed directory (`%SystemRoot%\System32\ADRemoteControl\ADRC_IdleAgent.exe` with runtime state in `%ProgramData%\ADRemoteControl\idle.json`).
  - Operates as an automatic native Windows System Service (`ADRC_IdleMonitor`) running under `SYSTEM` credentials.
  - **Starts Automatically with Windows at System Boot**: Begins monitoring the workstation during OS startup before any user logs in.
* **Continuous 24/7 Workstation State & Lifecycle Tracking**:
  - **Before Any User Logs In / Windows Login Screen**: Detects the absence of an interactive user and records state as `"At Windows Login Screen"` (`🚪 Logged Off`).
  - **User Login & Session Initialization**: Detects user logon and automatically tracks the authenticated username and interactive session ID.
  - **Interactive User Input & Idle Monitoring**: Accurately measures user idle time from keyboard and mouse activity, displaying `🟢 Active` (`< 5m`) or `💤 Idle (...)` with smart human-readable duration formatting (e.g. `13m`, `1h 30m`, `15h 16m`).
  - **Workstation Lock Screen**: Detects display lock states, instantly updating the status to `🔒 Locked (...)` with human-readable lock duration (e.g. `18m`, `1h 30m`, `17h`, `1d 4h`, `1mo 2d`).
  - **Fast User Switching & Multiple Users**: Detects session disconnects, reconnects, and user switches across multiple local and remote sessions.
  - **User Logout**: Detects session termination and immediately resets the state back to `"At Windows Login Screen"` (`🚪 Logged Off`).
  - **System Shutdown / Restart**: Receives OS shutdown notifications, marking state as `"Offline / Shutting Down"`.
* **Top Bulk Actions Controller**:
  - Clean, compact button in the top Bulk Actions bar (`⏱️ Idle Agent` / `Install Monitor` / `Retry Monitor` / `Remove Monitor`).
  - **Parallel Mass Deployment**: Remotely deploys the monitoring service, secures file permissions, and starts the service across all selected (or listed) domain computers in parallel.
  - **Intelligent Skip Logic**: Automatically inspects endpoints prior to deployment, skipping computers where the monitoring agent is already active. Eliminates redundant network traffic and disk operations.
  - **Targeted Retry Capability**: If any machines fail or are unreachable (e.g. offline during initial deployment), subsequent clicks automatically isolate and retry only the unapplied or failed endpoints.
  - **Dynamic State Toggle**: When 100% of listed computers have the agent successfully active, the button dynamically updates its label to **`Remove Monitor`**, allowing 1-click bulk removal.
  - **Exhaustive Diagnostic Audit Logging**: Generates itemized, structured audit log entries in the Activity Log for every single target machine with actionable status prefixes (`[SUCCESS]`, `[SKIPPED]`, `[NO ACCESS]`, `[OFFLINE]`, `[FAILED]`, `[ERROR]`).
  - **Rich Interactive Tooltip**: Hovering over the button displays a detailed explanation of the agent's operational benefits, presence states, and privacy-preserving design.
* **Enterprise Security Hardening & Tamper Protection**:
  - **Hidden from Standard Software Inventories**: Deployed natively without registering in standard uninstall registry keys; does not appear in Windows Settings > Installed Apps or Control Panel Programs and Features.
  - **File System Lockdown**: Installed with strict administrative-only permissions; standard users are restricted to read-and-execute only and cannot delete, overwrite, rename, or tamper with files.
  - **Eliminated from Task Manager Startup Apps**: Managed purely as a native Windows System Service, completely eliminating any trace in Task Manager's Startup Apps tab.
  - **Process Tamper Protection**: The running agent process is protected by Windows security controls, preventing non-administrative users from ending the task in Task Manager (access denied).
  - **Centralized IT Control**: Complete installation, health monitoring, updates, and removal remain strictly under the control of authorized Domain Administrators via this application suite.

#### ⏱️ Dedicated Live Uptime Column & Intelligent Duration Formatting
* **Intelligent Duration Formatting**:
  - Automatically scales duration strings into compact, clean, lowercase human-readable units (`m`, `h m` / `h`, `d h` / `d`, `mo d` / `mo`):
    - **Under 1 hour**: Displayed cleanly as minutes (e.g. `8m`, `13m`, `59m`).
    - **1 to 24 hours**: Decomposed into hours and minutes (e.g. `1h 30m`, `15h 16m`, `17h`).
    - **1 to 30 days**: Decomposed into days and remaining hours (e.g. `1d 4h`, `3d 12h`, `7d`).
    - **30+ days (1 month+)**: Decomposed into months and remaining days (e.g. `1mo 2d`, `2mo 15d`).
  - Completely eliminates confusing long raw minute strings (e.g. `Idle (916m)` -> `Idle (15h 16m)`, `Locked (1020m)` -> `Locked (17h)`).
* **Dedicated Live Uptime DataGrid Column**:
  - Added a dedicated **Uptime** column in the main inventory table positioned between **Logon Time** and **Operating System**.
  - Shows real-time endpoint system uptime formatted using the human-readable engine (e.g. `⏱️ 3d 12h`, `⏱️ 18d 6h`, `⏱️ 1mo 5d`).
  - **Color-Coded Health Thresholds**: Healthy uptime displays in vibrant green (`#10B981`); long-running systems exceeding 30 days display an amber notice (`#F59E0B`) signaling an overdue restart.
  - **1-Click Numerical Sorting**: Enables instant numerical ascending/descending sorting by total uptime duration across all endpoints.
  - **Interactive Boot Timestamp Tooltip**: Hovering over the uptime cell reveals the exact workstation last boot date and time (`Last Boot: yyyy-MM-dd HH:mm`).

#### 🔄 1-Minute Lightweight Silent Background Refresh Engine
* **Automated Background Telemetry Refresh**: Built-in background scanner runs automatically every **1 minute** to guarantee that live computer telemetry remains fresh and accurate.
* **Atomic Concurrency Guard**: Thread-safe lock prevents new scans from overlapping or colliding if a previous scan cycle is still completing.
* **Ultra-Fast Non-Intrusive Probes**: Operates with accelerated timeouts and lightweight connection checks on dedicated background worker threads, eliminating UI freezing and network saturation.
* **Silent Telemetry Updates**: Automatically refreshes Online/Offline status, ping latency, Logged-in User, Active/Idle presence states (`🟢 Active`, `💤 Idle (1h 30m)`, `🔒 Locked (15h 16m)`, `🚪 Logged Off`, `🔴 Offline`), and Idle Agent presence without resetting the operator's current row selection, without clearing the grid, and without overwriting transient user status notifications.

#### ⚡ Hybrid Cold Startup, Fast TSV Cache & Multi-Stage Splash Screen
* **High-Speed TSV Cache Engine**: Computers and dynamic telemetry are serialized to a lightweight cache file, loading all domain computer objects in under a millisecond with zero risk of parsing errors.
* **Full Dynamic Telemetry Persistence**: Live Status (`Online / Offline`), Status Colors, IP Addresses, Logged-in Users, and Logon Times are automatically saved to cache upon scan completion, eliminating initial checking placeholders on subsequent launches.
* **Multi-Stage Enterprise Splash Screen**: Features a polished, frameless dark card with progress tracking and a smooth fade-out transition that reveals the workspace fully hydrated with live green/red statuses and real user names.
* **Non-Blocking Background AD Synchronization**: Active Directory computer enumeration runs asynchronously in the background. Discovered domain computers are smoothly merged into memory without clearing the grid or interrupting user workflow.
* **Administrative Session Caching & Batch Group Resolution**: Eliminates cold-start delays by caching verified domain admin session credentials and batch-resolving security group names in a single call.

#### 📶 Remote ICMP Echo & Windows Defender Firewall Policy Engine
* **Remote Inbound Echo Request Rule Configuration**:
  - Remotely configures Windows Defender Firewall inbound ICMP Echo Request rules across both IPv4 and IPv6 without logging into client machines.
  - Automatically verifies connectivity with an immediate live ping, dynamically updating host status in the main table from `Online (ICMP Disabled)` to `Online (Xms)`.
  - Accessible via the right-click context menu (`🌐 Network & Firewall` -> `📶 Enable Remote ICMP Ping Echo...`) and the Remote Network Configuration Manager.

#### 🖥️ Dual Computer & User OU Column
* **Dedicated Organizational Unit Column**:
  - Main computers table features a dedicated `OU (Computer / User)` column displaying both Computer OU and logged-in User OU with distinct visual indicators (`🖥️` Computer OU in Sky Blue, `👤` User OU in Purple).
  - Column widths optimized to prevent text clipping across display resolutions.

---

### 🔄 Updated & Enhanced Features (Upgraded from v2.6.5 - Coming Soon)

#### 🖨️ Remote Printers & Print Queue Infrastructure Manager (Upgraded)
* **What was updated**:
  - **Modern In-Window Loading Progress Splash**: Centered translucent card featuring live connection telemetry, animated progress bar, and active host status that smoothly transitions upon completion of background data loading.
  - **Parallel Background Query Engine**: Concurrently queries installed printer drivers, port configurations, and print spooler queues via parallel background threads, cutting remote query latency by over 50%.
  - **Live Queued Jobs Column & Queue Isolation**: Dynamically cross-references active spooler jobs against print queue history. Idle printers cleanly display `0` rather than confusing historical completed event logs. Active documents waiting or spooling are highlighted dynamically with `⚠️ {N} Pending`. Selecting any printer automatically isolates its active queue and completed document log in the lower pane.
  - **Add Remote Shared Printers**: Administrators can now remotely connect network and shared print queues to target endpoints via UNC path (`\\PrintServer\ShareName`) with automatic fallback to native Windows printer tools.
  - **Complete Remote Printer Removal**: Full remote deletion for network, USB, virtual, and PDF printers.
  - **Domain Print Server Test Print Routing**: Intelligently detects domain shared printers (`\\PrintServer\PrinterShare`) and routes test page submissions through the authoritative print server host.
  - **Printer Properties & Metadata Dialog**: View driver, port, type, status, and edit location comments and default printer status on the remote computer.
  - **Spooler Pause / Resume Controls**: Remotely pause or resume individual printer queues directly from the toolbar.
  - **Visual Stability Improvement**: Fixed an interface re-attachment issue to ensure the Printers window opens smoothly and reliably every time without display errors.
* **Benefit**: Dramatically faster printer enumeration, instant identification of stuck print jobs, and full remote printer lifecycle administration without opening Print Management consoles.

#### 👤 Profile Card: Active Directory Group Membership Management (Upgraded)
* **What was updated**:
  - The "Member of Groups" tab now features an interactive action toolbar with `➕ Add to Group`, `➖ Remove from Group`, and `🔄 Refresh Groups`.
  - Built-in Primary Group security safeguards prevent accidental attempts to delete mandatory primary groups (e.g. `Domain Users`).
  - Clear diagnostic feedback if permission constraints or domain errors occur.
  - Eliminated hover flashing on tab navigation buttons, providing seamless visual feedback across both Dark and Light themes.
* **Benefit**: Modifying user group memberships takes seconds directly from the Profile Card without switching to Active Directory Users & Computers.

#### 💬 Advanced User Messaging Hub (Upgraded)
* **What was updated**:
  - **Strict Character Limit Enforcement & Over-Limit Warnings**: Distinct character limits enforced per message style: Popup OK Modal (Max 238 chars total), Toast Banner Title Mode (Max 123/200 chars), Toast Banner XL Mode (Max 59 chars), Toast Banner Subtitle Mode (Max 191/290 chars). When strict limit is unchecked, any excess text immediately triggers bold red warning alerts and a red border glow on the input field.
  - **Contextual Large Font Option**: The large font option is contextually displayed only when supported by the active message mode, preventing invalid formatting states.
  - **Vivid Visual Cards & Badges**: Modal Popup Card features an amber glowing badge with chat icon, and Action Center Toast Card features a sky blue glowing badge with slide-in indicator. Dropdown options feature vibrant color-coded pills: Info (Sky Blue), Warning (Amber Gold), Urgent (Crimson Alarm Red), Maintenance (Purple), Support (Emerald Green), and Security (Coral Orange).
  - **Complete Light Mode & Dark Mode Support**: The dialog interface automatically adapts backgrounds, card borders, text boxes, and contrast styling to the active theme preference.
  - **Responsive Dialog Design**: Expanded layout providing ample breathing room for preview cards, non-clipping badges, and full-width dropdown options displaying completely without trailing ellipsis truncation.
* **Benefit**: Guarantees messages fit cleanly on recipient displays without text clipping, clearly signals alert urgency, and ensures comfortable reading in any environment.

#### 🎨 Bottom Administration Toolbar (Streamlined to 2 Lines)
* **What was updated**:
  - Re-architected the previous 4-row bottom toolbar into 2 clean, dedicated rows:
    - **Line 1 (`🛠️ Tools`)**: Administrative and diagnostic tools (`💻 Console`, `💻 Specs`, `📊 Task Mgr`, `⚙️ Services`, `📦 Software`, `🚀 Startup`, `📋 Events`, `🖨️ Printers`, `📈 Live Perf`, `🌐 IP Config`, `💬 Message`).
    - **Line 2 (`📁 Folders & 👤 Profile`)**: Folder shortcuts (`💾 Open C$/`, `🖥️ Desktop`, `📥 Downloads`, `📄 Documents`, `🗄️ Net Drives`) and user identity tools (`👤 Profile Card`, `👥 Local Users`, `🔓 Unlock User`, `🔑 Reset Pass`).
  - Power and maintenance actions (Temp Clean, WOL, Lock, Logoff, Reboot, Shutdown) were consolidated into the right-click context menu under `⚡ Security, Clean & Power Options`.
* **Benefit**: Frees up substantial vertical screen space for the computer inventory table, providing a cleaner, more spacious administrative view.

#### 🌲 Hierarchical Right-Click Context Menu (Reorganized)
* **What was updated**:
  - Re-architected the flat 28-item right-click context menu into structured, intuitive submenus: Top-Level Quick Actions (`⚡ Shadow Session`, `🖥️ Remote Desktop`, `💻 Remote Console Terminal`), `📊 Diagnostics & Performance ▸`, `⚙️ Administration & Management ▸`, `🌐 Network & Firewall ▸`, `📁 Files & Shared Folders ▸`, `👤 Active Directory & User Session ▸`, `🛠️ Remote Maintenance & Automation ▸`, `🔒 Security & Power Options ▸`, and Export Inventory.
  - Streamlined long menu item names and removed redundant entries.
* **Benefit**: Eliminates menu scrolling completely across all display resolutions, allowing technicians to reach any administrative action in one swift mouse gesture.

#### 🌐 Remote Browser URL Launcher (Enhanced)
* **What was updated**:
  - Corrected execution command formatting to ensure web addresses open reliably across the default system browser, Microsoft Edge, and Google Chrome within the remote user's interactive session.
* **Benefit**: Smoothly launches web applications, intranet portals, and troubleshooting links on remote computers without command errors.

#### 📝 In-App Active Directory Computer Description Manager (Upgraded)
* **What was updated**:
  - Added `📝 Set Computer Description (Active Directory)...` in the right-click menu under Administration & Management.
  - Allows administrators to view and update any computer object's Active Directory description attribute directly from the console, instantly updating the table in real time.
* **Benefit**: Fast, direct updating of computer descriptions without opening Active Directory Users & Computers.

#### 🛡️ Performance, Stability & Resource Management Overhaul
* **What was updated**:
  - **Memory & Resource Management**: Enhanced background query disposal to prevent memory buildup and handle leaks during long monitoring sessions.
  - **Software Inventory Stability**: Stabilized registry access during remote software audits to prevent connection drops and ensure complete application inventories.
  - **Accelerated Startup Apps Loading**: Reused active remote connections to load startup applications across all user profiles significantly faster.
  - **Comprehensive Audit Logging**: Expanded structured audit logging for process launches, computer renames, reboots, and autorun changes.

#### ⚡ Administrative Dialog Usability & Safety Guards
* **What was updated**:
  - Added instant keyboard **Enter** key detection in administrative dialogs (such as Rename Computer and Enable ICMP Echo) to trigger execution immediately.
  - Automatically pre-populates the current domain and username in credentials fields.
  - Added progress lock guarding during computer rename operations to prevent accidental double-clicks or interruptions while renaming is in progress.
  - Eliminated corrupted characters from Win32 dialogs and messages with clean unicode formatting.
* **Benefit**: Accelerates daily administrative workflows and prevents input errors.

## 🏷️ Version 2.6.5 (Suite Rebranding, Periodic Background Auto-Updater & Mode B Notification Edition) - September 12, 2026

### 🏛️ Suite Rebranding to "Windows AD Remote Administration Control Center"
* **Official Application Renaming**:
  - Rebranded the entire suite to **Windows AD Remote Administration Control Center** across all user interfaces, window headers, status indicators, and embedded operator manuals.
  - Updated domain administration automation scripts (`Configure_Endpoint_GPO.ps1`) to align with the suite identity.

### 🌐 Official GitHub Repository Migration
* **New Canonical Repository URL**:
  - Migrated the project's upstream Git repository to `https://github.com/SuperUser-exe/Windows-Active-Directory-Remote-Administration-Control-Center`.
  - Updated in-app auto-updater endpoints, README documentation, release badges, license attribution, and community discussion links.

### 🚀 Periodic Background Update Polling & Mode B Non-Intrusive Alerts
* **Automated Background Update Verification**:
  - Implemented automated background polling that periodically queries the official GitHub repository for new releases while the management console remains open.
  - Eliminates the need for administrators to manually check for updates or restart long-running monitoring sessions.
* **Mode B Focus-Safe Emerald Notification System**:
  - When an update is detected during background polling, the header button automatically transitions into a radiant emerald green badge (`🚀 vX.X.X Available!`).
  - Plays a gentle, non-blocking system audio chime and updates the bottom status bar (`💡 New Update Available: vX.X.X - Click '🚀 vX.X.X Available!' to install`).
  - **Zero Focus Stealing**: Never interrupts active remote shadowing, typing, or administrative PowerShell console workflows with disruptive modal popups.
* **Instant Pre-Cached Release Opener**:
  - Clicking the emerald alert button immediately launches the update dialog with zero network latency, reading pre-cached release notes and assets without re-querying the GitHub API.

## 🏷️ Version 2.6.0 (Remote User Management, Sub-Second Live Monitor & Network IP Hub Edition) - September 7, 2026

### 🚀 Remote Startup Applications & Autorun Manager (`🚀 Startup`)
* **Remote Auto-Start Application Discovery**:
  - Remotely queries all configured startup entries across All Users, specific user profiles, and Startup folders.
* **Dynamic Enable / Disable Toggling**:
  - Remotely configures Windows startup settings to toggle applications between Enabled and Disabled without deleting user entries, syncing perfectly with Windows Task Manager.
* **Full Autorun Control Center**:
  - High-contrast dark theme DataGrid displaying Status (`🟢 Enabled` / `⚪ Disabled`), Application Name, Executable / Command line, Scope / User, and Registry Location.
  - Live search filtering, CSV export, right-click context menu (`🟢 Enable`, `⚪ Disable`, `🗑️ Delete Entry`), and double-click to toggle state.
  - Accessible via top toolbar button (`🚀 Startup`) and right-click computer context menu (`🚀 Remote Startup Applications (Autorun Manager)`).

* **Integrated GitHub Release Checker & 1-Click Updater**:
  - Automatically queries official GitHub releases 4 seconds after initial launch.
  - In-dialog release notes viewer with direct 1-click in-place updater script.
  - Silent fallback and graceful offline support when working in air-gapped enterprise domains.

* **Compact & Scrollable Context Menu (`Right-Click Menu`)**:
  - Engineered a compact context menu layout with crisp icons, clean typography, and a smooth scrolling container preventing overflow on low or high-DPI displays.
* **Thread-Safe UI Rendering**:
  - Resolved an off-thread binding issue in the Local Users Manager to ensure fast, glitch-free data display.
* **Global Application Crash Guard & Diagnostic Logging**:
  - Intercepts interface exceptions, logging diagnostic details to `AD_Remote_Control.log` and notifying the administrator without terminating the application.
* **Remote Workstation Lock & Unlock Controller Enhancements**:
  - **Dynamic State-Aware Button Activation**: When a workstation is locked, the "Lock Screen" action is automatically disabled and badged as "(Already Locked)", while "Reconnect Console Session" and "Unlock Session with Password" become active. When unlocked, lock actions are enabled and unlock actions are disabled.
  - **Dual-Engine Remote Lock Execution**: Primary attempt via Terminal Services session disconnect, with automated remote execution fallback.
  - **Dual-Engine Remote Unlock Execution**: Executes session reconnect directly on the target host with full standard output and error redirection.
  - **In-Dialog Real-Time Diagnostic Console**: Added an embedded live diagnostic console in the controller dialog streaming timestamped steps, exit codes, and output directly to the user and log.

### 👥 Local Computer Users & Accounts Manager (`👥 Local Users`)
* **Remote Local User Discovery & Management Without Active Logon**:
  - Direct connection to local security accounts, functioning completely independently of interactive user desktop sessions (works even when the remote PC is sitting at the logon or lock screen).
  - Remotely enumerates all local Windows accounts with security details and group memberships.
  - **Visual Account Type Badges**: Intelligently categorizes and badges accounts as **👑 Administrator** (Members of Administrators group), **👤 Standard User**, **🚼 Guest**, or **⚙️ Built-in Service**.
  - **Account Details & Security Telemetry**: Displays Username, Full Name, Description, Status (🟢 Active / 🔴 Disabled), Account Locked status, Last Logon timestamp, Password Required / Expires flags, SID, and local group memberships.
* **Remote Administration Actions**:
  - **➕ Create Local User**: Remotely provision new local accounts with customizable privileges (**👑 Administrator** or **👤 Standard User**), full name, description, and password settings ("Password Never Expires", "Must Change at Next Logon", and "Account Active") with administrative audit logging.
  - **🔑 Reset Password**: Securely update local user passwords remotely with administrative audit logging.
  - **✅ Enable Account / 🚫 Disable Account**: Instant 1-click toggling of account active status (`🟢 Enabled` / `🔴 Disabled`).
  - Integrated into the bottom Tools toolbar, right-click context menu, and User action buttons.

### ⚡ True 100ms High-Frequency Live Performance Telemetry (Decoupled Engine)
* **High-Speed Telemetry Pipeline**:
  - Replaced standard processor queries with high-speed Windows kernel performance counters, reducing query time from >1000ms down to ~20-50ms.
  - Concurrent Telemetry Execution: CPU, RAM, Network Bandwidth, and Disk I/O counters are queried concurrently on parallel worker threads, minimizing network query latency.
  - **Smooth Real-Time Visual Responsiveness**: Decoupled UI graph rendering at 10 FPS to smoothly redraw sparklines, advance graphs, and roll millisecond timestamps without interface freezing.
  - Process list queries remain throttled to 2 seconds during sub-second telemetry to keep target endpoint CPU negligible (<2%).

### 🎨 Universal High-Contrast Dark Theme & Vibrant Color Overhaul
* **Eliminated Monochromatic / Greyscale Styling**:
  - Replaced dull grey (`#94A3B8`) DataGrid table headers with high-contrast Sky Blue (`#38BDF8`) on deep navy (`#131C31`) with bold typography across all viewers in the suite.
  - Added rich color-coded status badges and pills across Local Users, Services (Running/Stopped), Processes, Printers, Storage Disks, and Network Adapters.
  - Fixed DataGrid unpopulated row background default (`#0F172A`), permanently removing white rectangular strips under table rows.

### 📊 Live Monitor Physical Storage & Network Auto-Sizing Layout
* **Dynamic Table Column Auto-Fitting**:
  - Re-engineered `gridHwDisks` and `gridHwNics` by replacing rigid star column sizing with dynamic `DataGridLength.Auto` and content-based `MinWidth` constraints.
  - Disabled parent ScrollViewer horizontal expansion, ensuring all columns (Interface, IPv4, Default Gateway, MAC Address, DHCP, Drive Type, Partitions) remain completely visible on all screen resolutions without being clipped.

### 🌐 Network Interface Total Bandwidth Metering
* **Cumulative Session Data Tracking**:
  - Continuously monitors raw byte delta throughput on each physical and virtual network adapter while the Live Monitor window is open.
  - Computes and displays cumulative Download/Receive (RX), Upload/Transmit (TX), and Combined Total usage formatted dynamically in MB and GB.
  - Displays as `↓ RX | ↑ TX (Total: Combined)` under the dedicated **Session Bandwidth (RX / TX / Total)** column, resetting cleanly when the monitoring session ends.

### 🌐 Remote IP Configuration & Network Management (`🌐 IP Config`)
* **Remote DHCP ⇄ Static IP Switching**:
  - Remotely switch any active network adapter between dynamic DHCP and static IPv4 configuration (IP Address, Subnet Mask, Default Gateway, Preferred DNS, Alternate DNS).
  - Built-in regex format validation for IP addresses, subnet masks, and gateways with verification checks.
  - **Disconnection Safeguards & Warnings**: Highlights explicit notices warning the administrator if changing the IP will affect the remote management session.
* **1-Click Network Maintenance Actions**:
  - **🔄 DHCP Renew**: Executes remote `ipconfig /renew` to refresh lease configurations.
  - **🛑 DHCP Release**: Executes remote `ipconfig /release`.
  - **🌐 Flush DNS**: Clears remote endpoint resolver cache (`ipconfig /flushdns`).
  - **📡 Register DNS**: Forces DNS name re-registration with domain name servers (`ipconfig /registerdns`).
  - **⚡ Reset Network Adapter**: Executes a safe batch restart command (`netsh interface set interface admin=disable & timeout /t 2 & netsh interface set interface admin=enable`) ensuring the adapter automatically re-enables even if remote management drops temporarily.

### 🗄️ Remote Mapped Network Drives Manager (`Ctrl + D`)
* **Dual-Engine Remote Share Discovery**:
  - **Profile Discovery**: Scans all detected user profiles on target endpoints to uncover persistent drive letters, remote UNC paths, username credentials, connection type, and provider name even when users are idle or locked.
  - **Live Capacity Inspection**: Inspects active mounted network drives, querying storage free space and total capacity (GB/MB) in real-time with automatic health color badges.
* **1-Click Add Network Drive Mapping (`➕ Add Drive Mapping`)**:
  - Smart Drive Letter Selector: Pre-selects the first free available drive letter from `Z:` down to `D:`, marking already occupied letters with `[Already In Use]`.
  - Remote Share UNC Path verification: Includes a **"🔍 Test Path"** button to check UNC access from the management console.
  - User Profile Target: Supports mapping to specific loaded user profiles or the active interactive user session.
  - Reconnect at sign-in: Configures persistent mapping so users see the drive mounted instantly in their active session.
* **Edit & Modify Drive Mapping (`✏️ Edit Mapping`)**:
  - Update UNC paths and change persistence parameters with live feedback.
* **Remote Disconnect & Removal (`🗑️ Disconnect & Remove`)**:
  - Prompts admin confirmation, cleans the registry entry, and unmounts the network drive cleanly without requiring a reboot.
* **Local Explorer Integration & CSV Export**:
  - Double-clicking any mapped drive or clicking **`📂 Open Share Locally`** directly launches local Windows Explorer to browse the UNC share.
  - Export complete multi-user drive mapping inventories to CSV.
* **Context Menu & Shortcut Integration**:
  - Added to Computer right-click context menu, Folders sub-menu, Folders toolbar, and keyboard shortcut **`Ctrl + D`**.

### ⚙️ Deep Group Policy, Firewall & Administrator Setup Documentation
* **Comprehensive GPO Deployment Guide**:
  - Complete step-by-step GPMC instructions for Remote Desktop Shadowing (Auto-Attended Unattended vs. Attended modes).
  - Terminal Services listener activation policy.
* **Firewall Rules Matrix**:
  - Complete port table for Windows Defender Firewall with Advanced Security: Remote Desktop (TCP 3389), WMI/RPC (TCP 135 + Dynamic RPC), SMB (TCP 445/139), WinRM (TCP 5985), ICMPv4 Ping, and Remote Registry.
* **Administrator Privileges & Delegation**:
  - Guidance for elevated launch (`Run as Administrator`), Domain Admin rights, and non-Domain Admin / Delegated Helpdesk group policy setup (Restricted Groups + Active Directory OU delegation for password resets and account unlocks).
* **Automated 1-Click PowerShell Endpoint Configuration Script**:
  - Ready-to-use PowerShell script (`Configure_Endpoint_GPO.ps1`) to configure endpoints in under 30 seconds via GPO startup script, Intune, or elevated terminal.

### 📈 Real-Time Live System Performance & Resource Monitor (`Ctrl + Shift + M`)
* **Real-Time 60-Second Trend Graphs & Sparklines**:
  - Continuous 60-sample historical telemetry buffer tracking CPU load, RAM usage, dual-stream network throughput (Download/Upload), and Disk active I/O.
  - **Embedded KPI Sparklines**: Each of the 4 top KPI cards (CPU, RAM, Network, Disk) now features a smooth native vector sparkline graph with area fill and 50% threshold indicator.
  - **Dedicated Real-Time Charts Tab (`📊 Real-Time Charts`)**: 4 large historical trend charts displaying Min, Max, Average, and Peak performance statistics over the last 60 polling samples.
* **Hardware Information Inspector (`🖥️ Hardware Specs Tab`)**:
  - **Processor (CPU)**: Detailed architecture detection querying CPU Model, Manufacturer, Physical Cores, Logical Processors (Threads), Max Clock Speed (GHz), L3 Cache (MB), and Architecture.
  - **Memory (RAM) Physical Modules**: Inspects individual motherboard DIMM slots, slot locator (e.g. `DIMM 0`, `DIMM 1`), module capacity (GB), frequency/speed (MHz), manufacturer brand, part numbers, and SMBIOS/speed DDR4 vs DDR5 RAM type detection.
  - **Physical Storage Drives**: Enumerates all attached physical disks, model names, interface bus (NVMe, SATA, SCSI, USB), formatted storage capacity (GB/TB), and partition counts.
  - **Network Adapters & IP Configuration**: Comprehensive network hardware audit showing connection status, link speed (100 Mbps / 1 Gbps / 2.5 Gbps / 10 Gbps), MAC addresses, IPv4/IPv6 addresses, subnet masks, default gateways, and DHCP status.
* **UI & Visual Styling Overhaul**:
  - **Fixed White-on-White Dropdown Text**: Re-engineered the Sampling Interval dropdown with dark-themed styling, clean contrast text, and dark background rendering.
  - **Tab Header Contrast**: Resolved light tab headers with deep navy selected tabs and slate unselected tabs.
* **Optimized Decoupled Telemetry**:
  - Hardware specifications are queried asynchronously once on initialization/refresh to prevent remote endpoint load.
  - Telemetry polling is decoupled and utilizes lightweight performance counters with clean cancellation on window close.

### 📄 License & Community Communication
* **Updated Official LICENSE Terms**:
  - Formalized personal-use origin and public release purpose specifically for IT administrators.
  - Documented `https://github.com/SuperUser-exe/Windows-Active-Directory-Remote-Administration-Control-Center` as the sole official release source with disclaimers for unofficial, third-party, or repackaged copies.
* **GitHub Discussions Community Welcome**:
  - Created `GITHUB_DISCUSSIONS_WELCOME.md` containing a warm, developer-written announcement post ready for community discussion.

### 🧹 UI & Toolbar Streamlining
* **Deduplicated Print Spooler Control**:
  - Removed redundant "Restart Print Spooler" button from the main bottom tools toolbar and main context menu.
  - Retained the dedicated **`🔄 Restart Spooler`** button inside the **Remote Printers & Print Queue Manager** window (`🖨️ Printers`) where it belongs contextually.
  - Replaced the bottom toolbar slot with the new **`📈 Live Perf`** button (`Ctrl + Shift + M`).

### 🏷️ Binary Metadata & Explorer Details Credit
* **Author Attribution in Windows File Properties**:
  - All compiled Windows binary properties now display author attribution:
    - **File description**: `Windows AD Remote Administration Control Center Enterprise - Developed and Created by Askarali Mattummal`
    - **Company**: `Developed and Created by Askarali Mattummal`
    - **Copyright**: `Copyright © 2026 Askarali Mattummal. All rights reserved.`
    - **Product version**: `2.6.0 - Developed and Created by Askarali Mattummal`
    - **Trademarks & Comments**: `Developed and Created by Askarali Mattummal`

## 🏷️ Version 2.5.0 (Remote Printers, Advanced Event Presets & Reliability Edition) - September 3, 2026

### 🖨️ Remote Printers & Active Print Queue Manager
* **Live Remote Printer Inventory & Automatic Default Resolution**:
  - Inspect all local and network shared printers installed on any remote workstation or server.
  - **Accurate Default Printer Detection**: Remotely inspects user device configurations to identify active default printers, highlighting them with `⭐ Default` and prioritizing them at the top of the inventory.
  - Displays Printer Name, Driver Name, Port Name / IP, Default Status (`⭐ Default` or `—`), Status code (Idle, Ready, Printing, Offline, Paused, Error), Queued Jobs, and **Pending Jobs**.
* **Intelligent Dual-Target Test Print Engine**:
  - Added new **`🖨️ Test Print`** button in the Remote Printers toolbar.
  - Automatically identifies whether the printer is **Domain Shared** (hosted on a print server) or **Local**.
  - Directs the test print submission directly to the actual host where the driver and print spooler live.
  - Zero False-Positives: Validates physical printer presence and subsystem return codes, reporting exact causes (e.g. printer offline, paused, or stale/orphaned registry connection on client).
* **Pending Jobs Live Cross-Referencing & Server Aggregation**:
  - Added dedicated **`Pending Jobs`** column immediately following `Queued Jobs`.
  - Automatically queries print servers for active print jobs, highlighting active queues with `⚠️ X Pending`.
* **Active & Stuck Print Queue Manager**:
  - Remotely inspect pending documents in real-time.
  - Details include Job ID, Printer Name, Document Title, Submitting User / Owner, Total Pages, Document Size (KB/MB), Submission Timestamp, and Print Job Status.
* **1-Click Remote Queue Maintenance Actions**:
  - **`🗑️ Cancel Selected Job`**: Silently removes any hung or unwanted print job remotely without disrupting other queued documents.
  - **`🧹 Purge All Jobs`**: Flushes all pending print jobs across all queues with one confirmation.
  - **`🔄 Restart Spooler`**: Restarts the remote Windows Print Spooler service (`spooler`) and auto-refreshes the printer queue window.
  - **`📋 Copy Info` & `📊 Export CSV`**: Easily document or export complete printer and queue details for technical support tickets.

### ⌨️ Universal Keyboard Shortcuts Suite
* **Instant Operator Ergonomics**:
  - **`Ctrl + S` / `Ctrl + F`**: Instantly jumps to the Quick Search box and selects all text for immediate filtering.
  - **`F5` / `Ctrl + R`**: Refreshes the Active Directory computer inventory.
  - **`Enter`**: Connects via Remote Shadow (Screen Mirror) to the selected computer.
  - **`Ctrl + Enter`**: Launches direct Remote Desktop (RDP) login.
  - **`Ctrl + P`**: Pings the selected host and displays real-time latency.
  - **`Ctrl + T`**: Opens the in-app Remote Command Terminal (CMD / PowerShell).
  - **`Ctrl + I`**: Launches System Hardware Diagnostics & Specs inspector.
  - **`Ctrl + M`**: Opens the User Toast Notification sender dialog.
  - **`Ctrl + U`**: Unlocks the logged-in user account in Active Directory.
  - **`Ctrl + Shift + P`**: Opens the Password Reset modal for the active user.
  - **`Ctrl + Shift + U`**: Opens the 360° Active Directory User Profile Card.
  - **`Esc`**: Clears search text when search box is focused, and universally dismisses any modal/popup window.

### 👤 Comprehensive Active Directory User Profile Inspector
* **Enterprise 360° AD User Identity Card**:
  - Launched by clicking **`👤 Profile`** in the main toolbar or right-clicking any workstation and choosing **`👤 View AD User Profile Card`**.
  - Extracts and displays 40+ Active Directory attributes grouped logically:
    - **Identity**: Full Display Name, SamAccountName, Given Name, Surname, User Principal Name (UPN), Object GUID, SID, Distinguished Name (DN).
    - **Organization & Hierarchy**: Job Title, Department, Company, Division, Office Location, Employee ID, Employee Number, and Direct Manager (automatically resolved to full display name).
    - **Contact Information**: E-Mail Address, Direct Phone, Mobile, IP Phone, Fax, Street, City, State/Province, Postal Code, Country/Region.
    - **Security & Passwords**: Account Enabled status, Lockout status & timestamp, Bad Logon Count, Last Bad Password timestamp, Password Last Set, Password Expiration policy ("Never Expires"), User Cannot Change Password flag, Smartcard Required, Account Expiration date, Last Logon (current DC) & Replicated Logon Timestamp (`lastLogonTimestamp`).
    - **Roaming & Environment**: Home Directory, Home Drive, Logon Script Path, Profile Path, When Created, When Modified.
* **Complete Security Group Membership Discovery**:
  - Dedicated **Security Groups** tab displaying all Active Directory groups (`memberOf`) the user belongs to, with real-time membership counts and fast search filter.
* **1-Click Interactive Actions**:
  - **`🔓 Unlock Account`**: Unlocks locked accounts directly inside the profile window without navigating away.
  - **`🔑 Reset Password`**: Triggers immediate credential reset with optional temporary password and forced password change on next logon.
  - **`📋 Copy Summary` & `📊 Export Text Report`**: Copy or export the entire user identity report with one click.
  - **Instant Filter Box & ESC Dismissal**: Search through attributes and groups instantly, or close with `Esc`.

### ⚡ Expanded Event Viewer Presets & Multi-Token Filtering
* **Comprehensive Diagnostic Quick Presets**:
  - `🔴 Errors Only`: Filters all critical and error events.
  - `🔄 Reboots (1074)`: Clean system restarts initiated by users, updates, or software (Event ID 1074).
  - `🛑 Shutdown (6006)`: Normal clean system power downs (Event ID 6006).
  - `🚨 Power Loss (41/6008)`: Sudden unexpected power loss or dirty shutdowns (Kernel-Power 41 & EventLog 6008).
  - `💥 BSOD (1001)`: BugCheck blue screen crash reports.
  - `🚫 App Crashes (1000)`: Application crash fault reports.
  - `⚙️ Svc Crashes (7031)`: Service Control Manager crashes & unexpected service terminations (Event ID 7031 & 7034).
  - `⚠️ Disk / NTFS`: Storage, controller, volume, and filesystem corruption warnings.
  - `🔄 Clear Filters`: Resets all active searches and channels in 1-click.
* **Multi-Token Search Engine**:
  - Event Viewer search filter now natively supports comma and pipe delimiters (e.g. `41, 6008`, `7031, 7034`, `Disk, Ntfs`) to match multiple event criteria simultaneously.

### 📦 Installed Software Fallback Engine
* **High-Reliability Software Inventory**:
  - Solved issue where workstations with the `RemoteRegistry` Windows service disabled (such as Windows 10/11 client PCs) returned an empty software list.
  - Automatically falls back to native remote registry queries, reliably populating 100% of installed 64-bit and 32-bit applications and silent uninstall strings without requiring the RemoteRegistry service to be started.

### 🎨 UI/UX Dark Theme & Styling Polishing
* **Black Dropdown Text Across All Popups**:
  - Ensured all ComboBox popup menu lists (Remote Terminal Console, Event Viewer Channels/Severity/Count, and Printers) render with crisp dark slate / black text (`#0F172A`) against clean popup backgrounds.
* **Dark Disabled Buttons**:
  - Eliminated the default Windows WPF Aero white rectangular block on disabled buttons (`Silent Uninstall`, `Copy Info`, `Copy Summary`, `Cancel Job`).
  - Disabled buttons now retain a dark slate enterprise appearance (`#1E293B` background, `#334155` border, `#64748B` muted text).

### 🛠️ Toolbar & Context Menu Refinements
* **Bottom Toolbar**:
  - Renamed the button from **"Spooler"** to **`🔄 Restart Print Spooler`** for clarity.
  - Added new **`🖨️ Printers`** button under `🛠️ Tools`.
* **Context Menu**:
  - Added **`🖨️ Remote Printers & Print Queue Manager`**.
  - Removed **User Guide** and **Version History** from the right-click menu to keep the menu compact and focused (both remain easily accessible from the top-right header toolbar).

---

## 🏷️ Version 2.4.0 (Remote Windows Event Log Viewer Edition) - August 28, 2026

### 📋 Remote Windows Event Log Viewer (System & Application)
* **High-Speed Remote Event Log Querying**:
  - Direct native RPC querying with reverse-chronological streaming to load the newest events first.
  - Reads the most recent 50 to 500 events in milliseconds across the network without high memory usage or forward-scanning delays.
  - Zero client agents or remote services required; operates natively over standard Windows RPC.
* **Dual-Channel Inspection**:
  - Query **System** logs, **Application** logs, or **Combined (All Channels)** in a unified timeline.
* **Smart Severity Level & Text Search Filtering**:
  - Filter instantly by severity level: `All Severities`, `🔴 Critical & Error`, `🟡 Warning`, or `🔵 Information`.
  - Live keyword search as you type across **Event ID**, **Source / Provider Name**, **Channel Name**, and **Message Content**.
* **1-Click Quick Action Presets**:
  - `🔴 Errors Only`: Instantly filters for critical and error events.
  - `💥 BSOD / BugCheck (1001)`: Jumps to Blue Screen crash logs (System BugCheck 1001).
  - `🚫 App Crashes (1000)`: Jumps to Application crash events (Application Error 1000).
  - `⚠️ Disk / NTFS Errors`: Filters for storage controller, disk, and filesystem corruption warnings.
  - `🔄 Clear Filters`: Resets all active searches and restores the complete event list.
* **Split-View Enterprise Diagnostics UI**:
  - Upper pane: Dark slate DataGrid with alternating rows, colored severity badges, timestamp, Event ID, channel, and provider.
  - Interactive GridSplitter for custom vertical workspace resizing.
  - Lower pane: Read-only Consolas diagnostics console showing complete formatted technical descriptions, parameters, and crash details.
* **Clipboard Copy & CSV Export**:
  - `📋 Copy Summary`: Copies single-line summary of selected event.
  - `📋 Copy Details`: Copies complete multi-line event diagnostic card.
  - `📊 Export CSV`: Exports all visible filtered events to an Excel-ready `.csv` report.
* **Toolbar & Context Menu Access**:
  - Added **`📋 Events`** button to main toolbar under `🛠️ Tools`.
  - Added **`📋 Remote Windows Event Logs (System & App)`** to the right-click computer context menu.

---

## 🏷️ Version 2.3.0 (Installed Software & Remote Uninstaller Edition) - August 12, 2026

### 📦 Remote Software Management & Silent Uninstaller
* **Remote Installed Software Inventory**:
  - Automatically queries the remote machine's 64-bit and 32-bit uninstall registries (`HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall` and `HKLM\Software\Wow6432Node\...`).
  - Reads Application Name, Version, Publisher, Install Date, Package Type (MSI/EXE), and Uninstall Strings in under 1 second.
  - Bypasses slow WMI consistency checks, eliminating system lags and event log spam.
* **1-Click Silent Remote Uninstaller**:
  - Automatically constructs the exact silent command line:
    - MSI packages: `MsiExec.exe /X{ProductCode} /qn /norestart`
    - Standard executables: uses `QuietUninstallString` or appends silent flags (`/S`, `/VERYSILENT /SUPPRESSMSGBOXES /NORESTART`).
  - Previews the target application details and exact command line in an admin confirmation dialog before execution.
  - Executes uninstallation silently in the background without interrupting the remote user.
* **Interactive Dark-Themed Software Manager UI**:
  - Instant live keyword filtering across application names, publishers, and versions.
  - Dynamic total software count badge (e.g. `71 Applications Installed`).
  - **Copy Info**: Copies all registry metadata to clipboard.
  - **Export CSV**: Generates a complete software inventory spreadsheet for any remote computer.
* **Toolbar & Context Menu Integration**:
  - Added **`📦 Software`** button to main toolbar under `🛠️ Tools`.
  - Added **`📦 Installed Software & Silent Uninstaller`** to computer right-click context menu.

---

## 🏷️ Version 2.2.0 (Security & Access Authorization Edition) - July 24, 2026

### 🛡️ Security & Access Control
* **Startup Authorization Guard**:
  - Automatically verifies whether the executing user is an authorized IT administrator upon launch.
  - Inspects active Windows token security groups (Local Administrators, Domain Admins, Enterprise Admins, IT-Admins) and Active Directory group memberships.
  - If launched by a standard, non-administrator user, the application halts immediately and displays an access restriction modal dialog:
    `"This application is restricted to authorized IT administrators only. Please contact your IT administrator if you need access."`
  - Prevents unauthorized standard users from viewing domain computer lists, specs, or executing remote tools.
* **Security Event Auditing**:
  - Logs all authorization decisions (`BLOCKED` vs `AUTHORIZED`) directly into `AD_Remote_Control.log` with user account details and timestamp.
* **Binary Integrity & Self-Contained Native Compilation**:
  - `AD_Remote_Control.exe` is compiled as a standalone native Windows PE executable. It is not an archive and cannot be extracted with WinRAR or 7-Zip.

---

## 🏷️ Version 2.1.0 (Feature Polish & Remote Console Edition) - July 02, 2026

### 🌟 New Features & Enhancements
* **🔔 "Alert" Checkbox for Shadow Connections**:
  - Added new connection option toggle: `🔔 Alert User`.
  - When enabled, automatically dispatches an on-screen popup alert via `msg.exe`:
    `"IT Support: An administrator is connecting to your screen to assist with your technical issue."`
  - When disabled, connects silently without prompting.
* **🎨 Dark Theme Fix for Task Manager & Services DataGrids**:
  - Completely redesigned the programmatic DataGrid styling in `Remote Task Manager` and `Remote Services Controller`.
  - Replaced Windows default white row and header styles with dark slate theme (`#0F172A` / `#0B1329` alternating rows, `#1E293B` column headers, `#F8FAFC` crisp text).
  - Eliminates the white lines and unreadable text issue.
* **📁 Open C:/ & Remote User Folders (Desktop, Downloads, Documents)**:
  - Renamed `"C$ Share"` button to `"📁 Open C:/"`.
  - Added 1-click quick-access buttons for:
    - `📁 Desktop`: Opens `\\<host>\C$\Users\<user>\Desktop`.
    - `📁 Downloads`: Opens `\\<host>\C$\Users\<user>\Downloads`.
    - `📁 Documents`: Opens `\\<host>\C$\Users\<user>\Documents`.
* **🔓 Smart Dynamic "Unlock User" Button**:
  - Checks the Active Directory account lockout status of the logged-in user in real time.
  - If **Locked Out**: Vibrantly flashes in red/amber as `🚨 UNLOCK USER (LOCKED!)` and enables 1-click unlock.
  - If **Healthy / Active**: Displays `✅ Account Active` in subtle dark green.
  - Automatically hides if no active domain user is logged into the selected computer.
* **🧹 4-Path Remote Temp Cleaner & Detailed Outcome Logging**:
  - Expanded remote cleanup to purge:
    1. `temp`: `\\<host>\C$\Windows\Temp`
    2. `%temp%`: `\\<host>\C$\Users\<user>\AppData\Local\Temp` (and all user profiles)
    3. `recent`: `\\<host>\C$\Users\<user>\AppData\Roaming\Microsoft\Windows\Recent`
    4. `prefetch`: `\\<host>\C$\Windows\Prefetch`
  - Shows file counts deleted and MB freed for each folder, and logs detailed outcomes.
* **📜 Reverse-Chronological Activity Log & Filtered Context Menu**:
  - `AD_Remote_Control.log` and the in-app viewer now display the **most recent event at the very top**.
  - Every single administrative action now explicitly records its outcome: `SUCCESS`, `FAILED`, `CANCELLED`, `PENDING`.
  - Right-clicking any computer to open the Activity Log automatically pre-filters the view to show only that machine's logs, while the top button shows the global audit trail.
* **💻 In-App Remote CMD & PowerShell Terminal Console**:
  - Interactive terminal window allowing administrators to run commands directly on remote computers.
  - Supports both **Command Prompt (CMD)** and **PowerShell (PS)** execution modes.
  - Pre-built quick action buttons (`ipconfig /all`, `whoami /all`, `gpresult /r`, `netstat -ano`, `systeminfo`, `Get-Process`, `Get-Service`, `Restart Spooler`).
  - Live output streaming right inside the application window.

---

## 🏷️ Version 2.0.0 (Enterprise Suite Edition) - May 15, 2026
* Cleaned out legacy batch/PowerShell directories into a single standalone executable.
* Added Hardware Specs, Serial Number / Service Tag, CPU, RAM, Uptime, and C: Drive storage gauge.
* Added Remote Task Manager to kill hung processes remotely.
* Added Remote Windows Services Controller & 1-Click Print Spooler reset.
* Added On-Screen Pop-Up User Messaging (`msg.exe`).
* Added 1-Click Remote C$ Admin Share access.
* Added Active Directory User Account Unlock & Password Reset.
* Added Remote Maintenance (Flush DNS, GPUpdate, Clear Temp) and Silent Software Deployer.
* Added Multi-Select Bulk Operations (Bulk WOL, Bulk Message, Bulk Reboot, Bulk Shutdown).
* Added Domain Asset Inventory Export to CSV/Excel.
* Added In-App Activity Log and In-App Version History viewers.

---

## 🏷️ Version 1.2.0 - March 20, 2026
* Added In-App Activity Log and User Guide viewers with live keyword search.
* Added support for `query.exe session console` for instant remote console session discovery.

---

## 🏷️ Version 1.1.0 - February 08, 2026
* Added remote power controls (Lock, Logoff, Restart, Shutdown) and Wake-on-LAN.
* Added active logged-in user and logon time tracking via `quser.exe`.
* Added resolved IPv4 address column.

---

## 🏷️ Version 1.0.0 - January 15, 2026
* Initial release of Windows AD Remote Administration Control Center.
* Active Directory computer enumeration with LDAP search paging.
* Real-time ping latency check and status badges.
* Auto-Attended Remote Shadowing (`mstsc /shadow`) and Remote Desktop (`mstsc /admin`).
