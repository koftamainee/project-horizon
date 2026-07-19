.PHONY: dev stop logs dev-scp dev-vod build up down test proto proto-watch migrate migrate-create \
       install-air lint lint-fix db-shell db-reset nats-shell

dev: infra
	tmux new-window -t horizon -n proto "make proto-watch"
	tmux new-window -t horizon -n kernel "air -c kernel/.air.toml"
	tmux new-window -t horizon -n scp "air -c streaming-control-plane/.air.toml"
	tmux new-window -t horizon -n vod "air -c vod-assembler/.air.toml"
	tmux select-window -t horizon:shell
	tmux attach -t horizon

infra:
	tmux new-session -d -s horizon -n shell
	tmux send-keys -t horizon:shell "cd $(shell pwd)" C-m
	tmux new-window -t horizon -n infra "docker compose -f docker-compose.dev.yaml up"

dev-scp:
	tmux new-window -t horizon -n scp "air -c streaming-control-plane/.air.toml"

dev-vod:
	tmux new-window -t horizon -n vod "air -c vod-assembler/.air.toml"

stop:
	-tmux kill-session -t horizon 2>/dev/null
	docker compose -f docker-compose.dev.yaml down 2>/dev/null

logs:
	docker compose -f docker-compose.dev.yaml logs -f

build:
	docker compose build

up:
	docker compose up -d

down:
	docker compose down

db-shell:
	docker compose -f docker-compose.dev.yaml exec db psql -U app_admin -d horizon

db-reset:
	docker compose -f docker-compose.dev.yaml down -v
	docker compose -f docker-compose.dev.yaml up -d db
	@echo "waiting for db..."
	@until docker compose -f docker-compose.dev.yaml exec db pg_isready -U app_admin -d horizon >/dev/null 2>&1; do sleep 1; done
	$(MAKE) migrate

migrate:
	docker compose -f docker-compose.dev.yaml run --rm migrator -path /migrations -database "postgres://migrator:$${MIGRATOR_PASSWORD}@db:5432/horizon?sslmode=disable" up

migrate-create:
	@if [ -z "$(NAME)" ]; then echo "usage: make migrate-create NAME=add_users"; exit 1; fi
	@sh -c ' \
		LAST=$$(ls kernel/migrations/*.up.sql 2>/dev/null | sed "s|.*/||;s|_.*||" | sort -n | tail -1); \
		NEXT=$${LAST:-0}; \
		NEXT=$$(( NEXT + 1 )); \
		NUM=$$(printf "%06d" $$NEXT); \
		touch "kernel/migrations/$${NUM}_$(NAME).up.sql"; \
		touch "kernel/migrations/$${NUM}_$(NAME).down.sql"; \
		echo "created kernel/migrations/$${NUM}_$(NAME).{up,down}.sql"'

proto:
	cd proto && buf generate

proto-watch:
	@which entr >/dev/null 2>&1 || { echo "entr not installed: pacman -S entr"; exit 1; }
	@find proto -name '*.proto' | entr -r $(MAKE) proto

nats-shell:
	docker compose -f docker-compose.dev.yaml run --rm nats-shell

test:
	go test ./...

lint:
	@for mod in kernel streaming-control-plane vod-assembler gopkg/config gopkg/conn/minio gopkg/conn/nats gopkg/conn/pg gopkg/http gopkg/json gopkg/log gopkg/proto gopkg/retry gopkg/shutdown; do \
		echo "==> $$mod"; \
		(cd $$mod && golangci-lint run ./...) || exit 1; \
	done
	@echo "all modules passed"

lint-fix:
	@for mod in kernel streaming-control-plane vod-assembler gopkg/config gopkg/conn/minio gopkg/conn/nats gopkg/conn/pg gopkg/http gopkg/json gopkg/log gopkg/proto gopkg/retry gopkg/shutdown; do \
		echo "==> $$mod"; \
		(cd $$mod && golangci-lint run --fix ./...) || exit 1; \
	done
	@echo "all modules passed"

install-air:
	go install github.com/air-verse/air@latest
