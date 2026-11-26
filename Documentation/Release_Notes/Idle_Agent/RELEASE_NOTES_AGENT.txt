# ADRC Inactivity & Idle Monitor Agent — Release Notes & Changelog

## Version: 1.2.0 – Multi-Session Terminal, Security Audit & Thread-Safe Telemetry
**Release Date:** 26 November 2026

> **ADRC_IdleAgent v1.2.0** introduces multi-session physical console and RDP tracking, Failed Logon (`Security Event ID 4625`) sensing, immediate startup state flushing, lock-free atomic persistence, and 64-bit uptime rollover protection.

#### New Features
- **Real-Time Activity & High-Precision Lock State Sensing**:
  - **What Was Updated**: Added high-precision interactive Windows session monitoring for live mouse and keyboard inactivity alongside accurate workstation lock-screen detection.
  - **How It Works**: Runs an invisible per-session interactive helper under the Windows GUI subsystem that queries native session input timers without keystroke logging or screen capture, while the background system service evaluates active desktop and lock-screen transitions every 3 seconds.
  - **Benefits**: Eliminates false "Locked" status reports on active desktops and gives IT teams true real-time active, idle, and locked durations across managed workstations.
  - **Practical Use Cases**: Identifying genuinely unattended workstations for off-hours maintenance, safe automated daily IT inventory refreshes, or license reclamation.
  - **Important Details**: Zero keystroke or screen content is ever captured; operates silently with zero desktop popups and no Task Manager Startup Apps entries.
- **Multi-Session Terminal & Remote Desktop (RDP) Tracking**:
  - **What Was Updated**: Added simultaneous enumeration and tracking across physical console sessions, active Remote Desktop (RDP) sessions, and disconnected RDP sessions with remote client endpoint resolution.
  - **How It Works**: Dynamically inspects all terminal sessions on Windows workstations and multi-user servers, isolates per-session interactive helpers, captures client hostnames, IP addresses, and protocol types, and prioritizes actively engaged console operators during Fast User Switching.
  - **Benefits**: Gives administrators accurate visibility into concurrent local and RDP users on shared computers and terminal servers.
  - **Practical Use Cases**: Checking whether an employee is working locally or over VPN/RDP before rebooting a workstation or initiating screen shadowing.
  - **Important Details**: Supports Windows 10, Windows 11, and Windows Server 2012 R2–2025; requires administrative deployment of the companion Windows service (`ADRC_IdleMonitor`).
- **Security Audit Log Sensing (Failed Logon Detection)**:
  - **What Was Updated**: Integrated automated sensing of failed remote logon events (`Security Event ID 4625`) alongside session telemetry.
  - **How It Works**: Periodically sweeps recent Security audit log entries under a re-entrancy guard to surface repeated authentication failures and client source details.
  - **Benefits**: Helps administrators spot potential brute-force attempts or mistyped credential lockouts while monitoring session health.
  - **Practical Use Cases**: Reviewing authentication anomalies on exposed RDP jump hosts or shared terminal servers.
  - **Important Details**: Requires standard Windows Security event auditing to be active on the endpoint.
- **Immediate Service Startup Version & Session Flush**:
  - **What Was Updated**: Added immediate session evaluation and telemetry publishing upon service start.
  - **How It Works**: As soon as the `ADRC_IdleMonitor` service starts or restarts after an upgrade, it immediately scans active console and RDP sessions and writes fresh versioned telemetry rather than waiting for the first scheduled cycle.
  - **Benefits**: Ensures fleet presence and updated agent version numbers appear immediately in the main console after reboots or remote upgrades.
  - **Practical Use Cases**: Mass fleet upgrades where administrators want instant confirmation that endpoints are active and reporting the new version.
  - **Important Details**: Preserves recent interactive worker heartbeats only when their reported version matches the currently running agent binary.

#### Improvements
- **Lock-Free Atomic State Persistence**:
  - **What Was Updated**: Replaced truncating file overwrites with unique temporary writes and native atomic file replacement backed by short retry backoffs and dedicated error-log locking.
  - **How It Works**: Telemetry state (`idle.json`) and structured error logs are written completely to a unique temporary file first and swapped atomically, preventing readers from seeing half-written or 0-byte files.
  - **Benefits**: Eliminates sharing violations and file corruption when the main console queries endpoints during active writes.
  - **Important Details**: Applies across both per-session telemetry files and service health state files.
- **Lock-Free Timer Re-Entrancy Guards & Deterministic Bounded Probes**:
  - **What Was Updated**: Protected background monitor, probe, and event-log sweep timers with atomic re-entrancy guards, and switched probe telemetry to deterministic per-target files (`source_{host}_{targetIp}.json`) with strict IPv4/IPv6 and host validation.
  - **How It Works**: Prevents overlapping timer callbacks under heavy endpoint CPU load and overwrites deterministic per-target files instead of generating random temporary filenames.
  - **Benefits**: Eliminates unbounded temporary file accumulation, reduces disk I/O fragmentation, and stabilizes CPU usage on busy endpoints.
- **Full RDP Transition Awareness & Parallel Upgrade Readiness**:
  - **What Was Updated**: Improved handling of remote connect/disconnect session transitions and pre-upgrade stale telemetry cleanup.
  - **How It Works**: Processes Windows session change events cleanly and removes outdated transient state files during parallel remote upgrades.
  - **Benefits**: Accelerates fleet-wide updates across hundreds of endpoints without stale version echoes.
- **Extended Uptime & Idle Counter Rollover Protection**:
  - **What Was Updated**: Added rollover and integer-underflow guards to tick-count and idle-duration calculations.
  - **How It Works**: Uses 64-bit safe elapsed-time arithmetic so systems running continuously for weeks or months never wrap around or display negative idle times.
  - **Benefits**: Guarantees accurate idle and uptime metrics on long-running servers and always-on workstations.

#### Fixes
- **RDP Disconnect Status Drift**: Resolved an issue where disconnecting an active Remote Desktop session could transiently report a logged-off state instead of accurately reporting the disconnected RDP session.
- **False Locked-Workstation Reports on Active Sessions**: Resolved an issue where active physical or RDP desktops could remain flagged as locked after resume or fast user switching.
- **Structured Error Log Concurrency**: Fixed a locking mismatch on the error log writer (`agent_errors.jsonl`) that could allow concurrent writes during simultaneous exception captures.

---

## Version: 1.1.2 – Telemetry Isolation Release
**Release Date:** 05 October 2026

#### Improvements
- **Decoupled Network Telemetry** – Removed automatic background ping sweeps during agent installation, update, and uninstallation workflows.
- **Fleet Version Verification** – Incremented binary release for testing update status tracking and version detection.

---

## Version: 1.1.1 – Precision Lock State & Headless Deployment
**Release Date:** 28 September 2026

#### New Features
- **Interactive Session Sensor** – Captures keyboard and mouse inactivity without user interface disruption.

---

## Version: 1.0.0 – Initial Companion Release
**Release Date:** 21 September 2026

#### New Features
- **Agentless Companion Deployment** – Initial release of background endpoint activity and idle time tracking.
