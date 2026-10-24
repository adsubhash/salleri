@echo off
cd /d "%~dp0"
where py >nul 2>nul && (start "thankot.com" cmd /k "py -m http.server 3000" & timeout /t 2 >nul & start http://localhost:3000) || (start "thankot.com" cmd /k "python -m http.server 3000" & timeout /t 2 >nul & start http://localhost:3000)
