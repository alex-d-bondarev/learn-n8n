# Prerequisites

1. Docker compose installed
2. A folder for n8n data is created with `chown -R 1000:1000` permissions
3. A folder for app knowledge base is created with `chown -R 1000:1000` permissions 
4. A folder for ollama models is created with `chown -R 1000:1000` permissions 
5. An env file created in the project root:
   1. Name: `.env`
   2. Content:
      ```shell
      DATA_FOLDER=<path to data folder created in step no.2>
      KNOWLEDGE_BASE_FOLDER=<path to knowledge base folder created in step no.3>
      OLLAMA_MODELS_FOLDER=<path to ollama models folder created in step no.4>
      PROJECT_ROOT=<path to project root folder>
      ```

# Start
```shell
docker compose up -d
```

# Stop
```shell
docker compose stop
```

# Maintenance
```shell
# Check logs
docker ps
docker logs -f n8n

# Update n8n to latest version
docker compose pull
docker compose stop
docker compose build
docker compose up -d

# Complete removal
docker-compose down
rm -rf ${KNOWLEDGE_BASE_FOLDER}
rm -rf ${DATA_FOLDER}
rm -rf ${PROJECT_ROOT}

# Rebuild a service
docker compose up -d --no-deps --build ollama
```

# ssh tunnel
For oauth per https://abaditya.com/2025/11/30/installing-n8n-on-raspberry-pi-3b/
```shell
ssh -L 5678:localhost:5678 pi@[your-pi-ip]
# open http://localhost:5678
```