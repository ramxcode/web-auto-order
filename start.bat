@echo off
title RamxPremium - Server
color 0A

echo.
echo  ========================================
echo    RamxPremium - Menjalankan Server...
echo  ========================================
echo.

:: Matikan proses lama di port 5000 dan 5500 jika ada
for /f "tokens=5" %%a in ('netstat -ano 2^>nul ^| findstr ":5000 " ^| findstr "LISTENING"') do (
  taskkill /PID %%a /F >nul 2>&1
)
for /f "tokens=5" %%a in ('netstat -ano 2^>nul ^| findstr ":5500 " ^| findstr "LISTENING"') do (                                                                                                                                                                                                                               
  taskkill /PID %%a /F >nul 2>&1
)

echo  [1/2] Menjalankan Backend (port 5000)...
start "Backend - RamxPremium" cmd /k "cd /d "%~dp0backend" && node server.js"

:: Tunggu sebentar agar backend siap
timeout /t 3 /nobreak >nul

echo  [2/2] Menjalankan Frontend + Proxy (port 5500)...
start "Frontend - RamxPremium" cmd /k "cd /d "%~dp0" && node server-frontend.js"

echo.
echo  ========================================
echo    Kedua server sudah berjalan!
echo.
echo    Frontend : http://localhost:5500
echo    Admin    : http://localhost:5500/admin/dashboard
echo    Backend  : http://localhost:5000/api/health
echo  ========================================
echo.
echo  Tutup jendela ini jika sudah siap.
echo  Untuk stop server, tutup jendela terminal Backend dan Frontend.
echo.
pause
