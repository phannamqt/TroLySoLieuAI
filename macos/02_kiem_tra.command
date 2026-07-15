#!/bin/bash
# ============================================================================
#  02_kiem_tra.command  -  Kiểm tra môi trường (macOS)
#  Dự án: Trợ Lý Số Liệu AI
#  KHÔNG thay đổi / xóa dữ liệu thật của người dùng.
#  In kết quả [OK] / [LỖI] / [CẢNH BÁO], ghi vào logs/environment_check.log
# ============================================================================

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
LOGDIR="$ROOT/logs"
LOGFILE="$LOGDIR/environment_check.log"
mkdir -p "$LOGDIR"

ERRCOUNT=0
WARNCOUNT=0

log()  { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOGFILE"; }
ok()   { echo "[OK] $1";       log "[OK] $1"; }
warn() { echo "[CẢNH BÁO] $1"; WARNCOUNT=$((WARNCOUNT+1)); log "[CANH BAO] $1"; }
err()  { echo "[LỖI] $1";      ERRCOUNT=$((ERRCOUNT+1));  log "[LOI] $1"; }

echo "============================================================" >> "$LOGFILE"
log "BẮT ĐẦU KIỂM TRA MÔI TRƯỜNG (macOS)"

clear
echo "============================================================"
echo "   KIỂM TRA MÔI TRƯỜNG - TRỢ LÝ SỐ LIỆU AI (macOS)"
echo "   Script created by Phan Nam  -  Version 1.0.0"
echo "============================================================"
echo

# --- Chọn Python: ưu tiên .venv ---
VENV="$ROOT/.venv"
if [ -x "$VENV/bin/python" ]; then
    PYBIN="$VENV/bin/python"
    ok "Có môi trường ảo .venv"
elif command -v python3 >/dev/null 2>&1; then
    PYBIN="$(command -v python3)"
    warn "Chưa có .venv - dùng python3 hệ thống (nên chạy 01_cai_dat.command)"
else
    PYBIN=""
    err "Không tìm thấy Python. Hãy chạy 01_cai_dat.command"
fi

# --- 1. Python ---
if [ -n "$PYBIN" ]; then
    ok "Python hoạt động: $("$PYBIN" --version 2>&1)"
fi

# --- 2. pip ---
if [ -n "$PYBIN" ]; then
    if "$PYBIN" -m pip --version >/dev/null 2>&1; then
        ok "pip hoạt động: $("$PYBIN" -m pip --version 2>&1)"
    else
        err "pip KHÔNG hoạt động."
    fi
fi

# --- 3. VS Code ---
CODE_CMD=""
if command -v code >/dev/null 2>&1; then
    CODE_CMD="$(command -v code)"
elif [ -x "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" ]; then
    CODE_CMD="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
elif [ -x "$HOME/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" ]; then
    CODE_CMD="$HOME/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
fi
if [ -n "$CODE_CMD" ]; then
    ok "VS Code hoạt động ($CODE_CMD)"
else
    warn "Không tìm thấy lệnh 'code'. Có thể cần cài lại VS Code."
fi

# --- 4. Thư viện Python trong requirements.txt ---
if [ -n "$PYBIN" ] && [ -f "$ROOT/requirements.txt" ]; then
    echo
    echo " --- Kiểm tra thư viện Python ---"
    while IFS= read -r line || [ -n "$line" ]; do
        # Bỏ comment và khoảng trắng
        line="${line%%#*}"
        pkg="$(echo "$line" | tr -d '[:space:]' | sed 's/[<>=~!].*//')"
        [ -z "$pkg" ] && continue
        importname="$pkg"
        [ "$pkg" = "python-dateutil" ] && importname="dateutil"
        if "$PYBIN" -c "import importlib.util,sys; sys.exit(0 if importlib.util.find_spec('$importname') else 1)" >/dev/null 2>&1; then
            ok "Thư viện: $pkg"
        else
            err "Thiếu thư viện: $pkg  (chạy lại 01_cai_dat.command)"
        fi
    done < "$ROOT/requirements.txt"
else
    warn "Bỏ qua kiểm tra thư viện (thiếu Python hoặc requirements.txt)."
fi

# --- 5. Các thư mục cần thiết ---
echo
echo " --- Kiểm tra thư mục ---"
for d in input output scripts logs templates; do
    if [ -d "$ROOT/$d" ]; then
        ok "Thư mục: $d"
    else
        warn "Thiếu thư mục: $d (chạy 01_cai_dat.command để tạo)"
    fi
done

# --- 6. Quyền ghi vào output (tạo rồi xóa file kiểm tra tạm) ---
echo
echo " --- Kiểm tra quyền ghi thư mục output ---"
mkdir -p "$ROOT/output"
TESTFILE="$ROOT/output/_kiemtra_ghi_$$_$RANDOM.tmp"
if echo "test" > "$TESTFILE" 2>/dev/null; then
    if rm -f "$TESTFILE" 2>/dev/null; then
        ok "Có thể tạo và xóa file trong output"
    else
        warn "Tạo được file nhưng KHÔNG xóa được trong output"
    fi
else
    err "KHÔNG thể ghi file vào thư mục output (kiểm tra quyền)"
fi

# --- Tổng kết ---
log "KẾT THÚC KIỂM TRA - Lỗi: $ERRCOUNT, Cảnh báo: $WARNCOUNT"
echo
echo "============================================================"
if [ "$ERRCOUNT" -eq 0 ]; then
    echo "   KẾT QUẢ: MÔI TRƯỜNG SẴN SÀNG  (Cảnh báo: $WARNCOUNT)"
else
    echo "   KẾT QUẢ: CÓ $ERRCOUNT LỖI, $WARNCOUNT CẢNH BÁO"
    echo "   Hãy chạy 01_cai_dat.command để khắc phục."
fi
echo "   Chi tiết: logs/environment_check.log"
echo "============================================================"
echo
read -n 1 -s -r -p "Nhấn phím bất kỳ để đóng..."
echo
exit 0
