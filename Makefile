NAME=inception
DOCKER_FILE=./srcs/docker-compose.yml
ENV=./srcs/.env
DATA_DIR=/home/nlonka/data
WP_PATH=$(DATA_DIR)/wp-data
DB_PATH=$(DATA_DIR)/db

.PHONY: all
all:
	@if [ ! -d $(WP_PATH) ]; then \
		mkdir -p $(WP_PATH); \
	fi
	@if [ ! -d $(DB_PATH) ]; then \
		mkdir -p $(DB_PATH); \
	fi
	sudo docker compose -f $(DOCKER_FILE) -p $(NAME) up --build --detach

.PHONY: clean
clean:
	sudo docker compose -f $(DOCKER_FILE) down --rmi all -v

.PHONY: fclean
fclean: clean
	@if [ -d $(DATA_DIR) ]; then \
		sudo rm -rf $(DATA_DIR); \
	fi;
	sudo docker system prune -f

.PHONY: re
re: fclean all
