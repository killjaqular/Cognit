.DEFAULT_GOAL := help

.PHONY: help build run clean logs

COMPOSE ?= docker compose
SERVICE ?= cognit
ENV_FILE ?= cognit.env
COMPOSE_ENV_ARGS := $(if $(wildcard $(ENV_FILE)),--env-file $(ENV_FILE),)

help:
	@printf '%s\n' \
		'Cognit Docker commands:' \
		'  make build  Build the Cognit image' \
		'  make run    Build and start the Cognit container' \
		'  make logs   Follow the Cognit container logs' \
		'  make clean  Stop and remove the Cognit container and image' \
		'  ENV_FILE=... make run  Use a different public config file'

build:
	$(COMPOSE) $(COMPOSE_ENV_ARGS) build $(SERVICE)

run:
	$(COMPOSE) $(COMPOSE_ENV_ARGS) up -d --build $(SERVICE)

clean:
	$(COMPOSE) $(COMPOSE_ENV_ARGS) down --rmi all --volumes --remove-orphans

logs:
	$(COMPOSE) $(COMPOSE_ENV_ARGS) logs -f $(SERVICE)
