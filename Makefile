FILE = srcs/docker-compose.yml

all:
	mkdir -p /home/$(USER)/data/wordpress
	mkdir -p /home/$(USER)/data/mariadb
	docker compose -f $(FILE) up --detach --build

down:
	docker compose -f $(FILE) down
clean:
	@if [ ! -z "$$(docker ps -aq)" ]; then \
		docker stop $$(docker ps -aq); \
		docker rm $$(docker ps -aq); \
	fi
	@if [ ! -z "$$(docker images -aq)" ]; then \
		docker rmi $$(docker images -aq); \
	fi	
	@if [ ! -z "$$(docker volume ls -q)" ]; then \
		docker volume rm $$(docker volume ls -q); \
	fi
	@if [ ! -z "$$(docker network ls -q --filter type=custom)" ]; then \
		docker network rm $$(docker network ls -q --filter type=custom); \
	fi
	sudo rm -rf /home/$(USER)/data/wordpress
	sudo rm -rf /home/$(USER)/data/mariadb

re: clean all

.PHONY: all down clean