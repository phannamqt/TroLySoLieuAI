@echo off
REM ============================================================================
REM  04_GO_CAI_DAT.bat
REM  Go cai dat cua rieng du an Tro Ly So Lieu AI
REM
REM  NGUYEN TAC AN TOAN:
REM   - KHONG tu dong go Python
REM   - KHONG tu dong go VS Code
REM   - KHONG xoa file_can_xu_ly / file_da_xu_ly khi chua co xac nhan ro rang
REM   - Luon canh bao sao luu du lieu truoc khi xoa
REM ============================================================================

setlocal EnableExtensions EnableDelayedExpansion

REM --- SCRIPT_DIR = windows\, ROOT = thu muc du an (cha) ---
set "SCRIPT_DIR=%~dp0"
for %%I in ("%~dp0..") do set "ROOT=%%~fI"
cd /d "%ROOT%"

title Tro Ly So Lieu AI - Go cai dat
color 0E
echo.
echo ============================================================
echo    TRO LY SO LIEU AI - GO CAI DAT
echo    Script created by Phan Nam  -  Version 1.0.0
echo ============================================================
echo.
echo  CANH BAO QUAN TRONG:
echo    - Hay SAO LUU (backup) du lieu trong file_can_xu_ly va file_da_xu_ly
echo      TRUOC KHI tiep tuc.
echo    - Cong cu nay KHONG go Python, KHONG go VS Code.
echo    - Chi xoa nhung gi ban dong y ben duoi.
echo ============================================================
echo.

REM ---------------------------------------------------------------------------
REM  1. Xoa shortcut tren Desktop do du an tao ra
REM ---------------------------------------------------------------------------
set "LNK=%USERPROFILE%\Desktop\Excel AI Starter.lnk"
if exist "%LNK%" (
    del "%LNK%" >nul 2>&1
    if not exist "%LNK%" (
        echo [OK] Da xoa shortcut tren Desktop.
    ) else (
        echo [CANH BAO] Khong xoa duoc shortcut tren Desktop.
    )
) else (
    echo [OK] Khong co shortcut tren Desktop ^(bo qua^).
)
echo.

REM ---------------------------------------------------------------------------
REM  2. Hoi xoa moi truong ao Python (neu co thu muc .venv hoac venv)
REM ---------------------------------------------------------------------------
set "VENVDIR="
if exist "%ROOT%\.venv\" set "VENVDIR=%ROOT%\.venv"
if not defined VENVDIR if exist "%ROOT%\venv\" set "VENVDIR=%ROOT%\venv"

if defined VENVDIR (
    echo Tim thay moi truong ao Python: %VENVDIR%
    set /p "ANS1=Ban co muon XOA moi truong ao nay khong? (go YES de xoa): "
    if /i "!ANS1!"=="YES" (
        rmdir /s /q "%VENVDIR%"
        if not exist "%VENVDIR%\" (
            echo [OK] Da xoa moi truong ao Python.
        ) else (
            echo [CANH BAO] Khong xoa duoc moi truong ao.
        )
    ) else (
        echo [BO QUA] Giu lai moi truong ao Python.
    )
) else (
    echo [OK] Khong tim thay moi truong ao Python ^(.venv/venv^) - bo qua.
)
echo.

REM ---------------------------------------------------------------------------
REM  3. Hoi xoa toan bo thu muc du an (bao gom file_can_xu_ly/file_da_xu_ly)
REM     Yeu cau go dung cum tu xac nhan de tranh xoa nham
REM ---------------------------------------------------------------------------
echo ------------------------------------------------------------
echo  XOA TOAN BO THU MUC DU AN
echo  Thu muc: %ROOT%
echo  Viec nay se xoa CA du lieu trong file_can_xu_ly va file_da_xu_ly.
echo ------------------------------------------------------------
echo.
echo  Neu chac chan, hay go dung: XOA TAT CA
set /p "ANS2=Xac nhan: "
if /i "!ANS2!"=="XOA TAT CA" (
    echo.
    echo  Xac nhan lan cuoi. Du lieu se KHONG the khoi phuc.
    set /p "ANS3=Go lai XOA TAT CA de dong y: "
    if /i "!ANS3!"=="XOA TAT CA" (
        REM Tao lenh xoa chay tach roi de co the xoa ca thu muc dang chay
        echo [DANG XOA] Toan bo thu muc du an...
        cd /d "%TEMP%"
        start "" cmd /c "timeout /t 2 >nul & rmdir /s /q "%ROOT%""
        echo [OK] Da yeu cau xoa thu muc du an. Cua so se dong.
        exit /b 0
    ) else (
        echo [BO QUA] Khong xoa thu muc du an ^(xac nhan khong khop^).
    )
) else (
    echo [BO QUA] Khong xoa thu muc du an.
)

echo.
echo ============================================================
echo    HOAN TAT GO CAI DAT
echo ============================================================
echo.
echo  Luu y: Python va VS Code van con tren may.
echo  Neu muon go, hay dung "Add or remove programs" cua Windows.
echo.
echo Nhan phim bat ky de dong...
pause >nul
exit /b 0
