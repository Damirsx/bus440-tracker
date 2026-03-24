@echo off
chcp 65001 >nul
color 0E
title 📚 Открыть всю документацию

echo.
echo ╔════════════════════════════════════════════════════════════════════╗
echo ║                                                                    ║
echo ║               📚 ОТКРЫТИЕ ВСЕЙ ДОКУМЕНТАЦИИ                       ║
echo ║                                                                    ║
echo ╚════════════════════════════════════════════════════════════════════╝
echo.
echo 📖 Открываю все файлы документации...
echo.

REM Проверка наличия файлов
set missing=0

if not exist "README.txt" (
    echo ❌ README.txt не найден
    set missing=1
)

if not exist "QUICK_START.txt" (
    echo ❌ QUICK_START.txt не найден
    set missing=1
)

if not exist "HOSTING_OPTIONS.txt" (
    echo ❌ HOSTING_OPTIONS.txt не найден
    set missing=1
)

if not exist "credentials.txt" (
    echo ❌ credentials.txt не найден
    set missing=1
)

if %missing%==1 (
    echo.
    echo ⚠️ Некоторые файлы отсутствуют!
    echo    Убедитесь что вы в папке deploy/
    echo.
    pause
    exit /b 1
)

echo ✅ Все файлы найдены!
echo.

REM Открыть все файлы
start notepad.exe README.txt
timeout /t 1 >nul
start notepad.exe QUICK_START.txt
timeout /t 1 >nul
start notepad.exe HOSTING_OPTIONS.txt
timeout /t 1 >nul
start notepad.exe credentials.txt

echo.
echo ╔════════════════════════════════════════════════════════════════════╗
echo ║                                                                    ║
echo ║            ✅ ВСЯ ДОКУМЕНТАЦИЯ ОТКРЫТА!                           ║
echo ║                                                                    ║
echo ╚════════════════════════════════════════════════════════════════════╝
echo.
echo 📋 Открыто 4 файла:
echo.
echo    1. README.txt           - Главная инструкция
echo    2. QUICK_START.txt      - Быстрый старт
echo    3. HOSTING_OPTIONS.txt  - Сравнение хостингов
echo    4. credentials.txt      - Учетные данные
echo.
echo Изучите документацию и выберите подходящий хостинг!
echo.
pause
