# ADRC High-Speed Remote Disk Usage Analyzer & Cleanup Assistant — Release Notes & Changelog

## Version: 1.0.0 – Initial Public Release
**Release Date:** 26 November 2026

Welcome to the initial public release of the **Remote Disk Usage Analyzer & Cleanup Companion (`ADRC_DiskScanner v1.0.0`)** — a lightweight, high-speed storage analysis and safe cleanup companion engine for Windows NTFS volumes, subfolders, and shared directories.

#### New Features & Core Capabilities
- **Hybrid Dual-Path Scanning Engine (`$MFT` + Parallel Win32)**:
  - **What Was Updated**: Built a dual-path scanning engine combining direct sequential NTFS Master File Table (`$MFT`) volume parsing with parallel Win32 directory enumeration.
  - **How It Works**: When scanning full NTFS drives with administrative volume access, the scanner reads `$MFT` extents sequentially at near-hardware speed; when targeting specific subfolders, network shares, or non-NTFS volumes, it automatically falls back to multi-threaded Win32 enumeration. Scans stream compressed results progressively to the main interface every 250 ms under re-entrancy protection.
  - **Benefits**: Maps hundreds of thousands of files in seconds without saturating target endpoint CPU or freezing the administrator console.
  - **Practical Use Cases**: Rapidly auditing full `C:` or data drives on remote servers and workstations during low-disk-space incidents.
  - **Important Details**: Runs with below-normal process priority (`--throttle`) to preserve interactive user responsiveness on the target machine.
- **Extended 32K Path Support & Reparse Point Loop Protection**:
  - **What Was Updated**: Added native support for extended Win32 paths up to 32,767 characters and automatic junction/symlink loop defense.
  - **How It Works**: Normalizes long paths using extended-length prefixes and automatically skips directory reparse points, junctions, and symbolic links during traversal.
  - **Benefits**: Prevents infinite circular scan loops (such as Windows compatibility junctions) and avoids path-too-long crashes on deeply nested developer or backup folders.
- **Interactive Visual Storage, Timeline & Live Directory Navigation**:
  - **What Was Updated**: Powers squarified 3D cushion treemaps, **Top 1,000 Largest Files** leaderboards, **Recent Files Timeline** (Today, 7d, 30d, 90d), **Multi-Category** breakdowns (Media, Virtual Disks, Archives, Documents, Executables, Databases, Logs, Temp), **7-Bracket Stale File Age** distribution (`<24h` up to `>3y`), recursive nested folder properties, and **live non-blocking directory browsing while scans run**.
  - **How It Works**: Uses thread-safe collection snapshotting and lazy TreeView loading so operators can expand folders, click breadcrumbs, sort columns, and inspect recursive file/subfolder totals in real time while discovery continues in the background.
  - **Benefits**: Lets technicians locate the biggest space consumers immediately without waiting for the entire disk scan to finish.
- **Cryptographic Duplicate File Detection**:
  - **What Was Updated**: Added a multi-stage duplicate file analyzer verifying true byte-identical duplicates.
  - **How It Works**: Groups candidate files by exact byte size and extension first, computes fast 4 KB head/tail fingerprints to eliminate non-matches with minimal disk I/O, and performs on-demand SHA-256 hashing to verify 100% identical files and calculate reclaimable savings.
  - **Benefits**: Pinpoints duplicated ISOs, installers, and media archives without wasting network or disk bandwidth reading every file in full.
- **14-Location Safe Cleanup Engine & Reversible 7-Day Quarantine**:
  - **What Was Updated**: Implemented rule-based cleanup across **14 operating system and user-profile cache locations** paired with dry-run preview staging and **7-day reversible soft quarantine**.
  - **How It Works**: Scans Windows Prefetch, System Temp, per-user `%Temp%`, Recent Items, Windows Error Reporting (`WER`), Thumbnail Cache, DirectX/GPU Shader Cache, Delivery Optimization Cache, Cryptnet/Font Caches, Setup & Servicing Logs, Edge/Chrome/Firefox Browser Caches, Crash Dumps (`MEMORY.DMP` / minidumps), Windows Update Download Cache, and Recycle Bin across all user profiles. Strictly preserves parent folder roots and NTFS ACLs, catches sharing violations to skip locked in-use files gracefully, enforces path canonicalization against an immutable blocklist (blocking root drives, personal `Documents`/`Downloads`/`Desktop` folders, and OS core files like `pagefile.sys` and `$MFT`), and logs all actions locally.
  - **Benefits**: Safely reclaims tens of gigabytes across workstations and servers while preserving a 1-click 7-day rollback safety net.
  - **Important Details**: Quarantine and permanent cleanup run asynchronously on background threads so the UI stays responsive throughout large purges.
- **Decoupled Multi-Window Architecture & Graceful Scan Cancellation**:
  - **What Was Updated**: Operates inside independent modeless windows (`ShowInTaskbar`) with non-blocking scan cancellation.
  - **How It Works**: Each target computer or drive opens in its own independent window so multiple scans can run concurrently without blocking the main dashboard. Stopping an active scan displays a non-blocking progress banner, suppresses heavy treemap redraws during teardown, and immediately preserves all already-discovered files and folders for inspection.
  - **Benefits**: Eliminates `[Not Responding]` hangs on large volumes and lets engineers work across multiple endpoints simultaneously.
