@echo off
echo ============================================================
echo   CampusConnect AI - phone mode with HTTPS (for live GPS)
echo ============================================================
echo.

if not exist venv (
    echo Setup has not been run yet.
    echo Please double-click setup.bat first.
    pause
    exit /b 1
)

call venv\Scripts\activate.bat

echo Installing the small extra package needed for https (first time only)...
pip install cryptography
echo.

echo Finding your computer's network address...
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /i "IPv4"') do set LOCALIP=%%a
set LOCALIP=%LOCALIP: =%

echo ================================================================
echo   On THIS computer, open:      https://127.0.0.1:5000
echo   On your PHONE (same Wi-Fi):  https://%LOCALIP%:5000
echo ================================================================
echo.
echo FIRST TIME on the phone the browser will warn "Your connection is
echo not private". That is expected (the certificate is self-made).
echo Tap Advanced, then "Proceed" / "Continue to site". After that,
echo the phone will allow GPS.
echo.
echo To stop: close this window or press CTRL+C.
echo.
python run.py --https
pause
