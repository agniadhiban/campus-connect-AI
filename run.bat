@echo off
echo Starting CampusConnect AI...
echo.

if not exist venv (
    echo Setup has not been run yet.
    echo Please double-click setup.bat first.
    pause
    exit /b 1
)

call venv\Scripts\activate.bat

echo Finding your computer's network address...
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /i "IPv4"') do set LOCALIP=%%a
set LOCALIP=%LOCALIP: =%

echo.
echo ================================================================
echo   On THIS computer, open:      http://127.0.0.1:5000
echo   On your PHONE (same Wi-Fi):  http://%LOCALIP%:5000
echo ================================================================
echo.
echo If your phone can't connect, see README.md for troubleshooting.
echo For live GPS + siren testing on your phone, use run_phone_https.bat instead.
echo To stop the app, close this window or press CTRL+C.
echo.
python run.py
pause
