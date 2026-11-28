# 📡 Network Monitor Coordinator — Release Notes & Changelog
**Module:** Network Monitor (network device monitoring & WhatsApp alerting) · **Background service:** Network Coordinator (`ADRC_MonitorCoordinator`)

The **Network Monitor** is the monitoring module inside the suite; the **Network Coordinator** is the lightweight background Windows Service that performs 24/7 probing, peer consensus, and alerting.

---

## Version: 1.0.1 – Peer Share Synchronization & Maintenance Reliability Update
**Release Date:** 27 November 2026

> **ADRC_MonitorCoordinator v1.0.1** eliminates transient peer-share permission gaps during scheduled security maintenance, hardens remote peer incident synchronization retries, and fixes build-time UTF-8 character preservation.

#### Fixes & Reliability Improvements
- **Zero-Gap Peer Monitoring Permissions During Maintenance**: Fixed scheduled 30-minute security maintenance so peer monitoring write permissions on shared state storage are never briefly reset and re-applied, preventing transient *Access Denied* errors when peer coordinators synchronize outage records.
- **Resilient Remote Peer Incident Synchronization**: Hardened remote file replacement and retry handling across SMB peer shares so transient antivirus scans or concurrent peer updates complete reliably without falling back to direct writes or generating automated error reports.
- **Clean Multi-Coordinator Message Formatting**: Fixed an encoding issue in the version synchronization pipeline so status emojis and punctuation in WhatsApp alert templates remain crisp across coordinator version updates.

---

## Version: 1.0.0 – Initial Public Release
**Release Date:** 26 November 2026

Welcome to the initial public release of **Network Monitor Coordinator (v1.0.0)** — an autonomous, 100% agentless 24/7 network monitoring and WhatsApp alerting engine built to run smoothly on normal office workstations or dedicated servers **without requiring Domain Administrator privileges**.

#### New Features & Core Capabilities
- **Combined 3-Layer Agentless Monitoring Engine**:
  - **What Was Updated**: Introduced simultaneous, independent 3-layer health verification across **ICMP Ping**, **TCP/UDP Ports** (including UDP diagnostics for `53/udp`, `67/udp`, `161/udp`, and `5060/udp`), and **Windows Services / Layer-7 Application Protocols** (`HTTP`, `HTTPS`, `SSH`, `RDP`, `SMB`, `RTSP`, `SNMP`, `SIP`, `DNS`, `MySQL`, `MSSQL`, and `SMTP`).
  - **How It Works**: Evaluates each enabled layer independently and applies configurable failure policies (Status-Only, Degraded Warning, or Critical Escalation). UDP probing sends protocol-aware datagrams and clearly distinguishes `Open|Filtered` responses from `Closed (No Listener)` port resets.
  - **Benefits**: Devices behind ping-blocking firewalls stay accurately marked Online as long as their configured service ports respond, while partial service crashes are surfaced immediately without mimicking total host outages.
  - **Practical Use Cases**: Monitoring firewalled DMZ web servers, SIP IP-PBXs, SNMP switches, and Windows file/print servers simultaneously.
  - **Important Details**: Supports multi-homed monitoring hosts by automatically resolving the exact outbound local adapter IP routing to each target device.
- **12 Automatic Hardware Device Presets & Multi-Role Profiles**:
  - **What Was Updated**: Added built-in monitoring templates for 12 device categories: **Server**, **Computer**, **Router**, **Switch**, **Firewall**, **Camera**, **Printer**, **Access Point**, **NAS**, **IP Phone**, **Scanner**, and **Other**.
  - **How It Works**: Selecting a device type automatically enables optimal monitoring layers, default ports, and protocol/service profiles, while Windows Servers support multi-role checkbox aggregation (AD DS, DNS, DHCP, Print, File, IIS, Hyper-V, WinRM, WMI) with two-way synchronization.
  - **Benefits**: Eliminates manual port memorization when onboarding dozens of diverse network appliances and servers.
  - **Practical Use Cases**: Rapidly provisioning a branch office's switches, CCTV cameras, printers, and NAS devices in minutes.
- **Normal Monitoring & Real-Time Monitoring Engines**:
  - **What Was Updated**: Implemented two dedicated monitoring schedules tailored to WAN/routine hosts versus mission-critical local LAN hosts.
  - **How It Works**: **Normal Monitoring** runs fixed-interval parallel cycles (default 60–300 s) collecting min/avg/max latency, packet loss, and threshold breaches, starting each cycle accurately on interval boundaries. **Real-Time Monitoring** probes local hosts every 3–30 s (5 s recommended); when a ping goes unanswered, it immediately launches a **100-packet fast verification burst** (`<5` replies confirms outage on the same check), and confirms failed ports with **10 simultaneous attempts** and failed services with **3 simultaneous attempts**—skipping redundant retries when ping and all ports are dead to confirm offline hosts in ~1.5–2.5 seconds.
  - **Benefits**: Detects real LAN outages within seconds while ensuring single dropped packets or WAN jitter never trigger false alarms.
  - **Important Details**: Real-Time Monitoring is designed for local LAN segments; WAN, VPN, and internet endpoints should use Normal Monitoring with appropriate thresholds.
- **Distributed Multi-Coordinator Consensus & Fleet Auto-Sync**:
  - **What Was Updated**: Enabled multiple workstations or servers across VLANs, departments, or branches to collaborate as a synchronized coordinator fleet with configurable per-device **Incident Threshold** and **Notification Threshold** quorum rules (*All Coordinators Down* vs. *Any Coordinator Down*).
  - **How It Works**: Coordinators synchronize device rules and probe telemetry through secured peer storage (`ADRC_Monitoring$`). When consensus is enabled and one coordinator confirms a Real-Time outage, peer coordinators are triggered to re-check immediately so consensus completes within 2–3 seconds. Incidents resolve symmetrically only once all active coordinators see the device online again, and stale probe files from stopped coordinators are automatically invalidated.
  - **Benefits**: Eliminates false-positive WhatsApp outage alerts caused by localized ISP blips, single-subnet cable faults, or inter-VLAN firewall drops.
  - **Practical Use Cases**: Placing one coordinator in HQ Server Room and another in a remote branch or secondary VLAN to require fleet-wide agreement before paging on-call engineers.
  - **Important Details**: Coordinators known by multiple DNS aliases or NetBIOS names are automatically deduplicated to a single identity. Note that **Sources & Agents** in Settings is reserved for future expansion and marked as *Coming Soon*.
- **Direct WhatsApp Alerting, Incident Lifecycle & Fleet Audit Transparency**:
  - **What Was Updated**: Integrated outbound WhatsApp outage, High Latency, Packet Loss, Reminder, Acknowledgement, and Recovery ("Back Online") notifications with persistent retry queueing.
  - **How It Works**: Dispatches formatted alerts the moment an incident opens (listing exact `FAILED PROTOCOL LAYERS` and a **Coordinator Fleet Audit** consensus header for multi-coordinator devices), enforces duplicate-free single reminders up to the configured **Maximum Reminder Limit** (0 disables reminders), synchronizes incident Acknowledge/Resolve actions across all peers, and stores messaging credentials encrypted via Windows Data Protection (DPAPI) and AES-256.
  - **Benefits**: Guarantees on-call teams receive one clean, actionable mobile alert per outage rather than duplicate message storms.
  - **Important Details**: Requires outbound HTTPS access to the configured WhatsApp gateway from the dispatching coordinator host.
- **Automated Security Hardening & Hidden Monitoring Share (`ADRC_Monitoring$`)**:
  - **What Was Updated**: Built automatic least-privilege filesystem and SMB share hardening directly into the coordinator service lifecycle.
  - **How It Works**: Upon startup and hourly maintenance cycles, the coordinator configures a hidden administrative share (`ADRC_Monitoring$`), purges any legacy visible `ADRC_Monitoring` share, locks down configuration, log, and notification directories (`%ProgramData%\ADRemoteControl\coordinator\`) with protected NTFS permissions restricting standard users to Read & Execute (`RX`) on binaries only, and quotes the service `ImagePath`.
  - **Benefits**: Prevents non-administrative domain users from browsing monitoring shares or reading device configurations, logs, or alert history—requiring zero manual permission setup.

#### Pre-Release Reliability & Security Hardening Included in v1.0.0
- **Consensus Toggle & Independent Alerting**: Resolved an issue where disabling *Enable Distributed Multi-Coordinator Consensus* was not persisted or still waited for peer coordinators; unchecking consensus now saves cleanly and allows independent alerting.
- **Duplicate Reminders & Recovery Messages**: Eliminated duplicate reminder and "Back Online" alerts across peer coordinators using monotonic incident merging and single-owner dispatch.
- **Stopped Application Service Detection**: Fixed service checks so stopped remote desktop, SMB, web, or WinRM services report accurately as *Stopped* rather than *Unverified*.
- **Queued WhatsApp Restart Recovery & Editing During Outages**: Automatically re-queues outbound messages left in `SENDING` state after a service restart, and preserves active offline status and incidents when editing device settings during an outage.
- **Deadlock & Interval Accuracy**: Eliminated 4 KB subprocess pipe deadlocks, bounded transient probe retention to 24 hours, debounced shared disk writes, and corrected Normal-mode cycle interval drift.
