@echo off
setlocal enabledelayedexpansion
for %%f in ("%~dp0Windows AD*Control*.exe") do (
    start "" "%%~ff"
    exit /b 0
)
