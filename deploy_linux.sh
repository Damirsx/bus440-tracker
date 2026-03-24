#!/bin/bash

# Скрипт для деплоя через Git/FTP на Linux хостинге
# Используйте после регистрации на хостинге

echo "╔════════════════════════════════════════════════════════════════════╗"
echo "║                                                                    ║"
echo "║          🚀 ДЕПЛОЙ Bus 440 - Linux Version                        ║"
echo "║                                                                    ║"
echo "╚════════════════════════════════════════════════════════════════════╝"
echo ""

# Проверка конфигурации
if [ ! -f "ftp_config.txt" ]; then
    echo "❌ Файл ftp_config.txt не найден!"
    echo ""
    echo "Создайте файл ftp_config.txt со следующим содержимым:"
    echo ""
    echo "FTP_HOST=ftp.ваш-домен.ru"
    echo "FTP_USER=ваш_логин"
    echo "FTP_PASS=ваш_пароль"
    echo "FTP_PATH=/public_html"
    echo ""
    exit 1
fi

# Чтение конфигурации
source <(grep -v '^#' ftp_config.txt | sed 's/ //g')

echo "✅ Конфигурация загружена"
echo "📡 Сервер: $FTP_HOST"
echo "👤 Пользователь: $FTP_USER"
echo "📂 Путь: $FTP_PATH"
echo ""

# Проверка lftp
if ! command -v lftp &> /dev/null; then
    echo "⚠️ lftp не установлен. Устанавливаю..."
    
    if command -v apt-get &> /dev/null; then
        sudo apt-get install -y lftp
    elif command -v yum &> /dev/null; then
        sudo yum install -y lftp
    else
        echo "❌ Не удалось установить lftp автоматически"
        echo "Установите вручную: sudo apt-get install lftp"
        exit 1
    fi
fi

# Деплой через lftp
echo "📤 Загрузка файлов на сервер..."
echo ""

lftp -c "
set ftp:ssl-allow no
open -u $FTP_USER,$FTP_PASS $FTP_HOST
cd $FTP_PATH
mirror -R -e -v --parallel=3 \
    --exclude .git/ \
    --exclude node_modules/ \
    --exclude __pycache__/ \
    --exclude *.bat \
    --exclude ftp_config.txt \
    --exclude deploy_linux.sh \
    ./ ./
bye
"

if [ $? -eq 0 ]; then
    echo ""
    echo "╔════════════════════════════════════════════════════════════════════╗"
    echo "║                                                                    ║"
    echo "║                  ✅ ДЕПЛОЙ УСПЕШНО ЗАВЕРШЕН!                      ║"
    echo "║                                                                    ║"
    echo "╚════════════════════════════════════════════════════════════════════╝"
    echo ""
    echo "🌐 Ваш сайт доступен по адресу:"
    echo "   👉 http://$(echo $FTP_HOST | sed 's/ftp\.//')"
    echo ""
else
    echo ""
    echo "❌ ОШИБКА ПРИ ЗАГРУЗКЕ!"
    echo "Проверьте FTP данные в ftp_config.txt"
    echo ""
fi
