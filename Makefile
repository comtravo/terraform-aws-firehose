#! make

DOCKER_COMPOSE=docker-compose -f ./docker-compose.yml
DOCKER_COMPOSE_DEVELOP=$(DOCKER_COMPOSE) -f ./docker-compose.develop.yml

GENERATE_DOCS_COMMAND:=terraform-docs markdown . > README.md

fmt:
	@terraform fmt -recursive

lint:
	@terraform fmt -check -recursive -diff=true
	@tflint

build:
	@$(DOCKER_COMPOSE) build

test:
	@cd tests && go test -v -tags=integration

test-docker:
	@$(DOCKER_COMPOSE) run --rm terraform make test
	@$(DOCKER_COMPOSE) run --rm terraform make lint
	@$(DOCKER_COMPOSE) down -v

develop:
	@$(DOCKER_COMPOSE_DEVELOP) run --rm terraform bash
	@$(DOCKER_COMPOSE_DEVELOP) down -v

generate-docs: fmt lint
	@$(GENERATE_DOCS_COMMAND)

clean:
	@$(DOCKER_COMPOSE) down -v
	@rm -f tests/terraform.tfstate tests/terraform.tfstate.backup
	@rm -rf ./terraform

logs:
	@$(DOCKER_COMPOSE) logs -f
