# 📜 AD Remote Control Center - Version History & Changelog
**Created & Developed by Askarali Mattummal**

All notable changes and upgrades to the **Active Directory Remote Control Suite** are documented in this file.

## 🏷️ Version 2.6.0 (Remote User Management, Sub-Second Live Monitor & Network IP Hub Edition) - September 7, 2026

### 🚀 Remote Startup Applications & Autorun Manager (`🚀 Startup`)
* **Remote Auto-Start Application Discovery**:
  - Remotely queries all configured startup entries across All Users (`HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run`), specific user profiles (`HKU\<SID>\SOFTWARE\Microsoft\Windows\CurrentVersion\Run`), and Startup folders via WMI `Win32_StartupCommand`.
* **Dynamic Enable / Disable Toggling**:
  - Direct remote registry manipulation via WMI `StdRegProv` targeting Windows `StartupApproved\Run` and `StartupApproved\StartupFolder`.
  - Sets binary flag `0x02` to **Enable** and `0x03` to **Disable** applications, perfectly syncing with Windows Task Manager Startup tab without deleting user entries.
* **Full Autorun Control Center**:
  - High-contrast dark theme DataGrid displaying Status (`🟢 Enabled` / `⚪ Disabled`), Application Name, Executable / Command line, Scope / User, and Registry Location.
  - Live search filtering, CSV export, right-click context menu (`🟢 Enable`, `⚪ Disable`, `🗑️ Delete Entry`), and double-click to toggle state.
  - Accessible via top toolbar button (`🚀 Startup`) and right-click computer context menu (`🚀 Remote Startup Applications (Autorun Manager)`).

### 🔄 Seamless 1-Click Updates from GitHub Releases
* **Integrated Release Detection**:
  - 1-click update check (`🔄 Check for Updates`) queries official releases from `https://github.com/SuperUser-exe/AD-Remote-Control-Center`.
  - Automatically notifies administrators when new features, stability enhancements, or security patches are published.
  - Seamless in-place download and automatic update installation without third-party installers or web browser redirects.
  - Silent fallback and graceful offline support when working in air-gapped enterprise domains.

* **Compact & Scrollable Context Menu (`Right-Click Menu`)**:
  - Re-engineered `CreateContextMenuItem` geometry with compact 20x20 visual badges, 11.5pt crisp typography, and tight padding (`4,1,6,1`), reducing row height from ~36px down to ~21px.
  - Implemented a scrollable container in the `ContextMenu` XAML template (`MaxHeight='560'` with smooth `<ScrollViewer>`), preventing the menu from overflowing low or high-DPI displays or extending below the Windows taskbar.
* **Thread-Safe Brush Freezing (`ShowLocalUserManager` Crash Fix)**:
  - Added `CreateFrozenBrush(string hex)` helper that invokes `.Freeze()` on all newly instantiated `SolidColorBrush` objects.
  - Resolved `System.ArgumentException` inside `System.Windows.DependencyObject.ValidateSources` by freezing all model brushes before binding off-thread collections to the DataGrid.
* **Global Application Crash Guard & Diagnostic Logging**:
  - Attached `Application.DispatcherUnhandledException` with `e.Handled = true`, intercepting interface layout or binding exceptions, logging full stack traces to `AD_Remote_Control.log`, and alerting the administrator without process termination.
  - Subscribed to `AppDomain.CurrentDomain.UnhandledException` and `TaskScheduler.UnobservedTaskException` to prevent silent process termination.
* **Remote Workstation Lock & Unlock Controller Enhancements**:
  - **Dynamic State-Aware Button Activation**: When a workstation is locked, the "Lock Screen" action is automatically disabled and badged as "(Already Locked)", while "Reconnect Console Session" and "Unlock Session with Password" become active. When unlocked, lock actions are enabled and unlock actions are disabled.
  - **Dual-Engine Remote Lock Execution**: Primary attempt via Terminal Services RPC (`tsdiscon.exe`), with automatic remote WMI execution fallback of `%SystemRoot%\System32\tsdiscon.exe {SessionId}` with output capture.
  - **Dual-Engine Remote Unlock Execution**: Executes `%SystemRoot%\System32\tscon.exe` directly on the target host via WMI with full standard output and error redirection.
  - **In-Dialog Real-Time Diagnostic Console**: Added an embedded live diagnostic console (`TextBox`) in the controller dialog streaming timestamped steps, exit codes, and stdout/stderr directly to the user and `AD_Remote_Control.log`.

### 👥 Local Computer Users & Accounts Manager (`👥 Local Users`)
* **Remote Local User Discovery & Management Without Active Logon**:
  - Direct connection to Windows SAM and LSASS via ADSI (`WinNT://`) and WMI RPC endpoints, functioning completely independently of interactive user desktop sessions (works even when the remote PC is sitting at the logon/lock screen).
  - Remotely enumerates all local Windows accounts via WMI `Win32_UserAccount WHERE LocalAccount = True` cross-referenced with `Win32_GroupUser` and `Win32_NetworkLoginProfile`.
  - **Visual Account Type Badges**: Intelligently categorizes and badges accounts as **👑 Administrator** (Members of Administrators group), **👤 Standard User**, **🚼 Guest**, or **⚙️ Built-in Service**.
  - **Account Details & Security Telemetry**: Displays Username, Full Name, Description, Status (🟢 Active / 🔴 Disabled), Account Locked status, Last Logon timestamp, Password Required / Expires flags, SID, and local group memberships.
* **Remote Administration Actions**:
  - **➕ Create Local User**: Remotely provision new local accounts with customizable privileges (**👑 Administrator** or **👤 Standard User**), full name, description, password settings ("Password Never Expires", "Must Change at Next Logon", and "Account Active"). Features dual-engine provisioning (ADSI primary + CLI fallback) with administrative audit logging.
  - **🔑 Reset Password**: Securely update local user passwords remotely via ADSI / WinNT provider with CLI fallback and administrative audit logging.
  - **✅ Enable Account / 🚫 Disable Account**: Instant 1-click toggling of account active status (`AccountDisabled = true/false`).
  - Integrated into the bottom Tools toolbar, right-click context menu, and User action buttons.

### ⚡ True 100ms High-Frequency Live Performance Telemetry (Decoupled Engine)
* **High-Speed Telemetry Pipeline**:
  - Replaced the high-latency `Win32_Processor` provider (which had a hardcoded 1000ms internal Windows sampling delay) with the instantaneous Windows kernel performance counter `Win32_PerfFormattedData_PerfOS_Processor WHERE Name='_Total'`, reducing query time from >1000ms down to ~20-50ms.
  - Concurrent Telemetry Execution: CPU, RAM, Network Bandwidth, and Disk I/O counters are queried concurrently using `Parallel.Invoke`, reducing RPC network query overhead to `max(T)`.
  - **Decoupled UI Animation Loop (`DispatcherTimer`)**: Implemented a dedicated rendering timer running on the UI thread at 100ms (10 FPS) that smoothly redraws sparklines, advances graphs, and rolls millisecond timestamps (`HH:mm:ss.fff`), delivering genuine real-time visual responsiveness without UI freezing.
  - Process list queries (`Win32_Process`) remain throttled to 2 seconds during sub-second telemetry to keep target endpoint CPU negligible (<2%).

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
  - **Engine 1 (Remote Registry via WMI `StdRegProv`)**: Scans `HKEY_USERS\<UserSID>\Network` across all detected user profiles on target endpoints. Uncovers persistent drive letters, remote UNC paths, username credentials, connection type, and provider name even when users are idle or locked.
  - **Engine 2 (WMI `Win32_LogicalDisk WHERE DriveType = 4`)**: Live inspection of active mounted network drives, querying storage free space and total size (GB/MB) in real-time with automatic health color badges (`#34D399` Connected / `#38BDF8` Persistent).
* **1-Click Add Network Drive Mapping (`➕ Add Drive Mapping`)**:
  - Smart Drive Letter Selector: Pre-selects the first free available drive letter from `Z:` down to `D:`, marking already occupied letters with `[Already In Use]`.
  - Remote Share UNC Path verification: Includes a **"🔍 Test Path"** button to check UNC access from the management console.
  - User Profile Target: Supports mapping to specific loaded user profiles or the active interactive user session.
  - Reconnect at sign-in: Configures persistent registry keys and simultaneously executes remote `net use <Drive>: "<UNC>" /persistent:yes` via WMI `Win32_Process` so users see the drive mounted instantly.
* **Edit & Modify Drive Mapping (`✏️ Edit Mapping`)**:
  - Update UNC paths and change persistence parameters with live feedback.
* **Remote Disconnect & Removal (`🗑️ Disconnect & Remove`)**:
  - Prompts admin confirmation, cleans the registry entry from `HKEY_USERS\<SID>\Network\<Drive>`, and runs remote `net use <Drive>: /delete /y` to cleanly unmount the drive without rebooting.
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
  - **Fixed White-on-White Dropdown Text**: Re-engineered the Sampling Interval ComboBox with dark-themed item containers, explicit `#0F172A` item text, and dark background rendering.
  - **Custom WPF TabControl Template**: Resolved light tab headers by implementing a custom WPF `ControlTemplate` featuring deep navy selected tabs (`#1E3A5F`) with neon cyan borders (`#38BDF8`) and slate unselected tabs (`#1E293B`).
* **Optimized Decoupled Telemetry**:
  - Hardware specifications are queried asynchronously once on initialization/refresh to prevent remote endpoint load.
  - Telemetry polling is decoupled and utilizes lightweight WMI performance counters (`Win32_PerfFormattedData_*`) with clean cancellation on window close.

### 📄 License & Community Communication
* **Updated Official LICENSE Terms**:
  - Formalized personal-use origin and public release purpose specifically for IT administrators.
  - Documented `https://github.com/SuperUser-exe/AD-Remote-Control-Center` as the sole official release source with disclaimers for unofficial, third-party, or repackaged copies.
  - Referenced security protections including code obfuscation and string encryption documented in `docs/PUBLIC_RELEASE_AND_PROTECTION_PLAN.md`.
* **GitHub Discussions Community Welcome**:
  - Created `GITHUB_DISCUSSIONS_WELCOME.md` containing a warm, developer-written announcement post ready for copy-pasting into GitHub Discussions.

### 🧹 UI & Toolbar Streamlining
* **Deduplicated Print Spooler Control**:
  - Removed redundant "Restart Print Spooler" button from the main bottom tools toolbar and main context menu.
  - Retained the dedicated **`🔄 Restart Spooler`** button inside the **Remote Printers & Print Queue Manager** window (`🖨️ Printers`) where it belongs contextually.
  - Replaced the bottom toolbar slot with the new **`📈 Live Perf`** button (`Ctrl + Shift + M`).

### 🏷️ Binary Metadata & Explorer Details Credit
* **Author Attribution in Windows File Properties**:
  - All compiled Windows binary properties (`AD_Remote_Control.exe`) now display author attribution:
    - **File description**: `AD Remote Control Center Enterprise - Developed and Created by Askarali Mattummal`
    - **Company**: `Developed and Created by Askarali Mattummal`
    - **Copyright**: `Copyright © 2026 Askarali Mattummal. All rights reserved.`
    - **Product version**: `2.6.0 - Developed and Created by Askarali Mattummal`
    - **Trademarks & Comments**: `Developed and Created by Askarali Mattummal`

## 🏷️ Version 2.5.0 (Remote Printers, Advanced Event Presets & Reliability Edition) - September 3, 2026

### 🖨️ Remote Printers & Active Print Queue Manager
* **Live Remote Printer Inventory & Automatic Default Resolution**:
  - Inspect all local and network shared printers installed on any remote workstation or server via WMI `Win32_Printer`.
  - **Accurate Default Printer Detection**: Remotely inspects `HKEY_USERS\<UserSID>\Software\Microsoft\Windows NT\CurrentVersion\Windows\Device` via `StdRegProv`, overcoming the limitation where WMI queries under SYSTEM context return blank defaults. Highlights active user default printers with `⭐ Default` and prioritizes them at the top of the inventory.
  - Displays Printer Name, Driver Name, Port Name / IP, Default Status (`⭐ Default` or `—`), Status code (Idle, Ready, Printing, Offline, Paused, Error), Queued Jobs, and **Pending Jobs**.
* **Intelligent Dual-Target Test Print Engine**:
  - Added new **`🖨️ Test Print`** button in the Remote Printers toolbar.
  - Automatically identifies whether the printer is **Domain Shared** (hosted on a print server like `10.10.10.30`) or **Local**.
  - Directs the WMI `PrintTestPage()` method directly to the actual host where the driver and print spooler live.
  - Zero False-Positives: Validates physical printer presence and subsystem return codes, reporting exact causes (e.g. printer offline, paused, or stale/orphaned registry connection on client).
* **Pending Jobs Live Cross-Referencing & Server Aggregation**:
  - Added dedicated **`Pending Jobs`** column immediately following `Queued Jobs`.
  - Automatically queries print servers for active print jobs (`JobStatus <> 'Printed' AND JobStatus <> 'Complete'`), highlighting active queues with `⚠️ X Pending`.
* **Active & Stuck Print Queue Manager**:
  - Remotely inspect pending documents in real-time via `Win32_PrintJob`.
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

### 📦 Installed Software WMI Fallback Engine
* **High-Reliability Software Inventory**:
  - Solved issue where workstations with the `RemoteRegistry` Windows service disabled (such as Windows 10/11 client PCs) returned an empty software list.
  - Automatically falls back to WMI `root\default:StdRegProv` RPC methods, reliably populating 100% of installed 64-bit and 32-bit applications and silent uninstall strings without requiring the RemoteRegistry service to be started.

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
  - Direct native RPC querying via `System.Diagnostics.Eventing.Reader` (`ReverseDirection = true`).
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
  - Spawns execution in the background via remote WMI (`Win32_Process.Create`) without interrupting the user.
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
* Initial release of AD Remote Control Center.
* Active Directory computer enumeration with LDAP search paging.
* Real-time ping latency check and status badges.
* Auto-Attended Remote Shadowing (`mstsc /shadow`) and Remote Desktop (`mstsc /admin`).
