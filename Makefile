.DEFAULT_GOAL := help

.PHONY: help build run clean logs

COMPOSE ?= docker compose
SERVICE ?= cognit

help:
	@printf '%s\n' \
		'Cognit Docker commands:' \
		'  make build  Build the Cognit image' \
		'  make run    Build and start the Cognit container' \
		'  make logs   Follow the Cognit container logs' \
		'  make clean  Stop and remove the Cognit container and image'

build:
	$(COMPOSE) build $(SERVICE)

run:
	$(COMPOSE) up -d --build $(SERVICE)

clean:
	$(COMPOSE) down --rmi all --volumes --remove-orphans

logs:
	$(COMPOSE) logs -f $(SERVICE)
