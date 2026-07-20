@echo off
REM ============================================================================
REM  03_MO_CONG_CU_AI.cmd
REM  Mo du an Tro Ly So Lieu AI bang VS Code cho nhan vien
REM  Ho tro duong dan co khoang trang, khong gia dinh o dia hay ten nguoi dung
REM ============================================================================

setlocal EnableExtensions EnableDelayedExpansion

REM --- Buoc 1: Chuyen ve dung thu muc du an (cha cua windows\) ---
for %%I in ("%~dp0..") do set "ROOT=%%~fI"
cd /d "%ROOT%"

title Tro Ly So Lieu AI - Mo cong cu AI

REM --- Buoc 2: Tim lenh 'code' cua VS Code ---
set "CODE_CMD="
for /f "delims=" %%I in ('where code 2^>nul') do (
    if not defined CODE_CMD set "CODE_CMD=%%I"
)
if not defined CODE_CMD if exist "%LOCALAPPDATA%\Programs\Microsoft VS Code\bin\code.cmd" set "CODE_CMD=%LOCALAPPDATA%\Programs\Microsoft VS Code\bin\code.cmd"
if not defined CODE_CMD if exist "%ProgramFiles%\Microsoft VS Code\bin\code.cmd" set "CODE_CMD=%ProgramFiles%\Microsoft VS Code\bin\code.cmd"
if not defined CODE_CMD if exist "%ProgramFiles(x86)%\Microsoft VS Code\bin\code.cmd" set "CODE_CMD=%ProgramFiles(x86)%\Microsoft VS Code\bin\code.cmd"

REM --- Buoc 4: Neu chua co VS Code thi huong dan cai ---
if not defined CODE_CMD (
    color 0E
    echo.
    echo ============================================================
    echo    CHUA TIM THAY VISUAL STUDIO CODE
    echo ============================================================
    echo.
    echo  Ban can cai dat cong cu truoc.
    echo  Hay chay file: 01_CAI_DAT_CONG_CU.bat
    echo  ^(Bam chuot phai - Run as administrator^)
    echo.
    echo ============================================================
    echo.
    echo Nhan phim bat ky de dong...
    pause >nul
    exit /b 1
)

REM --- Buoc 3: Mo toan bo project bang VS Code ---
call "%CODE_CMD%" .

REM --- Buoc 5: Hien thi huong dan ngan ---
color 0B
echo.
echo ============================================================
echo    TRO LY SO LIEU AI - DA MO TRONG VS CODE
echo    Script created by Phan Nam  -  Version 1.0.0
echo ============================================================
echo.
echo  Buoc 1: Bo file Excel vao thu muc file_can_xu_ly.
echo  Buoc 2: Mo Codex trong VS Code.
echo  Buoc 3: Mo file PROMPT_MAU.md.
echo  Buoc 4: Copy prompt mau va sua yeu cau.
echo  Buoc 5: Ket qua se nam trong thu muc file_da_xu_ly.
echo.
echo ============================================================
echo.
echo Nhan phim bat ky de dong cua so nay (VS Code van mo)...
pause >nul
exit /b 0
