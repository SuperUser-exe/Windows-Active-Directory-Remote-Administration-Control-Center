@echo off
setlocal
cd /d "%~dp0"

:: 1. Auto-unblock application and dependencies (strips Windows Mark-of-the-Web Zone.Identifier)
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-ChildItem -Path '%~dp0' -Recurse -Include '*.exe','*.dll','*.ps1','*.bat' | ForEach-Object { Unblock-File -LiteralPath $_.FullName -ErrorAction SilentlyContinue }" >nul 2>&1

:: 2. Launch the application
for %%f in ("%~dp0Windows AD*Control*.exe") do (
    start "" "%%~ff"
    exit /b 0
)

echo [ERROR] Windows AD Remote Admin Control Center executable not found.
pause