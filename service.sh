#!/bin/bash

docker_create() {
  docker compose build --no-cache
  sudo systemctl stop systemd-resolved
  echo "Criando containers e configurando a infraestrutura..."
  docker compose up -d --build
  echo "Infraestrutura criada com sucesso!"
}

docker_start() {
  echo "Iniciando os serviços..."
  docker compose start
  echo "Serviços iniciados!"
}

docker_stop() {
  echo "Parando os serviços..."
  docker compose stop
  echo "Serviços parados!"
  echo "Removendo containers e limpando a infraestrutura..."
  docker compose down --volumes
  echo "Infraestrutura removida com sucesso!"
  echo "Removendo todas as imagens Docker..."
  docker rmi -f $(docker images -q)
  echo "Todas as imagens foram removidas!"
}

case "$1" in
  create)
    docker_create
    ;;
  start)
    docker_start
    ;;
  stop)
    docker_stop
    ;;
    *)
    echo "Uso: $0 {create|start|stop}"
    exit 1
    ;;
esac
