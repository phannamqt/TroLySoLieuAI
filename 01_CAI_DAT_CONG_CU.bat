@echo off
REM ============================================================================
REM  01_CAI_DAT_CONG_CU.bat
REM  Bo cai dat tu dong cho du an Tro Ly So Lieu AI
REM  Danh cho nhan vien khong biet lap trinh (Windows 10 / 11)
REM
REM  GHI CHU KY THUAT (cho nguoi bao tri):
REM  - File dung tieng Viet KHONG DAU de tranh loi encoding tren cmd.exe
REM  - Duong dan lay theo %~dp0 (thu muc chua file .bat), ho tro khoang trang
REM  - Ghi log vao logs\install.log
REM  - Khong luu tai khoan / mat khau / API key / token trong source code
REM ============================================================================

setlocal EnableExtensions EnableDelayedExpansion

REM --- Chuyen ve dung thu muc du an (ho tro duong dan co khoang trang) ---
cd /d "%~dp0"

REM --- Cac bien duong dan chinh ---
set "ROOT=%~dp0"
if "%ROOT:~-1%"=="\" set "ROOT=%ROOT:~0,-1%"
set "LOGDIR=%ROOT%\logs"
set "LOGFILE=%LOGDIR%\install.log"

REM ============================================================================
REM  BUOC 0: Kiem tra quyen Administrator, tu nang quyen neu can
REM ============================================================================
net session >nul 2>&1
if %errorlevel% NEQ 0 (
    echo.
    echo [THONG BAO] Dang xin quyen Administrator de cai dat...
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

REM --- Tao thu muc logs som de co cho ghi log ---
if not exist "%LOGDIR%" mkdir "%LOGDIR%" >nul 2>&1

echo ============================================================ >> "%LOGFILE%"
call :log "BAT DAU CAI DAT Tro Ly So Lieu AI"
call :log "Thu muc du an: %ROOT%"

title Tro Ly So Lieu AI - Cai dat cong cu
color 0B
echo.
echo ============================================================
echo    TRO LY SO LIEU AI - CAI DAT CONG CU TU DONG
echo    Script created by Phan Nam  -  Version 1.0.0
echo ============================================================
echo.
echo  Qua trinh nay se:
echo    - Cai Python
echo    - Cai Visual Studio Code
echo    - Cai cac extension can thiet
echo    - Cai thu vien Python xu ly Excel
echo.
echo  Vui long KHONG dong cua so nay cho den khi hoan tat.
echo ============================================================
echo.

REM ============================================================================
REM  BUOC 1: Kiem tra winget (App Installer)
REM ============================================================================
call :log "Kiem tra winget"
where winget >nul 2>&1
if %errorlevel% NEQ 0 (
    call :err "Khong tim thay 'winget' (App Installer) tren may nay."
    echo.
    echo  HUONG DAN KHAC PHUC:
    echo    1. Mo Microsoft Store.
    echo    2. Tim: App Installer
    echo    3. Cai / cap nhat App Installer roi chay lai file nay.
    echo    Hoac tai tai: https://aka.ms/getwinget
    echo.
    call :pause_end
    exit /b 1
)
call :ok "Da co winget"

REM ============================================================================
REM  BUOC 2: Cai Python neu chua co
REM ============================================================================
call :log "Kiem tra Python"
set "PYOK=0"
python --version >nul 2>&1 && set "PYOK=1"
if "%PYOK%"=="0" ( py --version >nul 2>&1 && set "PYOK=1" )

if "%PYOK%"=="1" (
    call :ok "Python da duoc cai"
) else (
    call :log "Cai Python bang winget"
    echo [DANG CAI] Python... (co the mat vai phut)
    REM PrependPath=1 bao dam Python duoc them vao PATH
    winget install -e --id Python.Python.3.12 --scope machine --silent ^
        --accept-package-agreements --accept-source-agreements ^
        --override "/quiet PrependPath=1 Include_pip=1 Include_launcher=1" >> "%LOGFILE%" 2>&1
    if !errorlevel! NEQ 0 (
        call :err "Cai Python that bai o BUOC 2. Xem logs\install.log"
        call :pause_end
        exit /b 1
    )
    call :ok "Da cai Python (can mo lai cua so de cap nhat PATH)"
    REM Nap lai PATH cho phien hien tai
    call :refresh_path
)

REM ============================================================================
REM  BUOC 3: Cai VS Code neu chua co
REM ============================================================================
call :log "Kiem tra VS Code"
call :find_code
if defined CODE_CMD (
    call :ok "VS Code da duoc cai"
) else (
    call :log "Cai VS Code bang winget"
    echo [DANG CAI] Visual Studio Code...
    winget install -e --id Microsoft.VisualStudioCode --scope machine --silent ^
        --accept-package-agreements --accept-source-agreements ^
        --override "/VERYSILENT /NORESTART /MERGETASKS=!runcode,addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath" >> "%LOGFILE%" 2>&1
    if !errorlevel! NEQ 0 (
        call :err "Cai VS Code that bai o BUOC 3. Xem logs\install.log"
        call :pause_end
        exit /b 1
    )
    call :ok "Da cai VS Code"
    call :refresh_path
    call :find_code
)

if not defined CODE_CMD (
    call :warn "Chua tim thay lenh 'code'. Co the can DONG CUA SO va chay lai file nay de PATH cap nhat."
)

REM ============================================================================
REM  BUOC 4: Cai cac extension cho VS Code
REM ============================================================================
if defined CODE_CMD (
    call :log "Cai extension VS Code"

    echo [DANG CAI] Extension Python (Microsoft)...
    call "%CODE_CMD%" --install-extension ms-python.python --force >> "%LOGFILE%" 2>&1
    if !errorlevel! EQU 0 (call :ok "Extension Python") else (call :warn "Khong cai duoc extension Python")

    echo [DANG CAI] Extension Pylance...
    call "%CODE_CMD%" --install-extension ms-python.vscode-pylance --force >> "%LOGFILE%" 2>&1
    if !errorlevel! EQU 0 (call :ok "Extension Pylance") else (call :warn "Khong cai duoc Pylance")

    echo [DANG CAI] Extension Jupyter...
    call "%CODE_CMD%" --install-extension ms-toolsai.jupyter --force >> "%LOGFILE%" 2>&1
    if !errorlevel! EQU 0 (call :ok "Extension Jupyter") else (call :warn "Khong cai duoc Jupyter")

    REM --------------------------------------------------------------------
    REM  EXTENSION OPENAI CODEX:
    REM  Vi extension ID chinh thuc co the thay doi, KHONG tu bia ID.
    REM  Se mo trang Extensions de nguoi dung tu tim tu khoa "Codex".
    REM --------------------------------------------------------------------
    call :log "Huong dan cai extension Codex thu cong (khong bia ID)"
    echo.
    echo [LUU Y] Extension OpenAI Codex:
    echo    Vi ID extension co the thay doi theo thoi gian, bo cai KHONG
    echo    tu dong cai Codex de tranh cai nham. Se mo VS Code Extensions
    echo    de ban tu tim va cai.
    echo    - Nhan Ctrl+Shift+X trong VS Code
    echo    - Go tu khoa: Codex
    echo    - Chon extension chinh thuc cua OpenAI roi bam Install
    echo.
) else (
    call :warn "Bo qua cai extension vi chua co lenh 'code'."
)

REM ============================================================================
REM  BUOC 5: Cap nhat pip va cai thu vien tu requirements.txt
REM ============================================================================
call :log "Cap nhat pip"
echo [DANG CHAY] Cap nhat pip...
call :run_python -m pip install --upgrade pip >> "%LOGFILE%" 2>&1
if !errorlevel! EQU 0 (call :ok "Da cap nhat pip") else (call :warn "Khong cap nhat duoc pip (se thu tiep)")

if exist "%ROOT%\requirements.txt" (
    call :log "Cai thu vien tu requirements.txt"
    echo [DANG CAI] Thu vien Python xu ly Excel... (co the mat vai phut)
    call :run_python -m pip install -r "%ROOT%\requirements.txt" >> "%LOGFILE%" 2>&1
    if !errorlevel! EQU 0 (
        call :ok "Da cai thu vien Python"
    ) else (
        call :err "Cai thu vien that bai o BUOC 5. Xem logs\install.log"
        call :pause_end
        exit /b 1
    )
) else (
    call :warn "Khong tim thay requirements.txt - bo qua buoc cai thu vien"
)

REM ============================================================================
REM  BUOC 6: Tao cac thu muc lam viec neu chua co
REM ============================================================================
call :log "Tao thu muc lam viec"
for %%D in (input output scripts logs templates) do (
    if not exist "%ROOT%\%%D" (
        mkdir "%ROOT%\%%D" >nul 2>&1
        call :ok "Da tao thu muc %%D"
    )
)

REM ============================================================================
REM  BUOC 7: Tao shortcut tren Desktop tro toi 03_MO_CONG_CU_AI.cmd
REM ============================================================================
call :log "Tao shortcut Desktop"
set "TARGET=%ROOT%\03_MO_CONG_CU_AI.cmd"
if exist "%TARGET%" (
    powershell -NoProfile -Command ^
      "$ws = New-Object -ComObject WScript.Shell;" ^
      "$lnk = $ws.CreateShortcut([IO.Path]::Combine($ws.SpecialFolders('Desktop'),'Excel AI Starter.lnk'));" ^
      "$lnk.TargetPath = '%TARGET%';" ^
      "$lnk.WorkingDirectory = '%ROOT%';" ^
      "$lnk.IconLocation = 'shell32.dll,43';" ^
      "$lnk.Description = 'Mo cong cu Excel AI Starter';" ^
      "$lnk.Save()" >> "%LOGFILE%" 2>&1
    if !errorlevel! EQU 0 (call :ok "Da tao shortcut tren Desktop") else (call :warn "Khong tao duoc shortcut Desktop")
) else (
    call :warn "Chua thay 03_MO_CONG_CU_AI.cmd - bo qua tao shortcut"
)

REM ============================================================================
REM  BUOC 8: Mo project bang VS Code (neu co)
REM ============================================================================
if defined CODE_CMD (
    call :log "Mo project bang VS Code"
    call "%CODE_CMD%" "%ROOT%" >nul 2>&1
    call :ok "Da mo project trong VS Code"
)

REM ============================================================================
REM  HOAN TAT
REM ============================================================================
call :log "CAI DAT HOAN TAT"
color 0A
echo.
echo ============================================================
echo    CAI DAT HOAN TAT!
echo ============================================================
echo.
echo  BUOC TIEP THEO - DANG NHAP CODEX:
echo    1. Mo VS Code (da mo san).
echo    2. Nhan Ctrl+Shift+X de mo Extensions.
echo    3. Tim "Codex", cai extension chinh thuc cua OpenAI.
echo    4. Bam bieu tuong Codex, chon Sign in.
echo    5. Dang nhap bang TAI KHOAN CONG TY CAP cho ban.
echo.
echo  CACH DUNG HANG NGAY:
echo    - Bo file Excel vao thu muc: input
echo    - Chay: 03_MO_CONG_CU_AI.cmd  (hoac shortcut tren Desktop)
echo    - Mo file PROMPT_MAU.md de lay prompt mau
echo    - Ket qua se nam trong thu muc: output
echo.
echo  Log cai dat: logs\install.log
echo ============================================================
echo.
call :pause_end
exit /b 0

REM ============================================================================
REM  ======================  CAC HAM PHU (SUBROUTINES)  =======================
REM ============================================================================

:log
REM Ghi mot dong log kem thoi gian
echo [%date% %time%] %~1>> "%LOGFILE%"
exit /b 0

:ok
echo [OK] %~1
call :log "[OK] %~1"
exit /b 0

:warn
echo [CANH BAO] %~1
call :log "[CANH BAO] %~1"
exit /b 0

:err
echo.
echo [LOI] %~1
call :log "[LOI] %~1"
exit /b 0

:pause_end
REM Khong dong cua so ngay khi co loi - cho nguoi dung doc
echo.
echo Nhan phim bat ky de dong cua so...
pause >nul
exit /b 0

:refresh_path
REM Nap lai bien PATH may + nguoi dung vao phien hien tai (khong can mo lai cmd)
for /f "usebackq tokens=2,*" %%A in (`reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path 2^>nul ^| findstr /i "Path"`) do set "SYSPATH=%%B"
for /f "usebackq tokens=2,*" %%A in (`reg query "HKCU\Environment" /v Path 2^>nul ^| findstr /i "Path"`) do set "USRPATH=%%B"
if defined SYSPATH set "PATH=%SYSPATH%"
if defined USRPATH set "PATH=%PATH%;%USRPATH%"
exit /b 0

:find_code
REM Tim lenh 'code' (VS Code CLI). Dat ket qua vao bien CODE_CMD
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

:run_python
REM Chay Python bang 'python' neu co, neu khong dung 'py'
python --version >nul 2>&1
if %errorlevel% EQU 0 (
    python %*
    exit /b %errorlevel%
)
py --version >nul 2>&1
if %errorlevel% EQU 0 (
    py %*
    exit /b %errorlevel%
)
call :err "Khong tim thay Python de chay lenh pip. Hay dong va mo lai file cai dat."
exit /b 1
