NAME=inception
DOCKER_FILE=./srcs/docker-compose.yml
ENV=./srcs/.env
DATA_DIR=/home/nlonka/data
WP_VOL=wp-data
DB_VOL=db
WP_PATH=$(DATA_DIR)/$(WP_VOL)
DB_PATH=$(DATA_DIR)/$(DB_VOL)

.PHONY: all
all:
	@if ! grep -q "nlonka.42.fr" /etc/hosts; then \
		sudo echo "127.0.0.1 nlonka.42.fr" >> /etc/hosts; \
	fi
	@if ! grep -q "www.nlonka.42.fr" /etc/hosts; then \
		sudo echo "127.0.0.1 www.nlonka.42.fr" >> /etc/hosts; \
	fi
	@if [ ! -d $(WP_PATH) ]; then \
		mkdir -p $(WP_PATH); \
	fi
	@if [ ! -d $(DB_PATH) ]; then \
		mkdir -p $(DB_PATH); \
	fi
	sudo docker compose -f $(DOCKER_FILE) -p $(NAME) up --build --detach

.PHONY: down
down:
	sudo docker compose -f $(DOCKER_FILE) down

.PHONY: clean
clean:
	sudo docker compose -f $(DOCKER_FILE) down --rmi all -v

.PHONY: fclean
fclean: clean
	@if [ -d $(DATA_DIR) ]; then \
		sudo rm -rf $(DATA_DIR); \
		sudo docker volume rm --force $(WP_VOL); \
		sudo docker volume rm --force $(DB_VOL); \
	fi
	sudo docker system prune -a --force --volumes

.PHONY: re
re: fclean all
