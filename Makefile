FILE=-f srcs/docker-compose.yml
ENV_FILE=--env-file srcs/.env

all: build up

up:
	docker compose ${ENV_FILE} ${FILE} up -d

down:
	docker compose ${ENV_FILE} ${FILE} down

build:
	mkdir -p ~/data/wp_content
	mkdir -p ~/data/wp_db
	docker compose ${ENV_FILE} ${FILE} build

clean: down
	docker system prune -af
	docker volume prune -af
	- docker volume rm `docker volume ls -q`
	sudo rm -rf ~/data

re: clean all

.PHONY: all up down build clean re
