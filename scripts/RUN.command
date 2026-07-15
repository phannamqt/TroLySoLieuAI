#!/bin/bash
# ============================================================================
#  RUN.command  -  Chạy lại công cụ mẫu "vi_du_doc_excel.py" trên macOS
#  Bấm đúp file này (nếu bị chặn: chuột phải -> Open lần đầu).
#  Dùng Python trong .venv nếu có, nếu không dùng python3 hệ thống.
# ============================================================================

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$ROOT" || exit 1

clear
echo "============================================================"
echo "   ĐANG CHẠY: đọc và mô tả cấu trúc file Excel trong input"
echo "   Script created by Phan Nam  -  Version 1.0.0"
echo "============================================================"
echo

# Chọn Python: ưu tiên môi trường ảo .venv
if [ -x "$ROOT/.venv/bin/python" ]; then
    PYBIN="$ROOT/.venv/bin/python"
elif command -v python3 >/dev/null 2>&1; then
    PYBIN="$(command -v python3)"
else
    echo "[LỖI] Không tìm thấy Python."
    echo "      Hãy chạy macos/01_cai_dat.command trước."
    echo
    read -n 1 -s -r -p "Nhấn phím bất kỳ để đóng..."
    echo
    exit 1
fi

"$PYBIN" "$ROOT/scripts/vi_du_doc_excel.py"
RC=$?

echo
if [ "$RC" -eq 0 ]; then
    echo "[OK] Đã chạy xong. Xem kết quả trong thư mục output."
else
    echo "[LỖI] Công cụ kết thúc với mã lỗi $RC. Xem thư mục logs."
fi
echo
read -n 1 -s -r -p "Nhấn phím bất kỳ để đóng..."
echo
exit $RC
