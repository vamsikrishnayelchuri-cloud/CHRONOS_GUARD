@echo off
echo =======================================================================
echo  Starting Chronos-Guard: Anomaly Investigation Platform
echo =======================================================================

start "Chronos-Guard Backend" cmd /k "cd backend && set PYTHONPATH=. && uvicorn app.main:app --host 127.0.0.1 --port 8000 --reload"
timeout /t 2 >nul
start "Chronos-Guard Frontend" cmd /k "cd frontend && npm run dev"

echo Backend running on http://127.0.0.1:8000
echo Frontend running on http://localhost:5173
echo =======================================================================
pause
