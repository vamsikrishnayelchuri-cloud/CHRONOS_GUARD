Write-Host "=======================================================================" -ForegroundColor Cyan
Write-Host " Starting Chronos-Guard: Anomaly Investigation Platform" -ForegroundColor Gold
Write-Host "=======================================================================" -ForegroundColor Cyan

Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd backend; `$env:PYTHONPATH='.'; uvicorn app.main:app --host 127.0.0.1 --port 8000 --reload"
Start-Sleep -Seconds 2
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd frontend; npm run dev"

Write-Host "Backend running on http://127.0.0.1:8000" -ForegroundColor Green
Write-Host "Frontend running on http://localhost:5173" -ForegroundColor Green
Write-Host "=======================================================================" -ForegroundColor Cyan
