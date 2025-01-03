CONTAINER_MANAGER := docker
COMPOSE := $(CONTAINER_MANAGER) compose
DC_FILE := compose.yaml

.PHONY: ps
ps:
	$(COMPOSE) -f $(DC_FILE) ps

.PHONY: config
config:
	$(COMPOSE) -f $(DC_FILE) config

.PHONY: up
up:
	$(COMPOSE) -f $(DC_FILE) up -d

.PHONY: down
down:
	$(COMPOSE) -f $(DC_FILE) down

.PHONY: start
start:
	$(COMPOSE) -f $(DC_FILE) start

.PHONY: stop
stop:
	$(COMPOSE) -f $(DC_FILE) stop

.PHONY: restart
restart:
	$(COMPOSE) -f $(DC_FILE) restart

.PHONY: logs
logs:
	$(COMPOSE) -f $(DC_FILE) logs -f
