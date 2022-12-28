### Установка Docker

Makefile для установки Dcoker в Linux. Создан для удобства, чтобы не искать все установки в инете.

Команды Makefile:
1. `make all` - установка `docker` и `docker-compose`
2. `make display` - информация о содержимом докера (контейнеры, сети и т.п.)
3. `make clean` - очистка от всего, что есть в докере
4. `make check` - проверка, установлен ли docker в системе
5. `make delete` - удаление докера