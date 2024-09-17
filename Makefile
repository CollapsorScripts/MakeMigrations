.PHONY: setup

USER = postgres
PASSWORD = postgres
PORT = 5432
CONTAINER_NAME = development_base
SCHEMA_NAME = .\schema.sql
SCHEMA_IN_CONTAINER = ./schema.sql

setup:
	@echo Step 1: Writing variables to the environment...
	@set USER=$(USER)
	@echo USER = $(USER)
	@set PASSWORD=$(PASSWORD)
	@echo PASSWORD = $(PASSWORD)
	@set PORT=$(PORT)
	@echo PORT = $(PORT)
	@echo Step 2: Run docker compose...
	@docker compose up -d
	@echo Step 3: Copying schema to container...
	@docker cp $(SCHEMA_NAME) $(CONTAINER_NAME):$(SCHEMA_IN_CONTAINER)
	@echo Step 4: Docker exec and set migrations...
	@docker exec -it $(CONTAINER_NAME) psql -U $(USER) -d postgres -f $(SCHEMA_IN_CONTAINER)