#!/bin/bash

# Atualiza a lista de pacotes disponíveis e instala as dependências necessárias
sudo apt-get update
sudo apt-get install -y ca-certificates curl

# Cria o diretório /etc/apt/keyrings se não existir e baixa a chave do Docker
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Adiciona o repositório do Docker à lista de fontes de pacotes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Atualiza a lista de pacotes após adicionar o repositório do Docker
sudo apt-get update

# Instala o Docker e ferramentas relacionadas
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Adiciona o usuário atual ao grupo docker para executar comandos Docker sem sudo
sudo usermod -aG docker $USER

# Inicia o serviço do Docker
sudo service docker start

# Define permissões para o socket do Docker para que usuários locais possam interagir com o daemon Docker
sudo chmod 666 /var/run/docker.sock
