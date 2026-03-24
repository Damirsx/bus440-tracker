@echo off
chcp 65001 >nul
color 0D
title 🚀 GitHub Pages Deploy - Bus 440

cls
echo.
echo ╔════════════════════════════════════════════════════════════════════╗
echo ║                                                                    ║
echo ║         🚀 АВТОМАТИЧЕСКИЙ ДЕПЛОЙ НА GITHUB PAGES                  ║
echo ║                   Bus 440 Web Application                          ║
echo ║                                                                    ║
echo ╚════════════════════════════════════════════════════════════════════╝
echo.
echo.

REM Проверка Git
where git >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Git не установлен!
    echo.
    echo 📥 Скачайте Git для Windows:
    echo    https://git-scm.com/download/win
    echo.
    echo После установки запустите этот скрипт снова.
    echo.
    pause
    exit /b 1
)

echo ✅ Git найден!
echo.

REM Проверка файлов
if not exist "index.html" (
    echo ❌ Файл index.html не найден!
    echo    Запустите скрипт из папки deploy\
    echo.
    pause
    exit /b 1
)

echo ✅ Файлы найдены!
echo.

echo ════════════════════════════════════════════════════════════════════
echo  ШАГ 1: ИНИЦИАЛИЗАЦИЯ GIT РЕПОЗИТОРИЯ
echo ════════════════════════════════════════════════════════════════════
echo.

REM Удаление старого .git если есть
if exist ".git" (
    echo 🗑️  Удаление старого Git репозитория...
    rmdir /s /q .git
)

echo 📝 Создание нового Git репозитория...
git init

echo 📦 Добавление файлов в Git...
git add index.html gigachat_server.py requirements.txt .htaccess README.txt QUICK_START.txt HOSTING_OPTIONS.txt credentials.txt

echo 💾 Создание коммита...
git commit -m "🚀 Deploy Bus 440 Web App - Premium Transport Tracker"

echo 🌿 Создание ветки main...
git branch -M main

echo.
echo ✅ Git репозиторий готов!
echo.

echo ════════════════════════════════════════════════════════════════════
echo  ШАГ 2: СОЗДАНИЕ РЕПОЗИТОРИЯ НА GITHUB (ВРУЧНУЮ)
echo ════════════════════════════════════════════════════════════════════
echo.
echo.
echo 📌 ОТКРОЙТЕ В БРАУЗЕРЕ: https://github.com/new
echo.
start https://github.com/new
timeout /t 3 >nul

echo.
echo ╔════════════════════════════════════════════════════════════════════╗
echo ║  ЗАПОЛНИТЕ ФОРМУ НА GITHUB:                                        ║
echo ║                                                                    ║
echo ║  Repository name:        bus440-tracker                            ║
echo ║  Description:            🚌 Premium Bus Tracker for Route 440      ║
echo ║  Visibility:             ✅ Public                                 ║
echo ║  Initialize:             ❌ НЕ добавляйте README/gitignore         ║
echo ║                                                                    ║
echo ║  Нажмите: Create repository                                        ║
echo ╚════════════════════════════════════════════════════════════════════╝
echo.
echo.
echo ⏸️  Создайте репозиторий на GitHub, затем нажмите любую клавишу...
pause >nul

echo.
echo ════════════════════════════════════════════════════════════════════
echo  ШАГ 3: ВВЕДИТЕ ВАШ GITHUB ЛОГИН
echo ════════════════════════════════════════════════════════════════════
echo.
set /p GITHUB_USER="Ваш GitHub username: "

if "%GITHUB_USER%"=="" (
    echo ❌ Логин не может быть пустым!
    pause
    exit /b 1
)

echo.
echo ✅ Логин: %GITHUB_USER%
echo.

set REPO_NAME=bus440-tracker
set REPO_URL=https://github.com/%GITHUB_USER%/%REPO_NAME%.git

echo 🔗 URL репозитория: %REPO_URL%
echo.

echo ════════════════════════════════════════════════════════════════════
echo  ШАГ 4: ПОДКЛЮЧЕНИЕ К GITHUB
echo ════════════════════════════════════════════════════════════════════
echo.

echo 🔗 Добавление remote...
git remote add origin %REPO_URL% 2>nul

if %ERRORLEVEL% NEQ 0 (
    echo ⚠️  Remote уже существует, обновляю...
    git remote set-url origin %REPO_URL%
)

echo.
echo ════════════════════════════════════════════════════════════════════
echo  ШАГ 5: ЗАГРУЗКА НА GITHUB
echo ════════════════════════════════════════════════════════════════════
echo.
echo 📤 Отправка файлов на GitHub...
echo.
echo ⚠️  ВНИМАНИЕ: Сейчас откроется окно авторизации GitHub!
echo    Войдите через браузер или введите Personal Access Token
echo.

git push -u origin main

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ╔════════════════════════════════════════════════════════════════════╗
    echo ║                                                                    ║
    echo ║              ✅ ФАЙЛЫ УСПЕШНО ЗАГРУЖЕНЫ НА GITHUB!                ║
    echo ║                                                                    ║
    echo ╚════════════════════════════════════════════════════════════════════╝
    echo.
    echo ════════════════════════════════════════════════════════════════════
    echo  ШАГ 6: ВКЛЮЧЕНИЕ GITHUB PAGES
    echo ════════════════════════════════════════════════════════════════════
    echo.
    echo 📌 ОТКРОЙТЕ: https://github.com/%GITHUB_USER%/%REPO_NAME%/settings/pages
    echo.
    start https://github.com/%GITHUB_USER%/%REPO_NAME%/settings/pages
    echo.
    echo ╔════════════════════════════════════════════════════════════════════╗
    echo ║                                                                    ║
    echo ║  НА СТРАНИЦЕ GITHUB PAGES НАСТРОЙТЕ:                               ║
    echo ║                                                                    ║
    echo ║  Source:           Deploy from a branch                            ║
    echo ║  Branch:           main                                            ║
    echo ║  Folder:           / (root)                                        ║
    echo ║                                                                    ║
    echo ║  Нажмите: Save                                                     ║
    echo ║                                                                    ║
    echo ╚════════════════════════════════════════════════════════════════════╝
    echo.
    echo ⏳ Подождите 1-2 минуты пока GitHub соберет сайт...
    echo.
    echo ════════════════════════════════════════════════════════════════════
    echo.
    echo 🎉 ВАШ САЙТ БУДЕТ ДОСТУПЕН ПО АДРЕСУ:
    echo.
    echo    🌐 https://%GITHUB_USER%.github.io/%REPO_NAME%/
    echo.
    echo ════════════════════════════════════════════════════════════════════
    echo.
    echo 📋 СОХРАНИТЕ ССЫЛКУ:
    echo    https://%GITHUB_USER%.github.io/%REPO_NAME%/ > DEPLOYED_URL.txt
    echo.
    echo ✅ Ссылка сохранена в файл: DEPLOYED_URL.txt
    echo.
) else (
    echo.
    echo ❌ ОШИБКА ПРИ ЗАГРУЗКЕ!
    echo.
    echo 💡 ВОЗМОЖНЫЕ ПРИЧИНЫ:
    echo    • Неправильный логин
    echo    • Репозиторий не создан на GitHub
    echo    • Нет доступа к интернету
    echo    • Требуется Personal Access Token
    echo.
    echo 📖 ЕСЛИ НУЖЕН TOKEN:
    echo    1. Перейдите: https://github.com/settings/tokens
    echo    2. Generate new token (classic)
    echo    3. Выберите: repo (полный доступ)
    echo    4. Скопируйте токен
    echo    5. При git push используйте токен вместо пароля
    echo.
    start https://github.com/settings/tokens
)

echo.
echo ════════════════════════════════════════════════════════════════════
echo.
pause
