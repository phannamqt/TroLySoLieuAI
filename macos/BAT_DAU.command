#!/bin/bash
# ============================================================================
#  BAT_DAU.command  -  MENU TỔNG cho macOS (gộp bước 1, 2, 3)
#  Dự án: Trợ Lý Số Liệu AI
#
#  GHI CHÚ KỸ THUẬT (cho người bảo trì):
#   - Không chép lại logic, chỉ GỌI lại các file đã có trong thư mục macos/.
#   - Đường dẫn suy ra từ vị trí file, hỗ trợ khoảng trắng.
# ============================================================================

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

run_install() {
    if [ -f "$SCRIPT_DIR/01_cai_dat.command" ]; then
        echo "[ĐANG CHẠY] Cài đặt công cụ..."
        bash "$SCRIPT_DIR/01_cai_dat.command"
    else
        echo "[LỖI] Không tìm thấy 01_cai_dat.command"
    fi
}
run_check() {
    if [ -f "$SCRIPT_DIR/02_kiem_tra.command" ]; then
        echo "[ĐANG CHẠY] Kiểm tra môi trường..."
        bash "$SCRIPT_DIR/02_kiem_tra.command"
    else
        echo "[LỖI] Không tìm thấy 02_kiem_tra.command"
    fi
}
run_open() {
    if [ -f "$SCRIPT_DIR/03_mo_cong_cu.command" ]; then
        echo "[ĐANG CHẠY] Mở công cụ AI..."
        bash "$SCRIPT_DIR/03_mo_cong_cu.command"
    else
        echo "[LỖI] Không tìm thấy 03_mo_cong_cu.command"
    fi
}

while true; do
    clear
    echo "============================================================"
    echo "   TRỢ LÝ SỐ LIỆU AI - MENU BẮT ĐẦU (macOS)"
    echo "   Script created by Phan Nam  -  Version 1.0.0"
    echo "============================================================"
    echo
    echo "   [1] Cài đặt công cụ        (làm LẦN ĐẦU)"
    echo "   [2] Kiểm tra môi trường    (xem đã sẵn sàng chưa)"
    echo "   [3] Mở công cụ AI          (dùng hàng ngày)"
    echo
    echo "   [A] Làm TỰ ĐỘNG cả 3 bước: Cài đặt -> Kiểm tra -> Mở"
    echo "   [0] Thoát"
    echo
    echo "------------------------------------------------------------"
    read -r -p "Nhập lựa chọn rồi nhấn Enter: " CHON

    case "$CHON" in
        1) run_install ;;
        2) run_check ;;
        3) run_open ;;
        a|A)
            echo
            echo "[TỰ ĐỘNG] Chạy lần lượt: Cài đặt -> Kiểm tra -> Mở công cụ."
            echo
            run_install
            run_check
            run_open
            ;;
        0) echo; echo "Tạm biệt!"; exit 0 ;;
        *)
            echo
            echo "[CẢNH BÁO] Lựa chọn không hợp lệ. Hãy nhập 1, 2, 3, A hoặc 0."
            ;;
    esac

    echo
    read -n 1 -s -r -p "Nhấn phím bất kỳ để quay lại menu..."
done
