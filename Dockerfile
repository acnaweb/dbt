# Usando uma imagem base com Python
FROM python:3.11-slim

# Definindo o mantenedor
LABEL maintainer="acnaweb"

# Atualizando a lista de pacotes e instalando dependências
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    nano \
    sqlite3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /shared 
VOLUME /shared

# Criando um diretório de trabalho
WORKDIR /shared

# Instalando DBT e adaptador para o sqlite
COPY requirements.txt .
RUN pip install -r requirements.txt

# Expor a porta 8080
EXPOSE 8080

ENV DBT_PROJECT_DIR=/shared

# Definir o comando padrão para execução quando o container for iniciado
CMD ["/bin/bash"]