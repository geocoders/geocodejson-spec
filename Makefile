AJV_CLI_VERSION ?= 5.0.0
JSON_DEREFERENCE_CLI_VERSION ?= 0.1.2

all: build validate checksum verify

build:
	@echo "Building spec bundle"
	npx -y json-dereference-cli@$(JSON_DEREFERENCE_CLI_VERSION) -s src/geocodejson.schema.json -o draft/geocodejson.schema.json

validate:
	@echo "Validating spec bundle"
	npx -y ajv-cli@$(AJV_CLI_VERSION) compile -s draft/geocodejson.schema.json

checksum:
	@echo "Computing spec checksum"
	./scripts/checksum

verify:
	./scripts/verify && echo "Checksum ok"
