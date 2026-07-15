#!/bin/bash
# ============================================================================
#  04_go_cai_dat.command  -  Gỡ cài đặt riêng của dự án (macOS)
#  Dự án: Trợ Lý Số Liệu AI
#
#  NGUYÊN TẮC AN TOÀN:
#   - KHÔNG tự gỡ Homebrew, Python hay VS Code.
#   - KHÔNG xóa input / output khi chưa có xác nhận rõ ràng.
#   - Luôn cảnh báo sao lưu dữ liệu trước khi xóa.
# ============================================================================

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

clear
echo "============================================================"
echo "   TRỢ LÝ SỐ LIỆU AI - GỠ CÀI ĐẶT (macOS)"
echo "   Script created by Phan Nam  -  Version 1.0.0"
echo "============================================================"
echo
echo "  CẢNH BÁO QUAN TRỌNG:"
echo "    - Hãy SAO LƯU (backup) dữ liệu trong input và output"
echo "      TRƯỚC KHI tiếp tục."
echo "    - Công cụ này KHÔNG gỡ Homebrew, Python, VS Code."
echo "    - Chỉ xóa những gì bạn đồng ý bên dưới."
echo "============================================================"
echo

# --- 1. Xóa shortcut trên Desktop ---
LNK="$HOME/Desktop/Tro Ly So Lieu AI.command"
if [ -f "$LNK" ]; then
    rm -f "$LNK" && echo "[OK] Đã xóa shortcut trên Desktop." \
                  || echo "[CẢNH BÁO] Không xóa được shortcut trên Desktop."
else
    echo "[OK] Không có shortcut trên Desktop (bỏ qua)."
fi
echo

# --- 2. Hỏi xóa môi trường ảo .venv ---
VENV="$ROOT/.venv"
if [ -d "$VENV" ]; then
    echo "Tìm thấy môi trường ảo Python: $VENV"
    read -r -p "Bạn có muốn XÓA môi trường ảo này không? (gõ YES để xóa): " ANS1
    if [ "$ANS1" = "YES" ]; then
        rm -rf "$VENV" && echo "[OK] Đã xóa môi trường ảo .venv." \
                       || echo "[CẢNH BÁO] Không xóa được môi trường ảo."
    else
        echo "[BỎ QUA] Giữ lại môi trường ảo .venv."
    fi
else
    echo "[OK] Không tìm thấy môi trường ảo .venv - bỏ qua."
fi
echo

# --- 3. Hỏi xóa toàn bộ thư mục dự án (gồm input/output) ---
echo "------------------------------------------------------------"
echo "  XÓA TOÀN BỘ THƯ MỤC DỰ ÁN"
echo "  Thư mục: $ROOT"
echo "  Việc này sẽ xóa CẢ dữ liệu trong input và output."
echo "------------------------------------------------------------"
echo
echo "  Nếu chắc chắn, hãy gõ đúng: XOA TAT CA"
read -r -p "Xác nhận: " ANS2
if [ "$ANS2" = "XOA TAT CA" ]; then
    echo
    echo "  Xác nhận lần cuối. Dữ liệu sẽ KHÔNG thể khôi phục."
    read -r -p "Gõ lại XOA TAT CA để đồng ý: " ANS3
    if [ "$ANS3" = "XOA TAT CA" ]; then
        TARGET="$ROOT"
        cd "$HOME" || cd /
        echo "[ĐANG XÓA] Toàn bộ thư mục dự án..."
        rm -rf "$TARGET" \
            && { echo "[OK] Đã xóa thư mục dự án."; exit 0; } \
            || echo "[CẢNH BÁO] Không xóa được thư mục dự án."
    else
        echo "[BỎ QUA] Không xóa thư mục dự án (xác nhận không khớp)."
    fi
else
    echo "[BỎ QUA] Không xóa thư mục dự án."
fi

echo
echo "============================================================"
echo "   HOÀN TẤT GỠ CÀI ĐẶT"
echo "============================================================"
echo
echo "  Lưu ý: Homebrew, Python và VS Code vẫn còn trên máy."
echo "  Nếu muốn gỡ, dùng: brew uninstall / brew uninstall --cask ..."
echo
read -n 1 -s -r -p "Nhấn phím bất kỳ để đóng..."
echo
exit 0
