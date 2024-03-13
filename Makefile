include ./srcs/.env

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
	@if ! grep -q "$(DOMAIN_NAME)" /etc/hosts; then \
		echo "127.0.0.1 $(DOMAIN_NAME)" >> /etc/hosts; \
	fi
	@if ! grep -q "www.$(DOMAIN_NAME)" /etc/hosts; then \
		echo "127.0.0.1 www.$(DOMAIN_NAME)" >> /etc/hosts; \
	fi
	@if [ ! -d $(WP_PATH) ]; then \
		mkdir -p $(WP_PATH); \
	fi
	@if [ ! -d $(DB_PATH) ]; then \
		mkdir -p $(DB_PATH); \
	fi
	docker compose -f $(DOCKER_FILE) -p $(NAME) up --build --detach

.PHONY: down
down:
	docker compose -f $(DOCKER_FILE) down

.PHONY: clean
clean:
	docker compose -f $(DOCKER_FILE) down --rmi all -v

.PHONY: fclean
fclean: clean
	@if [ -d $(DATA_DIR) ]; then \
		rm -rf $(DATA_DIR); \
		docker volume rm --force $(WP_VOL); \
		docker volume rm --force $(DB_VOL); \
	fi
	@sed -i "/$(DOMAIN_NAME)/d" /etc/hosts
	docker system prune -a --force --volumes

.PHONY: re
re: fclean all
