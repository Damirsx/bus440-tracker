#!/bin/bash

# Остановка при ошибке
set -e

echo "🚀 Starting GigaChat API Server..."
echo "=================================="

# Проверка Python
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 не найден!"
    echo "Установите Python 3.8+ перед запуском"
    exit 1
fi

# Создание виртуального окружения если не существует
if [ ! -d "venv" ]; then
    echo "📦 Создание виртуального окружения..."
    python3 -m venv venv
fi

# Активация виртуального окружения
echo "🔧 Активация виртуального окружения..."
source venv/bin/activate

# Установка зависимостей
echo "📥 Установка зависимостей..."
pip install -q --upgrade pip
pip install -q -r requirements.txt

# Запуск сервера
echo "✅ Запуск сервера на порту 5000..."
echo "=================================="
echo ""
echo "🌐 API доступен по адресу: http://localhost:5000"
echo "📡 Endpoint: http://localhost:5000/chat"
echo ""
echo "Для остановки нажмите Ctrl+C"
echo ""

python3 gigachat_server.py
