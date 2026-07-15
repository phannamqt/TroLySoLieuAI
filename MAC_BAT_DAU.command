#!/bin/bash
# ============================================================================
#  MAC_BAT_DAU.command  -  ĐIỂM KHỞI ĐỘNG CHO macOS
#  Dự án: Trợ Lý Số Liệu AI
#
#  Bấm đúp file này để mở MENU (cài đặt / kiểm tra / mở công cụ).
#  (Nếu bị chặn lần đầu: chuột phải file -> Open -> Open.)
#  File chỉ gọi lại menu thật trong thư mục macos/.
# ============================================================================

DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -f "$DIR/macos/BAT_DAU.command" ]; then
    exec bash "$DIR/macos/BAT_DAU.command"
else
    echo "[LỖI] Không tìm thấy macos/BAT_DAU.command"
    echo "      Hãy bảo đảm bạn giải nén đầy đủ thư mục dự án."
    echo
    read -n 1 -s -r -p "Nhấn phím bất kỳ để đóng..."
    echo
fi
