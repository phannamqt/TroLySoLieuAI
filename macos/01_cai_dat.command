#!/bin/bash
# ============================================================================
#  01_cai_dat.command  -  Bộ cài đặt tự động cho macOS
#  Dự án: Trợ Lý Số Liệu AI
#  Dành cho nhân viên không biết lập trình (macOS Intel & Apple Silicon)
#
#  GHI CHÚ KỸ THUẬT (cho người bảo trì):
#   - Dùng Homebrew để cài Python và VS Code (KHÔNG chạy brew bằng sudo).
#   - Thư viện Python cài vào môi trường ảo .venv trong thư mục dự án
#     (tránh lỗi "externally-managed-environment" của macOS - PEP 668).
#   - Đường dẫn suy ra từ vị trí file .command, hỗ trợ khoảng trắng.
#   - Không lưu tài khoản / mật khẩu / API key / token trong mã nguồn.
# ============================================================================

# --- Xác định thư mục dự án (thư mục cha của macos/) ---
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
LOGDIR="$ROOT/logs"
LOGFILE="$LOGDIR/install.log"
mkdir -p "$LOGDIR"

# --- Các hàm ghi log / thông báo ---
log()  { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOGFILE"; }
ok()   { echo "[OK] $1";        log "[OK] $1"; }
warn() { echo "[CẢNH BÁO] $1";  log "[CANH BAO] $1"; }
err()  { echo "[LỖI] $1";       log "[LOI] $1"; }
pause_end() { echo; read -n 1 -s -r -p "Nhấn phím bất kỳ để đóng cửa sổ..."; echo; }

echo "============================================================" >> "$LOGFILE"
log "BẮT ĐẦU CÀI ĐẶT Trợ Lý Số Liệu AI (macOS)"
log "Thư mục dự án: $ROOT"

clear
echo "============================================================"
echo "   TRỢ LÝ SỐ LIỆU AI - CÀI ĐẶT CÔNG CỤ (macOS)"
echo "   Script created by Phan Nam  -  Version 1.0.0"
echo "============================================================"
echo
echo "  Quá trình này sẽ cài: Homebrew, Python, VS Code,"
echo "  các extension và thư viện Python xử lý Excel."
echo
echo "  Vui lòng KHÔNG đóng cửa sổ cho đến khi hoàn tất."
echo "  (Có thể sẽ hỏi mật khẩu máy khi cài Homebrew.)"
echo "============================================================"
echo

# ----------------------------------------------------------------------------
#  BƯỚC 1: Homebrew
# ----------------------------------------------------------------------------
find_brew() {
    if command -v brew >/dev/null 2>&1; then BREW="$(command -v brew)"; return 0; fi
    if [ -x /opt/homebrew/bin/brew ]; then BREW=/opt/homebrew/bin/brew; return 0; fi
    if [ -x /usr/local/bin/brew ];    then BREW=/usr/local/bin/brew;    return 0; fi
    return 1
}

log "Kiểm tra Homebrew"
if find_brew; then
    ok "Đã có Homebrew: $BREW"
else
    warn "Chưa có Homebrew. Đang cài Homebrew (có thể cần nhập mật khẩu máy)..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" 2>&1 | tee -a "$LOGFILE"
    if ! find_brew; then
        err "Cài Homebrew thất bại ở BƯỚC 1. Xem logs/install.log"
        echo "  Hướng dẫn: xem trang chính thức https://brew.sh"
        pause_end
        exit 1
    fi
    ok "Đã cài Homebrew: $BREW"
fi

# Nạp Homebrew vào phiên hiện tại (Intel: /usr/local, Apple Silicon: /opt/homebrew)
eval "$("$BREW" shellenv)"

# ----------------------------------------------------------------------------
#  BƯỚC 2: Python
# ----------------------------------------------------------------------------
log "Kiểm tra Python"
if command -v python3 >/dev/null 2>&1; then
    ok "Đã có python3: $(python3 --version 2>&1)"
else
    echo "[ĐANG CÀI] Python..."
    if "$BREW" install python >>"$LOGFILE" 2>&1; then
        ok "Đã cài Python"
        eval "$("$BREW" shellenv)"
    else
        err "Cài Python thất bại ở BƯỚC 2. Xem logs/install.log"
        pause_end
        exit 1
    fi
fi

# ----------------------------------------------------------------------------
#  BƯỚC 3: Visual Studio Code
# ----------------------------------------------------------------------------
find_code() {
    CODE_CMD=""
    if command -v code >/dev/null 2>&1; then CODE_CMD="$(command -v code)"; return 0; fi
    local app1="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
    local app2="$HOME/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
    if [ -x "$app1" ]; then CODE_CMD="$app1"; return 0; fi
    if [ -x "$app2" ]; then CODE_CMD="$app2"; return 0; fi
    return 1
}

log "Kiểm tra VS Code"
if find_code; then
    ok "VS Code đã được cài"
else
    echo "[ĐANG CÀI] Visual Studio Code..."
    if "$BREW" install --cask visual-studio-code >>"$LOGFILE" 2>&1; then
        ok "Đã cài VS Code"
    else
        err "Cài VS Code thất bại ở BƯỚC 3. Xem logs/install.log"
        pause_end
        exit 1
    fi
    find_code || warn "Chưa tìm thấy lệnh 'code'. Có thể cần mở lại cửa sổ Terminal."
fi

# ----------------------------------------------------------------------------
#  BƯỚC 4: Cài các extension cho VS Code
# ----------------------------------------------------------------------------
if [ -n "$CODE_CMD" ]; then
    log "Cài extension VS Code"

    echo "[ĐANG CÀI] Extension Python (Microsoft)..."
    "$CODE_CMD" --install-extension ms-python.python --force >>"$LOGFILE" 2>&1 \
        && ok "Extension Python" || warn "Không cài được extension Python"

    echo "[ĐANG CÀI] Extension Pylance..."
    "$CODE_CMD" --install-extension ms-python.vscode-pylance --force >>"$LOGFILE" 2>&1 \
        && ok "Extension Pylance" || warn "Không cài được Pylance"

    echo "[ĐANG CÀI] Extension Jupyter..."
    "$CODE_CMD" --install-extension ms-toolsai.jupyter --force >>"$LOGFILE" 2>&1 \
        && ok "Extension Jupyter" || warn "Không cài được Jupyter"

    # ------------------------------------------------------------------------
    #  CÁC EXTENSION TRỢ LÝ AI (chỉ CÀI, KHÔNG đăng nhập tự động).
    #  ID đã xác minh trên Visual Studio Marketplace:
    #    - OpenAI Codex   : openai.chatgpt
    #    - Claude Code    : anthropic.claude-code
    #    - GitHub Copilot : GitHub.copilot (+ GitHub.copilot-chat)
    #  Việc đăng nhập tài khoản do NGƯỜI DÙNG tự làm trong VS Code.
    # ------------------------------------------------------------------------
    log "Cài extension trợ lý AI (Codex, Claude Code, Copilot)"

    echo "[ĐANG CÀI] Extension OpenAI Codex..."
    "$CODE_CMD" --install-extension openai.chatgpt --force >>"$LOGFILE" 2>&1 \
        && ok "Extension OpenAI Codex" || warn "Không cài được Codex - có thể cài tay: tìm 'Codex' trong Extensions"

    echo "[ĐANG CÀI] Extension Claude Code..."
    "$CODE_CMD" --install-extension anthropic.claude-code --force >>"$LOGFILE" 2>&1 \
        && ok "Extension Claude Code" || warn "Không cài được Claude Code - có thể cài tay: tìm 'Claude Code' trong Extensions"

    echo "[ĐANG CÀI] Extension GitHub Copilot..."
    "$CODE_CMD" --install-extension GitHub.copilot --force >>"$LOGFILE" 2>&1 \
        && ok "Extension GitHub Copilot" || warn "Không cài được Copilot - có thể cài tay: tìm 'GitHub Copilot' trong Extensions"

    echo "[ĐANG CÀI] Extension GitHub Copilot Chat..."
    "$CODE_CMD" --install-extension GitHub.copilot-chat --force >>"$LOGFILE" 2>&1 \
        && ok "Extension GitHub Copilot Chat" || warn "Không cài được Copilot Chat"

    echo
    echo "[LƯU Ý] Các extension AI đã được CÀI nhưng CHƯA đăng nhập."
    echo "   Bạn sẽ tự đăng nhập trong VS Code khi dùng (bộ cài không lưu tài khoản)."
    echo
else
    warn "Bỏ qua cài extension vì chưa có lệnh 'code'."
fi

# ----------------------------------------------------------------------------
#  BƯỚC 5: Tạo môi trường ảo .venv và cài thư viện
# ----------------------------------------------------------------------------
VENV="$ROOT/.venv"
log "Tạo môi trường ảo .venv"
if [ ! -d "$VENV" ]; then
    echo "[ĐANG TẠO] Môi trường ảo Python (.venv)..."
    if python3 -m venv "$VENV" >>"$LOGFILE" 2>&1; then
        ok "Đã tạo môi trường ảo .venv"
    else
        err "Tạo môi trường ảo thất bại ở BƯỚC 5. Xem logs/install.log"
        pause_end
        exit 1
    fi
else
    ok "Đã có môi trường ảo .venv"
fi

PYBIN="$VENV/bin/python"

echo "[ĐANG CHẠY] Cập nhật pip..."
"$PYBIN" -m pip install --upgrade pip >>"$LOGFILE" 2>&1 \
    && ok "Đã cập nhật pip" || warn "Không cập nhật được pip (sẽ thử tiếp)"

if [ -f "$ROOT/requirements.txt" ]; then
    log "Cài thư viện từ requirements.txt"
    echo "[ĐANG CÀI] Thư viện Python xử lý Excel... (có thể mất vài phút)"
    if "$PYBIN" -m pip install -r "$ROOT/requirements.txt" >>"$LOGFILE" 2>&1; then
        ok "Đã cài thư viện Python"
    else
        err "Cài thư viện thất bại ở BƯỚC 5. Xem logs/install.log"
        pause_end
        exit 1
    fi
else
    warn "Không tìm thấy requirements.txt - bỏ qua cài thư viện"
fi

# ----------------------------------------------------------------------------
#  BƯỚC 6: Tạo các thư mục làm việc
# ----------------------------------------------------------------------------
log "Tạo thư mục làm việc"
for d in file_can_xu_ly file_da_xu_ly scripts logs templates; do
    if [ ! -d "$ROOT/$d" ]; then
        mkdir -p "$ROOT/$d" && ok "Đã tạo thư mục $d"
    fi
done

# ----------------------------------------------------------------------------
#  BƯỚC 7: Tạo shortcut trên Desktop
# ----------------------------------------------------------------------------
log "Tạo shortcut Desktop"
SHORTCUT="$HOME/Desktop/Tro Ly So Lieu AI.command"
if [ -f "$SCRIPT_DIR/03_mo_cong_cu.command" ]; then
    cat > "$SHORTCUT" <<EOF
#!/bin/bash
# Shortcut do bộ cài Trợ Lý Số Liệu AI tạo ra
exec "$SCRIPT_DIR/03_mo_cong_cu.command"
EOF
    chmod +x "$SHORTCUT" 2>/dev/null \
        && ok "Đã tạo shortcut trên Desktop" \
        || warn "Không tạo được shortcut Desktop"
else
    warn "Chưa thấy 03_mo_cong_cu.command - bỏ qua tạo shortcut"
fi

# ----------------------------------------------------------------------------
#  BƯỚC 8: Mở project bằng VS Code
# ----------------------------------------------------------------------------
if [ -n "$CODE_CMD" ]; then
    log "Mở project bằng VS Code"
    "$CODE_CMD" "$ROOT" >/dev/null 2>&1 && ok "Đã mở project trong VS Code"
fi

# ----------------------------------------------------------------------------
#  HOÀN TẤT
# ----------------------------------------------------------------------------
log "CÀI ĐẶT HOÀN TẤT"
echo
echo "============================================================"
echo "   CÀI ĐẶT HOÀN TẤT!"
echo "============================================================"
echo
echo "  CÁC TRỢ LÝ AI ĐÃ CÀI SẴN (chưa đăng nhập):"
echo "    - OpenAI Codex      (openai.chatgpt)"
echo "    - Claude Code       (anthropic.claude-code)"
echo "    - GitHub Copilot    (GitHub.copilot)"
echo
echo "  BƯỚC TIẾP THEO - ĐĂNG NHẬP (tự làm trong VS Code):"
echo "    1. Mở VS Code (đã mở sẵn)."
echo "    2. Bấm biểu tượng trợ lý AI bạn muốn dùng ở thanh bên trái."
echo "    3. Chọn Sign in / Đăng nhập."
echo "    4. Đăng nhập bằng TÀI KHOẢN CÔNG TY cấp cho bạn."
echo "    (Bộ cài KHÔNG lưu tài khoản/mật khẩu/token của bạn.)"
echo
echo "  CÁCH DÙNG HÀNG NGÀY:"
echo "    - Bỏ file Excel vào thư mục: file_can_xu_ly"
echo "    - Chạy: macos/03_mo_cong_cu.command (hoặc shortcut trên Desktop)"
echo "    - Mở file PROMPT_MAU.md để lấy prompt mẫu"
echo "    - Kết quả sẽ nằm trong thư mục: file_da_xu_ly"
echo
echo "  Lưu ý: thư viện được cài trong môi trường ảo .venv."
echo "  Trong VS Code, chọn Python Interpreter là .venv nếu được hỏi."
echo "  Log cài đặt: logs/install.log"
echo "============================================================"
pause_end
exit 0
