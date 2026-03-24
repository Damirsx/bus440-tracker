@echo off
chcp 65001 >nul
color 0F
title 📦 Creating Deployment Package

echo.
echo ╔════════════════════════════════════════════════════════════════════╗
echo ║                                                                    ║
echo ║          📦 СОЗДАНИЕ DEPLOYMENT PACKAGE                           ║
echo ║                  Bus 440 Web Application                           ║
echo ║                                                                    ║
echo ╚════════════════════════════════════════════════════════════════════╝
echo.
echo.

echo 📁 Создание архива для загрузки...
echo.

REM Проверка PowerShell 5.0+
powershell -Command "if ($PSVersionTable.PSVersion.Major -lt 5) {Write-Host 'Требуется PowerShell 5.0+'; exit 1}"

if %ERRORLEVEL% NEQ 0 (
    echo ❌ Требуется PowerShell 5.0 или выше
    pause
    exit /b 1
)

REM Создание ZIP архива
powershell -Command "Compress-Archive -Path '.\*' -DestinationPath '..\Bus440_Deployment_Package.zip' -Force"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ✅ Архив успешно создан!
    echo.
    echo 📍 Расположение: Bus440_Deployment_Package.zip
    echo 📦 Размер: 
    powershell -Command "(Get-Item '..\Bus440_Deployment_Package.zip').Length / 1KB | ForEach-Object {'{0:N2} KB' -f $_}"
    echo.
    echo ═══════════════════════════════════════════════════════════════════
    echo  ЧТО ДАЛЬШЕ:
    echo ═══════════════════════════════════════════════════════════════════
    echo.
    echo  1. Распакуйте архив на хостинге через файловый менеджер
    echo  2. Или используйте AUTO_DEPLOY.bat для автоматической загрузки
    echo.
) else (
    echo ❌ Ошибка при создании архива
)

echo.
pause
