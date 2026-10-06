@echo off
echo ============================================
echo   CampusConnect AI - First-time Setup
echo ============================================
echo.

where python >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo Python was not found on this computer.
    echo Please install it from https://python.org
    echo IMPORTANT: during install, tick the box that says "Add Python to PATH".
    echo Then run this file again.
    pause
    exit /b 1
)

if not exist venv (
    echo Creating a private space for this project...
    python -m venv venv
) else (
    echo Project space already exists. Skipping.
)

echo Turning it on...
call venv\Scripts\activate.bat

echo Installing everything the app needs. This can take a minute...
pip install -r requirements.txt

if not exist .env (
    echo Creating your settings file...
    copy .env.example .env
    echo.
    echo IMPORTANT: A file called .env was just created in this folder.
    echo Open it with Notepad and change SECRET_KEY and MASTER_ADMIN_PASSWORD
    echo to your own values, then save it and close Notepad.
    echo.
    echo Press any key once you have done that...
    pause >nul
) else (
    echo Settings file already exists. Skipping.
)

echo Setting up your database and admin account...
python seed.py

echo.
echo ============================================
echo   Setup complete!
echo   Next time, just double-click run.bat
echo ============================================
pause
