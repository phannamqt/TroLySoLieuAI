# AGENTS.md — Hướng dẫn cho Codex (AI) khi làm việc trong dự án này

> File này là **quy tắc bắt buộc** cho trợ lý AI (Codex) khi hỗ trợ nhân viên
> xử lý file Excel trong dự án **Trợ Lý Số Liệu AI**.
> Người sử dụng **không biết lập trình**. Hãy làm mọi việc thay họ.

---

## 1. Nguyên tắc giao tiếp

- **Luôn trả lời bằng tiếng Việt**, câu ngắn, dễ hiểu.
- Trước khi làm, **giải thích ngắn gọn kế hoạch xử lý** (3–5 dòng).
- Không bắt người dùng chỉnh sửa code. **Nếu tự sửa được thì tự sửa.**
- In tiến độ bằng tiếng Việt khi chạy chương trình.

## 2. Trước khi viết code: PHẢI đọc cấu trúc file Excel

Trước khi xử lý, đọc file trong thư mục `input/` và **liệt kê rõ**:

- Tên file
- Tên (các) sheet
- Số dòng
- Số cột
- Tên các cột
- Kiểu dữ liệu dự kiến của từng cột (số, ngày, chữ, tiền…)

Nếu **tên cột không rõ ràng**, **không được tự suy đoán**. Hãy hỏi lại hoặc
**ghi rõ giả định** đang dùng.

## 3. Quy tắc về file và thư mục (RẤT QUAN TRỌNG)

- **KHÔNG sửa, KHÔNG ghi đè** bất kỳ file nào trong `input/`.
- **KHÔNG xóa file** trong bất kỳ trường hợp nào.
- Mỗi lần xử lý phải **tạo file mới** trong `output/`.
- Tên file kết quả phải **có ngày giờ**, ví dụ:
  `output/ket_qua_loc_2026-07-15_09-30-00.xlsx`
- Code Python phải lưu vào thư mục `scripts/`.
- File log phải lưu vào thư mục `logs/`.
- **Chỉ thao tác trong thư mục dự án.** Không đọc/ghi file nằm ngoài dự án.
- Không được đọc toàn bộ ổ đĩa.

## 4. Thư viện được dùng

- Ưu tiên **`pandas`** và **`openpyxl`**.
- Nếu cần **giữ định dạng Excel** (màu, công thức, gộp ô) → dùng **`openpyxl`**.
- **Không cài thêm thư viện** nếu chưa giải thích lý do cho người dùng.
  Chỉ dùng các thư viện đã có trong `requirements.txt`.

## 5. Kiểm tra chất lượng dữ liệu

Với mỗi lần xử lý, phải kiểm tra:

- Dữ liệu **trống** (ô rỗng, thiếu giá trị).
- Dữ liệu **trùng lặp**.
- **Kiểu ngày tháng** có hợp lệ không.
- **Kiểu số** có hợp lệ không.
- **Lỗi công thức** trong Excel (ví dụ `#N/A`, `#REF!`, `#DIV/0!`).

Đối chiếu:

- **So sánh số dòng đầu vào và đầu ra.**
- Với **dữ liệu tiền**, phải **đối chiếu tổng tiền trước và sau** xử lý;
  nếu lệch, phải cảnh báo.

## 6. Thao tác nguy hiểm → làm bản PREVIEW trước

- Với thao tác **có nguy cơ làm sai dữ liệu** (xóa dòng, gộp, chuẩn hóa hàng
  loạt…), phải **tạo bản preview** (ví dụ 20 dòng đầu, hoặc một sheet
  `PREVIEW`) để người dùng xem trước khi chạy toàn bộ.

## 7. Cấu trúc file kết quả Excel

Mỗi file `.xlsx` xuất ra nên có tối thiểu:

- Sheet **`DU_LIEU_GOC`**: giữ nguyên dữ liệu gốc (không sửa).
- Sheet **`KET_QUA`**: dữ liệu sau xử lý.
- (Tùy chọn) Sheet **`BAO_CAO`**: số liệu đối chiếu, giả định, cảnh báo.

## 8. Bắt buộc có xử lý lỗi

- Mỗi chương trình phải có **try/except** rõ ràng.
- Khi lỗi, in thông báo tiếng Việt dễ hiểu **và** ghi vào `logs/`.
- **Không để chương trình dừng đột ngột** mà không giải thích.

## 9. Báo cáo sau khi chạy

Sau khi chạy xong, **luôn báo cáo**:

- File đầu vào
- File đầu ra
- Số dòng đã đọc
- Số dòng đã xuất
- Số dòng lỗi
- Số dòng bị loại
- Các giả định đã dùng
- Các cảnh báo

## 10. Tạo file `RUN.cmd` cho mỗi công cụ hoàn chỉnh

Với **mỗi công cụ hoàn chỉnh**, tạo thêm file để nhân viên **chạy lại mà không
cần mở code**. Tạo bản phù hợp với hệ điều hành của người dùng (hoặc cả hai):

- **Windows:** `scripts/RUN.cmd` — dùng đường dẫn tương đối theo `%~dp0`.
- **macOS:** `scripts/RUN.command` — dùng `"$(cd "$(dirname "$0")" && pwd)"`;
  nhớ đặt quyền chạy (`chmod +x`). Ưu tiên Python trong `.venv` nếu có.

Yêu cầu chung: gọi đúng script Python trong `scripts/`, hỗ trợ đường dẫn có
khoảng trắng, in tiến độ và tạm dừng cuối để người dùng đọc kết quả.

Mẫu tối thiểu cho `scripts/RUN.cmd` (Windows):

```bat
@echo off
cd /d "%~dp0\.."
python "scripts\ten_script.py"
pause
```

Mẫu tối thiểu cho `scripts/RUN.command` (macOS):

```bash
#!/bin/bash
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PY="python3"; [ -x "$ROOT/.venv/bin/python" ] && PY="$ROOT/.venv/bin/python"
"$PY" "$ROOT/scripts/ten_script.py"
read -n 1 -s -r -p "Nhan phim bat ky de dong..."
```

## 11. Quy tắc BẢO MẬT & AN TOÀN (nghiêm ngặt)

- **Không gọi API bên ngoài.** Không gửi dữ liệu lên Internet.
- **Không** lưu API key, token hoặc mật khẩu trong code.
- **Không** truy cập thông tin đăng nhập của máy.
- **Không** chạy lệnh nguy hiểm (format, shutdown…).
- **Không** dùng lệnh **xóa đệ quy** (`rmdir /s`, `rm -rf`, `shutil.rmtree`).
- **Không** sửa Windows Registry.
- **Không** thực hiện lệnh xóa dữ liệu khi chưa hỏi người dùng.
- **Log không được chứa nội dung nhạy cảm** trong file Excel.
  Log **chỉ** ghi: tên file, số dòng, thời gian, trạng thái xử lý.

## 12. Tóm tắt quy trình chuẩn mỗi lần làm việc

1. Đọc & mô tả cấu trúc file Excel trong `input/`.
2. Giải thích ngắn gọn kế hoạch.
3. (Nếu nguy hiểm) tạo bản preview.
4. Viết script Python vào `scripts/`.
5. Chạy, in tiến độ tiếng Việt, ghi log vào `logs/`.
6. Xuất kết quả có ngày giờ vào `output/` (không đụng `input/`).
7. Tạo `scripts/RUN.cmd` để chạy lại.
8. Báo cáo đầy đủ theo mục 9.
