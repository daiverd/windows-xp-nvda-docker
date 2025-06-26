# Default key value (can be overridden)
REMOTE_KEY ?= default_remote_key

.PHONY: clean oem-setup oem-setup-interactive

# Interactive key entry
oem-setup-interactive:
	@read -p "Enter NVDA key: " key; \
	if [ -z "$$key" ]; then \
		echo "Error: Key cannot be empty"; \
		exit 1; \
	fi; \
	REMOTE_KEY=$$key docker compose --profile setup run --rm oem-setup

clean:
	-docker compose --profile setup down
	-rm -rf oem

oem-setup:
	REMOTE_KEY=$(REMOTE_KEY) docker compose --profile setup run --rm oem-setup
