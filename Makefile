# Версия docker-compose
DOCKER_COMPOSE_RELEASE = v2.4.1

all: docker docker-compose

# Информация о том, что содержится в docker
display:
	docker system df

# Очистка всего, что есть в docker (образы, контейнеры, сети и т.п.)
clean:
	docker system prune --volumes

# Проверка, есть ли в системе файлы с названием docker
check:
	@dpkg -l | grep -i docker

# Удаление docker
delete:
	@sudo apt-get purge -y docker-compose docker-engine docker docker.io docker-ce docker-ce-cli
	@sudo apt-get autoremove -y docker-compose docker-engine docker docker.io docker-ce docker-ce-cli

# Установка docker (TODO регистрация пользователя пока не получилась: последняя команда - костыль)
docker:
	@sudo apt update
	@sudo apt install apt-transport-https ca-certificates curl software-properties-common
	@curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	@sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(shell lsb_release -cs) stable"
	@sudo apt update
	@sudo apt install docker-ce -y
	@sudo systemctl start docker
	@sudo systemctl enable docker
	@sudo usermod -aG docker $(USER)
	@su - $(USER)
	@sudo chmod 666 /var/run/docker.sock

# Установка docker-compose (версию можно изменить в константе в начале файла)
docker-compose:
	@sudo curl -L "https://github.com/docker/compose/releases/download/$(DOCKER_COMPOSE_RELEASE)/docker-compose-$(shell uname -s)-$(shell uname -m)" -o /usr/local/bin/docker-compose
	@sudo chmod +x /usr/local/bin/docker-compose

# Для разных тестов (не используется в работе)
test:
	@lsb_release -cs
	@echo $(USER)
	@uname -s
	@uname -m
# @sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(shell lsb_release -cs) stable"