#!/bin/bash

# === Настройки ===
MC_VERSION="1.21.5"
PAPER_BUILD_URL="https://api.papermc.io/v2/projects/paper/versions/$MC_VERSION/builds"
GEYSER_URL="https://download.geysermc.org/v2/projects/geyser/versions/latest/builds/latest/downloads/spigot"
SERVER_DIR="mc_server"
SEED="7092092118958763650"

# === Установка зависимостей ===
sudo apt update
sudo apt install -y openjdk-17-jre-headless wget curl

# === Создание папки сервера ===
mkdir -p "$SERVER_DIR"
cd "$SERVER_DIR"

# === Скачивание PaperMC ===
PAPER_BUILD=$(curl -s "$PAPER_BUILD_URL" | grep -oP '"build":\K[0-9]+' | tail -1)
PAPER_JAR="paper-$MC_VERSION-$PAPER_BUILD.jar"
wget -O "$PAPER_JAR" "https://api.papermc.io/v2/projects/paper/versions/$MC_VERSION/builds/$PAPER_BUILD/downloads/paper-$MC_VERSION-$PAPER_BUILD.jar"

# === Скачивание GeyserMC ===
mkdir -p plugins
wget -O plugins/Geyser-Spigot.jar "$GEYSER_URL"

# === Принятие EULA ===
echo "eula=true" > eula.txt

# === Создание server.properties с нужным сидом ===
cat > server.properties <<EOF
# Minecraft server properties
level-seed=$SEED
online-mode=false
enable-command-block=true
motd=Добро пожаловать на сервер Minecraft 1.21.5 с поддержкой Bedrock!
EOF

# === Запуск сервера ===
echo "Сервер установлен! Для запуска используйте:"
echo "cd $SERVER_DIR && java -Xms2G -Xmx2G -jar $PAPER_JAR nogui"