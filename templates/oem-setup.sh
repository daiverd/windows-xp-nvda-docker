#!/bin/sh
export NVDA2017="https://download.nvaccess.org/releases/2017.3/nvda_2017.3.exe?donation=0"
export NVDA2023="https://download.nvaccess.org/releases/2023.3/nvda_2023.3.exe?donation=0"
export NVDA2024="https://download.nvaccess.org/releases/2024.4/nvda_2024.4.exe?donation=0"

if [ -z "$VERSION" ]; then
    echo "ERROR: VERSION not set."
    exit 1
fi

case "$VERSION" in
    xp|vista)
        NVDA_URL="$NVDA2017"
        ;;
    7|7u)
        NVDA_URL="$NVDA2023"
        ;;
    *)
        NVDA_URL="$NVDA2024"
        ;;
esac

echo "Setting up OEM files for $VERSION..."
apk add --no-cache unzip dos2unix > /dev/null 2>&1
# Download NVDA if not exists
if [ ! -f /oem/nvda.exe ]; then
echo "Downloading NVDA: $NVDA_URL..."
curl -s -o /oem/nvda.exe "$NVDA_URL"
fi

# Download and process NVDA Remote addon if not exists
if [ ! -d /oem/remote ]; then
echo 'Downloading NVDA Remote addon...'
curl -s -o /oem/remote-2.2.nvda-addon 'https://nvdaremote.com/remote-2.2.nvda-addon'
echo 'Processing addon...'
cd /oem
unzip -q -o remote-2.2.nvda-addon -d remote/
rm remote-2.2.nvda-addon
fi

# Create install script if not exists
if [ ! -f /oem/install.bat ]; then
cp /templates/install.bat /oem/
unix2dos /oem/install.bat
fi

if [ ! -f /oem/remote.ini ]; then
# Check if REMOTE_KEY is set and not empty
if [ -z "$REMOTE_KEY" ] || [ "$REMOTE_KEY" = "default_remote_key" ]; then
echo "ERROR: REMOTE_KEY is not set or using default value"
echo "Please set REMOTE_KEY environment variable with your desired key"
echo "Example: REMOTE_KEY=mykey123 docker compose up oem-setup"
exit 1
fi
echo writing key to remote.ini...
cp /templates/remote.ini /oem/
echo "key = $REMOTE_KEY" >> /oem/remote.ini
unix2dos /oem/remote.ini
fi
echo 'OEM setup complete'
