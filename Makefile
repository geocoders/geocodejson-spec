AJV_CLI_VERSION ?= 5.0.0
JSON_DEREFERENCE_CLI_VERSION ?= 0.1.2

hooks:
	echo "Installing git hooks"
	cp .githooks/* .git/hooks/

checksum:
	echo "Computing spec checksum"
	.githooks/pre-commit

verify:
	.githooks/pre-push && echo "Checksum ok"

bundle:
	echo "Building spec bundle"
	npx -y json-dereference-cli@$(JSON_DEREFERENCE_CLI_VERSION) -s src/geocodejson.schema.json -o draft/geocodejson.schema.json

validate:
	echo "Validating spec bundle"
	npx -y ajv-cli@$(AJV_CLI_VERSION) compile --spec=draft2020 -s draft/geocodejson.schema.json

build: bundle validate checksum verify
