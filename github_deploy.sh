#!/bin/bash
# Автоматический деплой на GitHub Pages за 30 секунд

echo "🚀 Автоматический деплой Bus 440 на GitHub Pages"
echo "=================================================="
echo ""

# Проверка Git
if ! command -v git &> /dev/null; then
    echo "❌ Git не установлен!"
    echo "Скачайте: https://git-scm.com/download/win"
    exit 1
fi

# Проверка что мы в папке deploy
if [ ! -f "index.html" ]; then
    echo "❌ Запустите скрипт из папки deploy!"
    exit 1
fi

echo "📝 Инициализация Git репозитория..."
git init

echo "📦 Добавление файлов..."
git add index.html gigachat_server.py requirements.txt .htaccess README.txt

echo "💾 Создание коммита..."
git commit -m "🚀 Deploy Bus 440 Web App"

echo "🌿 Создание ветки main..."
git branch -M main

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                                                                ║"
echo "║  ⚠️  ВАЖНО: ВЫПОЛНИТЕ СЛЕДУЮЩИЕ ШАГИ ВРУЧНУЮ                  ║"
echo "║                                                                ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "1️⃣  Перейдите на: https://github.com/new"
echo "    • Название: bus440-tracker (или любое)"
echo "    • Тип: Public"
echo "    • НЕ добавляйте README, .gitignore, license"
echo "    • Нажмите 'Create repository'"
echo ""
echo "2️⃣  Скопируйте команды которые GitHub покажет:"
echo ""
echo "    git remote add origin https://github.com/ВАШ_ЛОГИН/bus440-tracker.git"
echo "    git push -u origin main"
echo ""
echo "3️⃣  Выполните эти команды в этом же терминале (вставьте сюда)"
echo ""
echo "4️⃣  После push:"
echo "    • Откройте: Settings → Pages"
echo "    • Source: Deploy from a branch"
echo "    • Branch: main / root"
echo "    • Save"
echo ""
echo "5️⃣  Подождите 1-2 минуты → сайт будет на:"
echo "    https://ВАШ_ЛОГИН.github.io/bus440-tracker/"
echo ""
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "💡 Git репозиторий готов! Осталось только push на GitHub"
echo ""
