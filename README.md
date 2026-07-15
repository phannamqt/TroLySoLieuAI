# Trợ Lý Số Liệu AI

> Bộ công cụ giúp **nhân viên không biết lập trình** xử lý file Excel bằng
> tiếng Việt, thông qua AI (Codex) trong Visual Studio Code trên Windows 10/11.
>
> **Script created by Phan Nam — Version 1.0.0**

---

## 1. Trợ Lý Số Liệu AI là gì?

- Bạn chỉ cần **bỏ file Excel vào thư mục `input`**, mô tả yêu cầu bằng
  **tiếng Việt** cho AI, và nhận **kết quả trong thư mục `output`**.
- **Không cần biết code.** Bộ cài tự chuẩn bị mọi thứ: Python, VS Code,
  các extension và thư viện xử lý Excel.
- **An toàn dữ liệu:** không sửa/ghi đè file gốc, không gửi dữ liệu ra ngoài.

## 2. Bắt đầu nhanh (3 bước)

| Bước | Việc cần làm |
|------|--------------|
| 1️⃣ | Bấm chuột phải `01_CAI_DAT_CONG_CU.bat` → **Run as administrator** (chỉ làm lần đầu). |
| 2️⃣ | Bỏ file Excel vào thư mục **`input`**. |
| 3️⃣ | Chạy `03_MO_CONG_CU_AI.cmd`, mở Codex trong VS Code, dán prompt mẫu và mô tả yêu cầu. |

> 💡 Có thể bấm đúp **`BAT_DAU.bat`** để hiện **menu** gộp cả 3 việc trên.
> Kết quả luôn nằm trong thư mục **`output`**.

## 3. Cấu trúc thư mục

```text
.
├── BAT_DAU.bat                 # Menu tổng: cài đặt / kiểm tra / mở công cụ
├── 01_CAI_DAT_CONG_CU.bat      # Cài Python + VS Code + extension + thư viện
├── 02_KIEM_TRA_MOI_TRUONG.bat  # Kiểm tra môi trường ([OK]/[LOI]/[CANH BAO])
├── 03_MO_CONG_CU_AI.cmd        # Mở dự án bằng VS Code (dùng hằng ngày)
├── 04_GO_CAI_DAT.bat           # Gỡ cài đặt an toàn (có xác nhận)
├── AGENTS.md                   # Quy tắc cho AI (Codex)
├── PROMPT_MAU.md               # 10+ prompt mẫu tiếng Việt
├── HUONG_DAN_SU_DUNG.md        # Hướng dẫn chi tiết từng bước
├── README_FIRST.txt            # Đọc đầu tiên (bản .txt cho Notepad)
├── requirements.txt            # Danh sách thư viện Python
├── input/                      # ⬅️ Bỏ file Excel cần xử lý vào đây
├── output/                     # ➡️ Kết quả xuất ra đây (tên có ngày giờ)
├── scripts/                    # Code Python + RUN.cmd do AI tạo
│   ├── vi_du_doc_excel.py      # Công cụ mẫu chạy được ngay
│   └── RUN.cmd                 # Bấm đúp để chạy lại công cụ mẫu
├── logs/                       # Nhật ký cài đặt và xử lý
└── templates/                  # Mẫu Excel dùng lại nhiều lần
```

## 4. Các file dành cho ai?

- **Nhân viên (non-IT):** `BAT_DAU.bat`, `HUONG_DAN_SU_DUNG.md`,
  `PROMPT_MAU.md`, thư mục `input` và `output`.
- **Người bảo trì:** `AGENTS.md`, `requirements.txt`, các file `.bat`/`.cmd`,
  thư mục `scripts` và `logs`.

## 5. Công cụ mẫu chạy thử ngay

Muốn kiểm tra nhanh mà chưa cần AI:

1. Bỏ một file `.xlsx` vào `input`.
2. Bấm đúp **`scripts/RUN.cmd`**.
3. Xem báo cáo cấu trúc file (tên sheet, số dòng, số cột, ô trống, dòng trùng…)
   trong thư mục `output`.

## 6. Nguyên tắc an toàn & bảo mật

- ❌ Không nhúng API key / tài khoản / mật khẩu / token trong mã nguồn.
- ❌ Không tự động đăng nhập Codex — người dùng **tự đăng nhập**.
- ❌ Không gửi file Excel lên máy chủ bên ngoài.
- ✅ Chỉ dùng `winget`, `pip` và VS Code Marketplace (nguồn chính thức).
- ✅ Chỉ thao tác **trong thư mục dự án**; không đọc toàn bộ ổ đĩa.
- ✅ **Không sửa/ghi đè** file trong `input`; mọi kết quả tạo file mới trong `output`.
- ✅ Log chỉ ghi: tên file, số dòng, thời gian, trạng thái — **không** ghi nội
  dung nhạy cảm.

> ⚠️ Không đưa dữ liệu nhạy cảm vào công cụ nếu chưa được phép.

## 7. Yêu cầu hệ thống

- Windows 10 hoặc Windows 11.
- Có **winget** (App Installer) — cài từ Microsoft Store nếu thiếu.
- Quyền **Administrator** cho lần cài đặt đầu tiên.
- Kết nối Internet để tải Python, VS Code và thư viện.

## 8. Gỡ cài đặt

Chạy **`04_GO_CAI_DAT.bat`**. Công cụ chỉ:

- Xóa shortcut trên Desktop.
- Hỏi trước khi xóa môi trường ảo / thư mục dự án.
- **Không** tự gỡ Python, **không** tự gỡ VS Code.

## 9. Sự cố thường gặp

Xem mục **10. Cách xử lý các lỗi thường gặp** trong
[HUONG_DAN_SU_DUNG.md](HUONG_DAN_SU_DUNG.md). Khi báo lỗi, gửi kèm
`logs/install.log` và `logs/environment_check.log`.

---

_Trợ Lý Số Liệu AI — Script created by Phan Nam — Version 1.0.0_
