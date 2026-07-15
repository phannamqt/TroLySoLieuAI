@echo off
REM ============================================================================
REM  WINDOW_BAT_DAU.bat  -  DIEM KHOI DONG CHO WINDOWS
REM  Du an: Tro Ly So Lieu AI
REM
REM  Bam dup file nay de mo MENU (cai dat / kiem tra / mo cong cu).
REM  File chi goi lai menu that trong thu muc windows\.
REM ============================================================================

setlocal EnableExtensions
cd /d "%~dp0"

if exist "%~dp0windows\BAT_DAU.bat" (
    call "%~dp0windows\BAT_DAU.bat"
) else (
    echo [LOI] Khong tim thay windows\BAT_DAU.bat
    echo       Hay bao dam ban giai nen day du thu muc du an.
    echo.
    echo Nhan phim bat ky de dong...
    pause >nul
)

exit /b 0
