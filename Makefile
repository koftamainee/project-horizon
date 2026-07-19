.PHONY: dev stop logs build up down test proto migrate install-air

dev: infra
	air

infra:
	docker compose -f docker-compose.dev.yml up -d

stop:
	docker compose -f docker-compose.dev.yml down

logs:
	docker compose -f docker-compose.dev.yml logs -f

build:
	docker compose build

up:
	docker compose up -d

down:
	docker compose down

test:
	go test ./...

proto:
	buf generate --path proto

migrate:
	docker compose run --rm migrator -path /migrations -database "postgres://migrator:$${MIGRATOR_PASSWORD}@db:5432/horizon?sslmode=disable" up

install-air:
	go install github.com/air-verse/air@latest
