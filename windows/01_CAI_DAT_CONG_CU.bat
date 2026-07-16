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

REM --- Xac dinh thu muc: SCRIPT_DIR = windows\, ROOT = thu muc du an (cha) ---
set "SCRIPT_DIR=%~dp0"
for %%I in ("%~dp0..") do set "ROOT=%%~fI"
cd /d "%ROOT%"
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
call :find_winget
if not defined WINGET (
    call :warn "Chua co winget. Dang thu tu dong cai App Installer (can Internet)..."
    echo [DANG CAI] App Installer / winget...
    call :install_winget
    call :find_winget
)
if defined WINGET (
    set "USE_WINGET=1"
    call :ok "Da co winget"
) else (
    set "USE_WINGET=0"
    call :warn "Khong dung duoc winget. Se CAI TRUC TIEP bang bo cai chinh thuc (tai ve)."
)

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
    call :log "Cai Python"
    echo [DANG CAI] Python... ^(co the mat vai phut^)
    call :ensure_python
    if !errorlevel! NEQ 0 (
        call :err "Cai Python that bai o BUOC 2. Xem logs\install.log"
        call :pause_end
        exit /b 1
    )
    call :ok "Da cai Python ^(can mo lai cua so de cap nhat PATH^)"
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
    call :log "Cai VS Code"
    echo [DANG CAI] Visual Studio Code...
    call :ensure_vscode
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

    echo [DANG CAI] Extension Python ^(Microsoft^)...
    call "%CODE_CMD%" --install-extension ms-python.python --force >> "%LOGFILE%" 2>&1
    if !errorlevel! EQU 0 (call :ok "Extension Python") else (call :warn "Khong cai duoc extension Python")

    echo [DANG CAI] Extension Pylance...
    call "%CODE_CMD%" --install-extension ms-python.vscode-pylance --force >> "%LOGFILE%" 2>&1
    if !errorlevel! EQU 0 (call :ok "Extension Pylance") else (call :warn "Khong cai duoc Pylance")

    echo [DANG CAI] Extension Jupyter...
    call "%CODE_CMD%" --install-extension ms-toolsai.jupyter --force >> "%LOGFILE%" 2>&1
    if !errorlevel! EQU 0 (call :ok "Extension Jupyter") else (call :warn "Khong cai duoc Jupyter")

    REM --------------------------------------------------------------------
    REM  CAC EXTENSION TRO LY AI (chi CAI, KHONG dang nhap tu dong).
    REM  ID da xac minh tren Visual Studio Marketplace:
    REM    - OpenAI Codex   : openai.chatgpt
    REM    - Claude Code    : anthropic.claude-code
    REM    - GitHub Copilot : GitHub.copilot (+ GitHub.copilot-chat)
    REM  Viec dang nhap tai khoan do NGUOI DUNG tu lam trong VS Code.
    REM --------------------------------------------------------------------
    call :log "Cai extension tro ly AI (Codex, Claude Code, Copilot)"

    echo [DANG CAI] Extension OpenAI Codex...
    call "%CODE_CMD%" --install-extension openai.chatgpt --force >> "%LOGFILE%" 2>&1
    if !errorlevel! EQU 0 (call :ok "Extension OpenAI Codex") else (call :warn "Khong cai duoc Codex - co the cai tay: tim 'Codex' trong Extensions")

    echo [DANG CAI] Extension Claude Code...
    call "%CODE_CMD%" --install-extension anthropic.claude-code --force >> "%LOGFILE%" 2>&1
    if !errorlevel! EQU 0 (call :ok "Extension Claude Code") else (call :warn "Khong cai duoc Claude Code - co the cai tay: tim 'Claude Code' trong Extensions")

    echo [DANG CAI] Extension GitHub Copilot...
    call "%CODE_CMD%" --install-extension GitHub.copilot --force >> "%LOGFILE%" 2>&1
    if !errorlevel! EQU 0 (call :ok "Extension GitHub Copilot") else (call :warn "Khong cai duoc Copilot - co the cai tay: tim 'GitHub Copilot' trong Extensions")

    echo [DANG CAI] Extension GitHub Copilot Chat...
    call "%CODE_CMD%" --install-extension GitHub.copilot-chat --force >> "%LOGFILE%" 2>&1
    if !errorlevel! EQU 0 (call :ok "Extension GitHub Copilot Chat") else (call :warn "Khong cai duoc Copilot Chat")

    echo.
    echo [LUU Y] Cac extension AI da duoc CAI nhung CHUA dang nhap.
    echo    Ban se tu dang nhap trong VS Code khi dung ^(khong luu tai khoan trong bo cai^).
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
    echo [DANG CAI] Thu vien Python xu ly Excel... ^(co the mat vai phut^)
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
set "TARGET=%SCRIPT_DIR%03_MO_CONG_CU_AI.cmd"
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
echo  CAC TRO LY AI DA CAI SAN (chua dang nhap):
echo    - OpenAI Codex      (openai.chatgpt)
echo    - Claude Code       (anthropic.claude-code)
echo    - GitHub Copilot    (GitHub.copilot)
echo.
echo  BUOC TIEP THEO - DANG NHAP (tu lam trong VS Code):
echo    1. Mo VS Code (da mo san).
echo    2. Bam bieu tuong tro ly AI ban muon dung o thanh ben trai.
echo    3. Chon Sign in / Dang nhap.
echo    4. Dang nhap bang TAI KHOAN CONG TY CAP cho ban.
echo    (Bo cai KHONG luu tai khoan/mat khau/token cua ban.)
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

:find_winget
REM Luon goi winget bang TEN (qua PATH), KHONG goi bang duong dan day du:
REM winget.exe trong WindowsApps la App Execution Alias, chay bang duong dan
REM se bao loi "The system cannot execute the specified program".
REM Kiem tra bang cach CHAY THU 'winget --version' (khong chi 'where'):
REM neu alias bi hong thi khong dat WINGET, se roi xuong cai truc tiep.
set "WINGET="
winget --version >nul 2>&1 && set "WINGET=winget"
if defined WINGET exit /b 0
REM Neu chua co tren PATH nhung ton tai trong WindowsApps: them vao PATH roi thu lai
if exist "%LOCALAPPDATA%\Microsoft\WindowsApps\winget.exe" (
    set "PATH=%PATH%;%LOCALAPPDATA%\Microsoft\WindowsApps"
    winget --version >nul 2>&1 && set "WINGET=winget"
)
exit /b 0

:install_winget
REM Thu tu dong cai App Installer (winget). Best-effort, khong dam bao 100%%.
REM Thu 1: dang ky lai goi App Installer neu da co san tren may
call :log "Thu dang ky lai App Installer"
powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Add-AppxPackage -RegisterByFamilyName -MainPackage 'Microsoft.DesktopAppInstaller_8wekyb3d8bbwe' -ErrorAction Stop } catch { exit 1 }" >> "%LOGFILE%" 2>&1
call :find_winget
if defined WINGET exit /b 0
REM Thu 2: tai thu vien phu VCLibs + App Installer tu Microsoft roi cai
call :log "Tai VCLibs va App Installer tu Microsoft"
powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; try { $t=$env:TEMP; $vc=Join-Path $t 'VCLibs.appx'; Invoke-WebRequest 'https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx' -OutFile $vc -UseBasicParsing; Add-AppxPackage -Path $vc -ErrorAction SilentlyContinue; $o=Join-Path $t 'AppInstaller.msixbundle'; Invoke-WebRequest 'https://aka.ms/getwinget' -OutFile $o -UseBasicParsing; Add-AppxPackage -Path $o -ErrorAction Stop } catch { exit 1 }" >> "%LOGFILE%" 2>&1
exit /b 0

:ensure_python
REM Thu cai Python bang winget; neu that bai vi bat ky ly do nao thi tai truc tiep
if "%USE_WINGET%"=="1" (
    call :winget_python
    if !errorlevel! EQU 0 exit /b 0
    call :warn "winget cai Python khong duoc, chuyen sang tai truc tiep tu python.org..."
)
call :download_python
exit /b %errorlevel%

:ensure_vscode
REM Thu cai VS Code bang winget; neu that bai thi tai truc tiep
if "%USE_WINGET%"=="1" (
    call :winget_vscode
    if !errorlevel! EQU 0 exit /b 0
    call :warn "winget cai VS Code khong duoc, chuyen sang tai truc tiep tu Microsoft..."
)
call :download_vscode
exit /b %errorlevel%

:winget_python
REM Cai Python bang winget (goi bang ten, khong dung duong dan)
%WINGET% install -e --id Python.Python.3.12 --scope machine --silent --accept-package-agreements --accept-source-agreements --override "/quiet PrependPath=1 Include_pip=1 Include_launcher=1" >> "%LOGFILE%" 2>&1
exit /b %errorlevel%

:winget_vscode
REM Cai VS Code bang winget (goi bang ten, khong dung duong dan)
%WINGET% install -e --id Microsoft.VisualStudioCode --scope machine --silent --accept-package-agreements --accept-source-agreements --override "/VERYSILENT /NORESTART /MERGETASKS=addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath" >> "%LOGFILE%" 2>&1
exit /b %errorlevel%

:download_python
REM Cai Python truc tiep tu python.org (khong can winget)
call :log "Tai Python truc tiep tu python.org"
set "PYURL=https://www.python.org/ftp/python/3.12.10/python-3.12.10-amd64.exe"
set "PYEXE=%TEMP%\python-3.12.10-amd64.exe"
powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; try { Invoke-WebRequest '%PYURL%' -OutFile '%PYEXE%' -UseBasicParsing } catch { exit 1 }" >> "%LOGFILE%" 2>&1
if not exist "%PYEXE%" exit /b 1
start "" /wait "%PYEXE%" /quiet PrependPath=1 Include_pip=1 Include_launcher=1
exit /b %errorlevel%

:download_vscode
REM Cai VS Code truc tiep tu Microsoft (khong can winget)
call :log "Tai VS Code truc tiep tu Microsoft"
set "VSURL=https://update.code.visualstudio.com/latest/win32-x64/stable"
set "VSEXE=%TEMP%\vscode-system-setup.exe"
powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; try { Invoke-WebRequest '%VSURL%' -OutFile '%VSEXE%' -UseBasicParsing } catch { exit 1 }" >> "%LOGFILE%" 2>&1
if not exist "%VSEXE%" exit /b 1
start "" /wait "%VSEXE%" /VERYSILENT /NORESTART /MERGETASKS=addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath
exit /b %errorlevel%
