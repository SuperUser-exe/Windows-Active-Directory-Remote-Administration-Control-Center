# 📜 Windows AD Remote Administration Control Center - Version History & Changelog
**Created & Developed by Askarali Mattummal**

All notable changes and upgrades to **Windows AD Remote Administration Control Center** are documented in this file.

## 🏷️ Version 2.7.0 (Official Enterprise Release)

---

### 🌟 New Features (Introduced in v2.7.0)

#### 🎨 Modern Windows 11 Fluent Icon & Transparent Silhouette
* **New App Icon with Transparent Background**:
  - Updated the application icon to a modern Fluent-style design with a transparent background. It blends naturally into both light and dark Windows 11 taskbars without a dark box behind it.


#### 📂 Company-Internal Network File Share Auditing & Structured Incident Extraction
* **Comprehensive Entity Resolution for Local File & Share Auditing**:
  - **What was updated**: Upgraded the Remote Event Log Viewer and Security Incident Stream to extract and present structured auditing metadata for network file share operations directly on the local administrator workstation. The system parses and displays dedicated indicators for the responsible User Account, Source Workstation or IP Address, Network Share Location, Specific File Name, and Performed Action. CSV exports from the Event Log Viewer include separate columns for Action, Network Share, and File Name for compliance reporting. In keeping with strict enterprise privacy standards, all user file access details remain completely local and company-internal.
  - **Benefit**: Empowers administrators and security officers to instantly determine who accessed or modified sensitive files across enterprise network shares and maintain comprehensive audit records, while ensuring employee file activities are never transmitted outside the company boundary.

#### 🎯 Remote Event Viewer Deep Entity Search & Authoritative Scope
* **Authoritative Date-Ranged Search for Users, Workstations, IP Addresses, and Files**:
  - **What was updated**: Upgraded the Remote Event Log Viewer's entity filters (Username, Computer Name, IP Address, File Path / Name, and Search Text) to perform an authoritative search across the entire selected date range on the remote computer, returning matching records up to your chosen display limit. Searching is no longer constrained to pre-loaded rows, ensuring that specific security incidents, file accesses, or administrative actions are discovered even when thousands of newer routine events exist. Added a dedicated "Search Logs" button and instant execution on pressing Enter in any filter input field.
  - **Benefit**: Technicians and security auditors can immediately locate specific user actions, source machines, or file operations across large event logs without needing to manually fetch thousands of unrelated records first.

#### 📅 Custom Date & Time Range Filtering with High-Performance Traversal
* **Precision Date-Time Picker for Forensic Investigations**:
  - **What was updated**: Added an interactive Custom Date Range selection panel to the Remote Event Log Viewer, featuring dedicated pickers for Start Date, Start Time, End Date, and End Time. When searching in reverse chronological order, the query engine automatically bypasses newer events outside the range and terminates log scanning immediately upon reaching events older than the requested start time.
  - **Benefit**: Enables rapid, surgical investigation of security events or system issues that occurred during specific operational windows, drastically reducing wait times on busy servers and domain controllers.


#### 🖥️ Remote Screen Saver Manager Interface Reliability
* **Full Theme-Adaptive Screen Saver Policy Management**:
  - **What was updated**: Enhanced the Remote Screen Saver Manager to reliably present its control panel with complete adaptive styling for both light and dark themes. The interface provides interactive configuration for remote screen saver activation, password lock requirements upon wake, and idle timeouts across default profiles and active user sessions.
  - **Benefit**: Guarantees dependable, visual policy management for endpoint screen security and lock timeouts across managed network computers without display inconsistencies.


#### 📈 Adaptive Light & Dark Theming for Deep Performance Telemetry Tiles
* **Dynamic Theme Synchronization for Expanded Live Graph Metrics**:
  - **What was updated**: Enhanced the full-screen deep monitoring telemetry cards below the real-time resource graphs to fully support both light and dark themes. In light mode, the timeline bar and individual metric tiles now display on clean, high-contrast card surfaces with subtle borders and optimized typography, rather than retaining fixed dark backgrounds. Metric values and health indicators dynamically adjust their color intensity for maximum legibility in both environments.
  - **Benefit**: Delivers a seamless visual experience across all workstation monitoring screens, eliminating harsh dark boxes when operating in light theme and ensuring live telemetry figures remain crystal clear under all lighting conditions.

#### 🗂️ Refined Bottom Administration Category Architecture & Visual Flow
* **Sleek Category Section Labels & Accent Pillars**:
  - **What was updated**: Redesigned the "Quick Tools", "Folders & Users", and "Profile" section indicators in the bottom navigation panel from button-style boxes into elegant, non-clickable category labels featuring vertical accent pillars. Removed obsolete privacy mode controls to streamline the session connection row.
  - **Benefit**: Eliminates operator click ambiguity by clearly distinguishing category organization headers from interactive tool actions, providing a cleaner, more intuitive administrative experience.

#### 🖨️ Enhanced Fleet Printing Report & Analytics Interface
* **Clean Header Architecture & Actionable Custom Data Selection**:
  - **What was updated**: Streamlined the Per-User Printing Report header by eliminating development badges, centered the report title in modern executive styling, and upgraded the custom Print Server and User selection tools into prominent, styled action buttons with pencil icons and dedicated custom input dialogs.
  - **Benefit**: Delivers a polished, production-ready reporting environment and improves operational efficiency when auditing print activity for ad-hoc hostnames or specific enterprise usernames.

#### ⚡ Streamlined Quick Action Toolbar & Context Menu Harmonization
* **Streamlined Quick Action Toolbar**:
  - **What was updated**: Redesigned the primary multi-select workstation toolbar above the main computers inventory grid, renaming the section to **Quick Action**. Streamlined the default toolbar layout to focus strictly on high-priority daily monitoring and broadcast communication tasks (`Inactivity & Idle Monitor Agent` and `Bulk Message`), while seamlessly preserving all bulk power operations (Bulk Wake-on-LAN, Bulk Reboot, Bulk Shutdown) and bulk custom wallpaper deployments within the multi-select right-click context menu.
  - **Benefit**: Provides an uncluttered, distraction-free inventory header with dedicated focus on primary operational controls, while keeping all bulk power and management capabilities instantly accessible to administrators through intuitive right-click multi-selection.


#### Clean Activity Log for Local Operations
* **Activity Log Dedicated to Administrator Actions**:
  - **What was updated**: Refined the Activity Log to record only direct administrator-initiated actions on managed endpoints. Background network health checks now run silently without adding noise to the audit trail.
  - **Benefit**: Keeps the Activity Log clean and easy to review, showing only the actions you performed on each workstation.


#### 🛑 Remote Shadow Session Disconnect Notification
* **Automated End-of-Support User Confirmation**:
  - **What was updated**: When an administrator ends an interactive screen shadowing session where user notification or permission was active, the remote computer immediately displays a clean on-screen notice: "IT Support Helpdesk remote support session has ended."
  - **Benefit**: Reassures the end-user that the remote assistance session is finished, their desktop is no longer being viewed or shared, and full privacy and input control are restored.

#### 🖨️ Real-Time Remote Printer Queue Monitor with Smart Switching
* **Live Print Job Polling & Low-Overhead Device Switching**:
  - **What was updated**: Upgraded the Remote Printers & Print Queue Manager to actively stream print queue changes for the selected printer every 2 seconds without requiring manual refresh clicks. Switching between printers instantly targets the new queue with zero interface delay and without loading remote system event logs.
  - **Benefit**: Allows technicians to observe real-time job arrival, document processing, and printer stall conditions dynamically while minimizing endpoint overhead and network traffic.
* **Multi-Color Ink and Toner Consumable Indicators with Standardized Severity Scaling & Cross-Workstation Resolution**:
  - **What was updated**: Upgraded the Ink and Toner Level telemetry in the Printer Management Dashboard with individual consumable chips for each physical cartridge (Black, Cyan, Magenta, Yellow, and monochrome supplies). Each cartridge maintains its distinctive cartridge identity and visual color badge (Cyan, Magenta, Yellow, Black) while uniformly adhering to a 6-tier severity scale: 100–50% (Good, Green), 49–25% (Low, Yellow), 24–10% (Very Low, Orange), 9–1% (Critical, Red), 0% (Empty, Dark Red), and Unknown / Cannot Detect (Gray). Added automated network address resolution for domain-shared network printers when inspecting client workstations, querying print server configurations and directory services to accurately detect physical printer addresses and retrieve live supply metrics from any endpoint. Includes interactive column sorting by lowest remaining consumable level and comprehensive tooltips detailing individual supply metrics and threshold scales.
  - **Benefit**: Empowers helpdesk technicians and system administrators to immediately recognize which specific color cartridge requires replacement and evaluate supply urgency at a glance directly from any user workstation or print server, preventing unexpected printer downtime and streamlining proactive consumable restocking.
* **Horizontal Scrolling & Adaptive Data Grids**:
  - **What was updated**: Enabled independent horizontal scrolling and resizable columns on both the Installed Printers and Print Queue & Job History tables, ensuring clear visibility across wide document names, file sizes, and printer network addresses on any screen size.
  - **Benefit**: Eliminates text truncation and visual clipping, allowing technicians to inspect detailed print job attributes with zero hassle.

#### 📊 Per-User Printing Report, Fleet Consumption Analytics & Print Job Statistics
* **Automated Print Server Detection & Best-Accuracy Guidance Banner**:
  - **What was updated**: Added an automated detection banner at the top of the Printing Report window that queries Active Directory and network configuration to identify the primary central Print Server name, fully qualified hostname, and IP address. Includes an interactive quick-switch button to immediately query the authoritative print server, or displays a confirmation badge when connected directly to the print server.
  - **Benefit**: Guarantees administrators always know where authoritative domain print spooler logs are hosted, preventing empty reports caused by querying individual client workstations that do not maintain print queues.
* **Centralized Print Server Telemetry & Multi-Dimensional In-Memory Filtering**:
  - **What was updated**: Upgraded the fleet print audit report so that event logs are always collected centrally from the authoritative domain Print Server, while all client workstations, individual users, printer queues, job statuses, minimum page thresholds, and date periods act as instant, in-memory filters over the server-side dataset. Selecting the Print Server displays the full fleet data across all workstations and users; selecting a specific user or workstation narrows the report strictly to that target's records; selecting a printer queue filters by that device; and selecting All Printers or resetting filters restores the fleet view without returning empty data.
  - **Benefit**: Completely eliminates empty report screens caused by querying individual client workstations directly, provides instantaneous sub-second filter switching across hosts, users, and printer devices simultaneously, and guarantees 100% data integrity against centralized enterprise print server logs.
* **High-Performance Event Log Query Engine**:
  - **What was updated**: Optimized remote event retrieval with an accelerated query engine that reads and parses tens of thousands of operational print log records in seconds, backed by an extended 45-second execution allowance.
  - **Benefit**: Ensures fast and dependable report generation even on high-traffic enterprise print servers with hundreds of thousands of accumulated print jobs.
* **Comprehensive Per-User & Per-Printer Consumption Reporting**:
  - **What was updated**: Introduced a full-featured Printing Reports & Fleet Analytics engine that mines print server audit logs to generate aggregated per-user printing totals, printer queue utilization breakdowns, daily volume trends, and workstation consumption statistics across any selected date range.
  - **Benefit**: Provides IT administrators and finance managers with instant visibility into who is printing the most documents and which physical printers bear the heaviest workload, enabling accurate departmental cost accounting, paper waste reduction, and proactive hardware maintenance.
* **Automatic Print Server & Workstation Discovery Across Any Network**:
  - **What was updated**: Built-in intelligent discovery automatically searches Active Directory domain services to detect registered print servers and print queues across the corporate network, with an editable selector allowing administrators to target any print server or client workstation hostname or IP address on demand.
  - **Benefit**: Eliminates manual server configuration, allowing technicians to audit printing volume seamlessly across multiple branch offices, subnets, and domain structures.
* **Client Workstation Friendly Printer Name Resolution**:
  - **What was updated**: Enhanced the printing audit engine to automatically translate internal client-side printer connection identifiers into real, friendly printer names across all user workstations and print servers. Mappings are resolved on the fly using local device configurations, ensuring printer queues and devices display their true model and department names everywhere.
  - **Benefit**: Technicians no longer see cryptic internal identifier strings when analyzing reports from client computers, allowing immediate recognition of target printer hardware across the entire fleet.
* **Smart Target & Active User Pre-Selection**:
  - **What was updated**: When opening the report from any computer, printer queue, or workstation menu, the Print Server / Host and User dropdowns automatically pre-select the targeted computer and active logged-in user, while preserving selections during real-time data refreshes.
  - **Benefit**: Eliminates manual dropdown navigation and speeds up troubleshooting by immediately focusing the audit report on the exact machine and operator being analyzed.
* **Multi-Status Print Audit Telemetry (Completed, Failed, Cancelled & Rendering Errors)**:
  - **What was updated**: Expanded the audit engine to query and count all print job lifecycle events—including successfully printed jobs, failed or paused print runs, cancelled or deleted jobs, and document rendering errors. Added dedicated KPI metrics for Completed vs Failed/Cancelled jobs, with the status filter defaulting to all print activity.
  - **Benefit**: Provides complete visibility into printing reliability and failure rates, helping administrators identify troublesome drivers, jammed queues, and discarded jobs alongside successful page counts.
* **Extended Multi-Dimensional Filtering & Date Range Presets**:
  - **What was updated**: Equipped the reporting engine with instant date presets (Today, Yesterday, This Week, This Month, Last 30 Days, Last 90 Days, This Year, All History, and Custom Date Pickers), printer queue filters, user selectors, minimum page count thresholds to isolate bulk print runs, and job completion status filters.
  - **Benefit**: Empowers administrators to drill down into specific user behavior, isolate high-volume print runs, and generate tailored compliance reports in seconds.
* **Dynamic Log Retention & Large Buffer Year-to-Date Support**:
  - **What was updated**: Designed the reporting query engine to dynamically adapt to any server log buffer size without artificial caps. The system streams and calculates all available print events across the entire year-to-date span, accurately reporting total fleet pages, job counts, and average pages per job.
  - **Benefit**: Ensures reliable year-end and quarterly consumption audits regardless of whether the server buffer is configured for standard, large, or enterprise multi-year capacity.
* **Integrated Privacy Compliance Guide & Setup Instructions**:
  - **What was updated**: Added an in-app setup guide explaining the default Windows document name masking behavior, providing side-by-side visual comparisons of masked vs unmasked audit records, and offering step-by-step Group Policy and registry configuration steps to log original document file names.
  - **Benefit**: Helps organizations balance employee privacy requirements with document tracking compliance while giving administrators straightforward instructions to unlock full file name auditing.
* **Multi-Format Export & One-Click Printable Reports**:
  - **What was updated**: Enabled instant export to CSV spreadsheets, one-click clipboard copying formatted for spreadsheet pasting, and generation of professional, executive-ready printable HTML audit reports complete with summary KPI metric cards, volume share progress bars, and top-consumer rankings.
  - **Benefit**: Saves administrators significant time when preparing departmental chargeback reports, executive summaries, and paper consumption audits.

#### ⏰ Scheduled Remote Power Operations (Reboot, Shutdown, Log Off, Lock)
* **Interactive Date/Time Task Scheduling & Grace Periods**:
  - **What was updated**: Introduced a comprehensive Scheduled Power Actions suite under Security & Power Control menus for both individual workstations and bulk computer selections. Administrators can pick an exact execution date and time using calendar and clock selectors, provide an optional countdown warning message for active users, view currently scheduled power jobs, and cancel pending actions in a single click.
  - **Benefit**: Streamlines after-hours maintenance and automated facility shutdowns without requiring technicians to remain logged in late or disrupt staff during business hours.

#### 🖥️ Remote Screen Saver & Desktop Wallpaper Central Manager
* **Centralized Security Lockout & Corporate Branding Control**:
  - **What was updated**: Added centralized Remote Screen Saver configuration alongside bulk Wallpaper management, accessible via the context menu and a dedicated top toolbar button. IT administrators can remotely enable or disable the Windows screen saver, customize inactivity timeout durations, enforce password lockout upon resume, and deploy branded desktop backgrounds across single or multiple computers with detailed delivery reports.
  - **Benefit**: Simplifies corporate compliance by enforcing workstation lockout policies and standardized corporate branding across all enterprise endpoints in seconds without tedious manual visits.

#### 📈 Remote Windows Server Task Manager Disk Performance Counters
* **One-Click Disk Counter Activation & Rebuild**:
  - **What was updated**: Added a specialized diagnostic tool in the administration context menu to activate built-in Task Manager disk throughput metrics and refresh performance libraries on remote Windows Server systems.
  - **Benefit**: Instantly brings real-time disk read/write throughput and response time graphs into the standard Task Manager on Windows Server installations where disk performance counters are disabled by default.

#### 🌐 Active Directory Domain Controller & DNS Server Troubleshooting
* **Dedicated Identity & Name Resolution Diagnostics**:
  - **What was updated**: Added a specialized troubleshooting submenu that automatically displays whenever a Domain Controller or DNS server is selected. Features one-click actions to restart the DNS Server service, restart the DNS Client resolver cache, clear the DNS resolver cache, test external DNS reachability (pinging 8.8.8.8), and perform custom DNS name lookups with real-time diagnostic output.
  - **Benefit**: Greatly accelerates Active Directory and domain name resolution diagnostics, enabling administrators to resolve DNS stalls and verify name resolution in seconds without initiating heavy remote desktop sessions.

#### 💬 On-Screen Message Delivery & User Acknowledgement Tracker
* **Real-Time Read Receipts & Acknowledgement Audit**:
  - **What was updated**: When broadcasting urgent modal messages, the system launches an interactive delivery and user acknowledgement dashboard. The tracker monitors each target computer in real time, displaying the logged-in username, delivery status, and exact timestamp when each user clicks "OK" to acknowledge the message. When all recipients have confirmed, a completion banner displays: "The message has been acknowledged by everyone."
  - **Benefit**: Delivers verified compliance and peace of mind for critical IT alerts, facility notices, and emergency communications by proving exactly which users read and acknowledged the notice.

#### 📊 Real-Time Performance Monitor High-Density Deep History
* **Full-Window Canvas Expansion & 10-Minute Historical Buffers**:
  - **What was updated**: Upgraded the Live Performance & Hardware Monitor with a 600-sample historical rolling buffer. Clicking any metric chart (CPU, RAM, Network, Disk) maximizes it across the entire window width, dynamically adjusting time resolution to show up to 10 minutes of deep rolling telemetry with an informative duration header. Clicking again returns smoothly to the 4-quadrant layout.
  - **Benefit**: Uncovers transient performance spikes, resource leaks, and network dropouts over extended observation windows while preserving the fast 4-chart dashboard overview.

#### 🔍 Inactivity & Presence Monitoring Agent Health & Multi-Tier Diagnostics
* **Four-Tier Deployment & Telemetry Verification Engine**:
  - **What was updated**: Added an interactive agent health verification dialog accessible from the Diagnostics context menu ("Check Inactivity Agent Status & Diagnostics..."). Instantly diagnoses the remote monitoring agent using a definitive four-state model: "Installed & Active", "Installed but Not Active / Not Reporting", "Not Installed", and "Unknown / Unable to Detect". Cross-verifies background system services, process execution, binary files, and telemetry heartbeat freshness, with direct one-click remediation actions to start services or redeploy.
  - **Benefit**: Eliminates ambiguity when endpoints appear idle or stop reporting telemetry, giving administrators precise visibility into agent health and instant tools to restore monitoring without manual intervention.

#### 🖨️ Network Printer Supplies & Ink/Toner Level Telemetry
* **Direct Network Marker Supply Monitoring (Toner, Ink & Drum)**:
  - **What was updated**: Enhanced the Remote Printers & Print Queue Manager with native, agentless network telemetry querying for networked and shared printers. The system automatically extracts printer network addresses and queries live marker supply levels (Black, Cyan, Magenta, Yellow toners and drums) directly in the background. Displays intuitive color-coded supply badges (Green for healthy, Amber for low supplies under 20%, Red for critical replenishment under 10%) alongside exact percentages and detailed hover tooltips breaking down every consumable compartment. For local virtual devices or software print engines, the interface cleanly displays "Not Available / Unsupported".
  - **Benefit**: Prevents unexpected printer stoppages and accelerates helpdesk resolution by allowing technicians to audit toner and ink levels in real time across the domain without accessing physical printer control panels or vendor web consoles.
* **Underlying Network Port Resolution & Clear Device Offline Distinction**:
  - **What was updated**: Added automatic cross-referencing of printer queues with their underlying network port definitions to resolve the actual host address, ensuring devices whose port names differ from their target IP address are seamlessly discovered. When a networked printer is powered off or unplugged from the local network, the interface distinctly reports "Offline / Unreachable" with an informative hover tooltip detailing the unreachable address and network timeout, clearly separating powered-off hardware from virtual or unsupported devices.
  - **Benefit**: Eliminates confusion by pinpointing whether a missing supply reading is due to an unplugged or powered-off physical device versus unsupported hardware, while resolving misnamed print server ports without requiring manual configuration changes.

#### 🎯 Inactivity & Presence Monitoring Status Indicator — High-Contrast Multi-Theme Visual Status
* **Intuitive Four-State Visual Color Mapping**:
  - **What was updated**: Standardized the visual status dot in the main computer inventory list to strictly reflect the four-tier monitoring agent health model: Green (`#10B981`) for Installed & Active, Amber (`#F59E0B`) for Installed but Inactive, Dark Slate/Black (`#0F172A` with adaptive outline) for Not Installed, and Red (`#EF4444`) for Unknown / Host Offline. Enhanced the indicator with a dynamic multi-line tooltip revealing detailed agent service status, background process activity, and last recorded telemetry timestamp.
  - **Benefit**: Enables administrators to audit agent deployment status across hundreds of domain computers at a single glance, instantly differentiating unmonitored systems from network unreachable hosts without opening diagnostic menus.

#### 🗑️ Local Computer Users & Security Manager — Secure User Deletion & Safeguards
* **Administrative Safeguard Confirmation Workflow**:
  - **What was updated**: Added a dedicated **Delete User** action to the Local Computer Users & Security Manager interface and context menu. When invoked, the system presents an explicit confirmation dialog displaying the user's account details and a prominent warning: "Are you sure you want to delete this user? Once deleted, the user account cannot be restored." To prevent accidental removal, IT administrators must re-enter their administrative account password and type a confirmation keyword.
  - **Benefit**: Empowers IT administrators to cleanly remove obsolete, orphaned, or unauthorized local user accounts remotely from endpoints with enterprise-grade safeguard protections, avoiding accidental lockout or destructive user removal.
* **Essential Account Protection Shield**:
  - **What was updated**: Built-in intelligent protection safeguards automatically block deletion attempts against essential system accounts, default guest profiles, and currently authenticated administrator accounts.
  - **Benefit**: Protects workstations from accidental system corruption and lockout, ensuring critical local administrative access remains permanently intact.

#### ⏱️ Remote System Restore Point Manager — Checkpoints, Recovery & State Management
* **Remote System Restore Point Configuration & History**:
  - **What was updated**: Introduced a comprehensive **System Restore Manager** accessible from the workstation context menu under Customization, Automation & Deployment and Diagnostics & Health. Administrators can remotely check whether System Restore protection is active, enable or disable protection on the system drive, create named on-demand restore points before executing risky installations or updates, view a chronological history of all available restore points with creation dates and sequence numbers, and remotely roll back the endpoint to any previous restore checkpoint with automatic restart confirmation.
  - **Benefit**: Provides a crucial safety net for helpdesk and infrastructure teams, allowing them to capture snapshot checkpoints before applying major software changes or configuration updates, and effortlessly recover non-booting or misconfigured computers remotely without physical visits.
* **Granular Checkpoint Details & Emergency Recovery Actions**:
  - **What was updated**: The interactive restore manager displays the sequence number, creation date and time, restore point event type, and descriptive tags for every snapshot taken on the machine, accompanied by clear action buttons for immediate refresh, creation, and rollback.
  - **Benefit**: Gives administrators full visibility into the machine's recovery history, enabling precise rollbacks to known-good operational states in emergencies.


#### 📦 Comprehensive Installed Software Discovery & Architecture Detection
* **Multi-Architecture 64-Bit & 32-Bit Registry & Directory Scan**:
  - **What was updated**: Upgraded the remote software detection engine to perform a thorough, multi-architecture scan of all installed applications on the target computer. The discovery engine now inspects both 64-bit and 32-bit software registries, system-wide and user-specific application directories, and includes automated fallback discovery to guarantee that all business applications, browser extensions, productivity suites, and utilities are accurately identified and listed.
  - **Benefit**: Ensures IT asset managers and systems administrators have an exhaustive, true-to-life inventory of all software installed on remote computers, eliminating "missing application" blind spots during software audits or remote uninstallation tasks.


#### 📐 Optimized Bottom Administration Panel Spacing & Visual Flow
* **Visual Dividers & Toolbar Separation**:
  - **What was updated**: Enhanced the visual separation and spacing in the lower toolbar, introducing a clean divider separator immediately after the Network Drives button before the Profile actions begin.
  - **Benefit**: Improves visual clarity and ergonomic navigation across the administrative toolbar, preventing accidental clicks between shared folder actions and user profile operations.

#### 📋 Enhanced LAPS Credential Clipboard Management
* **Formatted Local Username & Credential Copy Actions**:
  - **What was updated**: Expanded the Local Administrator Password Solution (LAPS) management window with quick-copy actions: administrators can now copy the managed username pre-formatted for direct local authentication (`.\Administrator` format), copy the plain password, or copy full formatted credentials (username and password together) with a single click.
  - **Benefit**: Accelerates administrator logon workflows during remote troubleshooting, preventing domain prefix confusion when logging into local accounts and enabling seamless one-click credential pasting into remote login prompts.

#### 🛡️ Streamlined Default Session Permissions & User Awareness
* **User-Centric Default Connection Preferences**:
  - **What was updated**: Optimized the default states for remote session connection toggles: **Alert User**, **Ask User Permission**, and **Full Control** are now enabled by default upon application launch.
  - **Benefit**: Upholds user privacy and corporate courtesy standards by ensuring remote users are notified and prompted before their screens are shared, while immediately granting technicians full keyboard and mouse control once permission is granted.

#### 🏷️ Dynamic Version Synchronization & Seamless Header Updating
* **Centralized Version Representation Across All Screens**:
  - **What was updated**: Streamlined version number propagation across all application components—including the splash loading screen, title header, about dialogs, and build packaging scripts. Version numbers are now centrally derived and updated across the user interface without leaving outdated static version tags.
  - **Benefit**: Ensures administrators always see accurate, coherent version information across every screen and dialog during deployment, testing, and production operations.

#### ⚡ Remote Group Policy Refresh — Guaranteed Remote Execution & Progress Tracking
* **Guaranteed Remote Target Execution & Verification**:
  - **What was updated**: Re-architected the remote group policy update tool to guarantee that policy refreshes execute strictly and directly on the targeted remote endpoint rather than the local administrator computer. Added interactive progress reporting, completion status codes, and direct access to remote event logs to verify successful policy application.
  - **Benefit**: Assures systems administrators that group policy updates are reliably applied to remote machines on demand, with transparent verification and zero risk of unintentionally refreshing local administrator policies.

#### ⚡ Remote Network Adapter — One-Click Network Repair & Reset Suite
* **Autonomous Multi-Stage Network Reset Engine**:
  - **What was updated**: Added a dedicated **One-Click Network Repair** action to the Remote Network Adapter configuration manager, the right-click Network & Connectivity context menu, and the Ping tools menu. When clicked, the application stages an autonomous repair script directly on the endpoint that sequentially executes a complete network overhaul: DNS cache flush, dynamic DNS registration, ARP/NetBIOS cache flush, Winsock catalog reset, TCP/IP stack reset, network adapter restart, and DHCP IP release and renewal.
  - **Benefit**: Resolves complex remote network connectivity dropouts, stale DNS mappings, corrupted socket states, and IP conflicts in a single click without requiring an administrator to connect interactively or run disparate command-line tools.
* **Resilient Disconnected Endpoint Execution & Rebind Polling**:
  - **What was updated**: Engineered a resilient decoupled execution architecture that guarantees the repair process completes on the client PC even when the network interface temporarily loses IP connectivity during the DHCP release stage. The administrator console actively polls the client computer with intelligent backoff until the network adapter completes its renewal and re-establishes connectivity.
  - **Benefit**: Prevents broken or orphaned remote troubleshooting sessions, ensuring the repair script runs to 100% completion and re-establishes contact automatically.
* **Detailed Multi-Step Execution Results DataGrid**:
  - **What was updated**: Designed an interactive results dialog featuring a real-time progress bar, overall status banner, and a structured DataGrid showing every individual command executed, execution status (Success, Failed, or Skipped), timestamp, completion exit code, and detailed command output, accompanied by a one-click clipboard copy button.
  - **Benefit**: Gives network administrators granular visibility into which specific network subsystem reset succeeded or failed, providing instant audit proof and troubleshooting clarity.

#### 📈 Unified Live Performance Monitor & Full-Screen Deep Monitoring Architecture
* **Integrated Hardware, System Identity & Storage Architecture**:
  - **What was updated**: Consolidated the standalone hardware diagnostics tools directly into the **Live Workstation Performance & Resource Monitor** under the dedicated **Hardware & Subsystems** tab. Administrators now have unified access to Motherboard & Service Tag identification (with 1-click clipboard copy), Operating System details, continuous uptime counter with automated warnings for systems running without rebooting for over 14 days, Processor core topology, physical RAM DIMM breakdown, logical storage volumes with visual capacity progress bars and health alerts, physical disk interfaces, and active network controllers with real link speeds.
  - **Benefit**: Eliminates redundant dialog windows, allowing administrators to inspect both live real-time performance metrics and deep underlying hardware specifications within a single consolidated dashboard.
* **Full-Screen Deep Monitoring View for Real-Time Charts**:
  - **What was updated**: Added interactive deep monitoring expansion to the live performance graphs (CPU Utilization, Memory Allocation, Network Bandwidth, and Disk I/O). Double-clicking any graph or clicking the expand button immediately maximizes that single metric into a full-window deep monitoring view with timeline axis markings (-60s to Now), 4 real-time KPI indicator cards (Current, Peak/Max, Low/Min, and Rolling 60s Average), and high-resolution sparkline visualization.
  - **Benefit**: Allows systems engineers to perform in-depth telemetry analysis on individual resource bottlenecks with expanded visual resolution, and quickly return to the 4-graph overview with a single click or by pressing Escape.
* **One-Click System Specifications Export**:
  - **What was updated**: Added a **📋 Copy Specs** button to the Live Performance Monitor footer that automatically copies a cleanly formatted, comprehensive text summary of the target workstation's hardware identity, operating system, processor, memory, storage volumes, and network adapters to the Windows clipboard.
  - **Benefit**: Enables helpdesk technicians to paste complete computer specifications directly into IT support tickets, asset management databases, or vendor support requests in seconds.

#### 🔓 Remote Desktop (RDP) Enablement, Diagnostic Suite & Multi-Action Controls
* **Pre-Flight Port 3389 Reachability & Automated Activation Prompt**:
  - **What was updated**: When an administrator initiates a Remote Desktop connection from the toolbar or context menu, the application automatically performs an ultra-fast pre-flight reachability check on TCP port 3389. If Remote Desktop is disabled or blocked on the target machine, a dedicated smart prompt appears immediately offering to enable Remote Desktop, configure the required background services, and open the firewall rule with a single click.
  - **Benefit**: Eliminates frustrating timeout delays and connection failures caused by turned-off Remote Desktop settings or blocked firewall ports on target endpoints.
* **Dedicated Remote Desktop Configuration & Diagnostic Center**:
  - **What was updated**: Created an interactive diagnostic and configuration window accessible via the new RDP dropdown arrow on the main toolbar, right-click context menu, and lock screen controller. The window inspects the remote computer's current Remote Desktop enablement state, Network Level Authentication (NLA) enforcement, and TCP port 3389 listening status, with one-click toggles to enable or disable Remote Desktop, start background services, and configure firewall rules.
  - **Benefit**: Provides administrators with complete visibility into remote terminal settings without having to run multiple manual troubleshooting tools or commands.
* **Bulk Remote Desktop Configuration across Multiple Computers**:
  - **What was updated**: Enabled bulk Remote Desktop activation across multiple selected workstations simultaneously from the multi-computer context menu, complete with real-time per-workstation progress tracking, automated background service configuration, and summary reporting.
  - **Benefit**: Allows IT teams to prepare, enable, and standardize Remote Desktop access across dozens or hundreds of computers in a single automated operation during mass deployments or maintenance windows.
* **Integrated Lock Screen Takeover Remote Desktop Activation**:
  - **What was updated**: Added a dedicated Remote Desktop enablement button directly inside the Physical Lock Screen Takeover Controller card, allowing administrators to activate Remote Desktop and verify port readiness on locked workstations prior to taking them over.
  - **Benefit**: Guarantees administrators can connect to and take over locked workstations even if Remote Desktop was previously disabled.

#### 👁️ Show Password & Clipboard Copy — Local Computer Users & Security Manager
* **Show / Hide Password Toggle**:
  - **What was updated**: Added a **Show / Hide** toggle button next to the password field in both the **Create Local User** dialog and the **Reset Password** dialog inside the Local Computer Users & Security Manager. By default, the password is masked for privacy during screen sharing or over-the-shoulder situations. Clicking **👁️ Show** reveals the exact characters; clicking **🙈 Hide** returns to masked view.
  - **Benefit**: System administrators can visually confirm the exact password they are about to set before committing, eliminating typo-related lockouts on remote accounts.
* **One-Click Password Copy to Clipboard**:
  - **What was updated**: Added a **📋 Copy** button alongside the password field in both dialogs. Clicking Copy places the current password directly on the Windows clipboard regardless of whether the field is in masked or visible mode.
  - **Benefit**: Allows administrators to immediately paste the new password into a secure notes application, a credential vault, or a remote session window without retyping — reducing human error during password handoffs.
* **Live Password Policy Banner**:
  - **What was updated**: When the Create Local User dialog opens, the application automatically queries the target workstation's active security policy in the background and displays a live banner showing the minimum password length and whether complexity requirements are enforced (e.g. "minimum 8 characters; uppercase + lowercase + number + symbol required").
  - **Benefit**: Administrators instantly know which password rules apply on the target machine before typing anything, preventing failed creation attempts due to unseen policy restrictions.



#### 🔑 Windows LAPS & Local Administrator Password Management Suite — Native Decryption, Plain-Text Viewing, Instant Rotation & Expiration Scheduling
* **Modern Windows LAPS & Encrypted Password Support**:
  - **What was updated**: Upgraded the local administrator password engine with multi-tier architecture supporting modern Windows LAPS encrypted attributes, plaintext Windows LAPS attributes, and legacy Active Directory password solutions. The system automatically detects and decrypts protected local administrator credentials securely from the domain controller.
  - **Benefit**: System administrators can inspect managed local credentials across modern operating systems even when centralized encryption policies are strictly enforced, eliminating false "not configured" alerts.
* **Plain-Text Password Viewing & Instant Clipboard Copy**:
  - **What was updated**: Added an interactive plain-text toggle to instantly switch between masked password bullets and clear-text view, along with dedicated display of the managed local administrator account name and a 1-click clipboard copy button.
  - **Benefit**: Helpdesk and systems engineers can quickly verify, read, or copy the exact managed password when performing local maintenance or emergency console recovery on remote workstations.
* **Instant Password Rotation ("Expire Now")**:
  - **What was updated**: Introduced a 1-click password rotation capability that immediately sets the expiration timestamp to the current time in Active Directory and prompts the remote workstation to generate a fresh managed password and synchronize it back to the directory.
  - **Benefit**: Enables administrators to instantly rotate compromised or shared local administrator passwords on demand without waiting for background group policy refresh cycles.
* **Custom Calendar Expiration Scheduling & Quick Presets**:
  - **What was updated**: Integrated a visual calendar picker and quick preset buttons (+7 Days, +30 Days, +60 Days, +90 Days) allowing administrators to extend or schedule the exact expiration date and time of the local administrator password directly from the console.
  - **Benefit**: Gives administrators full lifecycle control over credential validity, streamlining emergency access windows and audit compliance.
* **Real-Time Expiration Countdown**:
  - Shows a live countdown of days and hours remaining before the credential expires, including the last rotation timestamp. Helps administrators stay on top of password hygiene without checking Active Directory manually.
#### 🛡️ Enterprise Security Policies & Multi-Tier Lockout Governance
* **Security Policy Screens**:
  - When access is restricted by a security policy, the application shows a dedicated screen identifying the exact policy in effect (outdated version, quarantined device, or suspended domain), the incident reference ID, and clear next steps.
* **Request Unlock Workflow**:
  - Restricted administrators can request a temporary unlock directly in the application. An authorized Domain Administrator grants a time-limited bypass — no restarts or manual configuration needed.
* **Access Restricted Alert (Domain Admins Only)**:
  - Non-admin users who try to open the application see a clear alert explaining that Domain Administrator privileges are required, with a self-service option to recheck authorization.
* **Scoped Security Keys**:
  - Emergency unlock keys can target the entire fleet, a specific domain, or a single workstation — ensuring one key cannot unlock unintended machines.

#### ⚡ Workstation Right-Click Context Menu — Fast Action Search Bar, Target Header & Deduplicated Organization
* **Fast Action Search**:
  - Type any keyword (e.g. "rdp", "reboot", "ping") into the right-click menu to instantly filter all tools. Press Enter to launch the top result.
* **Target Device Header**:
  - Shows the targeted computer name, IP, and live status at the top of the menu so you always know which machine you're acting on.
* **Reorganized Submenu Structure**:
  - The right-click menu is now organized into 7 clear categories (Administration, Diagnostics, Network, Active Directory, Files, Customization, Power). All tools appear once, in the right place — no duplicates.
* **Bulk Operations Fast Action Search & Layout Polish**:
  - **What was updated**: Brought the same fast search bar and restructured category layout to multi-device bulk selections, enabling operators to filter and execute bulk operations across dozens or hundreds of computers simultaneously.
  - **Benefit**: Accelerates fleet maintenance tasks such as bulk wallpaper changes, temp file purges, group policy refreshes, and software deployments.

#### ⏱️ Inactivity & Idle Monitor Agent — Multi-Stage Teardown Lifecycle & Instant Fast Action Search
* **Multi-Stage Remote Agent Teardown & Process Elimination**:
  - **What was updated**: Re-architected the remote Inactivity Monitor removal routine to perform a thorough, multi-stage teardown. The application now resets service recovery actions, disables and stops the background service, deletes scheduled tasks across interactive sessions, terminates all running agent instances across user sessions using both privileged process termination and remote task management, applies multi-attempt retry logic with normal file attribute normalization to completely remove agent binaries and metrics data stores, and strictly verifies file deletion before reporting completion. If agent files remain locked, the routine reports detailed diagnostics instead of prematurely signaling success.
  - **Benefit**: Guarantees complete, clean uninstallation of the monitoring agent from remote endpoints without leaving orphaned background processes, stale metrics files, or lingering lock screen timers behind.
* **Dynamic Workstation State & Bulk Actions Synchronization**:
  - **What was updated**: Enhanced real-time synchronization between endpoint monitoring status and application UI controllers. Upon successful removal, workstation state timers immediately reset to standard session statuses (clearing idle minutes), the top Bulk Action button dynamically transitions to "Install Monitor", and single-device context menus immediately enable fresh deployment actions while disabling removal.
  - **Benefit**: Eliminates false "Installed" indicators and ensures operators always see the true, real-time installation and monitoring state of every computer across the Active Directory fleet.
* **Standardized "Monitor" Terminology & Instant Fast Action Search**:
  - **What was updated**: Standardized all menu item titles, action headers, and search keywords to include the word "Monitor" (such as "Deploy Inactivity & Idle Monitor Agent", "Uninstall Inactivity & Idle Monitor Agent", and "Inactivity Monitor Agent Already Installed").
  - **Benefit**: Typing "Monitor" into the fast action search box in both single-device and bulk right-click menus immediately displays relevant deployment and removal actions, eliminating search misses.


#### 📋 Remote Windows Event Viewer & Security Audit Hub — Comprehensive Presets, Real-Time Filtering & Channel Expansion
* **Categorized Quick Presets Dropdown with Rich Visual Styling (Over 35 Enterprise Presets)**:
  - **What was updated**: Upgraded the event log viewer with an organized Quick Presets dropdown library featuring over 35 enterprise forensic and troubleshooting presets with category-tailored visual palettes (emerald for users, amber for LAPS, indigo for groups, teal for file shares, sky blue for logon, rose for security threats/lockouts, purple for system diagnostics, orange for operations), high-contrast category badges, Segoe UI Emoji icons, clean display titles, and dedicated event identification pill tags. Includes Windows LAPS password audits (retrievals, automatic rotations, rotation failures), complete user account lifecycle (account creation, deletion, enable/disable status, lockouts, unlocks, attribute modifications, admin password resets, self-service password changes), security group operations (member additions, removals, group creations, deletions, modifications), network file share auditing (share connections, detailed file access checks, file creations, file edits, file deletions, permission modifications), logon and authentication diagnostics (successful logons, failed logons, administrator privilege assignments, explicit credentials, Kerberos pre-authentication errors, remote desktop connections), security and threat detection (new Windows services installed, audit policy tampering, firewall status modifications, Windows Defender malware alerts, PowerShell script executions, process creations), system reliability (clean reboots, shutdowns, unexpected power cuts, blue screen crashes, application hangs, service failures, hard drive bad blocks, BitLocker recovery key backup), and infrastructure diagnostics (completed print jobs, spooler failures, network IP conflicts, DNS timeouts, Windows Update patches, Group Policy processing errors, scheduled task failures).
  - **Benefit**: Transforms the dropdown into an intuitive visual forensic catalog, allowing operators to rapidly distinguish between different categories of events and audit operations at a glance without memorizing event numbers or constructing complex queries.
* **Instant Type-to-Find Preset Search with Continuous Keyboard Input**:
  - **What was updated**: Enhanced the embedded quick-find search box beside the Quick Presets dropdown with continuous keyboard focus retention. Typing multi-letter keywords smoothly filters the preset catalog in real-time without losing focus or interrupting input, with Down Arrow key navigation to enter the dropdown list and Enter key selection to apply the top matching preset.
  - **Benefit**: Eliminates focus interruptions after typing the first character, providing a rapid, seamless search experience that allows administrators to find and launch any event preset with minimal keystrokes.
* **Forensic Entity Filtering Toolbar (User, Host, IP & File Operations)**:
  - **What was updated**: Integrated a dedicated real-time Entity Filtering toolbar providing instant filtering across four core forensic dimensions: User / Account, Computer / Host, IP Address, and File / Object Path, complete with an interactive Exact File Match option and live filtered result counters.
  - **Benefit**: Enables sysadmins and security responders to isolate specific user actions, trace individual client IP addresses, investigate single machine activities, or pinpoint exact file deletions and modifications in seconds without writing manual queries.
* **Dedicated Sortable Forensic Columns**:
  - **What was updated**: Added dedicated columns for User / Account, Computer / Host, IP Address, and File / Object Path directly in the main event grid with interactive one-click column header sorting.
  - **Benefit**: Gives administrators full sorting capability across usernames, workstation hostnames, network addresses, and file paths alongside timestamp and severity levels.
* **Native Remote Server-Side Filtering Engine**:
  - **What was updated**: Upgraded the remote event query architecture to execute server-side filtering directly against the remote computer's native Windows Event Log subsystem. When a preset is chosen, the remote host processes the filter directly and transmits only matching event records over the network.
  - **Benefit**: Maximizes query speed and responsiveness, retrieving hundreds or thousands of target records in milliseconds without transmitting irrelevant event records or missing historical events that occurred outside a narrow window.
* **Full Multi-Channel Auditing & Coverage**:
  - **What was updated**: Expanded channel selection to include Security, Windows LAPS, Setup, Remote Desktop Local Session Manager, Print Spooler, Task Scheduler, Windows Defender, DNS Client, Active Directory Directory Service, and DNS Server, alongside System and Application logs.
  - **Benefit**: Provides comprehensive visibility into the entire Windows operational ecosystem and domain controller health from a single unified diagnostic interface.
* **Vivid Audit Success, Audit Failure & Verbose Severity Badging**:
  - **What was updated**: Introduced dedicated visual classification badges for Audit Success (vibrant Emerald Green), Audit Failure (vibrant Rose Red), and Verbose/Debug (rich Purple), complete with light and dark theme styling, distinct category filtering, and refined data grid pill formatting.
  - **Benefit**: Dramatically enhances forensic readability, allowing administrators to immediately spot authentication rejections, unauthorized access attempts, and successful administrative actions at a glance.
* **Massive Query Capacity (Up to 10,000 Records)**:
  - **What was updated**: Expanded event limit options to include 1,000, 2,000, 5,000, and 10,000 events, supported by high-speed reverse-chronological streaming.
  - **Benefit**: Delivers deep historical audit capacity for busy corporate servers and domain controllers, enabling thorough forensic investigations across weeks or months of activity.
* **Rapid-Access Emergency Action Pills**:
  - **What was updated**: Embedded dedicated one-click action pills for the most frequent emergency diagnostic scenarios: Critical Errors, Account Lockouts, User Account Operations, Group Memberships, File Share Access, Windows LAPS, Blue Screen Crashes, and System Reboots.
  - **Benefit**: Provides immediate single-click access to urgent troubleshooting filters with zero configuration required.
* **Dedicated Group Policy & GPUpdate Diagnostics Presets Suite**:
  - **What was updated**: Added a comprehensive suite of Group Policy presets covering the entire policy lifecycle: All Policy & GPUpdate Activity (tracking policy refreshes, client-side extension executions, and processing results), Policy Errors & Failures (detecting unreachable domain controllers, network timeouts, access issues, and processing faults), Software Installation Deployment (monitoring software assigned, removed, installation failures, and reboot requirements), and Successful Policy Refreshes (verifying clean policy updates and newly detected settings).
  - **Benefit**: Empowers administrators to immediately verify whether a policy refresh succeeded, identify exactly which policies or client-side extensions failed, and diagnose software deployment issues on any workstation in seconds.
* **1-Click GPUpdate Diagnostic Action Pill**:
  - **What was updated**: Added a dedicated single-click action pill button on the top presets toolbar that instantly loads and streams all Group Policy and policy refresh events for the target machine.
  - **Benefit**: Provides zero-click configuration to check policy update results immediately without navigating menus or constructing manual filters.
* **Group Policy Operational Channel Expansion**:
  - **What was updated**: Added the dedicated Windows Group Policy Operational event channel to the channel selection dropdown, enabling native retrieval of deep policy processing logs and client-side extension execution timelines.
  - **Benefit**: Gives sysadmins full visibility into granular policy processing stages, client-side extension durations, and detailed error reports directly from the remote workstation.
* **Accurate Severity Level & Audit Badge Classification**:
  - **What was updated**: Corrected event severity categorization so that non-security operational warnings and errors (such as Group Policy client-side extension warnings and software installation errors) are accurately identified and badged as Errors or Warnings rather than Audit Success.
  - **Benefit**: Prevents diagnostic confusion by ensuring that warning and error states are clearly highlighted with vivid red and amber badges.
* **Context Menu & GPUpdate Workflow Integration**:
  - **What was updated**: Added direct context menu shortcuts to view Group Policy event logs, and updated the remote policy refresh action to offer immediate access to live event streaming upon triggering a policy update.
  - **Benefit**: Seamlessly connects remote policy refresh commands with real-time verification logs, allowing operators to trigger an update and immediately verify the results on the target workstation.
* **Group Policy Diagnostics & Streamlined Record Visibility**:
  - **What was updated**: Refined in-memory filter coordination and stream completion indicators when executing Group Policy and policy refresh diagnostic presets. Remotely retrieved events appear immediately in the event grid without interference from filter field text, and the details pane displays a clear confirmation message as soon as event retrieval completes.
  - **Benefit**: Guarantees that all retrieved Group Policy and policy refresh events are immediately visible and selectable, eliminating perceived loading stalls and providing instant confirmation that event streaming has completed.
* **Enhanced Forensic Technical Details & CSV Audit Export**:
  - **What was updated**: Enhanced the event technical details pane and CSV audit export to automatically parse and display structured entity metadata (user accounts, hostnames, IP addresses, and file paths), alongside raw event descriptions.
  - **Benefit**: Accelerates incident documentation and evidence collection for compliance, auditing, and threat investigation workflows.

#### 🏷️ Remote Computer Management & Identity Operations
* **Encrypted Management Channel for Remote Computer Rename**:
  - **What was updated**: Enforced packet-level privacy encryption across administrative remote control channels during remote computer rename operations and privileges diagnostic checks, supporting both current session credentials and alternate Domain Administrator credentials. Also reinforced script execution fallbacks with direct binary encoding.
  - **Benefit**: Completely eliminates connection encryption rejections, enabling administrators to rename remote computers reliably across Active Directory networks with full compliance and zero security policy errors.

#### 📈 Live Workstation Performance & Resource Telemetry — High-Resilience Engine & Layout Polish
* **Resilient Non-Blocking Telemetry Engine**:
  - Telemetry sampling across processor load, memory allocation, network throughput, and storage activity now executes sequentially with strict 3-second safeguards, eliminating remote background stalls and deadlocks when querying long-uptime workstations.
  - Eliminates the need to restart client workstations to access real-time system performance telemetry.
* **Instant Hardware Link Speed Detection**:
  - Network interface inventory immediately identifies and displays true hardware connection speeds (e.g. 1.0 Gbps or 100 Mbps) during initial system connection, replacing generic auto-sensing placeholders with verified network interface metrics.
* **Window-Level Network Telemetry Calibration Status Banner**:
  - Added an informative, high-visibility status banner docked prominently at the bottom of the Live Performance Monitor window that clearly alerts administrators across all tabs while initial real-time bandwidth performance counters are calibrating (15–30 sec), transitioning seamlessly to confirmed active throughput reporting once counters synchronize.
* **Proportional Auto-Fit Column Layout & Expanded Minimum Widths**:
  - Redesigned the Network Adapters table with responsive, proportional column widths and generous minimum sizing that automatically fit to the full window width, ensuring network interface descriptions, real-time transfer speeds, and session bandwidth totals are cleanly presented without cramped columns or truncated text.
* **Instant Fail-Safe Performance Fallbacks**:
  - Automatically engages immediate standard system fallbacks if advanced high-frequency performance counters are sluggish or unavailable on remote computers, guaranteeing continuous live CPU and RAM reporting without interruption.
* **Proactive Network Hardware Availability**:
  - Automatically populates active network interfaces from verified hardware scan records if real-time bandwidth performance counters return empty, ensuring network adapters and IP addressing always display reliably.
* **Asynchronous Core Services Discovery**:
  - Windows Services catalog enumerates smoothly in the background without blocking core telemetry polling loops, ensuring instant visibility into processor, memory, and network throughput while services load.
* **Windows Services Toolbar Layout Polish**:
  - Fixed button positioning alignment on the Windows Services tab toolbar, ensuring action controls (Start, Stop, Restart, Start by Name) render with full width, clean spacing, and zero button clipping.


#### 📢 In-App Broadcast Studio & Notification Dispatcher — Delivery & Read-Status Tracking System
* **Complete Status Lifecycle (Sent ➔ Received ➔ Read ➔ Acknowledged)**:
  - Replaced the previous static "Active" display with a granular delivery and read-status tracking lifecycle that monitors the actual progression of notifications on remote client workstations.
  - **Sent / Pending**: Notification has been dispatched by administrators and queued for delivery across target workstations.
  - **Received**: Notification has reached the remote client workstation and is currently displayed on the operator's screen.
  - **Read**: Notification was viewed and dismissed by the operator clicking the close action.
  - **Acknowledged**: When explicit acknowledgement is mandated, certifies that the operator clicked the confirmation button to acknowledge compliance.
  - **Expired / Revoked**: Indicates broadcasts whose scheduled lifetime expired or which were manually withdrawn by administrators.
* **Mandatory Acknowledgement Mode**:
  - Broadcast Studio composer includes a 1-click **"Require Explicit Acknowledgment"** option.
  - When enabled, the remote banner presents a prominent **`✓ Acknowledge`** button instead of a simple dismiss action, ensuring critical security advisories, policy updates, and emergency maintenance notices cannot be closed without verification.
* **Contextual Action Lifecycle Management**:
  - The **Deactivate** button is now contextually restricted to broadcasts that are actively circulating or pending on client workstations.
  - Once all targeted endpoints have successfully read or acknowledged the notice, the broadcast automatically transitions to **`✓ Completed`**, preventing redundant deactivations.
* **Dedicated Verification Action — Streamlined Single Acknowledge Interaction**:
  - Eliminated the ambiguous close icon from client workstation banners in favor of a prominent, mandatory **`✓ Acknowledge`** action button.
  - Ensures notices are confirmed before they can be dismissed — no silent closes.
* **Dynamic Fleet Reach Progress & Receipts Audit Ledger**:
  - Replaced static placeholder percentages with dynamic reach analytics calculated in real-time from active workstations in the target scope.
  - Interactive **`📋 Receipts`** inspection modal opens an itemized compliance audit trail detailing workstation computer names, logged-in operators, Active Directory domains, delivery timestamps, and receipt status badges.

#### 💬 In-App Feedback & Star Ratings System
* **Mandatory Rating & Message Validation**:
  - Requires operators to select both a star rating (1 to 5 stars) and enter detailed comments or suggestions before submitting, ensuring complete, actionable feedback for ongoing development.
* **Granular Category Classification**:
  - Allows operators to categorize submissions into General Experience & Praise, Feature Requests & Enhancements, Bug Reports & Technical Issues, or Performance Suggestions.
* **Streamlined Telemetry Dispatch**:
  - Automatically captures machine, user, and domain context seamlessly alongside ratings and feedback suggestions.

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

#### ✅ Accurate Activity Logging — Local Account Operations
* **Truthful Operation Result Recording**:
  - **What was updated**: Corrected a silent reporting flaw in the Local Computer Users & Security Manager where the activity log recorded "success" even when a local user account was not actually created on the target workstation. Logs now only record a success entry after verifying that the account genuinely exists on the target machine. Failed attempts record the precise reason for failure, including the actual rejection message from Windows (such as minimum length, complexity, or duplicate account).
  - **Benefit**: System administrators can trust the Activity Log as an accurate record of what actually occurred on each workstation, eliminating confusion from misleading success entries that masked silent failures.

#### 🔐 Automatic Windows Password Policy Enforcement — Local Account Creation
* **Pre-Validation Before Account Submission**:
  - **What was updated**: When creating a local user account, the application now automatically reads the active password security policy from the target workstation in the background and validates the chosen password before any creation attempt is made. If the password is too short for the configured minimum length, a clear dialog explains the exact requirement and prevents submission. If complexity requirements are enabled, the application checks whether the password meets the minimum category requirements and explains which categories are missing.
  - **Benefit**: Administrators immediately understand why a simple password such as "123" cannot be used on a secured workstation — instead of receiving a misleading success message or a cryptic Windows error — and are guided toward choosing a compliant password before the account creation attempt is made.
* **Real Windows Error Reporting on Failure**:
  - **What was updated**: When Windows rejects an account creation due to policy restrictions or any other reason, the application now captures and surfaces the actual error message returned by Windows (such as "The password does not meet the password policy requirements") instead of silently reporting the operation as successful.
  - **Benefit**: Removes all ambiguity from failed account creation — administrators can read the exact reason Windows rejected the operation and take the correct corrective action.

---

### 🔄 Updated & Enhanced Features (Upgraded from v2.6.5 - Coming Soon)

#### 🎨 High-Contrast Modal Dialogs & Action Button Hover Clarity (Upgraded)
* **What was updated**:
  - Engineered a uniform high-contrast visual styling system across all modal dialogs, security alerts, Quarantine notices, God Mode controllers, and administrative dialogs.
  - Eliminated washed-out button backgrounds and zero-contrast hover states where default operating system templates produced light cyan overlays against white button text.
  - Action buttons (including Close Application, Emergency Unlock, Browse, Apply Selected Configuration, and Remove Tweaks) now feature smooth, dark-accented hover and pressed states with crisp, high-visibility text across both Dark Mode and Light Mode.
  - **Single-Instance Quarantine Guard & Automatic Window Restoration**: Implemented single-instance application control and active synchronization locks. When a workstation is quarantined, exactly one security alert window appears; the moment SecOps releases the workstation from administrative quarantine, the application automatically dismisses the restricted notice and restores the full administrative interface without requiring an application restart.
* **Benefit**: Guarantees seamless administrative continuity, eliminating manual application restarts and duplicate popups during security quarantine and release workflows.

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


