@echo off
REM ============================================================================
REM  02_KIEM_TRA_MOI_TRUONG.bat
REM  Kiem tra moi truong lam viec cua Tro Ly So Lieu AI
REM  KHONG thay doi / xoa du lieu that cua nguoi dung
REM  Ket qua in dang [OK] / [LOI] / [CANH BAO] va ghi vao logs\environment_check.log
REM ============================================================================

setlocal EnableExtensions EnableDelayedExpansion

REM --- SCRIPT_DIR = windows\, ROOT = thu muc du an (cha) ---
set "SCRIPT_DIR=%~dp0"
for %%I in ("%~dp0..") do set "ROOT=%%~fI"
cd /d "%ROOT%"
set "LOGDIR=%ROOT%\logs"
set "LOGFILE=%LOGDIR%\environment_check.log"

if not exist "%LOGDIR%" mkdir "%LOGDIR%" >nul 2>&1

set "ERRCOUNT=0"
set "WARNCOUNT=0"

echo ============================================================ >> "%LOGFILE%"
call :log "BAT DAU KIEM TRA MOI TRUONG"

title Tro Ly So Lieu AI - Kiem tra moi truong
echo.
echo ============================================================
echo    KIEM TRA MOI TRUONG - TRO LY SO LIEU AI
echo    Script created by Phan Nam  -  Version 1.0.0
echo ============================================================
echo.

REM ---------------------------------------------------------------------------
REM  1. Python
REM ---------------------------------------------------------------------------
set "PYCMD="
python --version >nul 2>&1 && set "PYCMD=python"
if not defined PYCMD ( py --version >nul 2>&1 && set "PYCMD=py" )

if defined PYCMD (
    for /f "delims=" %%V in ('%PYCMD% --version 2^>^&1') do set "PYVER=%%V"
    call :ok "Python hoat dong: !PYVER!"
) else (
    call :err "Python KHONG hoat dong. Hay chay 01_CAI_DAT_CONG_CU.bat"
)

REM ---------------------------------------------------------------------------
REM  2. pip
REM ---------------------------------------------------------------------------
if defined PYCMD (
    %PYCMD% -m pip --version >nul 2>&1
    if !errorlevel! EQU 0 (
        for /f "delims=" %%V in ('%PYCMD% -m pip --version 2^>^&1') do set "PIPVER=%%V"
        call :ok "pip hoat dong: !PIPVER!"
    ) else (
        call :err "pip KHONG hoat dong."
    )
) else (
    call :err "Bo qua kiem tra pip vi khong co Python."
)

REM ---------------------------------------------------------------------------
REM  3. VS Code
REM ---------------------------------------------------------------------------
call :find_code
if defined CODE_CMD (
    call :ok "VS Code hoat dong (code CLI: %CODE_CMD%)"
) else (
    call :warn "Khong tim thay lenh 'code'. Co the can mo lai cua so hoac cai lai VS Code."
)

REM ---------------------------------------------------------------------------
REM  4. Thu vien Python trong requirements.txt
REM ---------------------------------------------------------------------------
if defined PYCMD (
    if exist "%ROOT%\requirements.txt" (
        echo.
        echo  --- Kiem tra thu vien Python ---
        for /f "usebackq eol=# tokens=1 delims=<>=~! " %%L in ("%ROOT%\requirements.txt") do (
            set "PKG=%%L"
            if not "!PKG!"=="" (
                set "IMPORTNAME=!PKG!"
                if /i "!PKG!"=="python-dateutil" set "IMPORTNAME=dateutil"
                %PYCMD% -c "import importlib.util,sys; sys.exit(0 if importlib.util.find_spec('!IMPORTNAME!') else 1)" >nul 2>&1
                if !errorlevel! EQU 0 (
                    call :ok "Thu vien: !PKG!"
                ) else (
                    call :err "Thieu thu vien: !PKG!  (chay lai 01_CAI_DAT_CONG_CU.bat)"
                )
            )
        )
    ) else (
        call :warn "Khong tim thay requirements.txt"
    )
) else (
    call :warn "Bo qua kiem tra thu vien vi khong co Python."
)

REM ---------------------------------------------------------------------------
REM  5. Cac thu muc can thiet
REM ---------------------------------------------------------------------------
echo.
echo  --- Kiem tra thu muc ---
for %%D in (input output scripts logs templates) do (
    if exist "%ROOT%\%%D\" (
        call :ok "Thu muc: %%D"
    ) else (
        call :warn "Thieu thu muc: %%D (chay 01_CAI_DAT_CONG_CU.bat de tao)"
    )
)

REM ---------------------------------------------------------------------------
REM  6. Quyen ghi vao thu muc output (tao roi xoa file kiem tra tam)
REM     KHONG dung toi du lieu that cua nguoi dung
REM ---------------------------------------------------------------------------
echo.
echo  --- Kiem tra quyen ghi thu muc output ---
if not exist "%ROOT%\output\" mkdir "%ROOT%\output" >nul 2>&1
set "TESTFILE=%ROOT%\output\_kiemtra_ghi_%RANDOM%.tmp"
> "%TESTFILE%" echo test >nul 2>&1
if exist "%TESTFILE%" (
    del "%TESTFILE%" >nul 2>&1
    if not exist "%TESTFILE%" (
        call :ok "Co the tao va xoa file trong output"
    ) else (
        call :warn "Tao duoc file nhung KHONG xoa duoc trong output"
    )
) else (
    call :err "KHONG the ghi file vao thu muc output (kiem tra quyen)"
)

REM ---------------------------------------------------------------------------
REM  TONG KET
REM ---------------------------------------------------------------------------
call :log "KET THUC KIEM TRA - Loi: %ERRCOUNT%, Canh bao: %WARNCOUNT%"
echo.
echo ============================================================
if "%ERRCOUNT%"=="0" (
    echo    KET QUA: MOI TRUONG SAN SANG  ^(Canh bao: %WARNCOUNT%^)
) else (
    echo    KET QUA: CO %ERRCOUNT% LOI, %WARNCOUNT% CANH BAO
    echo    Hay chay 01_CAI_DAT_CONG_CU.bat de khac phuc.
)
echo    Chi tiet: logs\environment_check.log
echo ============================================================
echo.
echo Nhan phim bat ky de dong...
pause >nul
exit /b 0

REM ============================================================================
REM  HAM PHU
REM ============================================================================
:log
echo [%date% %time%] %~1>> "%LOGFILE%"
exit /b 0

:ok
echo [OK] %~1
call :log "[OK] %~1"
exit /b 0

:warn
echo [CANH BAO] %~1
set /a WARNCOUNT+=1
call :log "[CANH BAO] %~1"
exit /b 0

:err
echo [LOI] %~1
set /a ERRCOUNT+=1
call :log "[LOI] %~1"
exit /b 0

:find_code
set "CODE_CMD="
for /f "delims=" %%I in ('where code 2^>nul') do (
    if not defined CODE_CMD set "CODE_CMD=%%I"
)
if defined CODE_CMD exit /b 0
if exist "%LOCALAPPDATA%\Programs\Microsoft VS Code\bin\code.cmd" set "CODE_CMD=%LOCALAPPDATA%\Programs\Microsoft VS Code\bin\code.cmd"
if defined CODE_CMD exit /b 0
if exist "%ProgramFiles%\Microsoft VS Code\bin\code.cmd" set "CODE_CMD=%ProgramFiles%\Microsoft VS Code\bin\code.cmd"
if defined CODE_CMD exit /b 0
if exist "%ProgramFiles(x86)%\Microsoft VS Code\bin\code.cmd" set "CODE_CMD=%ProgramFiles(x86)%\Microsoft VS Code\bin\code.cmd"
exit /b 0
