# NVDA Windows XP Docker

Automated Windows XP VM with NVDA screen reader and remote access pre-configured.

Based on dockur/windows: Windows inside a Docker container [https://github.com/dockur/windows](https://github.com/dockur/windows)

## Requirements

- Docker with KVM support
- `/dev/kvm` and `/dev/net/tun` devices available

## Setup

1. **Prepare NVDA installation files:**
   ```bash
   make
   ```
   Enter your NVDA Remote key when prompted.

2. **Start Windows XP VM:**
   ```bash
   docker compose up windows
   ```

3. **Access VM:**
   - Web: http://localhost:8006
   - RDP: localhost:3389

4. **Install NVDA:**
   After XP installs itself, about 45 minutes, NVDA will install automatically and connect to nvdaremote.com with the key you specified in setup

## What It Does

- Downloads NVDA 2017.3 and Remote addon 2.2
- Configures auto-connection to NVDAREMOTE.COM
- Sets up NVDA to start with Windows

## Commands

```bash
make oem-setup-interactive  # Setup with key prompt
make oem-setup             # Setup with REMOTE_KEY env var
make clean                 # Remove files and containers
```

## Files Created

- `oem/nvda.exe` - NVDA installer
- `oem/install.bat` - Windows installation script
- `oem/remote.ini` - Remote access configuration
- `oem/remote/` - NVDA Remote addon files

## Notes

- Uses Windows XP (unsupported OS - for testing only)
- NVDA Remote key is required and must be unique
- VM data persists in `windows/` directory