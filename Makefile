all: up

up:
	@docker-compose -f ./srcs/docker-compose.yml up -d
	
build:
	@docker-compose -f ./srcs/docker-compose.yml build

run:
	@docker-compose -f ./srcs/docker-compose.yml up --build -d

down:
	@docker-compose -f ./srcs/docker-compose.yml down

stop:
	@docker-compose -f ./srcs/docker-compose.yml stop

start:
	@docker-compose -f ./srcs/docker-compose.yml start

status:
	@docker ps
