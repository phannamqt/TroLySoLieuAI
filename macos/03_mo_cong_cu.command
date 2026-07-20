#!/bin/bash
# ============================================================================
#  03_mo_cong_cu.command  -  Mở dự án Trợ Lý Số Liệu AI bằng VS Code (macOS)
#  Hỗ trợ đường dẫn có khoảng trắng, không giả định vị trí cài đặt.
# ============================================================================

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# --- Tìm lệnh 'code' của VS Code ---
CODE_CMD=""
if command -v code >/dev/null 2>&1; then
    CODE_CMD="$(command -v code)"
elif [ -x "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" ]; then
    CODE_CMD="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
elif [ -x "$HOME/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" ]; then
    CODE_CMD="$HOME/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
fi

clear
# --- Nếu chưa có VS Code thì hướng dẫn cài ---
if [ -z "$CODE_CMD" ]; then
    echo "============================================================"
    echo "   CHƯA TÌM THẤY VISUAL STUDIO CODE"
    echo "============================================================"
    echo
    echo "  Bạn cần cài đặt công cụ trước."
    echo "  Hãy chạy file: macos/01_cai_dat.command"
    echo "  (Nếu bị macOS chặn: chuột phải vào file -> Open)"
    echo
    echo "============================================================"
    echo
    read -n 1 -s -r -p "Nhấn phím bất kỳ để đóng..."
    echo
    exit 1
fi

# --- Mở toàn bộ project bằng VS Code ---
"$CODE_CMD" "$ROOT"

# --- Hiển thị hướng dẫn ngắn ---
echo "============================================================"
echo "   TRỢ LÝ SỐ LIỆU AI - ĐÃ MỞ TRONG VS CODE"
echo "   Script created by Phan Nam  -  Version 1.0.0"
echo "============================================================"
echo
echo "  Bước 1: Bỏ file Excel vào thư mục file_can_xu_ly."
echo "  Bước 2: Mở Codex trong VS Code."
echo "  Bước 3: Mở file PROMPT_MAU.md."
echo "  Bước 4: Copy prompt mẫu và sửa yêu cầu."
echo "  Bước 5: Kết quả sẽ nằm trong thư mục file_da_xu_ly."
echo
echo "============================================================"
echo
read -n 1 -s -r -p "Nhấn phím bất kỳ để đóng cửa sổ này (VS Code vẫn mở)..."
echo
exit 0
