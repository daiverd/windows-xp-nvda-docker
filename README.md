# NVDA Windows XP Docker

Automated Windows XP VM with NVDA screen reader and remote access pre-configured.

Based on dockur/windows: Windows inside a Docker container [https://github.com/dockur/windows](https://github.com/dockur/windows)

## Requirements

- Docker with KVM support
- `/dev/kvm` and `/dev/net/tun` devices available

## Setup

1. **Prepare NVDA installation files:**
   ```bash
   make oem-setup-interactive
   ```
   Enter your NVDA Remote key and Windows version when prompted.

2. **Start Windows VM:**
   ```bash
   docker compose up windows
   ```

3. **Access VM:**
   - Web: http://localhost:8006
   - RDP: localhost:3389

4. **Install NVDA:**
   After XP installs itself, about 45 minutes, NVDA will install automatically and connect to nvdaremote.com with the key you specified in setup

## What It Does

- Downloads appropriate NVDA version based on Windows version:
  - Windows XP/Vista: NVDA 2017.3
  - Windows 7: NVDA 2023.3
  - Other versions: NVDA 2024.4
- Downloads and installs NVDA Remote addon 2.2
- Configures auto-connection to NVDAREMOTE.COM
- Sets up NVDA to start with Windows
- Maps network drive Z: to host data directory

## Commands

```bash
make oem-setup-interactive  # Setup with key and version prompt
make oem-setup             # Setup with REMOTE_KEY and VERSION env var
make clean                 # Remove files and containers
```

## Files Created

- `oem/nvda.exe` - NVDA installer
- `oem/install.bat` - Windows installation script
- `oem/remote.ini` - Remote access configuration
- `oem/remote/` - NVDA Remote addon files

## Supported Windows Versions

- `xp` - Windows XP (default)
- `vista` - Windows Vista
- `7` - Windows 7
- `7u` - Windows 7 Ultimate
- Other versions supported by dockur/windows

## Notes

- Uses legacy Windows versions (unsupported OS - for testing only)
- NVDA Remote key is required and must be unique
- VM data persists in `./windows` directory
- Host `./data` directory mounted as network drive Z: in Windows