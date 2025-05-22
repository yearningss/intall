# === Запуск сервера в screen-сессии ===
echo "Запускаю сервер в screen-сессии 'mcserver'..."
screen -dmS mcserver java -Xms2G -Xmx2G -jar $PAPER_JAR nogui
echo "Сервер запущен! Для подключения к консоли сервера используйте: screen -r mcserver"