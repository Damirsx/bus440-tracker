@echo off
chcp 65001 >nul
color 0A
title 🚀 AUTO DEPLOY - Bus 440 Web App

echo.
echo ╔════════════════════════════════════════════════════════════════════╗
echo ║                                                                    ║
echo ║          🚀 АВТОМАТИЧЕСКИЙ ДЕПЛОЙ НА ХОСТИНГ                      ║
echo ║                   Bus 440 Web Application                          ║
echo ║                                                                    ║
echo ╚════════════════════════════════════════════════════════════════════╝
echo.
echo.

REM Проверка наличия конфигурации FTP
if not exist "ftp_config.txt" (
    echo ❌ ОШИБКА: Файл ftp_config.txt не найден!
    echo.
    echo 📝 ИНСТРУКЦИЯ:
    echo    1. Зарегистрируйтесь на хостинге (beget.ru или timeweb.ru^)
    echo    2. Скопируйте FTP данные в файл ftp_config.txt:
    echo.
    echo       FTP_HOST=ftp.ваш-домен.ru
    echo       FTP_USER=ваш_логин
    echo       FTP_PASS=ваш_пароль
    echo       FTP_PATH=/public_html
    echo.
    echo    3. Запустите этот скрипт снова
    echo.
    pause
    exit /b 1
)

echo ✅ Конфигурация найдена!
echo.

REM Чтение конфигурации
for /f "tokens=1,2 delims==" %%a in (ftp_config.txt) do (
    if "%%a"=="FTP_HOST" set FTP_HOST=%%b
    if "%%a"=="FTP_USER" set FTP_USER=%%b
    if "%%a"=="FTP_PASS" set FTP_PASS=%%b
    if "%%a"=="FTP_PATH" set FTP_PATH=%%b
)

echo 📡 Сервер: %FTP_HOST%
echo 👤 Пользователь: %FTP_USER%
echo 📂 Путь: %FTP_PATH%
echo.

REM Создание FTP скрипта
echo open %FTP_HOST% > ftp_commands.txt
echo %FTP_USER% >> ftp_commands.txt
echo %FTP_PASS% >> ftp_commands.txt
echo cd %FTP_PATH% >> ftp_commands.txt
echo binary >> ftp_commands.txt
echo put index.html >> ftp_commands.txt
echo put gigachat_server.py >> ftp_commands.txt
echo put requirements.txt >> ftp_commands.txt
echo mkdir api >> ftp_commands.txt
echo cd api >> ftp_commands.txt
echo put start_server.sh >> ftp_commands.txt
echo cd .. >> ftp_commands.txt
echo bye >> ftp_commands.txt

echo 📤 Загрузка файлов на сервер...
echo.

ftp -s:ftp_commands.txt

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ╔════════════════════════════════════════════════════════════════════╗
    echo ║                                                                    ║
    echo ║                  ✅ ДЕПЛОЙ УСПЕШНО ЗАВЕРШЕН!                      ║
    echo ║                                                                    ║
    echo ╚════════════════════════════════════════════════════════════════════╝
    echo.
    echo 🌐 Ваш сайт доступен по адресу:
    echo    👉 http://ваш-домен.ru
    echo.
    echo 📋 Учетные данные сохранены в: credentials.txt
    echo.
) else (
    echo.
    echo ❌ ОШИБКА ПРИ ЗАГРУЗКЕ!
    echo Проверьте FTP данные в ftp_config.txt
    echo.
)

REM Очистка
del ftp_commands.txt 2>nul

echo.
pause
