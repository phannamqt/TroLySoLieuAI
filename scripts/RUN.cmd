@echo off
REM ============================================================================
REM  RUN.cmd - Chay lai cong cu mau "vi_du_doc_excel.py"
REM  Nhan vien chi can bam dup file nay, khong can mo code.
REM  Dung duong dan tuong doi theo %~dp0, ho tro khoang trang.
REM ============================================================================

setlocal EnableExtensions
REM Chuyen ve thu muc goc du an (thu muc cha cua scripts)
cd /d "%~dp0\.."

title Tro Ly So Lieu AI - Chay cong cu mau
echo.
echo ============================================================
echo    DANG CHAY: doc va mo ta cau truc file Excel trong file_can_xu_ly
echo    Script created by Phan Nam  -  Version 1.0.0
echo ============================================================
echo.

REM Chon lenh Python co san (python hoac py)
set "PYCMD="
python --version >nul 2>&1 && set "PYCMD=python"
if not defined PYCMD ( py --version >nul 2>&1 && set "PYCMD=py" )

if not defined PYCMD (
    echo [LOI] Khong tim thay Python.
    echo       Hay chay 01_CAI_DAT_CONG_CU.bat truoc.
    echo.
    echo Nhan phim bat ky de dong...
    pause >nul
    exit /b 1
)

%PYCMD% "scripts\vi_du_doc_excel.py"
set "RC=%errorlevel%"

echo.
if "%RC%"=="0" (
    echo [OK] Da chay xong. Xem ket qua trong thu muc file_da_xu_ly.
) else (
    echo [LOI] Cong cu ket thuc voi ma loi %RC%. Xem thu muc logs.
)
echo.
echo Nhan phim bat ky de dong...
pause >nul
exit /b %RC%
