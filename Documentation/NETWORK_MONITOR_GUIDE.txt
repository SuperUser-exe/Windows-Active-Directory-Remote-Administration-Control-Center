# 📡 Network Monitor — User Guide
## Network Device Monitoring, Network Coordinator Service & WhatsApp Alerting (v1.0.0)

> **Version 1.0.0 — Initial Public Release (with Suite v3.0.0).** This guide describes how Network Monitor works for both normal everyday monitoring and Distributed Multi-Coordinator deployments.

The **Network Monitor** watches your switches, routers, firewalls, servers, storage, cameras, printers and other network devices 24 hours a day, detects outages and partial failures, keeps a record of every incident, and sends WhatsApp alerts to your on-call team. It needs no software on the monitored devices.

This guide is the **Network Monitor** tab of the in-app User Guide. Everything else in the application is documented in the **Main Application** tab.

**Names used in this guide**

| Name | What it means |
| :--- | :--- |
| **Network Monitor** | The whole module: the monitoring window, settings, incidents, notifications and the background service. |
| **Network Coordinator** (or **Coordinator**) | The background Windows service that does the actual checking and alerting. It runs on one or more computers. Each computer running it is a *Coordinator Server* or *coordinator*. |
| **Normal Monitoring** | The standard checking cycle that follows the intervals and ping settings in **⚙️ Settings**. |
| **Real-Time Monitoring** | A per-device mode for local network devices that are checked every few seconds and confirmed with a fast verification burst. |
| **Consensus** | *Distributed Multi-Coordinator Consensus*: an optional per-device rule that makes several coordinators agree before an incident or alert is raised. |

---

### 📑 Table of Contents
- [A. Introduction & System Architecture](#a-introduction--system-architecture)
- [B. Installation & Initial Setup](#b-installation--initial-setup)
- [C. Network Coordinator Service Management](#c-network-coordinator-service-management)
- [D. Device & Target Management (Add / Edit Device)](#d-device--target-management-add--edit-device)
- [E. Normal Monitoring and Real-Time Monitoring](#e-normal-monitoring-and-real-time-monitoring)
- [F. Incident Detection Timing & Confirmation Logic (4 Practical Scenarios)](#f-incident-detection-timing--confirmation-logic-4-practical-scenarios)
- [G. Coordinator Consensus & Multi-Coordinator Monitoring](#g-coordinator-consensus--multi-coordinator-monitoring)
- [H. Incident Management](#h-incident-management)
- [I. Notifications & WhatsApp Alerts](#i-notifications--whatsapp-alerts)
- [J. Multiple Ping Sessions & Monitoring Layouts (Ping Studio)](#j-multiple-ping-sessions--monitoring-layouts-ping-studio)
- [K. Monitoring Reports, Logs & Data Storage](#k-monitoring-reports-logs--data-storage)
- [L. Settings Reference](#l-settings-reference)
- [M. Practical Setting Samples & Recommended Configurations](#m-practical-setting-samples--recommended-configurations)
- [N. Troubleshooting & Practical Network Failure Scenarios](#n-troubleshooting--practical-network-failure-scenarios)
- [O. Complete First-Time Setup Tutorial](#o-complete-first-time-setup-tutorial)

---

**Opening the Network Monitor**: click **📡 Network Monitor** on the main toolbar, or press **Ctrl+Shift+M**.

The monitoring window contains:
- **Header**: Coordinator service status badge, the active Coordinator Server badge (click it to open the Coordinator Server window), a coordinator update banner when a newer service version is available, and **🏷️ Version Log**.
- **Toolbar**: **➕ Add Device**, **⚡ Ping All Now**, **🔄 Refresh**, **▶️ Enable** / **⏸️ Disable** (for the selected devices), **🖥️ Coordinator Server**, **⚙️ Settings**, **🚨 Incidents**, **📜 Notification Log**, a search box, status filter chips (for example **🟡 Degraded**) and the **🌐 All Coordinators** view selector.
- **KPI cards**: totals for online, offline and degraded devices and active incidents. Click a card to filter the grid or open the related window.
- **Device grid**: Live Status, Probe Server / Coordinator, Device Name, IP Address, Type, Role / Profile, Ping, Port(s), Service(s), Overall Health, Latency, Loss %, Alert Status, Location / Group, Description, Last Seen and Last Checked. Right-click a device for **📡 Ping Now (Instant Verification)**, **📝 Edit Device...**, **▶️ Activate** / **Deactivate**, **🔔 Notification Settings...**, **🚨 View Active Incidents**, **📋 Copy IP Address** and **🗑️ Delete Device**.

---

### A. Introduction & System Architecture

#### What Network Monitor Does and Why It Is Essential
Modern enterprise networks rely on dozens or hundreds of dedicated hardware appliances that do not run standard desktop operating systems. When a core switch, internet gateway router, or warehouse security camera goes down, IT teams often only discover the outage after users complain or business operations halt.

The Network Monitor solves this challenge by continuously verifying endpoint reachability around the clock, computing live latency metrics and packet drop percentages, tracking incidents from start to resolution, and instantly delivering formatted push notifications to on-call administrators' mobile phones via WhatsApp.

#### Key Architecture Components
The system operates through four coordinated components:

1. **Desktop Control Center (`AD_Remote_Control`)**:
   - The primary graphical interface used by system administrators to view live reachability, inspect high-density performance KPI cards, add or manage devices, trigger diagnostic pings, configure alerting rules, and track active outage incidents.
2. **Autonomous Coordinator Background Service (`ADRC_NetworkMonitor`)**:
   - An independent Windows Service that executes 24/7 background watchdog cycles. It runs autonomously in the background even when the desktop application is closed and no user is logged in. It probes configured devices across ICMP Ping, TCP/UDP Ports, and Windows Service / Layer-7 Protocol checks, evaluates breach thresholds and alert policies, tracks outage/degraded incidents, and dispatches WhatsApp alerts.
3. **Agentless Monitored Endpoints**:
   - Target network hardware (switches, routers, firewalls, cameras, access points, NAS appliances, servers, workstations, VoIP phones, scanners, and printers). Because monitoring relies on standard ICMP Echo verification, TCP/UDP port handshakes, and native application/protocol probes, **zero proprietary client software is required on monitored devices**.
4. **WhatsApp Cloud Messaging Bridge**:
   - A cloud messaging gateway integration that converts outage events into real-time mobile push messages delivered directly to designated emergency contact numbers and IT response teams.

#### End-to-End System Architecture Flow
```
┌────────────────────────────────────────────────────────────────────────┐
│             Windows AD Remote Administration Control Center            │
│                 Desktop Client Application Interface                   │
└───────────────────────────────────┬────────────────────────────────────┘
                                    │ Management & Live Dashboard Sync
                                    ▼
┌────────────────────────────────────────────────────────────────────────┐
│             Autonomous Coordinator Service (ADRC_NetworkMonitor)       │
│               Hosted on Local Admin PC or Dedicated Domain Server      │
│  ┌──────────────────────┐ ┌──────────────────────┐ ┌─────────────────┐ │
│  │ 24/7 Watchdog Engine │ │ Threshold Evaluator  │ │ Incident Engine │ │
│  └──────────┬───────────┘ └──────────┬───────────┘ └────────┬────────┘ │
└─────────────┼────────────────────────┼──────────────────────┼──────────┘
              │                        │                      │
  Combined Ping, Port & L7 Probes      │                      │ Outage & Recovery
   (0% Client Software Required)       │                      │ Push Alerts
              ▼                        ▼                      ▼
┌──────────────────────────────┐       │         ┌───────────────────────┐
│     Monitored LAN Targets    │       │         │ WhatsApp Cloud Bridge │
│  - Core / Edge Switches      │       │         │   (Messaging Gateway) │
│  - Enterprise Routers        │       │         └───────────┬───────────┘
│  - Next-Gen Firewalls        │       │                     │ Instant Mobile
│  - Wireless Access Points    │       │                     │ Delivery
│  - IP Security Cameras       │       │                     ▼
│  - Physical & Virtual Servers│       │         ┌───────────────────────┐
│  - NAS Storage & IP Phones   │       │         │ IT Support Engineers  │
│  - Enterprise Printers       │       │         │ & On-Call Admins      │
└──────────────────────────────┘       │         └───────────────────────┘
                                       ▼
                       ┌───────────────────────────────┐
                       │ Persistent JSON File Storage  │
                       │ %ProgramData%\ADRemoteControl │
                       │ \monitoring\config & state    │
                       └───────────────────────────────┘
```


### B. Installation & Initial Setup

#### What the Coordinator Server Is and Why It Is Required
The Coordinator Server is the machine hosting the **`ADRC_NetworkMonitor`** Windows Service (Display Name: **`ADRC Network Device Monitor`**).

It is essential because:
- It maintains uninterrupted 24/7 surveillance across your infrastructure even when your administrator workstation is restarted, turned off, or disconnected from the network.
- It executes scheduled ping sweeps at configured intervals (e.g. every 5 minutes), calculates packet loss trends, and manages the incident lifecycle state machine.
- It queues and dispatches WhatsApp emergency messages during off-hours, weekends, and holidays without requiring any active desktop login sessions.

#### Recommended Hosting Platforms (Single vs. Distributed Multi-Coordinator Architecture)
You can deploy the Coordinator Service on either a single machine or across a distributed pool of workstations and servers depending on your topology and availability goals:

* **Option 1: Single Coordinator Installation (Single Workstation or Server)**
  - **Best for**: Small offices, single-subnet networks, labs, or initial evaluation (typically 5–50 devices).
  - **Advantage**: Zero extra infrastructure required; installed in 1 click on an existing Windows PC or office server.
  - **Consideration**: If the coordinator runs solely on a personal workstation that is powered down or restarted, 24/7 monitoring and alerting pause until that computer turns back on.

* **Option 2: Distributed Multi-Coordinator Architecture (Recommended for Multi-VLAN & High-Availability Environments)**
  - **How it works**: Multiple Windows PCs, normal staff workstations, or servers across different VLANs, departments, or branch sites each run the **Network Coordinator** background service and participate in the **Distributed Multi-Coordinator** fleet.
  - **No Dedicated Server or Domain Controller Required**: Any ordinary domain-joined or standalone Windows PC (for example, an IT technician workstation on VLAN 10, a reception or print-subnet PC on VLAN 20, a warehouse computer on VLAN 30, and/or a VM in your server rack) can act independently as a Coordinator node simultaneously.
  - **Multi-VLAN Reachability Without Risky Firewall Changes**: Each coordinator monitors devices directly reachable from its own VLAN or subnet—and when devices span multiple coordinators, **Distributed Multi-Coordinator Consensus** cross-verifies reachability across coordinators so isolated local PC or subnet hiccups never cause false outage alerts.
  - **Automatic Resilience & Zero Single Point of Failure**: Because configuration files synchronize automatically across all coordinators in the **Auto-Sync Pool**, if one coordinator workstation goes offline, restarts, or is turned off for maintenance, all remaining coordinators continue probing, evaluating active quorum, opening/resolving incidents cleanly, and sending WhatsApp alerts without interruption.

```
         ┌─────────────────────────────────────────────────────────────┐
         │    WADRACC Desktop App (View & Configure Any Coordinator)   │
         └──────────────┬───────────────┬───────────────┬──────────────┘
                        │ Auto-Sync     │ Auto-Sync     │ Auto-Sync
                        ▼               ▼               ▼
 ┌───────────────────────────┐ ┌───────────────────────────┐ ┌───────────────────────────┐
 │  Coordinator 1 (VLAN 10)  │ │  Coordinator 2 (VLAN 20)  │ │  Coordinator 3 (VLAN 30)  │
 │  Normal IT Workstation    │ │  Branch Office PC         │ │  VM / File Server         │
 │  Status: Online & Active  │ │  (Offline? Remaining      │ │  Status: Online & Active  │
 └─────────────┬─────────────┘ │  Coordinators Continue!)  │ └─────────────┬─────────────┘
               │               └─────────────┬─────────────┘               │
      Reaches Core / Mgmt           Reaches Branch LAN            Reaches Server / Printer
               ▼                             ▼                             ▼
  [Switches / Firewalls / APs]    [Branch Routers / Cameras]    [AD / Print / NAS Servers]
```

#### Prerequisites, Permissions & Network Connectivity Requirements
- **Supported Operating Systems**: Windows 7 SP1 through Windows 11, and Windows Server 2008 R2 through Windows Server 2025 (64-bit architecture).
- **No Domain Administrator Rights or Dedicated Server Required**:
  - Installing and running the Network Coordinator Service **does not require Domain Administrator credentials**, an Active Directory Domain Controller, or a dedicated server machine. You can install coordinators on ordinary **user workstations**, IT support laptops, or standard servers.
  - **Local Service Privilege**: Because the coordinator runs as a background Windows Service (`ADRC_NetworkMonitor`), the user installing or managing that Windows Service needs **Local Administrator** privileges on the host PC where that coordinator service resides (not Domain Admin across the domain). Remote push installation from another PC uses Windows SMB/RPC Admin shares (`445`/`135`), or you can simply install directly on each local PC in 1 click as a Local Administrator.
- **Network Routing & Firewall Requirements**:
  - While Domain Admin and dedicated servers are not required, each coordinator host **must still have standard network IP routing and firewall clearance** to reach the target devices it monitors:
  - **Inbound ICMP Echo**: Target devices and intermediate VLAN firewalls must permit standard ICMP ping packets from each assigned Coordinator host's IP address when ICMP Ping monitoring is enabled. Devices behind strict ping-blocking firewalls can also be monitored using TCP Port or HTTPS/Protocol checks independently of ping.
  - **Monitored Application / Appliance Ports**: When Port or Service/Protocol monitoring is enabled for a device across VLANs (for example, HTTPS 443, SSH 22, RDP 3389, SMB 445, RTSP 554, SNMP 161/udp, SIP 5060/udp), permit only those specific service ports from the Coordinator host IP.
  - **SMB (`445`) & RPC (`135`)**: Required between the Desktop App and Coordinators when inspecting remote coordinator status or syncing configurations across the fleet.
  - **Outbound HTTPS (`443`)**: Required on Coordinators that deliver WhatsApp alerts to the cloud messaging gateway.

#### Multi-VLAN Network Architecture & Routing Fundamentals
A very common enterprise deployment question is how the Coordinator monitors devices across segregated virtual local area networks (VLANs), such as Management VLAN, Server VLAN, User VLAN, Printer VLAN, and Guest VLAN:
- **Direct Layer 3 Reachability**:
  The Coordinator Server probes devices across IP networks using standard ICMP Echo packets, TCP/UDP port checks, and application protocol handshakes. Sending probes from a server on the Server VLAN to a printer or gateway on another VLAN requires a routable Layer 3 path through the core switch or firewall gateway.
- **Transitive "Hopping" Is Not Supported by IP Networking**:
  If the Server VLAN can communicate with the User VLAN, and the User VLAN can communicate with the Printer VLAN, the Coordinator on the Server VLAN **cannot** automatically "hop" through computers in the User VLAN to reach printers. Ordinary computers on the User VLAN do not act as network routers or proxy forwarders.
- **Direct Reachability Requirement**:
  The Coordinator requires direct IP reachability (a routed IP path) from its own network interface to every device it directly probes.
- **Recommended Architectural Solutions**:
  1. **Option A: Central Routed Gateway Rule (Easiest & Industry Standard)**:
     On your core switch or firewall gateway, add a granular firewall rule that permits outbound **ICMP Echo (Ping)** and any selected **application monitoring ports** (such as HTTP 80, HTTPS 443, RAW 9100, or SNMP 161/udp) from the Coordinator Server's specific IP address into the Printer VLAN, User VLAN, and other monitored subnets. This preserves complete security segregation across VLANs while giving the Coordinator 100% multi-layer reachability.
  2. **Option B: Distributed Multi-Coordinator Pool (Zero Routing Changes)**:
     If strict compliance or physical separation prohibits routing between VLANs, deploy a second Coordinator service on a machine that has access to the segregated VLAN (e.g. on a computer in the User/Printer VLAN, or a virtual machine with virtual network interfaces on both subnets). Add both servers to the **Auto-Sync Pool** (Add to Auto-Sync). The desktop application synchronizes configuration across all coordinators automatically.
- **Desktop Application Connectivity**:
  The main Windows desktop application on the Management VLAN communicates only with the Coordinator Server on the Server VLAN via standard Windows administrative management (Ports 135 and 445). **The administrator PC does NOT require direct network connectivity to the User VLAN, Printer VLAN, or monitored devices.** The Coordinator handles all 24/7 watchdogs and WhatsApp alerting on the server side.

#### Step-by-Step Installation: Method A (Local PC Installation)
1. Open the application and launch **📡 Network Monitor** from the top navigation toolbar (or press **Ctrl+Shift+M**).
2. Click **⚙️ Settings** on the toolbar, open the **⚙️ General** tab and click **📥 Install Service** on the **Background Coordinator Windows Service** card.
3. In the confirmation dialog, click **Yes** to install and start the background Windows Service.
4. A dedicated installation progress dialog opens, showing live step-by-step telemetry logs as the binary is copied and the service is registered with automatic startup.
5. Once installation finishes, click **Close**. The top header service badge turns green (`● Service: Running`).

#### Step-by-Step Installation: Method B (Remote Domain Server Deployment)
1. Open Network Monitor and click **🖥️ Coordinator Server** (or click the active host badge in the top header).
2. In the Coordinator Discovery dialog, click **➕ Deploy to Server...**.
3. A directory of domain computers appears. Check the box next to your desired target server (e.g. `SRV-MONITOR-01`), or enter the server's hostname or IP address into the search box.
4. Click **🚀 Deploy & Install Service**.
5. The **Coordinator Installation Progress Dialog** opens immediately, displaying:
   - Clear status message: *"Please wait, installing the Network Monitor service..."*
   - Animated progress bar.
   - Live step telemetry log detailing:
     - Remote server reachability and administrative share validation.
     - Graceful stopping of any older service version.
     - Silent deployment of the coordinator binary to `%ProgramData%\ADRemoteControl\coordinator\`.
     - Automatic mirroring of existing monitored devices, settings, and WhatsApp alert rules.
     - Registration of the auto-starting Windows Service with automatic restart recovery.
     - Service startup execution and active health verification.
6. When verified, the dialog displays `✅ Service successfully installed and verified running healthy!`. Click **Close**.
7. The active management target switches to the newly deployed server, and the header badge displays `Host: Server: SRV-MONITOR-01` and `● Service: Running`.

#### Verifying Coordinator Service Operation
- **Application Header Badge**: The service indicator displays a vibrant green pill labeled **● Service: Running**.
- **Windows Services Console (`services.msc`)**:
  - Service Name: `ADRC_NetworkMonitor`
  - Display Name: `ADRC Network Device Monitor`
  - Startup Type: `Automatic`
  - Status: `Running`
- **Automatic Failure Recovery**: The service is automatically configured with Windows Service failure actions to restart automatically after 60 seconds if it ever encounters an unexpected operating system issue.

#### Hidden Administrative Share Security (`ADRC_Monitoring$`)
- **Hidden Network Share (`ADRC_Monitoring$`)**: The Coordinator service communicates using a hidden administrative file share (`ADRC_Monitoring$`) ending with a `$` character. In Windows networking, shares ending with `$` are hidden administrative shares that are never displayed or broadcast when network users browse the server in Windows Explorer (`\\SERVER`).
- **Automatic Legacy Share Cleanup**: When the service starts or updates, it automatically detects and removes legacy unhidden shares (`ADRC_Monitoring`), keeping your server's shared folder listings clean and visible only to authorized IT administrators.

#### Coordinator Resource Footprint & Multi-Coordinator Benefits
Each individual Coordinator Windows Service is lightweight—using asynchronous sockets with under **35 MB of RAM** and under **1% CPU utilization** during standard monitoring cycles—so it runs silently on both normal office PCs and servers without slowing users down. Deploying **multiple coordinators** is valuable in several practical situations:

1. **Higher Resilience on Normal Workstations**: If one coordinator workstation is restarted, unplugged, or powered off, other coordinators continue checking devices and delivering alerts uninterrupted.
2. **Distributed Multi-Coordinator Consensus**: Multiple coordinators verify outages independently before opening fleet-wide incidents or sending WhatsApp alerts, preventing single-point network blips from causing false alarms.
3. **Segmented Networks & Isolated VLANs (DMZs / Printers / CCTV)**: Place coordinators on workstations or servers that already reside inside segmented zones without punching broad firewall holes across subnets.
4. **Multi-Branch WAN Deployments**: Run 1–3 coordinators locally at remote branches so local LAN outages are verified cleanly even during WAN/VPN jitter.

#### Practical Deployment Sizing Matrix

| Environment | Monitored Devices | Recommended Coordinators | Ideal Coordinator Placement |
| :--- | :--- | :--- | :--- |
| **Small Office / Single Site** | 5 – 50 devices | **1 – 2 Coordinators** | Normal IT or office workstations (2 provides backup if one PC restarts) |
| **Medium Network (Multi-VLAN)** | 50 – 250 devices | **3 – 5 Coordinators** | Distributed across main VLANs/subnets on staff workstations or servers |
| **Large Enterprise / Campus** | 250 – 500+ devices | **5 – 10 Coordinators** | Distributed across campus buildings, network segments, and always-on servers |
| **Multi-Branch / Multi-Site** | 1,000+ devices | **1 – 3 per Branch / Region** | 1 – 3 local coordinators inside each branch/region plus HQ consensus nodes |

> ℹ️ **Note on Sizing Recommendations**: The coordinator counts above are **recommended starting guidelines**, not hard technical limits. Actual coordinator requirements depend on your **monitoring intervals** (e.g., frequent 3–5 s Real-Time checks vs. 60–300 s Normal intervals), **network topology** (number of isolated VLANs or WAN branches), **monitored device count**, and the **uptime/hardware capacity** of each machine running the service.

---

### C. Network Coordinator Service Management

#### Centralized Service Lifecycle Controls (Start, Restart & Stop Service)
Service management operations are centralized under **Settings → General** to prevent duplicate controls and provide unified lifecycle management across the monitoring fleet:
- **Centralized Service Management**: Open **⚙️ Settings** from the Network Device Monitoring toolbar and navigate to the **General** tab. The **Background Coordinator Windows Service** card provides real-time service status alongside unified **▶ Start**, **🔄 Restart**, and **⏹ Stop** buttons.
- **Fleet-Wide Server Control**: Clicking **▶ Start**, **🔄 Restart**, or **⏹ Stop** controls the entire server-side monitoring service across registered servers from a single button, ensuring global monitoring is activated, gracefully refreshed, or paused consistently.
- **Confirmation & Result Summary**: Start, Restart and Stop first list every coordinator server they will act on and ask for confirmation (Stop asks twice, because it pauses all outage detection and WhatsApp alerts). When finished, a summary shows how many coordinator services are running and the state of each server.
- **First-Time Installation**: When setting up the application for the first time on a new workstation or server, click **📥 Install Service** on the same machine to configure the auto-starting background Windows Service, set up necessary firewall rules, and immediately begin 24/7 device monitoring.
- **Per-Server Restart**: In the **Coordinator Server Discovery & Health Monitor** window, right-click any individual server in the roster and choose **🔁 Restart Coordinator Service on this Server...** to restart only that specific server without interrupting other active coordinators.

#### Source Agents Tab (Coming Soon)
- The **🖥️ Source Agents (Coming Soon)** tab in the monitoring Settings window is reserved for a future capability that will let Idle Agents on user PCs act as extra checking points for nearby devices. The option is shown but cannot be switched on yet.
- **Today**: to monitor from an extra site, VLAN or network segment, install a Coordinator on a PC there. Coordinators run on standard user PCs and automatically take part in multi-coordinator consensus.

#### Complete Service Uninstallation & Coordinator Roster Cleanup
When decommissioning a monitoring server, migrating monitoring services, or cleaning up obsolete servers:
1. Open the **Coordinator Server Discovery & Multi-Server Synchronization** dialog (`Ctrl+Shift+M` -> click the active host badge or **🖥️ Coordinator Server**).
2. Select the server from the **Coordinator Server Discovery & Health Monitor** roster table.
3. Click **🗑️ Uninstall Service...** on the bottom toolbar (or right-click the server and select **🗑️ Uninstall Service...**).
4. Confirm the uninstallation prompt. The system performs a complete, multi-point cleanup:
   - Gracefully terminates running monitoring processes and safely stops the service.
   - Unregisters the service cleanly using Windows Service Control Manager.
   - Purges remote coordinator binaries, configuration storage directories, and inbound firewall rules.
   - Automatically removes the server from active synchronization pools and discovery registries, preventing unwanted background synchronization or automatic reappearance.
   - Immediately removes the server entry from the Coordinator Server list in the dialog, eliminating stale "Service: Not Installed" placeholder rows.
   - Stops all active background heartbeat checks, ping probes, and communication against the decommissioned server.
5. **Removing Non-Service Entries**: If a server was added for testing or is no longer reachable, select it and click **❌ Remove Server** (or right-click and choose **❌ Remove Server**) to immediately unregister it from the discovery roster and configuration without modifying remote files.

#### How the Multi-Coordinator Synchronization Pool Works
The application features an automated **Multi-Coordinator Auto-Sync Pool**. When multiple domain servers are designated as coordinators, any configuration change made on one server (adding a device, updating thresholds, or changing WhatsApp recipient phone numbers) is **automatically mirrored across all synchronized coordinators in the background**.

#### Step-by-Step Guide: Adding a Server to the Auto-Sync Pool
1. Open Network Monitor and click **🖥️ Coordinator Server**.
2. Select or enter the hostname of the remote domain server that already has the coordinator service installed.
3. Click **🔄 Add to Auto-Sync**.
4. The server is registered into the synchronization pool. Every configuration save automatically mirrors `devices.json`, `settings.json`, and `whatsapp.json` to the remote server's administrative storage.

#### Switching the Active Management Target in 1 Click
Administrators can switch the active management target at any time:
1. Open the **🖥️ Coordinator Server** discovery window.
2. Highlight any server in the discovered servers list.
3. Click **✅ Set as Active**.
4. The dashboard immediately updates to display the selected server's live reachability records, incident history, and background service status.

#### Resilient Offline Local Inventory Fallback & Practical 100-Device Scenario
If a remote Coordinator Server becomes temporarily unreachable due to network maintenance, switch reboots, or a WAN link interruption, the desktop application automatically activates its **Offline Local Inventory Fallback Engine**.

##### Practical 100-Device Scenario:
Consider a scenario where you have **100 network devices** monitored by a remote Coordinator Server, and the network connection between your administrator workstation and the Coordinator Server suddenly goes down:
1. **Will you still see all 100 devices in your desktop application?**
   - **YES**. The application maintains a persistent local cache on your PC (%ProgramData%\ADRemoteControl\monitoring\). When remote connectivity times out, the application automatically loads the cached device inventory. All 100 devices remain visible in your data grid.
2. **Will last-known status and device details remain visible?**
   - **YES**. Every device's last-known operational status (Online, Offline, Degraded), round-trip latency, packet loss percentage, device type, physical location, and last-seen timestamp remain fully displayed. The bottom status bar clearly informs you: *"Coordinator Offline — Displaying Cached Snapshot"*.
3. **Will real-time monitoring and ping checks continue, or will monitoring stop?**
   - **Surveillance continues 24/7 on the Server!** If the Coordinator Server itself is still running and healthy, it **continues pinging all 100 devices and sending WhatsApp emergency alerts autonomously in the background**. The temporary outage only impacts the link between your personal PC and the server.
   - **Desktop Live View**: Live metric updates on your desktop screen are paused while the link is down because the PC cannot query the server.
4. **What happens once the connection comes back?**
   - **Automatic Instant Synchronization**: As soon as network connectivity is restored, the application's auto-refresh engine (or clicking **Refresh**) automatically reconnects to the Coordinator Server, updates the live dashboard with the latest probe results, and synchronizes any configuration changes made in the interim.

#### Isolated Coordinator Server Updates & Automated Multi-Coordinator Bulk Upgrades
To ensure 24/7 background monitoring infrastructure stays current across your entire enterprise while protecting domain client workstations:
- **Isolated Update Scope**: Clicking **⚡ Update Coordinator Server** (or **⚡ Update Now** / **⚡ Update All**) applies strictly to registered Coordinator Servers. It never distributes or installs coordinator binaries on domain client PCs or workstations.
- **Automated Sequential Multi-Server Updates**: When multiple coordinator servers are deployed across the domain (for example, local admin workstation, domain controller, and secondary member server), clicking the update button automatically updates all outdated coordinator servers sequentially one by one. The application halts each coordinator service, unlocks the directory, deploys the latest compiled binary, restarts the service, and verifies healthy startup before seamlessly moving to the next server.
- **Independent Agent Separation**: Coordinator server updates are completely decoupled from workstation client agents. Upgrading the coordinator service leaves client-side tools (such as the Inactivity Monitor Agent) untouched, and vice versa.
- **Pre-Update Multi-Server Safety Confirmation**: Initiating an update presents a comprehensive confirmation dialog listing all target coordinator servers along with their currently installed versions, explicitly detailing the one-by-one execution plan and confirming that client PCs are excluded.
- **Live Sequential Progress & Telemetry**: During the multi-server upgrade, an interactive progress dialog displays live status (`Updating coordinator server 1 of 3: ServerName...`), step-by-step logs tagged by server, and a final summary showing succeeded and failed counts.
- **Dismiss & Cancel Options**: Clicking **Dismiss** or **Cancel** hides the notification banner without interrupting active monitoring services.


---

### D. Device & Target Management (Add / Edit Device)

#### What Monitored Devices Are
Monitored devices are the physical or virtual hardware appliances on your local network or wide area network that you wish to monitor.

Supported device categories include:
- **Core, Distribution & Edge Switches** (Cisco, HP/Aruba, Dell, Juniper, Ubiquiti, Mikrotik, Netgear)
- **Enterprise Firewalls & Edge Gateways** (Fortinet, Palo Alto, Sophos, pfSense, Cisco ASA)
- **Wireless LAN Controllers & Access Points**
- **Physical & Virtual Windows and Linux Servers**
- **Network-Attached Storage (NAS) & SAN Appliances** (Synology, QNAP, TrueNAS, Dell EMC)
- **IP Security CCTV Cameras & Network Video Recorders (NVRs)**
- **Enterprise Network Printers, Multifunction Copiers & Scanners**
- **VoIP IP Telephones & PBX Gateways**
- **Industrial IoT Controllers, UPS Battery Backups & Environmental Sensors**

#### The 100% Agentless Multi-Layer Advantage
Unlike workstation management tools that require client software, **the Network Monitor requires zero proprietary agent installations on target devices**. The Coordinator Server combines three independent monitoring methods—**ICMP Ping** reachability, **TCP/UDP Port** transport verification, and **Windows Service / Layer-7 Protocol** probing (`HTTP`, `HTTPS`, `SSH`, `RDP`, `SMB`, `RTSP`, `SNMP`, `SIP`, `DNS`, `MySQL`, `MSSQL`, `SMTP`)—so any IP device can be monitored deeply without installing software agents on endpoints.

#### Add / Edit Monitored Device — Field-by-Field Guide

Open it with **➕ Add Device** on the toolbar, by double-clicking a device, or by right-clicking a device and choosing **📝 Edit Device...**. The window is organised in four parts:

```
┌────────────────────────────────────────────────────────────────────────┐
│                   ADD / EDIT MONITORED DEVICE                          │
├───────────────────────┬────────────────────────┬───────────────────────┤
│ 1. Device Identity    │ 2. Multi-Layer Health  │ 3. Execution & Quorum │
│ • IP / Hostname       │ • Monitoring Methods   │ • Active Status       │
│ • Device Type         │ • Health Profile       │ • Real-Time Mode      │
│ • Device Name         │ • Alert Policy         │ • Probe Interval      │
│ • Location / Group    │ • Live Layer Preview   │ • Probe Server        │
│ • Description         │                        │ • Consensus           │
└───────────────────────┴────────────────────────┴───────────────────────┘
```

##### Part 1: Device Identity & Classification

1. **IP / Hostname \***
   - **What it does**: The IPv4/IPv6 address or host name / FQDN to monitor (for example `10.10.10.10`, `printer.domain.local`, `vpn.company.com`).
   - **How it works**: A live check runs as you type and shows `✅ Reachable` or `❌ Not Reachable`. The host name is resolved to pre-fill the Device Name, and every configured port and service is re-tested against the new address. The badge is information only: you can save a device that is currently offline.
   - **Use case**: Use the static IP for core servers and switches; use a DNS name for devices whose address can change.
2. **Device Type**
   - **What it does**: Classifies the device (Switch, Router, Firewall, Server, Camera, Printer, Access Point, NAS, IP Phone, Scanner, Computer, Other).
   - **How it works**: For a new device, choosing a type switches on the recommended monitoring methods, health profile, ports and services (see the list further below). Editing an existing device keeps its saved settings.
3. **Device Name \***
   - **What it does**: The friendly name shown in the grid, incidents and WhatsApp alerts (for example `HQ-Core-Switch-01`, `OceanStore iSCSI`).
   - **Tip**: Include the role and site so the on-call engineer knows what failed without looking up the IP address.
4. **Location / Group** and **Description**
   - **What they do**: Free text for the site or zone (`Data Center`, `Riyadh HQ`, `DMZ`) and notes such as model, failover IP or support contract. Both are searchable from the toolbar search box.

##### Part 2: Multi-Layer Monitoring & Health Profiles

5. **Monitoring Methods** (three independent checkboxes; at least one must be ticked)
   1. **📡 ICMP Ping**: network reachability, latency and packet loss.
   2. **🔌 Port Monitoring (TCP/UDP)**: checks that the listed ports accept connections (for example `80`, `443`, `3260`, `389`, `161/udp`).
   3. **⚙️ Service / Protocol**: checks Windows services (`NTDS`, `DNS`, `Spooler`) or application protocols (`HTTP`, `HTTPS`, `SSH`, `RDP`, `SMB`, `SNMP`, `RTSP`, `SIP`, `DNS`, `MySQL`, `MSSQL`, `SMTP`).
   - **Important benefit**: Ports and services are still checked when ping fails. If a device blocks ping but a monitored port answers, the device stays **Online** with Ping shown as **ICMP Filtered**, and no outage is raised. You do not have to untick ICMP Ping for such devices, although you can.
6. **Health Profile**, **Target Port(s)** and **Service(s) / Protocol(s)**
   - Pick one or more built-in profiles from the multi-select list (for example *Active Directory Domain Services*, *Windows Server Baseline*, *Network Printer*, *Windows Print Server*), or tick **⚙️ Custom** to type your own ports and services.
   - **🔍 Scan & Auto-Detect Roles on Host** checks the device and ticks the matching roles automatically.
7. **Alert Policy** (what happens when the device is reachable but one of its ports or services fails)
   - **🟡 Degraded Warning (Recommended)**: shows *Degraded* and raises a warning incident.
   - **ℹ️ Status Only**: shows *Degraded* on the dashboard only; no incident and no WhatsApp alert.
   - **🚨 Critical Zombie Alert**: raises a critical incident and urgent alert.
   - A complete outage (nothing answers) is always a critical *Offline* incident, whichever policy you choose. Details are in [Alert Policy Guide](#alert-policy-guide-how-each-policy-works--real-world-use-cases).
8. **Live Layer Preview**
   - A live summary of how the device looks with the current settings, for example `🟢 Overall: Online | Ping: 🟢 <1ms • Ports: 4/4 Open • Services: 4/4 Up`.
   - When you save a device while every layer is green, this healthy result is remembered as the device's verified baseline (see [Section N](#n-troubleshooting--practical-network-failure-scenarios) for how this affects some partial-failure alerts).

##### Part 3: Execution & Scheduling

9. **Enable 24/7 combined monitoring for this device** (Active Status)
   - **Ticked**: every assigned coordinator checks the device.
   - **Unticked**: the device is kept but not checked, and no incidents or alerts are raised. Use this during planned maintenance.
10. **⚡ Real-Time Monitoring** (Real-Time Mode)
    - **Unticked (Normal Monitoring)**: the device is checked on the normal cycle using **Settings → General → Default Monitoring Interval** and the ping values in **Settings → Ping & Rules**, unless you set a custom interval in the device's **🔔 Notification Settings...**.
    - **Ticked (Real-Time Monitoring)**: the device is checked every few seconds with fast verification. See [Section E](#e-normal-monitoring-and-real-time-monitoring).
    - ⚠️ **Real-Time Monitoring is intended for devices connected to the local network.** It uses very short intervals and fast verification timings, so it is not intended for VPN-connected branch devices, remote networks or cloud servers, where latency and packet loss can cause misleading results.
11. **Probe Interval** (shown when Real-Time Monitoring is ticked)
    - Choose **3, 5, 10, 15, 20, 25 or 30 seconds**. **5 seconds** is recommended and is the default.
    - Every interval, the coordinator sends one ping. If it is not answered, a multi-ping verification is initiated immediately. If fewer than 5 replies are received, the outage is confirmed during the same monitoring check.

##### Part 4: Coordinator Assignment & Distributed Consensus

12. **Probe Server** (Coordinator assignment)
    - **🌐 All Coordinators (Fleet-wide probing)**: every coordinator checks the device independently.
    - **Specific servers**: tick only the coordinators that have a network path to the device (for example, a storage array reachable only from `SRV1` and `SRV2`). Unassigned coordinators skip the device.
13. **🛡️ Enable Distributed Multi-Coordinator Consensus**
    - **Unticked**: each assigned coordinator acts on its own. The first coordinator that confirms an outage raises the (single, shared) incident and alert, without waiting for the others.
    - **Ticked**: coordinators check with each other before raising an incident or alert, using two separate settings:
      - **Incident Threshold**: *All Coordinators Down (Confirmed Outage Quorum)* (default) or *Any Coordinator Down (Immediate Local Breach)*.
      - **Notification Threshold**: *All Coordinators Down (Send Alert Only on Full Quorum Outage)* (default) or *Any Coordinator Down (Send Alert on Any Coordinator Breach)*.
    - Full explanation, scenarios and the four threshold combinations are in [Section G](#g-coordinator-consensus--multi-coordinator-monitoring).
14. **➕ Save Device** / **💾 Update Device**
    - Saving sends the configuration to every coordinator and checks the device straight away. Saving never clears an active outage: if the device is offline with an open incident, it stays Offline until it really recovers.

#### Intelligent 3-Layer Combined Monitoring (Ping + Ports + Services / Protocols) & Dynamic Auto-Configuration
Modern infrastructure cannot rely solely on basic ICMP ping. A server or gateway can continue answering ICMP pings while its file shares, database engine, web interface, or print spooler has hung—or conversely, a firewall appliance may intentionally block ICMP ping while serving critical HTTPS traffic normally. Monitoring ping alone creates both silent blind spots and unnecessary false offline alerts.

The **Combined 3-Layer Monitoring Engine** solves this by coordinating all three monitoring methods simultaneously and independently:
1. **📡 ICMP Ping (Network Layer)**: Verifies IP reachability, round-trip latency, and packet loss percentage.
2. **🔌 Port Monitoring (TCP & UDP Transport Layer)**: Verifies TCP connection responsiveness and UDP transport availability (including DNS `53/udp`, DHCP `67/udp`, NTP `123/udp`, SNMP `161/udp`, and VoIP SIP `5060/udp`).
3. **⚙️ Service / Protocol Monitoring (Application Layer)**: Verifies both domain **Windows Services** (`NTDS`, `DNS`, `LanmanServer`, `Spooler`, `W3SVC`, `MSSQLSERVER`, `vmms`, etc.) and **100% agentless Layer-7 protocol responses** (`HTTP`, `HTTPS`, `SSH`, `RDP`, `SMB`, `RTSP`, `SNMP`, `SIP`, `DNS`, `MySQL`, `MSSQL`, `SMTP`).

Crucially, **Port and Service/Protocol checks continue executing independently even when ICMP Ping is disabled or blocked by a firewall**, and every layer's status is surfaced side-by-side in dedicated dashboard columns (**`Ping`**, **`Port(s)`**, **`Service(s)`**, and **`Overall Health`**).

* **Intelligent Automatic Configuration Across All 12 Device Types**:
  When adding a new device or changing the **Device Type** dropdown, the application automatically configures recommended monitoring layers, ports, and services/protocols tailored to that hardware category:
  - **🖥️ Server**: Enables Ping + Ports (`3389`, `445`) + Services (`RDP`, `SMB`).
  - **💻 Computer**: Enables Ping + Ports (`3389`, `445`) + Service (`RDP`).
  - **🌐 Router**: Enables Ping + Ports (`80`, `443`, `22`, `161/udp`) + Services (`HTTP`, `HTTPS`, `SSH`, `SNMP`).
  - **🔀 Switch**: Enables Ping + Ports (`80`, `443`, `22`, `161/udp`) + Services (`HTTP`, `SSH`, `SNMP`).
  - **🛡️ Firewall**: Enables Ping + Ports (`443`, `22`, `8443`) + Services (`HTTPS`, `SSH`).
  - **📹 Camera**: Enables Ping + Ports (`554`, `80`) + Services (`RTSP`, `HTTP`).
  - **🖨️ Printer**: Enables Ping + Ports (`9100`, `515`, `80`) + Service (`HTTP`).
  - **📶 Access Point**: Enables Ping + Ports (`80`, `443`) + Services (`HTTP`, `HTTPS`).
  - **🗄️ NAS**: Enables Ping + Ports (`445`, `80`, `443`) + Services (`SMB`, `HTTP`).
  - **☎️ IP Phone**: Enables Ping + Ports (`5060/udp`, `80`, `443`) + Services (`SIP`, `HTTP`).
  - **📠 Scanner**: Enables Ping + Ports (`80`, `443`, `445`) + Services (`HTTP`, `SMB`).
  - **📡 Other**: Defaults cleanly to **Ping Only** (Network Reachability), ready for custom layer selection if needed.
  - Editing an existing device always preserves your previously saved configuration until you intentionally choose a different preset or role.

* **Multi-Select Checkable Health Profile Dropdown with Fail-Safe "Custom" Protection Guard**:
  Click the **Health Profile** bar to open a comprehensive 23-profile multi-selection checklist covering infrastructure appliances, domain server roles, and custom setups:
  - **Infrastructure & Appliance Presets**: Windows Server Baseline (`3389, 445`, `RDP, SMB`), Workstation Remote Admin (`3389, 445`, `RDP`), Router / Gateway (`80, 443, 22, 161/udp`, `HTTP, HTTPS, SSH, SNMP`), Managed Switch (`80, 443, 22, 161/udp`, `HTTP, SSH, SNMP`), Firewall Appliance (`443, 22, 8443`, `HTTPS, SSH`), NAS Storage Appliance (`445, 80, 443`, `SMB, HTTP`), Network Printer (`9100, 515, 80`, `HTTP`), Access Point / Web Management (`80, 443`, `HTTP, HTTPS`), IP Camera / RTSP Video Stream (`554, 80`, `RTSP, HTTP`), IP Phone / VoIP (`5060/udp, 80, 443`, `SIP, HTTP`), and Network Scanner (`80, 443, 445`, `HTTP, SMB`).
  - **Enterprise Windows Server & Application Roles**: Active Directory Domain Services (`389`, `NTDS`), DNS Server (`53`, `DNS`), DHCP Server (`67/udp`, `DHCPServer`), Windows File Server (`445`, `LanmanServer`), Windows Print Server (`515, 445`, `Spooler`), Microsoft SQL Server Database (`1433`, `MSSQLSERVER`), Other Database (`3306, 5432, 1521`, `MySQL`), IIS Web Server (`80, 443`, `W3SVC`), Remote Desktop Session Host (`3389`, `TermService`), Hyper-V Virtualization Host (`2179`, `vmms`), Backup Server (`9392`, `VeeamBackupSvc`), and Active Directory Certificate Services (`135`, `CertSvc`).
  - **📡 Ping Only**, **⚙️ Custom Editing Lock** & **`Select All` / `Clear All` Quick Actions**: Checking multiple roles merges unique ports and services cleanly without duplication. Use **☑ Select All** or **✕ Clear All** in the dropdown header to select every role or clear your entire selection in one click. By default, target fields remain safely locked against accidental typing; checking **⚙️ Custom (Enable Manual Port & Service/Protocol Editing)** unlocks both fields for free-form TCP/UDP ports and Windows services or Layer-7 protocols.
  - **🔄 Reliable Two-Way Synchronization & Duplicate Prevention**: Both the **Health Profile** dropdown and the **Target Port(s)** / **Service(s) / Protocol(s)** fields share one unified configuration state:
    - Removing a port or service from the field automatically unticks every profile in the dropdown that depends on it (while keeping any overlapping profiles whose required ports and services are all still present).
    - Clearing all ports and services automatically clears all checked profiles in the dropdown.
    - Manually typing ports or services that match a predefined profile automatically ticks that profile in the dropdown (preferring the matching device type cleanly without false overlapping matches), while non-predefined custom ports and services remain preserved alongside your other selections.
    - Duplicate ports or services are cleaned up automatically without re-testing already-verified entries on the same IP address, and opening an existing device to edit validates saved profiles against its active ports and services.
  - **🔍 Scan & Auto-Detect Roles on Host**: Clicking this button scans active TCP/UDP ports, Layer-7 protocols, and Windows services on the entered IP/Hostname, automatically checking matching roles in the dropdown.

* **Live Concurrent Verification, Incremental Probing & Automatic IP-Change Synchronization**:
  - **Incremental Add & Remove Behavior (Same IP)**: When adding or removing individual ports or services through the **Health Profile** checklist or **Custom** input while the IP address remains unchanged, the system verifies **only newly added items**, cleanly removes deleted item badges, and preserves all already-verified statuses without redundant rechecks or UI flicker. Removing all ports or services clears all statuses immediately without running any checks.
  - **Immediate Full Re-Evaluation on IP Changes**: Entering or editing the IP/Hostname automatically stops previous pending checks, clears stale port and service badges immediately, displays `⏳ Checking...` states, and re-runs Connectivity, Port, and Service/Protocol checks concurrently against the new IP—without removing or re-adding any ports or services. Rapid edits safely discard outdated results so the UI never displays status belonging to an older IP.
  - **Per-Item Live Status Badges & Readiness Preview**: Displays clear badges for every TCP/UDP port (`🟢 Open`, `🟡 Open|Filtered`, `🔴 Closed (No Listener)`, `⚠️ Firewall Timeout`), every service or protocol (`🟢 Running`, `🟡 Stopped`, `🔒 Limited / Access`, `❌ Not Found`), click-to-apply smart suggestions for misspelled service names, and a **Live Layer Preview** banner showing both **Open** ports and **Open|Filtered** UDP counts side-by-side (e.g. `🟢 7/10 Open (+3 UDP Filt.)`). Note that UDP probes send real UDP datagrams directly to target ports (not ICMP Ping); silent firewall drops or unauthenticated DHCP listeners (`67/udp`) show `Open|Filtered` as a normal non-outage status, whereas an active OS/firewall rejection reports `🔴 Closed (No Listener)`.
  - **Automatic Dashboard Sync & Non-Resetting Verification**: Adding, editing, enabling, disabling, or changing the IP of a device in Network Monitor automatically checks and synchronizes the affected device on the dashboard without clicking **Refresh All**, while preserving all existing device configurations, rules, and unrelated statuses untouched. Bounded unreachable-host timeouts ensure stalled offline endpoints never delay healthy device updates, and shared-IP devices track their outage incidents independently.

* **Per-Layer Dashboard Visibility & 1-Click Filtering**:
  The main Monitoring Grid shows **Ping**, **Port(s)** (`All Open`, `1 Failed`, etc.), **Service(s)** (`All Running`, `1 Stopped`, etc.), and **Overall Health** (`🟢 Healthy`, `🟡 Degraded`, `⚠️ Zombie`, `🔴 Offline`) side-by-side, accompanied by a dedicated **⚠️ Degraded / Zombie** toolbar filter chip.

#### Alert Policy Guide: How Each Policy Works & Real-World Use Cases
When **Multi-Layer Monitoring** (ICMP Ping + TCP/UDP Ports + Windows Services / Layer-7 Protocols) is enabled, a server or network appliance can remain **reachable on the network** (Ping replies normally, or at least one open port/running service confirms the host is alive) while one or more specific monitored ports or services stop responding.

The **Alert Policy** setting in **Add / Edit Device Configuration** controls how the monitoring engine classifies, logs, and notifies on these partial port or service failures—preventing false "full device offline" alerts while letting you match alert urgency to each system's criticality.

> **Important Note on Full Device Outages & Ping Thresholds**:
> - If **all** active monitoring layers become unreachable (ICMP Ping fails AND no monitored port or service responds), the device is marked **🔴 Offline** and always raises a critical **`DESTINATION_UNREACHABLE`** outage alert regardless of which Alert Policy is chosen.
> - Similarly, if ICMP packet loss or round-trip latency exceeds your configured thresholds, normal packet-loss (`PACKET_LOSS_BREACH`) and high-latency (`HIGH_LATENCY`) alerts continue to operate as configured.
> - Informational non-failure states such as UDP **`Open|Filtered`** ports or **`Limited / Blocked`** remote service permission badges do **not** trigger partial-failure alerts—only confirmed unresponsive/closed ports or stopped/missing services trigger the Alert Policy.

---

1. **🟡 Degraded Warning — Raise `SERVICE_PORT_DEGRADED` if Ping is OK *(Recommended / Default)***
   - **How It Works**:
     - When the host remains reachable (Ping is OK or another active layer confirms connectivity) and one or more monitored ports or services fail, the dashboard marks overall health as **`🟡 Degraded`** (Alert column: **`⚠️ Service/Port Alert`**) instead of claiming the entire server is offline.
     - Once the configured consecutive breach threshold is reached, the coordinator logs a **`WARNING`**-severity incident of type **`SERVICE_PORT_DEGRADED`** in the Incidents Log.
     - A clear **`⚠️ SERVICE / PORT DEGRADED ALERT`** WhatsApp notification is dispatched confirming that the host itself is still reachable while listing strictly the exact failed port(s) or service(s) (unrelated healthy ports and running services are excluded from notifications so alerts stay focused).
     - As long as the condition remains unresolved and unacknowledged, recurring reminder notifications are sent at your configured reminder interval until the subsystem recovers or an admin acknowledges the incident.
     - When all failed ports and services return to healthy, an automatic recovery notification (**`🟢 SERVICE & PORT HEALTH RECOVERED`**) is sent.
   - **Real-World Use Cases**:
     - Ideal default choice for everyday **Web Servers**, **File Servers**, **Application Servers**, **NAS Appliances**, **Managed Switches**, and **Enterprise Printers**.
     - Use this whenever you want prompt alerts when a specific application port or service drops, without flooding your team with misleading "server completely offline" outage alerts.

2. **ℹ️ Status Only — Show Degraded in dashboard; never raise outage alerts**
   - **How It Works**:
     - When the host remains reachable and one or more monitored ports or services fail, the dashboard still updates **Port(s)**, **Service(s)**, and **Overall Health** to **`🟡 Degraded`** (Alert column: **`ℹ️ Status Only`**) so operators can see the partial issue visually.
     - **No incident record is created** in the Incidents Log and **no WhatsApp alerts or recurring reminders are sent** for port or service failures.
     - *(Full offline outages when all layers fail, as well as ICMP packet loss and high latency breaches, still generate normal alerts.)*
   - **Real-World Use Cases**:
     - Best suited for **Test / Staging Servers**, **Non-Critical Workstations**, **Network Printers** that routinely enter power-saving sleep mode, or **Optional / Secondary Services** that restart periodically.
     - Choose this when you want dashboard visibility into port/service status on demand without generating noisy after-hours WhatsApp notifications.

3. **🚨 Critical Zombie Alert — Raise `ZOMBIE_SERVER_DETECTED` if host answers Ping**
   - **How It Works**:
     - Detects **"Zombie Server" lockups**—situations where a server's network stack still answers ICMP Ping (causing traditional ping-only monitors to falsely report the host as healthy), even though its critical server roles, Windows services, or listening ports have frozen, crashed, or stopped responding.
     - When the host answers Ping (or remains reachable) and any monitored port or service fails, the dashboard highlights the device in red as **`⚠️ Zombie Alert`** / **`🚨 ZOMBIE`**.
     - The coordinator creates a **`CRITICAL`**-severity **`ZOMBIE_SERVER_DETECTED`** incident and immediately dispatches an urgent **`🚨 CRITICAL ALERT: ZOMBIE SERVER DETECTED`** WhatsApp alert plus recurring reminders until acknowledged or resolved—followed by a recovery notification once all services and ports are restored.
   - **Real-World Use Cases**:
     - Essential for **mission-critical servers and core infrastructure** where a single stopped service or frozen port halts business operations even though the OS still responds to Ping:
       - **Primary Active Directory Domain Controllers** (monitoring `NTDS`, `DNS`, `DHCPServer`, and LDAP port `389`)
       - **Core Database Servers** (SQL Server `1433`, MySQL `3306`)
       - **Production ERP, Mail, Payment, and Core Web Servers** (`HTTPS 443`, `SMTP 25`)
       - **Core Firewalls and VPN Gateways** where an unresponsive management or application daemon requires immediate admin intervention via RDP, iLO, iDRAC, or VM console.

> **💡 Understanding the Difference: Technical Detection vs. Operational Urgency**:
> - **The Detection Engine is 100% Identical**: From a network probing perspective, both **`🟡 Degraded Warning`** and **`🚨 Critical Zombie Alert`** detect the exact same technical event: *ICMP Ping replies normally (the host is alive), but one or more monitored TCP/UDP ports or Windows services fail to respond within timeout*. Whether a service is "stopped", "frozen", "deadlocked", or a "port is closed/unresponsive", the probe receives the exact same socket result (connection refused, reset, or timed out).
> - **The Distinction is Business Impact & Alert Escalation Priority**:
>   - **`🟡 Degraded Warning`** is treated as a **Warning**. Designed for standard servers where an auxiliary port or background daemon dropped, but the server is still largely operational. It notifies the team without causing after-hours panic.
>   - **`🚨 Critical Zombie Alert`** is treated as a **Critical Emergency**. Designed for core systems (like Domain Controllers or Databases). While the network card still answers Ping, human users cannot authenticate, log in, or access files because core services are dead (the machine is a "Zombie"). It triggers urgent red visual indicators and high-priority escalation so administrators take immediate action.
> - **How Recurring Reminders Work Across All Alert Types**:
>   - WhatsApp reminders are **not exclusive to Zombie alerts**.
>   - Whenever **Notification Reminders** are enabled in your settings, the monitoring coordinator automatically sends recurring reminders for **all active unresolved incidents**—including `SERVICE_PORT_DEGRADED`, `ZOMBIE_SERVER_DETECTED`, `DESTINATION_UNREACHABLE`, and `PACKET_LOSS_BREACH`—at the configured interval (e.g. every 15 or 30 minutes) up to your maximum reminder limit.
>   - Reminders continue until the incident is resolved or an administrator right-clicks and chooses **`✅ Acknowledge Incident`** in the Incidents log (which silences further reminders while troubleshooting is underway).

* **Quick Comparison Summary *(Host Reachable / Ping OK, but a Monitored Port or Service Fails)***:

| Alert Policy | Dashboard Status | Incident Logged? | Severity | WhatsApp Alert & Reminders? | Recommended For |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **🟡 Degraded Warning** *(Recommended)* | `🟡 Degraded` | Yes (`SERVICE_PORT_DEGRADED`) | `WARNING` | Yes (Warning Alert + Recurring Reminders + Recovery) | Standard servers, file/web servers, NAS, switches |
| **ℹ️ Status Only** | `🟡 Degraded` / `ℹ️ Status Only` | **No** | — | **No** *(Full offline outage still alerts)* | Test/dev servers, sleeping printers, optional apps |
| **🚨 Critical Zombie Alert** | `⚠️ Zombie Alert` *(Red)* | Yes (`ZOMBIE_SERVER_DETECTED`) | `CRITICAL` | Yes (Urgent Critical Alert + Recurring Reminders + Recovery) | Domain Controllers, DB servers, core production systems |

#### Step-by-Step Walkthrough: Setting Up Combined Multi-Layer Surveillance
Follow these practical steps to configure a server, router, firewall, switch, printer, access point, camera, NAS, IP phone, or scanner with combined monitoring:

1. **Open Device Management**:
   - In the **Network Monitor** (`Ctrl + Shift + M`), click **➕ Add Device** on the toolbar, or right-click any existing device and select **📝 Edit Device...**.
2. **Enter IP / Hostname & Select Device Type**:
   - Enter the device's IP address or hostname (e.g. `192.168.1.10` or `SRV-DC-01`) and pick its **Device Type**.
   - The system immediately activates the recommended **Monitoring Methods** (`ICMP Ping`, `Port Monitoring (TCP/UDP)`, `Service / Protocol`), populates the default profile ports and protocols, and begins live probing across all enabled layers.
   - If you change the IP address at any time, every selected port and service automatically shows `⏳ Checking...` and refreshes live against the new IP.
3. **Customize Methods, Roles & Alert Policy**:
   - Toggle individual **Monitoring Methods** checkboxes as needed (for example, uncheck `ICMP Ping` for an external gateway that drops ping while keeping HTTPS port and protocol monitoring active).
   - Click **🔍 Scan & Auto-Detect Roles on Host** to discover active server roles automatically, open the **Health Profile** dropdown to combine multiple profiles, or check **⚙️ Custom** to type custom TCP/UDP ports (`443`, `53/udp`) or Layer-7 protocols (`HTTPS`, `SSH`, `SNMP`, `RTSP`).
   - Select the desired **Alert Policy** (`Degraded Warning`, `Status Only`, or `Critical Zombie Alert`).
4. **Assign Coordinators & Distributed Quorum Consensus (Optional)**:
   - Select which Coordinator server(s) probe this device (or keep **All Coordinators** checked for fleet-wide probing).
   - For mission-critical servers monitored across multiple branches or data centers, check **🛡️ Enable Distributed Multi-Coordinator Consensus**.
   - **Incident Threshold**: Select whether an incident is opened immediately upon any local coordinator breach, or only when all assigned coordinators confirm the device is down.
   - **Notification Threshold**: Select whether WhatsApp emergency alerts are sent on any breach or strictly when all active coordinators agree the device is down. Setting this to *All Coordinators Down* prevents false alarms caused by localized branch ISP drops while the target remains online elsewhere.
5. **Confirm Live Badges & Layer Preview**:
   - Wait for `⏳ Checking...` badges to resolve into live results beneath each field and review the **Live Layer Preview** banner at the bottom of the monitoring section.
6. **Save & Monitor**:
   - Click **💾 Save Device** (or **💾 Update Device**). The dashboard tracks **Ping**, **Port(s)**, **Service(s)**, and **Overall Health** continuously around the clock with automatic recovery confirmations when degraded subsystems return to normal.

#### Performing Diagnostic Reachability Tests
- **Instant Diagnostic Ping**:
  - Right-click any device row and select **📡 Ping Now (Instant Verification)**.
  - The application executes a 4-packet diagnostic ping in real time and reports exact reachability status, round-trip latency (e.g. `1.8 ms`), and packet loss percentage (e.g. `0% Loss`).
- **1-Click Ping All Now**:
  - Click **⚡ Ping All Now** on the action toolbar.
  - The application runs high-speed parallel pings across all configured devices simultaneously using background worker threads, refreshing live statuses across the entire fleet in seconds without freezing the user interface.

#### Multi-Coordinator Filtering & Probe Source Telemetry
- **Probe Server / Coordinator Column**:
  - The main device roster, Outage Incidents history dialog, and WhatsApp Notification delivery log each include dedicated **Probe Server / Source Server** and **Destination Target** columns.
  - Instantly reveals whether a device is monitored fleet-wide by all coordinator servers or assigned to specific probe servers (e.g. `SRV1`), and which server generated each alert.
- **1-Click Coordinator Filter Dropdown**:
  - The toolbar includes a **🌐 All Coordinators** dropdown listing all known probe servers.
  - Selecting any server immediately isolates the view to targets, incidents, or notification dispatches originating from that probe server.

#### Editing, Copying & Deleting Monitored Devices
- **Edit Device**: Double-click any row or right-click and select **📝 Edit Device...** to modify the IP address, device name, location group, category, real-time monitoring mode, or assigned probe servers.
- **Copy IP Address**: Right-click any row and select **📋 Copy IP Address** to copy the target IPv4 address directly to your Windows clipboard.
- **Delete Device**: Right-click any row and select **🗑️ Delete Device**. Confirm the prompt to remove the target from active monitoring.

#### Instant Device Monitoring Activation & Bulk Management
System administrators can easily activate or pause 24/7 ICMP reachability monitoring through three synchronized methods:
- **Right-Click Menu Toggle**: Right-click any device in the inventory table and choose **Activate** (if currently inactive) or **Deactivate** (if active) to toggle monitoring immediately without opening the Edit dialog.
- **Bulk Selection Toolbar**: Select checkboxes next to target devices and use the **▶️ Enable** or **⏸️ Disable** buttons on the toolbar. A confirmation prompt protects against accidental bulk deactivation.
- **Device Configuration Dialog**: Manage individual active status via the Active Monitoring checkbox inside the Add or Edit Device dialog.

All three methods update the underlying device configuration immediately and automatically replicate the updated status across all assigned coordinator servers.

#### Multi-Layer Device Health Profiles & Management Protocols
When configuring monitored devices, administrators can select tailored health profiles that verify network connectivity, open ports, and core services together:
- **🖨️ Windows Print Server**: Monitors core `Spooler`, `PrintNotify` (Printer Extensions and Notifications), and `WinRM` services alongside ports `445` (SMB/RPC), `135` (RPC/WMI), `5985` (WinRM HTTP), `515` (LPR), and `9100` (RAW print). This comprehensive profile ensures print spoolers, notification dialogs, and remote management endpoints remain healthy.
- **⚙️ Windows Remote Management (WinRM / WMI)**: Specialized profile for agentless Windows management tracking `WinRM` and `winmgmt` services on ports `5985` (WinRM HTTP), `5986` (WinRM HTTPS), and `135` (WMI/RPC Endpoint Mapper).
- **🖨️ Network Printer**: Monitors physical and shared network printers across RAW port `9100`, LPR port `515`, web configuration ports `80`/`443`, and `SNMP` (UDP 161) for printer reachability, ink levels, and status reporting.
- **🖥️ Windows Server Baseline**: Monitors `RDP` (3389), `SMB` (445), and `WinRM` (5985) alongside Windows services to verify core operational availability.
- **Intelligent Service & Protocol Alias Normalization**: The monitoring engine automatically recognizes administrative aliases—mapping `WMI` to the internal Windows service `winmgmt` and `WinRM-Service` to `WinRM`—and smoothly falls back to non-intrusive TCP and WS-Management HTTP probes if RPC is blocked by network firewalls.
- **Verified Multi-Layer Health Baseline & False Alert Prevention**: When an administrator verifies and saves a network device where all monitored ports and services display green and operational in the live preview, the system records an authoritative health baseline across all monitoring nodes. Background coordinators differentiate between an active connection refusal (where a host explicitly rejects a port, indicating a stopped service) and an unestablished timeout caused by inter-VLAN firewall routing. If an endpoint is confirmed responsive and verified healthy, ports blocked from a specific coordinator subnet are classified as filtered rather than a service failure, preventing false outage incidents and repetitive WhatsApp alerts while immediately synchronizing the fleet dashboard to Online.

---

### E. Normal Monitoring and Real-Time Monitoring

Every device is checked in one of two ways. You choose per device with the **⚡ Real-Time Monitoring** checkbox in **Add / Edit Device**.

#### How Normal Monitoring Works
- **Schedule**: Devices are checked once per cycle. The cycle length is **Settings → General → Default Monitoring Interval** (60 s, 120 s, 300 s, 600 s or 900 s; 300 s is the factory default), or the custom interval in a device's **🔔 Notification Settings...**. The next cycle starts one interval after the *start* of the previous one, so a 60-second interval really means one check every 60 seconds. All devices in a cycle are checked at the same time, up to **Max Concurrent Probes**.
- **Ping check**: The coordinator sends **Default Ping Count** pings (factory default 10), **50 ms apart**, and waits up to **Default Ping Timeout** for each reply (factory default 2 seconds).
  - A healthy cycle of 10 pings takes about **0.5 seconds**.
  - If **none** of the pings are answered, the coordinator waits 250 ms and sends **2 extra confirmation pings** (each waits at most 1 second). Only if these also fail is the device considered unreachable on this cycle.
- **Statistics**: Every cycle records average, minimum and maximum response time and packet loss, which feed the dashboard, packet-loss alerts and latency alerts.
- **Ports and services**: Checked on every cycle after the ping check (see the timing scenarios for how a dead device is handled quickly).
- **Confirmation**: A problem must be seen on **Consecutive Breach Count** cycles in a row (**Settings → Ping & Rules**, factory default 3) before an incident is opened and an alert is sent. One good cycle resets the count. The dashboard already shows the device as **Offline** (red) after the first failed cycle.
- **Packet loss alert**: Raised when the number of lost pings in a cycle reaches **Default Max Packet Drop Limit** (counted in packets; with 10 pings, a limit of 5 means 5 lost pings or 50%) on the required number of consecutive cycles. **Loss Evaluation Mode** decides whether all lost packets count (**Total Failed Packets in Cycle**) or only lost packets in a row (**Consecutive Drops Only**).
- **Latency alert**: Raised when the average response time is above **Maximum Permitted Latency** on the required number of consecutive cycles (only when **Enable High-Latency Alerts** is ticked).
- **Between coordinators**: Normal Monitoring does **not** send immediate re-check requests to other coordinators. Each coordinator follows its own cycle.

#### How Real-Time Monitoring Works
- **Schedule**: The device is checked every **Probe Interval** (3, 5, 10, 15, 20, 25 or 30 seconds; 5 seconds recommended). It does not wait for the normal cycle.
- **Ping check**: **One** ping with a **1-second timeout** (the same for every available interval). A healthy local device answers in under 1 ms, so the check finishes almost immediately.
- **Fast multi-ping verification**: Every interval, the coordinator sends one ping. If it is not answered, a fast multi-ping verification check is initiated immediately (completing in about **0.5 seconds**, even when the device is unreachable).
  - **5 or more replies** → the device is alive; no outage. (This protects against a single lost packet.)
  - **Fewer than 5 replies** → ping is confirmed **DOWN** during that same monitoring check.
- **Ports and services**: See [Section F](#f-incident-detection-timing--confirmation-logic-4-practical-scenarios). When ping is down and no monitored port answers, the device is confirmed **Offline** on that same check; services are not queried because the machine cannot answer.
- **Confirmation**: For devices with ICMP Ping ticked, **one** failed check plus the failed verification burst confirms the outage. The Consecutive Breach Count is still used for partial port/service failures and latency alerts, and for Real-Time devices that do not use ping.
- **Packet loss**: Real-Time Monitoring sends one ping per check, so packet-loss statistics and packet-loss alerts belong to Normal Monitoring. Latency alerts still work (single-ping response time against **Maximum Permitted Latency**).
- **Between coordinators**: When consensus is enabled with an *All Coordinators Down* threshold, the first coordinator that confirms an outage asks the other coordinators to re-check the device **immediately** instead of waiting for their next interval (see [Section G](#g-coordinator-consensus--multi-coordinator-monitoring)).

> ⚠️ **Important usage warning — Local network only**
> **Real-Time Monitoring is intended for devices connected to the local network.** It uses very short intervals and fast verification timings, so it is not intended for VPN-connected branch devices, remote networks or cloud servers where network latency and packet loss may cause misleading results. Use Normal Monitoring (for example a 60-second interval with 10 pings and a 2-second timeout) for anything reached over a WAN, VPN or the internet.

#### Real-Time vs Normal Monitoring — Comparison

| Behavior | Real-Time Monitoring | Normal Monitoring |
| :--- | :--- | :--- |
| Example interval | 5 seconds (3–30 s per device) | 60 seconds (Settings → General) |
| Initial ping check | 1 ping, 1-second timeout | Configured ping count (example: 10 pings, 50 ms apart, 2-second timeout) |
| Fast verification | Immediate multi-ping verification (about 0.5 s); fewer than 5 replies = down | 2 extra confirmation pings after a fully failed cycle (about 2.3 s) |
| Offline confirmation | One failed check plus the failed burst | Consecutive Breach Count failed cycles in a row (example: 2) |
| Port check on a dead device | One pass of all ports at the same time (about 1 s) | One pass of all ports at the same time (about 1 s) |
| Coordinator consensus | Immediate re-check request to the other coordinators | Each coordinator follows its own cycle |
| Typical outage alert (single coordinator or consensus off) | About 2.5–9.5 seconds after the failure | About 1 min 25 s – 2 min 25 s with a 60 s interval and 2 cycles |
| Packet-loss statistics & alerts | Not used (one ping per check) | Yes (average / min / max latency and loss per cycle) |
| Primary purpose | Fast outage detection for critical local network devices | Standard monitoring, remote/WAN devices and detailed statistics |

#### When to Choose Each Mode
- **Choose Real-Time Monitoring** for critical devices on the same local network as the coordinator: core and distribution switches, local firewalls and gateways, domain controllers, storage arrays and production servers, where an outage must be known within seconds.
- **Choose Normal Monitoring** for:
  - Branch routers, VPN-connected sites, cloud servers and anything reached over the internet.
  - Devices where occasional slow replies are normal (wireless bridges, busy appliances).
  - Peripheral devices (printers, cameras, access points) where a few minutes' delay is acceptable.
  - Devices where you want packet-loss statistics and packet-loss alerts.

---

### F. Incident Detection Timing & Confirmation Logic (4 Practical Scenarios)

This chapter explains, step by step, how long it takes from the moment a device fails (for example, its network cable is pulled) until the dashboard turns red, an incident is opened and the WhatsApp alert arrives. The values below were checked against the monitoring engine of this release.

#### Why the Detection Time Always Varies
A device is only checked at its scheduled times. If the cable is pulled **just before** a scheduled check, the failure is noticed almost immediately. If it is pulled **just after** a check, nothing notices until the next check. That is why every timing below is a range:

```
Real-Time, 5 s interval:

   check        check        check        check
     │            │            │            │
─────┼────────────┼────────────┼────────────┼────▶ time
          ▲  cable pulled here → up to 5 s until the next check
                         ▲ cable pulled here → next check almost at once
```

- **Waiting time** = from the failure to the next scheduled check: between 0 and one interval (0–5 s for Real-Time 5 s; 0–60 s for Normal 60 s).
- **Verification time** = how long the check itself needs to be sure (ping timeout, verification burst, port pass).
- **Confirmation** = how many failed checks are needed before an incident (Real-Time ping: 1; Normal: the Consecutive Breach Count).
- **Consensus time** = extra time for other coordinators to agree (only when consensus is enabled).
- **Delivery time** = sending the WhatsApp message, normally **1–2 seconds**. The alert is sent the moment the incident is created; it does not wait for a queue timer.

#### Example Settings Used in the Scenarios

| Setting | Where | Value used |
| :--- | :--- | :--- |
| Real-Time Probe Interval | Add / Edit Device | 5 seconds |
| Default Monitoring Interval | Settings → General | 60 seconds |
| Default Ping Count | Settings → Ping & Rules | 10 packets |
| Default Ping Timeout | Settings → General | 2 seconds (2000 ms) |
| Consecutive Breach Count | Settings → Ping & Rules | 2 cycles |
| Default Max Packet Drop Limit | Settings → Ping & Rules | 5 packets |
| Maximum Permitted Latency | Settings → Ping & Rules | 100 ms (high-latency alerts enabled) |
| Recovery Confirmation Count | Settings → Ping & Rules | 1 |

---

#### Scenario 1: Real-Time Monitoring (5 seconds) — Ping Only

**While the device is working**
- A check runs every 5 seconds.
- One ping is sent with a 1-second timeout.
- The reply arrives in under 1 ms, so the check finishes far within 1 second.

**When the device goes offline (cable pulled = time 0)**

| Timeline | What happens |
| :--- | :--- |
| 0 – 5 s | Waiting for the next scheduled check. |
| + 1 s | The routine ping is not answered (1-second timeout). |
| + about 0.5 s | Multi-ping verification runs immediately. Fewer than 5 replies confirms **Offline**. The dashboard turns red. |
| Immediately | **Consensus OFF**: the incident is created and the WhatsApp alert is sent at once. |
| + 1 – 2 s | WhatsApp delivery. |

**Expected notification time**
- **Consensus OFF**: about **2.5 – 8.5 seconds** after the cable is pulled (0–5 s waiting + about 1.5 s check + 1–2 s delivery).
- **Consensus ON (All Coordinators Down)**: the coordinator that detected the outage immediately asks the other coordinators to re-check. Each of them picks up the request within about 1 second and needs about 1.5 seconds for its own check, so the whole fleet normally agrees **2 – 3 seconds** later (the detecting coordinator waits at most 4 seconds). One coordinator then creates the single shared incident, which can add up to about 2 seconds. Total: typically **about 5 – 11 seconds**, occasionally up to about 13 seconds.
- If one coordinator still reports the device as Online after the 4-second wait (for example, it really can still reach it), no incident is raised on this check; the next checks decide.

---

#### Scenario 2: Real-Time Monitoring (5 seconds) — Ping + 2 Ports + 3 Services

**While the device is working**
- One ping.
- One connection attempt per monitored port.
- One check per monitored service.
- Under normal network conditions all checks complete within about 1 second.

**When the device goes offline (cable pulled = time 0)**

| Timeline | What happens |
| :--- | :--- |
| 0 – 5 s | Waiting for the next scheduled check. |
| + 1 s | The routine ping fails. |
| + about 0.5 s | Multi-ping verification confirms **Ping DOWN**. |
| + about 1 s | Both monitored ports are tried **at the same time** (one pass, 1-second timeout). Neither answers. |
| Right after the port pass | Because ping and every port are dead, the machine cannot answer service queries, so the services are **not queried** and are all reported **DOWN (Unreachable – Host Down)**. |

**Expected result**
- The device is classified **Offline** about **2.5 seconds** after the check starts.
- **Consensus OFF**: about **3.5 – 9.5 seconds** to the WhatsApp notification.
- **Consensus ON**: about **6 – 12 seconds** to the WhatsApp notification (each coordinator needs about 2.5 seconds for its own re-check), occasionally up to about 14 seconds.

**What the WhatsApp alert shows** — a *FAILED PROTOCOL LAYERS* block listing each layer:
```text
🧪 *FAILED PROTOCOL LAYERS*
• ICMP Ping: 🔴 DOWN (fewer than 5 of 100 burst packets answered)
• Port(s): 🔴 DOWN – 3389: BlockedOrTimeout, 445: BlockedOrTimeout
• Service(s): 🔴 DOWN – RDP: Unreachable (Host Down), SMB: Unreachable (Host Down), WinRM: Unreachable (Host Down)
```
Ports are listed together on one line and services together on one line, each with its individual result.

> **Why the device is not treated as Offline when a port still answers**: if ping fails but any monitored port answers (or actively refuses the connection), the machine is alive behind a firewall that blocks ping. The device stays **Online** with Ping shown as **ICMP Filtered**, and the normal port and service checks continue.

##### Additional Scenario: Individual Port or Service Failure (Device Still Reachable)

If ping keeps answering but one monitored port or service fails:

| Step | What happens |
| :--- | :--- |
| Port fails | The port is tried once; if it fails, **10 confirmation attempts start at the same time** (each waits up to 0.35 s). A port that refuses the connection is confirmed in well under a second; a port that does not answer at all needs about 1.4 seconds. Any successful attempt means the port is fine. |
| Service fails | The service is checked once; if it fails, **3 confirmation checks run at the same time**. A cleanly stopped service is usually confirmed in under a second; when the service query itself has to wait for its timeouts, confirmation can take a few seconds (up to about 6 seconds). |
| Classification | The device is **Degraded**, not Offline, because it still answers. |
| Incident | Raised when the failure is seen on **Consecutive Breach Count** checks in a row (2 in the example settings), using the device's **Alert Policy**: *Degraded Warning* (warning incident), *Critical Zombie Alert* (critical incident) or *Status Only* (no incident, no alert). |

**Expected alert time** (Real-Time 5 s, 2 consecutive failed checks): about **7 – 15 seconds** after the port or service stops (0–5 s waiting + first check + 5 s to the second check + confirmation + 1–2 s delivery).

**Complete outage vs individual failure**

| | Complete device outage | Individual port / service failure |
| :--- | :--- | :--- |
| What answers | Nothing (no ping, no port) | Ping and/or other ports still answer |
| Status | 🔴 Offline | 🟡 Degraded (or 🚨 Zombie with Critical policy) |
| Confirmation (Real-Time) | One failed check | Consecutive Breach Count failed checks |
| Incident type | Outage (critical) | Service/port degraded (warning) or zombie server (critical) |
| Alert Policy applies? | No — always alerts | Yes |

---

#### Scenario 3: Normal Monitoring (60 seconds) — Ping Only

Example settings: interval 60 s, 10 pings, 2-second timeout, 50 ms between pings, 2 consecutive failed cycles required.

**While the device is working**
- Every 60 seconds, 10 pings are sent, 50 ms apart.
- A normal cycle takes about **0.5 seconds**.
- Each cycle records average, minimum and maximum response time and packet loss.
- **5 or more lost pings** in a cycle count as a packet-loss breach; an alert follows after 2 such cycles in a row.
- An **average above 100 ms** counts as a latency breach; an alert follows after 2 such cycles in a row.

**When the device goes offline (cable pulled = time 0)**

| Timeline | What happens |
| :--- | :--- |
| 0 – 60 s | Waiting for the next scheduled cycle. |
| + about 20.5 s | All 10 pings reach their 2-second timeout (10 × 2 s plus the 50 ms gaps). |
| + about 2.3 s | Short pause, then 2 confirmation pings (each waits up to 1 second) also fail. |
| About 23 s after the cycle starts | The cycle classifies the device as **Offline**. The dashboard turns red. Failed cycle 1 of 2. |
| 60 s after the first failed cycle started | The next cycle starts (the interval is counted from the start of each cycle). |
| About 23 s later | The second failed cycle completes. The incident is created and the WhatsApp alert is sent immediately. |

**Expected incident and notification time**: about **1 minute 25 seconds to 2 minutes 25 seconds** after the cable is pulled (0–60 s waiting + 60 s + about 23 s + 1–2 s delivery).

**Points to remember**
- Normal Monitoring follows the ping settings exactly (count, timeout, interval, consecutive breach count). It does not use the Real-Time multi-ping verification mode.
- Two consecutive failed cycles are required with these settings; a single good cycle in between resets the count.
- Unlike Real-Time Monitoring, Normal Monitoring does **not** send immediate re-check requests to other coordinators.
- **When several coordinators monitor the same device** (All Coordinators or several selected servers), a coordinator that sees a failure still trusts another coordinator's recent *Online* result (up to 3 minutes old) until that coordinator has run its own failed check. Each coordinator follows its own schedule, so the count can start up to about **one cycle later** (up to about **3 minutes 25 seconds** in total with a 60-second interval). This applies whether consensus is on or off. With consensus **All Coordinators Down**, the incident is also held until every assigned coordinator reports the device down.

---

#### Scenario 4: Normal Monitoring (60 seconds) — Ping + 2 Ports + 3 Services

Same settings as Scenario 3.

**While the device is working**
- Ten pings are sent.
- Both ports get their normal check.
- All three services get their normal check.
- A healthy cycle takes about **1 second**.

**When the device goes offline (cable pulled = time 0)**
- The ping check follows the same steps as Scenario 3; about **23 seconds** after the cycle starts, ping is confirmed down.
- Both ports are tried **at the same time**, taking about another second.
- The services are **not queried** because the machine is unreachable; they are reported DOWN (Unreachable – Host Down).
- The device is classified **Offline** about **24 seconds** after the cycle starts.
- Two consecutive failed cycles are required before the incident is created.

**Expected incident and WhatsApp time**: about **1 minute 25 seconds to 2 minutes 25 seconds** after the cable is pulled (about one second longer than Scenario 3), plus the multi-coordinator note from Scenario 3 when several coordinators monitor the device.

The alert lists the failed **Ping**, **Port(s)** and **Service(s)** layers in the same *FAILED PROTOCOL LAYERS* block shown in Scenario 2.

---

#### Summary of Expected Times

| Scenario | Dashboard turns red | WhatsApp — consensus OFF | WhatsApp — consensus ON (All Down) |
| :--- | :--- | :--- | :--- |
| 1. Real-Time 5 s, ping only | 1.5 – 6.5 s | 2.5 – 8.5 s | about 5 – 11 s |
| 2. Real-Time 5 s, ping + 2 ports + 3 services | 2.5 – 7.5 s | 3.5 – 9.5 s | about 6 – 12 s |
| 2b. Real-Time 5 s, one port/service fails (2 checks) | Degraded after first check | 7 – 15 s | 7 – 15 s (plus agreement time if All Down) |
| 3. Normal 60 s, ping only, 2 cycles | 23 – 83 s | 1 min 25 s – 2 min 25 s | up to about 3 min 25 s |
| 4. Normal 60 s, ping + 2 ports + 3 services, 2 cycles | 24 – 84 s | 1 min 25 s – 2 min 25 s | up to about 3 min 25 s |

#### How Recovery Is Confirmed
- **Real-Time**: once the device answers again, it must pass **Recovery Confirmation Count** checks in a row (each one Probe Interval apart) before the incident is resolved.
- **Normal**: the same count, in cycles.
- **Consensus with Incident Threshold = All Coordinators Down**: the incident is resolved only after every active assigned coordinator sees the device online again, so one coordinator cannot close an outage that the others still see.
- Exactly **one** recovery WhatsApp is sent (by the coordinator that owns the incident), and only if **Send WhatsApp Recovery Alerts** is ticked.

---

### G. Coordinator Consensus & Multi-Coordinator Monitoring

When a device is monitored from several locations (for example Riyadh, Khobar and a data centre), a network problem at **one** location can make that location's coordinator believe the device is down, even though it is working and reachable from everywhere else. **Distributed Multi-Coordinator Consensus** prevents these false alarms by making the coordinators compare results before an incident or alert is raised.

#### How Coordinators Share Results
Each coordinator publishes its latest results, incidents and a heartbeat on its hidden monitoring share. The other coordinators read them, so every coordinator knows what the others currently see. The desktop application shows these per-coordinator results in the **Probe Server / Coordinator** column and lets you switch the view to any single coordinator with the **🌐 All Coordinators** selector.

```
                     ┌──────────────────┐
                     │ Server (1.1.1.1) │
                     └────────┬─────────┘
        ┌─────────────┬───────┼───────┬─────────────┐
        ▼             ▼       ▼       ▼             ▼
  ┌───────────┐ ┌──────────┐┌──────┐┌──────┐ ┌─────────────┐
  │ 1. Riyadh │ │2. Khobar ││3.OffA││4.OffB│ │5.Data Centre│
  └─────┬─────┘ └────┬─────┘└──┬───┘└──┬───┘ └──────┬──────┘
        └────────────┴────┬────┴───────┴────────────┘
                          ▼  shared results (hidden monitoring share)
                 [ Consensus check ]
                 - Is the server really down?
                 - Or is only Riyadh's path down?
```

#### Practical Walkthrough: The 5-Coordinator Scenario

**Scenario A — Local WAN / path outage at Riyadh (1 of 5 down)**
- Riyadh: no replies. Khobar, Office A, Office B, Data Centre: replies in under 1 ms.
- Riyadh confirms its own failure, then reads the other coordinators' results and finds 4 of 5 reporting **Online**.
- **Incident Threshold = All Coordinators Down**: no incident is created; it is a path problem at Riyadh, not a server failure.
- **Incident Threshold = Any Coordinator Down + Notification Threshold = All Coordinators Down**: an incident is recorded (so you can see that Riyadh has a routing problem), but **no WhatsApp alert** is sent.

**Scenario B — Real server outage (5 of 5 down)**
- Every coordinator gets no replies.
- With Real-Time Monitoring, the first coordinator that confirms the outage immediately asks the other four to re-check instead of waiting for their next interval. They agree within about 2–3 seconds.
- The threshold is met: **one** shared incident is created by one coordinator (the others adopt it), and **one** WhatsApp alert is sent, stating that all 5 coordinators confirm the outage.

**Scenario C — Recovery**
- The server restarts and answers again.
- With **Incident Threshold = All Coordinators Down**, the incident is resolved only when every active coordinator sees the server online, so a single flapping location cannot close the incident early.
- **One** recovery message is sent.

#### The 4 Threshold Combinations

| # | Incident Threshold | Notification Threshold | Behaviour & best use |
| :-: | :--- | :--- | :--- |
| **1** | Any Coordinator Down | Any Coordinator Down | **Maximum sensitivity.** Any coordinator that detects a failure creates the incident and sends the alert. Use for devices monitored by one coordinator, or links where even a local path failure needs an immediate page. |
| **2** | Any Coordinator Down | All Coordinators Down | **Track internally, alert only on real outages.** A local path problem opens an incident for the network team, but WhatsApp stays silent until every coordinator agrees. Good for distributed monitoring where you want an audit trail of local blips. |
| **3** | All Coordinators Down | All Coordinators Down | **Full consensus (recommended, default).** No incident and no alert unless every assigned coordinator confirms. Use for core infrastructure: domain controllers, ERP, mail gateways, public DNS. |
| **4** | All Coordinators Down | Any Coordinator Down | **Strict incident, early warning.** The incident waits for full agreement. In practice combinations 2 and 3 are the usual choices. |

#### Consensus OFF vs ON

| | Consensus OFF | Consensus ON (All Coordinators Down) |
| :--- | :--- | :--- |
| Who decides | Each coordinator on its own | All active assigned coordinators together |
| Incident & alert | Raised by the first coordinator that confirms; still only one shared incident and one alert | Raised only when every active coordinator reports down |
| Real-Time re-check request | Not used | The detecting coordinator asks the others to re-check at once (waits up to 4 s) |
| Extra time | None | About 2–3 s (Real-Time); up to about one cycle (Normal) |
| Recovery | Resolved by the incident owner when it sees recovery | Waits until all active coordinators see the device online |

#### Unavailable, Stopped or Crashed Coordinators
A coordinator that stops reporting must never be treated as proof that a device is down, and must never block a real outage from being detected:
1. **Heartbeat age**: a coordinator whose heartbeat is older than **3 minutes** is treated as *unavailable*.
2. **Excluded from the vote**: unavailable coordinators are removed from the count. If 5 are assigned and 1 has crashed, the decision is made by the other 4; if all 4 report the device down, the outage is confirmed (4 of 4).
3. **Never a "down" vote**: an unavailable coordinator is counted as *unknown*, never as a failed check.
4. **Old "Online" results expire**: another coordinator's *Online* result only counts while it is recent — **six probe intervals (at least 30 seconds)** for Real-Time devices and **3 minutes** for Normal Monitoring. An old healthy result from a stopped coordinator can therefore not hold back a confirmed outage for long.

#### Exactly One Incident and One Message per Event
- When several coordinators confirm the same outage at nearly the same moment, only **one** of them creates the incident; the others adopt it. If that coordinator does not create it within 15 seconds, another one does, so an outage is never lost.
- Reminders, consensus escalation messages and the recovery message are sent only by the coordinator that owns the incident, so you receive each message once.
- **Fleet consensus escalation**: if the first alert was sent while some coordinators still saw the device online (for example with Notification Threshold *Any Coordinator Down*) and later all coordinators confirm the outage, one **🚨 FLEET CONSENSUS OUTAGE CONFIRMATION** message is sent.

#### Reading the Fleet Result in Alerts and Logs
- WhatsApp alerts for multi-coordinator devices include a **COORDINATOR PROBE FLEET AUDIT** block: probing scope, assigned coordinators, the consensus verdict (for example `🔴 TOTAL FLEET OUTAGE (0/4 Reachable • 4/4 Down)`) and which coordinators confirmed it.
- The **Source Server** column of the Notification Log shows the consensus as well, for example `HQ [All 4 Coords Down]`.
- In the main grid, the **🌐 All Coordinators** selector switches the view to any single coordinator, so you can see exactly what that location sees.

---

### H. Incident Management

#### Centralized Incident Hub & Notification Delivery Log
Click **🚨 Incidents** on the header toolbar to open the centralized Incident Hub, or **📜 Notification Log** to inspect all queued and completed WhatsApp dispatches:
- **Live Real-Time Auto-Refresh (Zero Restart Needed)**: Both the **Outage Incidents** and **Notification History** windows automatically monitor underlying probe data every 2 seconds while open—displaying newly detected incidents, ongoing outage duration updates, status transitions (`ACTIVE` ➔ `ACKNOWLEDGED` ➔ `RESOLVED`), and delivery status updates (`PENDING` ➔ `SENDING` ➔ `SENT` / `FAILED` / `EXPIRED`) immediately with zero duplicate rows while preserving your selected row, details view, column sort order, and scroll position.
- **Unified Sequential Incident Identifiers & Cross-Server Deduplication**: Every outage is assigned a clean, globally unique sequential identifier (`INC-NET-15`) without unnecessary leading zeros or server prefixes. When multiple coordinator servers monitor the same infrastructure target and detect an outage or performance breach, the engine consolidates detection into a single shared incident record, combines all detecting servers (`Source Server: SRV1, HQ`), dispatches a single initial alert, coordinates recurring reminders from the primary detector, and synchronizes acknowledgement and recovery across all coordinators.
- **Unified Multi-Probe Aggregation**: View outage incidents and notification dispatches across **All Probes** simultaneously or filter by any specific coordinator server from the dropdown.
- **Color-Coded Notification Type Badges & Combined Type Filter**: In the Notification Delivery Log, every entry displays a color-coded pill badge in the **Type** column (**Alert** in red, **Reminder** in orange, **Recovery** in green, **Acknowledge** in blue, **Test** in purple, and additional types in slate). Combine the **Type** dropdown (`All Types`, `Alert`, `Reminder`, `Recovery`, `Acknowledge`, `Test`, `Other Types`) with the **Source Probe** selector and **Status** filter pills (`All`, `Delivered`, `Pending`, `Failed / Expired`) simultaneously.
- **Populated Destination Target Identification**: The **Destination Target** column displays the exact monitored host and IP address (`DeviceName (IP)`) for every outage, degradation, latency, acknowledgement, or recovery notification, and cleanly displays `Not Applicable` for system-level gateway connectivity tests that have no target device.
- **Live Status Tracking & Incident Metrics**: Displays whether an incident is **ACTIVE**, **ACKNOWLEDGED**, or **RESOLVED**, initial failure causes, packet loss percentages, average latency, affected device name/IP, and live outage duration.
- **Reorganized 12-Column Incident Layout & Network Directional Visibility**:
  - Optimized column hierarchy provides complete incident context at a glance:
    1. **Incident ID**: Clean sequential identifier (`INC-NET-01`).
    2. **Device Name**: Plain-English monitored device label.
    3. **Status**: Color-coded pill badge (Red `ACTIVE`, Amber `ACKNOWLEDGED`, Green `RESOLVED`).
    4. **Source Server (IP)**: Identifies the exact coordinator server that initiated the monitoring check and its active adapter IP address.
    5. **Destination Server (IP)**: Displays the monitored target host and its IP address.
    6. **Issue Type**: Human-readable failure description (e.g. `Ping Failure (Offline)`, `Critical Service Lockup`, `TCP Port Failure`).
    7. **Severity**: Distinct severity indicator (Red `CRITICAL`, Amber `WARNING`, Blue `INFO`).
    8. **Detection Time**: Exact timestamp when the outage or performance breach was confirmed.
    9. **Last Updated**: Real-time timestamp of the latest probe cycle.
    10. **Duration**: Live calculated outage duration (e.g. `02h 45m`).
    11. **Acknowledged By**: Administrator identity and acknowledgment timestamp.
    12. **Resolved Time**: Timestamp when the recovery sweep verified normal reachability.
    13. **Packet Loss**: Percentage of dropped packets across probe bursts.
    14. **Alerts Sent**: Total number of WhatsApp notifications and reminders dispatched.
- **Bulk Incident Acknowledge & Resolve Operations**:
  - **Multi-Selection & Select All**: Select multiple individual incidents via Ctrl+click or Shift+click, or use the dedicated **☑️ Select All** and **⬜ Clear** buttons.
  - **Single-Click Batch Execution**: Click **Mark as Acknowledged** to acknowledge all selected active outages at once, or **Resolve Selected** to resolve them in a single atomic operation.
  - **Confirmation Dialog**: Displays a clear summary of how many incidents will be updated and confirms the operation before execution.
  - **Instant UI Refresh**: Affected rows update their status pills and text immediately in memory with zero screen flicker or reloading lag, while unselected records remain untouched.
  - **Atomic Host Batching & Error Resilience**: Automatically groups selected incidents by their managing coordinator host, saving changes atomically and silencing reminders or broadcasting recovery alerts safely.
  - **Detailed Execution Summary**: Displays total success and failure counts after execution, identifying any specific records that could not be updated.
- **Safe "Clear History" Controls with Confirmation Prompts**:
  - Click **🗑️ Clear History** in **Outage Incidents** to permanently prune **Resolved** historical incidents for the currently selected coordinator probe (or across all synchronized probes when **All Probes** is selected). Ongoing **Active** and **Acknowledged** incidents, monitoring schedules, and incident numbering remain completely untouched.
  - Click **🗑️ Clear History** in **Notification History** to clear archived delivery records while strictly preserving active queued/retrying notifications, active incidents, gateway credentials, and monitoring settings.
  - Both actions display a confirmation prompt summarizing exact item counts before any records are deleted.
- **Administrative Notes**: Operators can select any incident, mark it as acknowledged, and record troubleshooting notes for compliance records.

---

### I. Notifications & WhatsApp Alerts

#### Why WhatsApp Alerting Is Superior to Email
Traditional email alerts frequently suffer from delayed delivery, spam filter quarantines, and inbox clutter. WhatsApp emergency alerts provide **instant push delivery directly to IT engineers' mobile phones with delivery receipts**, ensuring immediate awareness and drastically reducing mean time to repair (MTTR).

#### Step-by-Step WhatsApp Gateway Setup Guide (WABlend Platform)
The application integrates seamlessly with the **WABlend Cloud Messaging Gateway** (`https://wablend.com`) for direct, authenticated WhatsApp message delivery:

##### Part 1: WABlend Account Creation & WhatsApp Device Linking
1. Visit [https://wablend.com](https://wablend.com) and click **Sign Up** to create your account.
2. Subscribe to an active service plan that includes the **API Feature**. Ensure your subscription is active before proceeding.
3. In the WABlend dashboard, open the left-hand navigation menu and click **Devices**.
4. Click **➕ Add Device** and enter your WhatsApp mobile number (including international country code).
5. Click **Save Device**.
6. In the devices table, locate your newly created device and click the **three-dot action menu** (`...`).
7. Select your preferred connection method: **QR Code** (recommended) or **WhatsApp Linking Code**.
8. On your mobile phone, open WhatsApp, tap **Settings** -> **Linked Devices** -> **Link a Device**, and scan the QR code displayed on your screen.
9. Verify that your device status in WABlend changes to a green **Connected** badge.

##### Part 2: Retrieving Your API Authorization Key
10. In the top-right corner of the WABlend dashboard, click your **Profile Icon**.
11. From the dropdown menu, select **Settings**.
12. Navigate to the **API Key** section and click the copy icon to copy your secret API key to the clipboard.

##### Part 3: Configuring the Windows Application
13. Open the **Windows AD Remote Administration Control Hub** and launch **📡 Network Monitor** (`Ctrl+Shift+M`).
14. Click **⚙️ Settings** on the action toolbar and select the **WhatsApp API Gateway** tab.
15. In the **API Key** field, paste your copied secret key.
16. In the **Sender Phone Number** field, enter the exact mobile phone number connected in Step 8.
17. In the **Default Emergency Recipients** list, enter your destination mobile phone numbers (e.g. `966501234567`).
18. Click **⚡ Test Connection** to verify gateway authorization.
19. Click **✉️ Send Test Message** to receive a live verification message on your phone.
20. Click **Save Settings** to activate 24/7 automated alerting.

#### Anatomy of an Emergency Outage Alert
When an outage is confirmed (see [Section F](#f-incident-detection-timing--confirmation-logic-4-practical-scenarios) for when this happens), the coordinator immediately sends a structured emergency message. The *FAILED PROTOCOL LAYERS* block lists only the monitoring methods that are switched on for the device (Ping, Port(s), Service(s)):
```text
🔴 *NETWORK OUTAGE ALERT*

*HQ-Core-Switch-01 is OFFLINE*

━━━━━━━━━━━━━━━━━━
🖥️ *DEVICE & ROUTING*
📍 Dispatching Server: HQ-MONITOR (10.10.10.10)
🎯 Destination Target: HQ-Core-Switch-01 (192.168.10.254)
10.10.10.10 → 192.168.10.254
Type: Switch | Location: Server Room Rack A

🌐 *COORDINATOR PROBE FLEET AUDIT*
• Probing Scope: All Coordinators (Fleet-Wide Probing)
• Assigned Nodes (4): HQ-MONITOR, SRV-BACKUP, BRANCH-DC, DR-COORDINATOR
• Quorum Consensus: 🔴 TOTAL FLEET OUTAGE (0/4 Reachable • 4/4 Down)
• Confirmed Down By: HQ-MONITOR, SRV-BACKUP, BRANCH-DC, DR-COORDINATOR

📊 CURRENT *STATUS*
• Connectivity: 🔴 Offline
• Packet Loss: 100%
• Downtime: 05m 00s
• Probe: 10/10 Failed
• Successful Probes: 0 / 10

🧪 *FAILED PROTOCOL LAYERS*
• ICMP Ping: 🔴 DOWN (fewer than 5 of 100 burst packets answered)
• Port(s): 🔴 DOWN – 443: BlockedOrTimeout, 22: BlockedOrTimeout

🆔 *INCIDENT*
• ID: INC-NET-4
• Since: 04-Nov-2026 13:47:51 UTC
• Notification Sequence: #1
• Status: UNRESOLVED

━━━━━━━━━━━━━━━━━━
⚠️ *ATTENTION REQUIRED*

A sustained network outage has been detected. Please investigate the affected device and restore network connectivity.

🤖 *Automated Alert | Windows AD Remote Administration Control Hub*
```

> **💡 Multi-Coordinator Fleet Audit & Quorum Consensus Transparency**:
> - For any device monitored across multiple coordinator servers (or configured with **All Coordinators**), the alert message automatically embeds a dedicated **COORDINATOR PROBE FLEET AUDIT** block.
> - **Probing Scope & Assigned Nodes**: Displays the exact list and total count of coordinator servers assigned to monitor the target.
> - **Quorum Consensus Verdict**: Clearly differentiates between a **Total Fleet Outage** (where 100% of all assigned coordinators confirm the device is unreachable) and a **Local Coordinator Breach** (where the device is unresponsive from the dispatching coordinator but reachable from other coordinators in the fleet).
> - **Fleet Consensus Outage Escalation**: If an alert is dispatched at the initial onset of an outage and subsequent probe cycles confirm that all remaining assigned coordinators also report unreachable, an automated **🚨 FLEET CONSENSUS OUTAGE CONFIRMATION** escalation notification is dispatched to WhatsApp so administrators know with 100% certainty that the outage is fleet-wide.

#### Anatomy of a Recurring Outage Reminder
For ongoing outages, follow-up reminder notifications are dispatched at configured intervals:
```text
🔴 *NETWORK OUTAGE ALERT*

*HQ-Core-Switch-01 is still OFFLINE.*

━━━━━━━━━━━━━━━━━━
🖥️ *DEVICE*
`10.10.10.10` → `192.168.10.254`
Type: Switch | Location: Server Room Rack A

📊 CURRENT *STATUS*
• Connectivity: 🔴 Offline
• Packet Loss: 100%
• Downtime: 02h 45m
• Probe: 10/10 Failed
• Successful Probes: 0 / 10

🆔 *INCIDENT*
• ID: INC-NET-4
• Since: 04-Nov-2026 13:47:51 UTC
• Notification Sequence: #67
• Status: UNRESOLVED

━━━━━━━━━━━━━━━━━━
⚠️ *ATTENTION REQUIRED*

The outage is ongoing. Please investigate the affected device and restore network connectivity.

🤖 *Automated Alert | Windows AD Remote Administration Control Hub*
```

#### Anatomy of an Acknowledged Incident Alert
When an operator acknowledges an ongoing outage from the Incidents center, the system dispatches an acknowledgement confirmation:
```text
🟡 *NETWORK OUTAGE ACKNOWLEDGED*

*HQ-Core-Switch-01 outage is ACKNOWLEDGED.*

━━━━━━━━━━━━━━━━━━
🖥️ *DEVICE*
`10.10.10.10` → `192.168.10.254`
Type: Switch | Location: Server Room Rack A

📊 CURRENT *STATUS*
• Connectivity: 🔴 Offline
• State: 🟡 Acknowledged (Under Investigation)
• Packet Loss: 100%
• Downtime: 02h 45m
• Reminders: Silenced

🆔 *INCIDENT*
• ID: INC-NET-4
• Since: 04-Nov-2026 13:47:51 UTC
• Acknowledged At: 04-Nov-2026 15:10:00 UTC
• Notification Sequence: #68
• Status: ACKNOWLEDGED

━━━━━━━━━━━━━━━━━━
👁️ *ADMINISTRATIVE STATUS*

The incident has been acknowledged by the administrator. Recurring reminders have been silenced while troubleshooting is underway.

🤖 *Automated Alert | Windows AD Remote Administration Control Hub*
```

#### Anatomy of an Automatic Recovery Alert
When the device recovers and passes confirmed recovery cycles, a recovery confirmation is sent:
```text
🟢 *NETWORK OUTAGE RECOVERED*

*HQ-Core-Switch-01 is ONLINE.*

━━━━━━━━━━━━━━━━━━
🖥️ *DEVICE*
`10.10.10.10` → `192.168.10.254`
Type: Switch | Location: Server Room Rack A

📊 CURRENT *STATUS*
• Connectivity: 🟢 Online
• Packet Loss: 0%
• Total Downtime: 02h 50m
• Latency: 1.4 ms
• Probe: 0/10 Failed
• Successful Probes: 10 / 10

🆔 *INCIDENT*
• ID: INC-NET-4
• Since: 04-Nov-2026 13:47:51 UTC
• Recovered At: 04-Nov-2026 16:37:51 UTC
• Notification Sequence: #68
• Status: RESOLVED

━━━━━━━━━━━━━━━━━━
✅ *RECOVERY VERIFIED*

Network connectivity has been successfully restored and verified. All health probes are responding normally.

🤖 *Automated Recovery | Windows AD Remote Administration Control Hub*
```

#### Anatomy of a High Latency Alert & Performance Recovery
When a monitored device remains reachable but experiences elevated latency exceeding the configured threshold, the coordinator dispatches a dedicated performance warning instead of an offline alert:
```text
🟡 *HIGH LATENCY ALERT*

*HQ-Core-Switch-01 High Response Latency Detected*

━━━━━━━━━━━━━━━━━━
🖥️ *DEVICE & ROUTING*
📍 Source Server: SRV1
🎯 Destination Target: HQ-Core-Switch-01 (192.168.10.254)
10.10.10.10 → 192.168.10.254
Type: Switch | Location: Server Room Rack A

📊 CURRENT *STATUS*
• Connectivity: 🟡 Online (Degraded Latency)
• Average Latency: 245.5 ms
• Configured Threshold: 100 ms
• Min / Max Latency: 190.2 ms / 312.0 ms
• Packet Loss: 0%
• Breach Duration: 02m 30s
• Probe Summary: 5/5 Successful (0 Failed)

🆔 *INCIDENT*
• ID: INC-NET-8
• Type: HIGH_LATENCY
• Since: 05-Nov-2026 19:40:00 UTC
• Notification Sequence: #1
• Status: UNRESOLVED

━━━━━━━━━━━━━━━━━━
⚠️ *ATTENTION REQUIRED*

Average response latency (245.5 ms) has exceeded the configured threshold (100 ms). Network traffic congestion, bandwidth saturation, or host resource constraints may be impacting performance.

🤖 *Automated Alert | Windows AD Remote Administration Control Hub*
```

When response latency returns within acceptable limits, the system dispatches a recovery confirmation:
```text
🟢 *HIGH LATENCY RECOVERED*

*HQ-Core-Switch-01 Latency Normalized*

━━━━━━━━━━━━━━━━━━
🖥️ *DEVICE & ROUTING*
📍 Source Server: SRV1
🎯 Destination Target: HQ-Core-Switch-01 (192.168.10.254)
10.10.10.10 → 192.168.10.254
Type: Switch | Location: Server Room Rack A

📊 CURRENT *STATUS*
• Connectivity: 🟢 Online (Normal)
• Current Latency: 2.4 ms (Threshold: 100 ms)
• Packet Loss: 0%
• Total Degradation Duration: 05m 12s
• Probe Summary: 5/5 Successful (0 Failed)

🆔 *INCIDENT*
• ID: INC-NET-8
• Type: HIGH_LATENCY
• Since: 05-Nov-2026 19:40:00 UTC
• Recovered At: 05-Nov-2026 19:45:12 UTC
• Notification Sequence: #2
• Status: RESOLVED

━━━━━━━━━━━━━━━━━━
✅ *RECOVERY VERIFIED*

Network response latency has stabilized within acceptable operational thresholds (2.4 ms <= 100 ms). All health probes are responding normally.

🤖 *Automated Recovery | Windows AD Remote Administration Control Hub*
```


### J. Multiple Ping Sessions & Monitoring Layouts (Ping Studio)

The **Advanced Multi-Target Ping & Diagnostic Studio** (Ping Studio) complements the Network Monitor. The Network Monitor watches devices around the clock in the background; the Ping Studio is for **live, hands-on investigation**: running many ping sessions side by side, at intervals down to 1 ms, while you troubleshoot.

#### Opening the Ping Studio
- Click **📡 Ping** on the **Quick Action** toolbar of the main window. It opens with an empty target box.
- Right-click a computer → **🌐 Network & Connectivity** → **📡 Advanced Multi-Target Ping & Diagnostic Studio...** (a session for that computer starts at once).
- Select several computers → right-click → **🌐 Network & User Messaging (Bulk)** → **📡 Advanced Multi-Target Ping Studio (Bulk)...** (one session per computer).
- If the studio is already open, it comes to the front and only new targets are added.

#### Running Multiple Ping Sessions
1. Type a host name or IP address in **Target Host / IP Address**.
2. Choose the **Protocol**: ICMP Echo, TCP Port, UDP, DNS Lookup, HTTP or HTTPS response time. For TCP or UDP, type a port or pick a preset (RDP 3389, SMB 445, SSH 22, HTTP 80, HTTPS 443, DNS 53, LDAP 389, WinRM 5985 and others).
3. Type the **Interval** in milliseconds (for example `1000`, `250`, or `2s`).
4. Optionally set **Delay**, **Timeout** and **Stop After** (`100` packets, `5m`, `100, 30s`, or blank to run until stopped).
5. Click **➕ Add & Monitor** or press **Enter**. Repeat for more targets, or use **Bulk Add** to paste a list.
- Header buttons: **Start All**, **Stop All**, **Clear** (removes finished and stopped sessions only), **Bulk Add** and **Summary** (live table of every session with CSV export).

#### Monitoring Layouts
- Each session is a widget with latency, jitter, min / average / max, packets sent / received / lost, loss % and a live graph.
- **Graph** / **CMD** switch: graphs in every widget, or Command Prompt style ping lines.
- **Automatic layout**: widgets always fill the window. For example 5 sessions are shown as a row of 3 and a row of 2; 7 sessions as a row of 4 and a row of 3. The layout is recalculated when sessions are added or removed and when the window is resized.
- **Pin**: fixes a widget's position and size; the others arrange around it. **Unpin All** returns everything to the automatic layout.
- **Resize**: drag the grip in a widget's bottom-right corner. Resizing pins the widget automatically.
- When there are more sessions than fit at a readable size, a scroll bar appears instead of shrinking widgets further.

#### Practical Uses Alongside the Network Monitor
- **Confirming an alert**: after an outage alert, add the device in the Ping Studio with a 100 ms interval to watch the moment it comes back.
- **Checking a Real-Time candidate**: before switching a device to Real-Time Monitoring, run an ICMP session at 1000 ms for 10 minutes. If you see lost packets or replies well above a few milliseconds, the device is not a good Real-Time candidate (it may be behind a WAN or VPN link).
- **Port-level checks**: run TCP sessions on the device's monitored ports (for example 445 and 3389) to see which layer fails first.
- **Comparing coordinators' view**: run the studio on different machines to compare what each network location sees.

The complete Ping Studio reference (all controls, calculation rules, limits and benchmarks) is in the **Main Application** tab, section *19. Network Diagnostics & Connectivity Tools → H.2*.

---

### K. Monitoring Reports, Logs & Data Storage

#### Diagnostic Logs in the Settings Window
Open **⚙️ Settings → 📋 Logs & Diagnostics** to read the active coordinator's logs without leaving the application:
- **Monitor Cycle Log (`monitor.log`)**: Live reverse-tail view of background ICMP watchdog cycles, probe durations, breach tracking events, and recovery confirmations.
- **WhatsApp Delivery Log (`notifications.log`)**: Real-time audit trail of outbound alert payloads, recipient phone numbers, gateway API HTTP responses, and error codes.
- **1-Click Actions**: `🔄 Refresh` log display and `📁 Open Logs Folder` directly in Windows File Explorer.
- **Logs Folder vs. Stored History Note**: Deleting plain-text diagnostic logs inside `Logs Folder` (`monitor.log`, `notifications.log`) only clears troubleshooting trace files. To safely remove historical **Resolved** incidents or archived **Notification** delivery records displayed in the UI tables, use the **🗑️ Clear History** button inside the **Outage Incidents** or **Notification History** window.

#### Diagnostic Storage Locations & File Paths
All monitoring inventory, active incident records, notification queues/archives, and troubleshooting trace logs are stored in separate structured locations so clearing plain-text trace files never erases structured incident or notification history:

* **Local Machine Storage**:
  - Root: `%ProgramData%\ADRemoteControl\monitoring\`
  - Configuration Files: `%ProgramData%\ADRemoteControl\monitoring\config\` (`devices.json`, `settings.json`, `whatsapp.json`)
  - Operational State & Incident History: `%ProgramData%\ADRemoteControl\monitoring\state\` (`dashboard.json`, `incidents.json`)
  - Notification Queue & Delivery History: `%ProgramData%\ADRemoteControl\monitoring\notifications\` (`queue.json`, `history.json`)
  - Troubleshooting Trace Logs *(Open Logs Folder)*: `%ProgramData%\ADRemoteControl\monitoring\logs\` (`monitor.log`, `notifications.log`)
* **Remote Server Storage**:
  - Root: `\\<ServerHost>\C$\ProgramData\ADRemoteControl\monitoring\`
  - State & Incident History: `\\<ServerHost>\C$\ProgramData\ADRemoteControl\monitoring\state\`
  - Notification Queue & History: `\\<ServerHost>\C$\ProgramData\ADRemoteControl\monitoring\notifications\`
  - Troubleshooting Trace Logs: `\\<ServerHost>\C$\ProgramData\ADRemoteControl\monitoring\logs\`
* **Important Operational Tip**: Deleting files inside the `logs\` folder only clears plain-text diagnostic logs (`monitor.log`, `notifications.log`). Incident and notification records displayed inside the UI tables are stored in `state\` and `notifications\`—always use **🗑️ Clear History** inside those respective windows for safe cleanup.
* **Windows Event Log**:
  - Outage alerts and service lifecycle events are registered in the Windows **Application Event Log** under Source **`ADRC_NetworkMonitor`**.

---

### L. Settings Reference

Open **⚙️ Settings** from the Network Monitor toolbar. Settings are saved to the active coordinator and copied automatically to every coordinator in the Auto-Sync Pool. The window has six tabs.

#### Tab 1: ⚙️ General
| Setting | What it does | Applies to |
| :--- | :--- | :--- |
| **Enable Network Device Monitoring globally** | Master switch. Unticked pauses all checking (Normal and Real-Time) on every coordinator, for example during planned maintenance. | Both modes |
| **Background Coordinator Windows Service** card | Shows the service state and provides **📥 Install Service** (first-time install on this machine), **▶ Start**, **🔄 Restart** and **⏹ Stop**. Start, Restart and Stop act on every registered coordinator server; each asks for confirmation first (Stop asks twice) and shows a per-server result summary. | Service |
| **Default Monitoring Interval** | Length of the Normal Monitoring cycle: 1, 2, 5 (default), 10 or 15 minutes, or a custom value in seconds. | Normal |
| **Default Ping Timeout** | How long each Normal Monitoring ping waits for a reply: 1, 2 (default), 3 or 5 seconds, or a custom value. | Normal |
| **Max Concurrent Probes** | How many devices are checked at the same time in a Normal cycle (default 50; the engine uses at most 32 at once). | Normal |
| **Data Retention Period** | How long resolved incidents and notification history are kept: 30, 60, 90 (recommended), 180 or 365 days. | Both |
| **Application Timezone** | Time zone used for times shown in alerts (for example *Asia/Riyadh (UTC+3)*). | Alerts |
| **🏷️ Subnet & VLAN Friendly Name Mappings** | Gives subnets or VLAN IDs readable names (for example `192.168.10.0/24` = `Corp-LAN`) used in ping results and monitoring views. | Display |

#### Tab 2: 📡 Ping & Rules
| Setting | What it does | Applies to |
| :--- | :--- | :--- |
| **Default Ping Count (packets)** | Pings sent per Normal cycle (default 10). | Normal |
| **Default Max Packet Drop Limit** | Number of lost pings in one cycle that counts as a packet-loss breach (default 5). | Normal |
| **Loss Evaluation Mode** | **Total Failed Packets in Cycle** (any lost pings count) or **Consecutive Drops Only** (only lost pings in a row count, which filters momentary jitter). | Normal |
| **Consecutive Breach Count (Cycles)** | How many failed checks in a row are needed before an incident (factory default 3). Used for every Normal Monitoring problem, and in Real-Time Monitoring for partial port/service failures, latency and devices that do not use ping. A Real-Time ping outage is confirmed on one check. | Both (see left) |
| **Recovery Confirmation Count (Cycles)** | How many good checks in a row are needed before an incident is resolved (factory default 2). | Both |
| **Enable High-Latency Alerts** and **Maximum Permitted Latency (ms)** | Raises a latency alert when the response time is above the limit (default 100 ms) on the required number of checks. Independent of packet loss. | Both |

#### Tab 3: 🔔 Alert Policies
| Setting | What it does |
| :--- | :--- |
| **Send WhatsApp Recovery Alerts automatically when an incident clears** | Sends one recovery message when an incident is resolved. |
| **Unresolved Incident Reminder Interval (minutes, 0 = disabled)** | Sends a reminder for an incident that is still unresolved and not acknowledged, every this many minutes. **0 switches reminders off.** Reminders are checked whenever the device is checked again, so the actual spacing is rounded up to the device's check interval. |
| **Maximum Notification Reminders (0 = unlimited)** | Stops reminders for an incident after this many. |
| **Default WhatsApp Broadcast Recipients (Global List)** | Phone numbers that receive alerts unless a device has its own recipients. |

#### Tab 4: 📱 WhatsApp API
| Setting | What it does |
| :--- | :--- |
| **Enable WABlend Direct WhatsApp Alerts** | Master switch for WhatsApp sending. When it is off, pending messages are discarded instead of piling up. |
| **API Base URL**, **API Key**, **Sender Number** | Your WABlend gateway details. The key is stored encrypted and cannot be viewed again in this window; enter a new key only to replace it. |
| **👥 WhatsApp Alert Broadcast Recipients** | Add or remove destination numbers in international format (for example `966501234567`). Kept in step with the list on the Alert Policies tab. |
| **🧪 Test Connection** / **✉️ Send Test Message** | Verify the gateway and send a test message to a recipient. |
| **📊 WhatsApp Delivery Statistics** | Last successful send and last error. |

#### Tab 5: 🖥️ Source Agents (Coming Soon)
- Reserved for a future feature that will let Idle Agents on user PCs act as extra checking points. The option is shown but cannot be switched on yet.
- **Today**: to monitor from another site, VLAN or network segment, install a Network Coordinator on a PC or server there. It takes part in consensus automatically.

#### Tab 6: 📋 Logs & Diagnostics
- **Monitor Cycle Log (monitor.log)** and **WhatsApp Delivery Log (notifications.log)**: live view of the active coordinator's logs, with **🔄 Refresh** and **📁 Open Logs Folder**. See [Section K](#k-monitoring-reports-logs--data-storage).

#### Per-Device Settings (🔔 Notification Settings...)
Right-click a device → **🔔 Notification Settings...** → **Custom Monitoring & Notification Thresholds for This Device** to override the global values for that device only:
- **Check Interval** (10 s to 1 hour, or custom), **Ping Timeout**, **Ping Count**, **Max Packet Drop Limit** and **Loss Evaluation Mode**.
- **High Latency Alert** and its limit, **WhatsApp Recovery Alert**, reminder interval and maximum reminders.
- **Custom recipients**: send this device's alerts to a different team (for example the security team for cameras).
- For a Real-Time device, the window shows *Real-Time Monitoring Mode Active (5s Ping Interval)*: the Probe Interval from Add / Edit Device is used instead of the Check Interval.

#### Which Settings Apply to Which Mode

| Setting | Normal Monitoring | Real-Time Monitoring |
| :--- | :---: | :---: |
| Default Monitoring Interval / per-device Check Interval | ✅ | ❌ (uses Probe Interval) |
| Ping Count, Ping Timeout, Max Packet Drop Limit, Loss Evaluation Mode | ✅ | ❌ (1 ping, 1 s timeout, multi-ping verification) |
| Consecutive Breach Count | ✅ all problems | ✅ partial failures, latency, no-ping devices; ❌ ping outage (1 check) |
| Recovery Confirmation Count | ✅ | ✅ |
| High-Latency Alerts | ✅ (average of the cycle) | ✅ (single ping) |
| Reminders, recovery alerts, recipients | ✅ | ✅ |
| Distributed consensus (per device) | ✅ (cycle based) | ✅ (immediate re-check) |

---

### M. Practical Setting Samples & Recommended Configurations

Here are four concrete, real-world configuration templates tailored for common enterprise infrastructure scenarios:

#### 📋 Sample 1: Mission-Critical Core Switch & Perimeter Firewall
*Scenario*: High-priority enterprise backbone hardware where downtime causes severe business interruption. Rapid outage detection and fast reminder cadences are essential.

| Setting Field | Configured Value | Operational Rationale |
| :--- | :--- | :--- |
| **Check Interval** | `60 seconds` | Rapid 1-minute sweep for near-instant outage detection. |
| **Ping Timeout** | `1.000 second` | Fast timeout calibrated for ultra-low latency local fiber switching. |
| **Ping Count** | `10 packets` | High-fidelity statistical sample per probe cycle. |
| **Max Packet Drop Limit** | `0 packets` | Zero tolerance: 0 means any lost ping in the cycle counts as a breach. |
| **Loss Evaluation** | `Total Packets Lost` | Evaluates total loss across the 10-packet burst. |
| **Consecutive Breach Count** | `2 cycles` | Alerts about 1.5–2.5 minutes after a failure (2 failed 60 s cycles), filtering out single blips. |
| **Recovery Confirmation Count** | `2 cycles` | Verifies link stability for 2 consecutive minutes before declaring recovery. |
| **High Latency Alert** | `Enabled (50 ms)` | Early detection of switch buffer exhaustion or broadcast storms. |
| **WhatsApp Recovery Alert** | `Enabled` | Dispatches green recovery alert once normal operations resume. |
| **Outage Reminder Interval** | `15 minutes` | Regular reminders ensure on-call engineers actively maintain triage focus. |
| **Emergency Recipients** | `966501234567, 966509876543` | On-call Network Operations Center (NOC) and Lead Network Engineer. |

---

#### 📋 Sample 2: IP Surveillance Cameras & CCTV Video Recorders (NVR)
*Scenario*: Peripheral physical security cameras and recording appliances across a large campus. Occasional wireless or PoE switch reboots should not trigger false alarms.

| Setting Field | Configured Value | Operational Rationale |
| :--- | :--- | :--- |
| **Check Interval** | `300 seconds (5 min)` | Balanced polling rate that avoids flooding low-bandwidth PoE switches. |
| **Ping Timeout** | `2.500 seconds` | Accommodates occasional wireless bridge latency spikes. |
| **Ping Count** | `10 packets` | Standard 10-packet probe burst. |
| **Max Packet Drop Limit** | `2 packets` | Tolerates a single dropped wireless frame per 10-ping cycle. |
| **Loss Evaluation** | `Consecutive Drops` | Requires consecutive packet loss to prevent alerts on single dropped packets. |
| **Consecutive Breach Count** | `4 cycles` | Requires 20 minutes of sustained failure (`4 x 5m`) before waking security staff. |
| **Recovery Confirmation Count** | `2 cycles` | Confirms 10 minutes of uninterrupted video stream recovery. |
| **High Latency Alert** | `Disabled` | Video feeds handle moderate latency; only hard disconnects require alerts. |
| **WhatsApp Recovery Alert** | `Enabled` | Confirms camera reconnection for physical security auditing. |
| **Outage Reminder Interval** | `0 (Disabled)` | Avoids overnight reminder spam; initial alert and recovery notice are sufficient. |
| **Emergency Recipients** | `966551122334` | Dedicated Campus Physical Security and Facility Management team. |

---

#### 📋 Sample 3: Remote Branch Office Router & SD-WAN Appliance
*Scenario*: Branch office router connected over commercial internet or SD-WAN tunnel with variable carrier latency and peak-hour congestion.

| Setting Field | Configured Value | Operational Rationale |
| :--- | :--- | :--- |
| **Check Interval** | `120 seconds (2 min)` | Fast 2-minute cycle balancing WAN bandwidth and monitoring responsiveness. |
| **Ping Timeout** | `3.000 seconds` | Tolerates WAN propagation delays and carrier route reconvergence. |
| **Ping Count** | `10 packets` | Standard 10-packet evaluation. |
| **Max Packet Drop Limit** | `2 packets` | Allows minor public internet jitter without premature alarms. |
| **Loss Evaluation** | `Total Packets Lost` | Detects degraded tunnel throughput. |
| **Consecutive Breach Count** | `3 cycles` | Confirms outage after 6 minutes of sustained packet loss (`3 x 2m`). |
| **Recovery Confirmation Count** | `3 cycles` | Requires 6 minutes of verified stability to prevent flapping during link bounces. |
| **High Latency Alert** | `Enabled (250 ms)` | Warns when branch internet bandwidth is saturated before full disconnect occurs. |
| **WhatsApp Recovery Alert** | `Enabled` | Provides positive confirmation when WAN tunnel re-establishes. |
| **Outage Reminder Interval** | `30 minutes` | Periodic reminders sent until local branch staff or ISP restores link. |
| **Emergency Recipients** | `966505556677, 966504443322` | Regional Branch IT Support and WAN Service Desk. |

---

#### 📋 Sample 4: Multi-Subnet Distributed Coordinator Pool
*Scenario*: Enterprise with Headquarters (HQ) and a Manufacturing Plant (Plant-01) connected via routed WAN. HQ Coordinator probes HQ infrastructure; Plant Coordinator probes local plant equipment. Both sync to a central console.

| Configuration Element | HQ Coordinator (`SRV-HQ-MON`) | Plant Coordinator (`SRV-PLANT-MON`) |
| :--- | :--- | :--- |
| **Local Coordinator Host** | `.` (Local Machine at HQ) | `.` (Local Machine at Plant) |
| **Assigned Devices** | HQ Core Switch, HQ Firewall, HQ DCs | Plant Edge Switch, PLC Gateways, Plant NVR |
| **Assigned Coordinator Setting** | Select `SRV-HQ-MON` in device editor | Select `SRV-PLANT-MON` in device editor |
| **Sync Coordinator Hosts** | `SRV-PLANT-MON` | `SRV-HQ-MON` |
| **WhatsApp API Key** | Copied to the other coordinator in encrypted form | Stored encrypted on this coordinator |
| **WhatsApp Recipients** | `966501234567` (HQ NOC) | `966559876543` (Plant Operations Team) |
| **Central Desktop View** | Shows aggregated telemetry across both probe servers in one unified dashboard |

#### Recommended Configuration Matrix by Device Role

| Device role | Monitoring methods | Health profile | Alert policy | Monitoring mode | Coordinator assignment | Consensus |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Active Directory Domain Controller** (local) | Ping + Ports + Services | Active Directory Domain Services (+ DNS Server) | Degraded Warning | Real-Time, 5 s | All Coordinators | On (All Down / All Down) |
| **SAN / NAS storage** (local) | Ping + Ports | NAS Storage Appliance / File Server | Degraded Warning | Real-Time, 5 s | Coordinators on the storage network | On (All Down / All Down) |
| **Core switch / local firewall** | Ping (+ management port) | Managed Switch / Firewall Appliance | Degraded Warning | Real-Time, 5 s | All Coordinators | On (All Down / All Down) |
| **Branch router / VPN gateway** | Ping + Ports | Router / Gateway | Degraded Warning | Normal, 60–120 s | Coordinators that route to the branch | On (Any Down / All Down) |
| **Cloud server** | Ports + Services (ping often blocked) | Windows Server Baseline / IIS Web Server | Degraded Warning | Normal, 60 s | All Coordinators | On (All Down / All Down) |
| **Edge switch / access point** | Ping | Managed Switch / Access Point | Status Only | Normal, 60–300 s | Local site coordinator | Off |
| **Printer / camera** | Ping + Ports | Network Printer / IP Camera | Status Only | Normal, 300 s | Local site coordinator | Off |
| **Office workstation** | Ping | Workstation Remote Admin | Status Only | Normal, 300 s | Local site coordinator | Off |

> Real-Time Monitoring appears only for devices on the coordinators' local network. Branch, VPN and cloud devices always use Normal Monitoring.

---

### N. Troubleshooting & Practical Network Failure Scenarios

#### Troubleshooting Guide: 19 Common Scenarios & Step-by-Step Resolutions

| # | Observed Issue | Underlying Cause | Step-by-Step Resolution |
| :-: | :--- | :--- | :--- |
| **1** | Device shows **Offline** in dashboard, but device is powered on and functioning. | Target device or local firewall is dropping incoming ICMP echo requests. | Either permit **Allow ICMP Echo (Ping)** on the target device/firewall, OR open **Edit Device** -> uncheck **ICMP Ping** and monitor open TCP/HTTPS ports or Layer-7 services instead. |
| **2** | Service badge displays **Service: Not Installed** or **Stopped**. | The background Windows Service has not been installed or was stopped. | Open **⚙️ Settings** -> **General** tab and click **📥 Install Service** (if setting up on this machine for the first time) or **▶ Start** to activate 24/7 background monitoring across the server fleet. |
| **3** | Re-installing the coordinator displays a *"file in use"* error. | A previous coordinator process was still shutting down and holding a file lock. | The updated installer handles this automatically by terminating lingering processes. If manual intervention is required, open Windows Task Manager and end any running `ADRC_MonitorCoordinator.exe` process before retrying. |
| **4** | Remote deployment to a domain server fails with *"Access Denied"*. | Connecting user account lacks administrative privileges on the target server. | Ensure you are logged into Windows with Domain Administrator credentials, or verify that your account is a member of the local `Administrators` group on the target server. |
| **5** | WhatsApp test message fails or reports an authorization error. | Invalid API Key or connected phone number disconnected in the gateway. | Log in to the gateway portal (`wablend.com`), verify your WhatsApp device shows **Connected**, regenerate your API key, paste it into Settings, and click **Test Connection**. |
| **6** | Monitored devices disappear after restarting the application. | Coordinator target settings were not saved or point to a different host. | The application automatically restores your active coordinator and provides local inventory caching. Open **Coordinator Server** and ensure your preferred server is marked with **Set as Active**. |
| **7** | Frequent false alerts during peak network utilization hours. | Consecutive breach count is set too low for a busy network. | Open **⚙️ Settings** -> **📡 Ping & Rules** and increase **Consecutive Breach Count** to **3 or 4 cycles** so temporary latency spikes do not trigger alerts. |
| **8** | Remote server deployment cannot find servers on the network. | File & Printer Sharing (SMB Port 445) or RPC (Port 135) is blocked between subnets. | Ensure Windows Firewall on the target server permits **File and Printer Sharing** and **Remote Service Management**. |
| **9** | Device latency values show elevated numbers (yellow/amber badge). | Network bandwidth saturation, Wi-Fi interference, or high switch CPU load. | Right-click the device and run **Ping Now** to inspect packet latency trends. If sustained, inspect switch port bandwidth utilization. |
| **10** | Excessive recurring WhatsApp messages for ongoing outages. | Reminder notification interval or limit is not set appropriately. | Open **⚙️ Settings** -> **🔔 Alert Policies** and set **Maximum Notification Reminders** to **3 to 5** or increase **Reminder Interval** to **60 minutes** (or set to 0 to disable reminders). |
| **11** | Incident Log reports `Service 'RDP' NotFound`, `'SMB' NotFound`, `'HTTPS' NotFound`, or `ZOMBIE_SERVER_DETECTED` even though services work and **Live Layer Preview** is green. | The background Monitor Coordinator service on the reporting probe server is running an older version prior to Layer-7 protocol probing and Alert Policy support. | Click **Update Now** on the Coordinator Update banner (or deploy the latest coordinator service to all registered probe servers) so every coordinator matches the desktop application version. |
| **12** | UDP ports (`67/udp`, `161/udp`, `5060/udp`) show `Open|Filt` / `Open|Filtered`, or an alert reports `161/udp` or `5060/udp: Closed (No Listener)`. | UDP probes send direct UDP datagrams (not ICMP Ping). Firewalls or unauthenticated DHCP ports (`67/udp`) drop silent probes cleanly as healthy `Open|Filtered` without raising alerts. However, when a coordinator checks SNMP (`161/udp`) or SIP (`5060/udp`) on its own host or an unfirewalled server where SNMP/VoIP is not actually running—often because extra roles like **Router**, **Managed Switch**, or **IP Phone** were checked alongside **Server**—the host immediately rejects the UDP packet with `Closed (No Listener)`. | Leave `Open|Filtered` UDP ports as healthy non-outage statuses. If SNMP or VoIP SIP is not used on that server, open **Edit Device** -> uncheck unused roles (**Router / Gateway**, **Managed Switch**, **IP Phone**) or remove `161/udp` / `5060/udp` from **Target Port(s)**, then click **Update Now** so every coordinator runs the latest issue-only notification engine. |
| **13** | A **Real-Time** device over VPN, WAN or the internet raises outages that recover seconds later. | Real-Time Monitoring is designed for the local network; one lost ping plus a short burst over a slow or lossy link is not reliable. | Untick **⚡ Real-Time Monitoring** for that device and use Normal Monitoring (for example 60 s, 10 pings, 2 s timeout, 2–3 consecutive cycles). |
| **14** | With consensus **All Coordinators Down**, a real outage is not alerted. | One assigned coordinator can still reach the device (for example over a different route), so the coordinators do not agree. | Open the device's row and check the **Probe Server / Coordinator** column or switch the **🌐 All Coordinators** selector to each coordinator. Remove coordinators that are not on the device's path from **Probe Server**, or use **Notification Threshold = Any Coordinator Down**. |
| **15** | A Normal Monitoring device monitored by several coordinators takes up to about 3 minutes to alert. | Each coordinator trusts another coordinator's recent *Online* result until that coordinator has run its own failed check; schedules are not aligned. | Expected behaviour (see Scenario 3). For faster alerts on a local device, use Real-Time Monitoring, or assign only the coordinators that need to monitor it. |
| **16** | A device shows **🟡 Degraded** because a service stopped, but no incident or WhatsApp alert is raised. | The device was saved with every layer green (verified baseline). For such devices, a service that reports *Stopped* or a port that stops answering without refusing the connection is shown as Degraded but does not open a new incident. A port that actively refuses connections does. The **Status Only** policy also never raises partial-failure incidents. | Check the device's **Alert Policy**. Where an alert for a stopped service is required, monitor that service's port as well, so a refused connection raises the incident. |
| **17** | The alert says *"fewer than 5 of 100 burst packets answered"* for a Normal Monitoring device. | The alert template uses the same wording for both modes. | Informational only. Normal Monitoring devices are confirmed with the configured ping count and 2 confirmation pings (see Section E). |
| **18** | Reminders are not sent although an interval is set, or are sent less often than set. | Reminders are checked each time the device is checked again; an **Acknowledged** incident never sends reminders; **0** disables them; the maximum may have been reached. | Check **Settings → Alert Policies** and the incident status. With a 5-minute Normal cycle, a 1-minute reminder interval is sent about every 5 minutes. |
| **19** | Two coordinators appear for one computer (for example `BRANCH-PC` and `BRANCH`). | The computer is known by its DNS alias and its own name. | It is the same coordinator and is counted once in consensus. Use one name in **Probe Server** assignments. |

#### Recommended Real-World Deployment Scenarios

##### Scenario 1: Small Office / Branch Location
- **Environment**: Single local subnet (`192.168.1.0/24`), 25 total devices (1 Internet Router, 2 Switches, 3 Access Points, 1 NAS, 2 Printers, 16 Workstations).
- **Recommended Setup**:
  - Coordinator Server: Installed directly on the primary IT Administrator's workstation (Local PC setup).
  - Monitoring Interval: 5 minutes (300 seconds), 3 consecutive breach cycles.
  - Alert Recipients: Primary IT support mobile number.

##### Scenario 2: Medium Enterprise with Multiple VLANs
- **Environment**: Corporate headquarters with 6 subnets / VLANs (Management, Servers, Corporate Wi-Fi, IP Telephony, CCTV Cameras, Guest), 180 total monitored devices.
- **Recommended Setup**:
  - Coordinator Server: Installed on an always-on Windows Server Virtual Machine (e.g. `SRV-MGMT-01`) located in the Core Server VLAN with inter-VLAN routing permitted for ICMP traffic.
  - Monitoring Interval: 3 minutes (180 seconds), 3 consecutive breach cycles.
  - Alert Recipients: Network Operations on-call mobile group.

##### Scenario 3: Large Campus / Hospital Facility
- **Environment**: High-density campus with 400+ critical devices across multiple buildings, clinical data centers, and life-safety systems.
- **Recommended Setup**:
  - Coordinator Server: Dual Coordinator deployment linked via the **Auto-Sync Pool** (Primary Coordinator in Main Data Center, Secondary Coordinator in Disaster Recovery Center).
  - Departmental Alert Routing: CCTV cameras routed to Security Team; medical imaging servers routed to Biomedical IT; core switches routed to Senior Network Engineers.

##### Scenario 4: Multi-Branch Organization with Remote Sites
- **Environment**: Central headquarters with 8 remote regional branches connected via IPsec VPN or SD-WAN.
- **Recommended Setup**:
  - Coordinator Placement: 1 Primary Central Coordinator at Headquarters monitoring regional gateway routers, plus 1 Local Coordinator deployed to a branch server at each major site.
  - All branch coordinators registered in the **Auto-Sync Pool** for unified inventory management and consolidated WhatsApp alerting.

### O. Complete First-Time Setup Tutorial

Follow this 10-step tutorial to configure a complete, working monitoring environment in under five minutes:

1. **Launch Network Monitor**:
   - Open the application and click **📡 Network Monitor** on the top navigation toolbar (or press **Ctrl+Shift+M**).
2. **Install the Coordinator Service**:
   - Click **⚙️ Settings** → **⚙️ General** → **📥 Install Service**, click **Yes**, and allow the automated installer to register and start the background Windows Service.
3. **Confirm Service Running Status**:
   - Verify that the service indicator badge in the top-left header displays a green pill: **`● Service: Running`**.
4. **Configure WhatsApp Gateway Credentials**:
   - Click **⚙️ Settings** and select the **WhatsApp API** tab.
   - Enter your Base URL (`https://wablend.com`), paste your **API Key**, and enter your connected **Sender Number**.
5. **Set Emergency Recipient Numbers**:
   - In the **Default Emergency Recipients** box, enter your mobile phone number in international format (e.g. `+966501234567`).
6. **Verify Live Message Delivery**:
   - Click **⚡ Test Connection** (verify authorization succeeds), then click **✉️ Send Test Message**.
   - Check your mobile phone to confirm receipt of the test notification.
   - Click **Save Settings**.
7. **Add Your First Core Network Device**:
   - Click **➕ Add Device** on the action toolbar.
   - Enter a Device Name (e.g. `Main-Default-Gateway`), enter its IPv4 address (e.g. `192.168.1.1`), select Type **Router**, and set Location to `Core Rack`.
   - Click **Save Device**.
8. **Run an Instant Verification Ping**:
   - Right-click your newly added device and select **📡 Ping Now (Instant Verification)**.
   - Confirm that the ping returns `REACHABLE (ONLINE)` with `0% Loss` and live latency metrics.
9. **Verify Alerting Sensitivity**:
   - Open **⚙️ Settings** -> **📡 Ping & Rules** and ensure **Consecutive Breach Count** is set to **3 cycles** to guarantee false-positive protection.
10. **Confirm Autonomous 24/7 Surveillance**:
    - Close the Network Monitor window and minimize the main application.
    - The autonomous `ADRC_NetworkMonitor` background service continues monitoring your devices 24/7, ready to dispatch instant WhatsApp alerts whenever an outage occurs.


---

*Network Monitor User Guide — Windows AD Remote Administration Control Center. For every other feature, open the **Main Application** tab of the User Guide.*
