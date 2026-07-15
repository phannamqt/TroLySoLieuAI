@echo off
REM ============================================================================
REM  BAT_DAU.bat  -  MENU TONG (gop buoc 1, 2, 3 vao mot cho)
REM  Danh cho nhan vien: chi can bam dup file nay va chon so.
REM
REM  GHI CHU KY THUAT (cho nguoi bao tri):
REM   - File nay KHONG chep lai logic, chi GOI lai cac file da co:
REM       01_CAI_DAT_CONG_CU.bat   (tu nang quyen Administrator ben trong)
REM       02_KIEM_TRA_MOI_TRUONG.bat
REM       03_MO_CONG_CU_AI.cmd
REM   - Dung %~dp0 nen ho tro duong dan co khoang trang, khong hardcode o dia.
REM ============================================================================

setlocal EnableExtensions
REM SCRIPT_DIR = windows\ (noi chua cac file .bat), ROOT = thu muc du an (cha)
set "SCRIPT_DIR=%~dp0"
for %%I in ("%~dp0..") do set "ROOT=%%~fI"
cd /d "%ROOT%"

title Tro Ly So Lieu AI - Menu bat dau

:MENU
color 0B
cls
echo ============================================================
echo    TRO LY SO LIEU AI - MENU BAT DAU
echo    Script created by Phan Nam  -  Version 1.0.0
echo ============================================================
echo.
echo   [1] Cai dat cong cu        (lam LAN DAU - can quyen Admin)
echo   [2] Kiem tra moi truong    (xem da san sang chua)
echo   [3] Mo cong cu AI          (dung hang ngay)
echo.
echo   [A] Lam TU DONG ca 3 buoc: Cai dat -^> Kiem tra -^> Mo
echo   [0] Thoat
echo.
echo ------------------------------------------------------------
set "CHON="
set /p "CHON=Nhap lua chon roi nhan Enter: "

if /i "%CHON%"=="1" goto STEP1
if /i "%CHON%"=="2" goto STEP2
if /i "%CHON%"=="3" goto STEP3
if /i "%CHON%"=="A" goto ALL
if /i "%CHON%"=="0" goto END

echo.
echo [CANH BAO] Lua chon khong hop le. Hay nhap 1, 2, 3, A hoac 0.
echo Nhan phim bat ky de chon lai...
pause >nul
goto MENU

REM ---------------------------------------------------------------------------
:STEP1
call :RUN_INSTALL
goto BACK

:STEP2
call :RUN_CHECK
goto BACK

:STEP3
call :RUN_OPEN
goto BACK

:ALL
echo.
echo [TU DONG] Se chay lan luot: Cai dat -^> Kiem tra -^> Mo cong cu.
echo.
call :RUN_INSTALL
call :RUN_CHECK
call :RUN_OPEN
goto BACK

REM ---------------------------------------------------------------------------
:BACK
echo.
echo Nhan phim bat ky de quay lai menu...
pause >nul
goto MENU

REM ============================================================================
REM  CAC HAM GOI FILE CON
REM  Luu y: 01 tu nang quyen Admin nen se mo cua so rieng (dung Admin).
REM ============================================================================
:RUN_INSTALL
if exist "%SCRIPT_DIR%01_CAI_DAT_CONG_CU.bat" (
    echo [DANG CHAY] Cai dat cong cu...
    call "%SCRIPT_DIR%01_CAI_DAT_CONG_CU.bat"
) else (
    echo [LOI] Khong tim thay 01_CAI_DAT_CONG_CU.bat
)
exit /b 0

:RUN_CHECK
if exist "%SCRIPT_DIR%02_KIEM_TRA_MOI_TRUONG.bat" (
    echo [DANG CHAY] Kiem tra moi truong...
    call "%SCRIPT_DIR%02_KIEM_TRA_MOI_TRUONG.bat"
) else (
    echo [LOI] Khong tim thay 02_KIEM_TRA_MOI_TRUONG.bat
)
exit /b 0

:RUN_OPEN
if exist "%SCRIPT_DIR%03_MO_CONG_CU_AI.cmd" (
    echo [DANG CHAY] Mo cong cu AI...
    call "%SCRIPT_DIR%03_MO_CONG_CU_AI.cmd"
) else (
    echo [LOI] Khong tim thay 03_MO_CONG_CU_AI.cmd
)
exit /b 0

REM ---------------------------------------------------------------------------
:END
echo.
echo Tam biet!
endlocal
exit /b 0
