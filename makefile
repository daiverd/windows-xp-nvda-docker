# Default key value (can be overridden)
REMOTE_KEY ?= default_remote_key
VERSION ?= xp

.PHONY: clean oem-setup oem-setup-interactive

# Interactive key entry
oem-setup-interactive:
	@read -p "Enter NVDA key: " key; \
	if [ -z "$$key" ]; then \
		echo "Error: Key cannot be empty"; \
		exit 1; \
	fi; \
	read -p "Enter Windows Version: " VERSION; \
	if [ -z "$$VERSION" ]; then \
		echo "Error: Version cannot be empty"; \
		exit 1; \
	fi; \
	REMOTE_KEY=$$key VERSION=$$VERSION docker compose --profile setup run --rm oem-setup

clean:
	-docker compose --profile setup down
	-rm -rf oem

oem-setup:
	REMOTE_KEY=$(REMOTE_KEY) VERSION=$(VERSION) docker compose --profile setup run --rm oem-setup
