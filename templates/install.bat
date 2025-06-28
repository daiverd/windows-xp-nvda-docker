@echo off
if not exist "%APPDATA%\nvda\addons\remote\" mkdir "%APPDATA%\nvda\addons\remote"
xcopy "c:\oem\remote\*" "%APPDATA%\nvda\addons\remote\" /E /I /H /Y                                                          
copy "c:\oem\remote.ini" "%APPDATA%\nvda\"
c:\oem\nvda.exe --install                                                                                          
net use Z: \\host.lan\Data /persistent:yes

setlocal enabledelayedexpansion
REM Check Windows version
ver | findstr "5.1" >nul
if %errorlevel% equ 0 (
    echo This is Windows XP
    set "nvda_path=%ProgramFiles%\NVDA\nvda.exe"
    set "startup_path=%USERPROFILE%\Start Menu\Programs\Startup\StartNVDA.bat"
) else (
    REM Vista and later - check if Program Files (x86) exists
    if exist "%ProgramFiles(x86)%" (
        set "nvda_path=%ProgramFiles(x86)%\NVDA\nvda.exe"
    ) else (
        set "nvda_path=%ProgramFiles%\NVDA\nvda.exe"
    )
    set "startup_path=%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\start-nvda.bat"
)

echo @echo off > "!startup_path!"
echo "!nvda_path!" >> "!startup_path!"