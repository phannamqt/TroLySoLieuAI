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

## 2. Bắt đầu nhanh

Công cụ hỗ trợ **cả Windows và macOS**. **Cách dễ nhất:** bấm đúp đúng file
khởi động ở thư mục ngoài cùng — nó mở **menu** để bạn chọn Cài đặt / Kiểm tra /
Mở công cụ:

| Máy của bạn | Bấm đúp file này |
|-------------|------------------|
| 🪟 Windows | **`WINDOW_BAT_DAU.bat`** |
| 🍎 macOS | **`MAC_BAT_DAU.command`** (nếu bị chặn: chuột phải → Open) |

Sau đó theo 3 bước: **(1)** chọn *Cài đặt* (chỉ lần đầu) → **(2)** bỏ file Excel
vào thư mục **`input`** → **(3)** chọn *Mở công cụ*, rồi dùng trợ lý AI trong VS Code.

> 🤖 Bộ cài **tự cài sẵn** 3 trợ lý AI: **OpenAI Codex** (`openai.chatgpt`),
> **Claude Code** (`anthropic.claude-code`), **GitHub Copilot** (`GitHub.copilot`).
> Bạn chỉ cần **đăng nhập** khi dùng — bộ cài không lưu tài khoản của bạn.

### 🪟 Chi tiết trên Windows

| Bước | Việc cần làm |
|------|--------------|
| 1️⃣ | Bấm chuột phải `windows/01_CAI_DAT_CONG_CU.bat` → **Run as administrator** (chỉ làm lần đầu). |
| 2️⃣ | Bỏ file Excel vào thư mục **`input`**. |
| 3️⃣ | Chạy `windows/03_MO_CONG_CU_AI.cmd`, mở Codex trong VS Code, dán prompt mẫu và mô tả yêu cầu. |

### 🍎 Chi tiết trên macOS

| Bước | Việc cần làm |
|------|--------------|
| 1️⃣ | Bấm đúp `macos/01_cai_dat.command` (nếu bị chặn: **chuột phải → Open**). Chỉ làm lần đầu. |
| 2️⃣ | Bỏ file Excel vào thư mục **`input`**. |
| 3️⃣ | Chạy `macos/03_mo_cong_cu.command`, mở Codex trong VS Code, dán prompt mẫu và mô tả yêu cầu. |

> 💡 Có thể bấm đúp **`macos/BAT_DAU.command`** để hiện **menu** gộp cả 3 việc trên.
>
> Kết quả luôn nằm trong thư mục **`output`** (dùng chung cho cả hai nền tảng).

## 3. Cấu trúc thư mục

```text
.
├── WINDOW_BAT_DAU.bat          # 🪟 BẮT ĐẦU trên Windows (bấm đúp file này)
├── MAC_BAT_DAU.command         # 🍎 BẮT ĐẦU trên macOS (bấm đúp file này)
├── windows/                    # Bản dành cho Windows (.bat/.cmd)
│   ├── BAT_DAU.bat             #   Menu tổng: cài / kiểm tra / mở
│   ├── 01_CAI_DAT_CONG_CU.bat  #   Cài Python + VS Code + extension + thư viện
│   ├── 02_KIEM_TRA_MOI_TRUONG.bat  # Kiểm tra môi trường
│   ├── 03_MO_CONG_CU_AI.cmd    #   Mở dự án bằng VS Code
│   └── 04_GO_CAI_DAT.bat       #   Gỡ cài đặt an toàn
├── macos/                      # 🍎 Bản dành cho macOS (.command)
│   ├── BAT_DAU.command         #   Menu tổng
│   ├── 01_cai_dat.command      #   Cài Homebrew + Python + VS Code + .venv
│   ├── 02_kiem_tra.command     #   Kiểm tra môi trường
│   ├── 03_mo_cong_cu.command   #   Mở dự án bằng VS Code
│   └── 04_go_cai_dat.command   #   Gỡ cài đặt an toàn
├── AGENTS.md                   # Quy tắc cho AI (Codex) — dùng chung
├── PROMPT_MAU.md               # 10+ prompt mẫu tiếng Việt — dùng chung
├── HUONG_DAN_SU_DUNG.md        # Hướng dẫn chi tiết từng bước — dùng chung
├── README.md                   # File này
├── README_FIRST.txt            # Đọc đầu tiên (bản .txt)
├── requirements.txt            # Danh sách thư viện Python — dùng chung
├── input/                      # ⬅️ Bỏ file Excel cần xử lý vào đây
├── output/                     # ➡️ Kết quả xuất ra đây (tên có ngày giờ)
├── scripts/                    # Code Python + file chạy lại do AI tạo
│   ├── vi_du_doc_excel.py      #   Công cụ mẫu chạy được ngay (đa nền tảng)
│   ├── RUN.cmd                 #   (Windows) Bấm đúp để chạy lại
│   └── RUN.command             #   (macOS) Bấm đúp để chạy lại
├── logs/                       # Nhật ký cài đặt và xử lý
└── templates/                  # Mẫu Excel dùng lại nhiều lần
```

> Trên macOS, thư viện Python được cài trong môi trường ảo **`.venv`** (tạo tự
> động ở lần cài đầu) để tránh lỗi *externally-managed-environment* của macOS.

## 4. Các file dành cho ai?

- **Nhân viên (non-IT):** `WINDOW_BAT_DAU.bat` / `MAC_BAT_DAU.command`,
  `HUONG_DAN_SU_DUNG.md`, `PROMPT_MAU.md`, thư mục `input` và `output`.
- **Người bảo trì:** `AGENTS.md`, `requirements.txt`, các file `.bat`/`.cmd`,
  thư mục `scripts` và `logs`.

## 5. Công cụ mẫu chạy thử ngay

Muốn kiểm tra nhanh mà chưa cần AI:

1. Bỏ một file `.xlsx` vào `input`.
2. Bấm đúp **`scripts/RUN.cmd`**.
3. Xem báo cáo cấu trúc file (tên sheet, số dòng, số cột, ô trống, dòng trùng…)
   trong thư mục `output`.

## 6. Cách ra lệnh cho AI (viết prompt)

AI làm việc theo **prompt** — tức là câu mô tả yêu cầu bằng tiếng Việt bạn gõ
cho Codex. Prompt càng rõ, kết quả càng đúng.

### 6.1. Quy trình 4 bước

1. Mở file **[PROMPT_MAU.md](PROMPT_MAU.md)** trong VS Code.
2. Chọn mẫu gần giống việc bạn cần, **copy** cả khối.
3. **Dán** vào khung chat Codex, rồi **sửa các chỗ có dấu `[ ]`** cho đúng yêu cầu.
4. Nhấn **Enter** để gửi. Xem kết quả trong thư mục `output`.

### 6.2. Cấu trúc một prompt tốt

```text
Hãy phân tích file Excel trong thư mục input.

Yêu cầu nghiệp vụ:
[Mô tả rõ việc cần làm, ví dụ: lọc các đơn đã thanh toán trong tháng 7]

Nguyên tắc:
- Không sửa file gốc.
- Xuất file kết quả vào output.
- Giữ nguyên dữ liệu gốc trong một sheet riêng.
- Tạo sheet kết quả.
- Báo số dòng trước và sau xử lý.
- Báo các dòng lỗi.
- Tạo script Python trong scripts.
- Tạo file RUN.cmd để chạy lại.
```

### 6.3. Prompt tổng quát (chỉ cần điền vào chỗ trống)

Dùng khi yêu cầu của bạn không giống mẫu có sẵn:

```text
Hãy phân tích file Excel trong thư mục input.

Thông tin đầu vào:
- Tên file: [ví dụ: bao_cao_thang_7.xlsx]
- Tên sheet: [ví dụ: Sheet1]
- Cột cần xử lý: [ví dụ: Ngày, Số tiền, Khách hàng]
- Điều kiện xử lý: [ví dụ: chỉ lấy đơn đã thanh toán trong tháng 7]
- Kết quả mong muốn: [ví dụ: bảng tổng tiền theo khách hàng, sắp xếp giảm dần]

Nguyên tắc:
- Không sửa file gốc; xuất kết quả ra output (tên file có ngày giờ).
- Giữ dữ liệu gốc trong sheet riêng, tạo sheet kết quả.
- Báo số dòng trước/sau, dòng lỗi và các giả định.
- Nếu có cột tiền, đối chiếu tổng tiền trước và sau.
- Tạo script Python trong scripts và file RUN.cmd để chạy lại.
- Nếu tên cột chưa rõ, hãy hỏi lại hoặc ghi rõ giả định, không tự suy đoán.
```

### 6.4. Các loại việc AI làm được (có sẵn prompt mẫu)

**⭐ PHẦN A — Phân tích kinh doanh & đề xuất chiến lược** (trọng tâm):

| # | Loại phân tích chiến lược |
|---|---------------------------|
| A1 | Phân tích doanh thu tổng thể → đề xuất tăng trưởng |
| A2 | Sản phẩm bán chạy / bán chậm → chiến lược danh mục |
| A3 | Phân nhóm khách hàng (RFM) → giữ chân & chăm sóc |
| A4 | So sánh khu vực / chi nhánh → phân bổ nguồn lực |
| A5 | Xu hướng theo thời gian / mùa vụ → kế hoạch kinh doanh |
| A6 | Lợi nhuận / biên lợi nhuận → chiến lược giá & chi phí |
| A7 | So sánh kỳ này với kỳ trước → điều chỉnh chiến lược |
| A8 | Báo cáo điều hành (Executive Summary) + đề xuất |
| A9 | Prompt chiến lược **tổng quát** (chỉ cần điền chỗ trống) |

**PHẦN B — Xử lý dữ liệu cơ bản** (làm sạch/chuẩn bị dữ liệu):

| # | Loại việc | # | Loại việc |
|---|-----------|---|-----------|
| 1 | Lọc dữ liệu theo điều kiện | 6 | Chia file theo phòng ban |
| 2 | Xóa dòng trùng | 7 | Tổng hợp doanh thu |
| 3 | Đối chiếu hai file Excel | 8 | Tổng hợp dữ liệu theo tháng |
| 4 | Đối chiếu hai sheet | 9 | Chuẩn hóa ngày tháng & số tiền |
| 5 | Gộp nhiều file Excel | 10 | Tìm dữ liệu thiếu / bất thường |

> 👉 Toàn bộ prompt mẫu chi tiết nằm trong **[PROMPT_MAU.md](PROMPT_MAU.md)**
> (Phần A là các prompt phân tích kinh doanh để ra quyết định chiến lược).

### 6.5. Mẹo viết prompt hiệu quả

- ✅ **Nói rõ tên cột** đúng như trong file Excel (ví dụ: `Số tiền`, `Ngày lập`).
- ✅ **Nêu điều kiện cụ thể** (lớn hơn / bằng / trong khoảng thời gian nào).
- ✅ **Mô tả kết quả mong muốn** (bảng gì, sắp xếp theo cột nào).
- ✅ Nếu không chắc, cứ **bảo AI hỏi lại** thay vì để nó tự đoán.
- ❌ Tránh câu chung chung như "xử lý giúp file này" — AI sẽ không biết làm gì.

## 7. Nguyên tắc an toàn & bảo mật

- ❌ Không nhúng API key / tài khoản / mật khẩu / token trong mã nguồn.
- ❌ Không tự động đăng nhập Codex — người dùng **tự đăng nhập**.
- ❌ Không gửi file Excel lên máy chủ bên ngoài.
- ✅ Chỉ dùng nguồn chính thức: `winget` (Windows) / Homebrew (macOS), `pip`
  và VS Code Marketplace.
- ✅ Chỉ thao tác **trong thư mục dự án**; không đọc toàn bộ ổ đĩa.
- ✅ **Không sửa/ghi đè** file trong `input`; mọi kết quả tạo file mới trong `output`.
- ✅ Log chỉ ghi: tên file, số dòng, thời gian, trạng thái — **không** ghi nội
  dung nhạy cảm.

> ⚠️ Không đưa dữ liệu nhạy cảm vào công cụ nếu chưa được phép.

## 8. Yêu cầu hệ thống

**Windows:**
- Windows 10 hoặc Windows 11.
- Có **winget** (App Installer) — cài từ Microsoft Store nếu thiếu.
- Quyền **Administrator** cho lần cài đặt đầu tiên.

**macOS:**
- macOS trên chip **Intel** hoặc **Apple Silicon** (M1/M2/M3…).
- **Homebrew** — bộ cài sẽ tự cài nếu thiếu (có thể hỏi mật khẩu máy).
- Lần đầu bị Gatekeeper chặn: **chuột phải file `.command` → Open**.

**Chung:** Kết nối Internet để tải Python, VS Code và thư viện.

## 9. Gỡ cài đặt

- **Windows:** chạy **`windows/04_GO_CAI_DAT.bat`**.
- **macOS:** chạy **`macos/04_go_cai_dat.command`**.

Cả hai chỉ:

- Xóa shortcut trên Desktop.
- Hỏi trước khi xóa môi trường ảo (`.venv`) / thư mục dự án.
- **Không** tự gỡ Python, **không** tự gỡ VS Code (macOS: không gỡ Homebrew).

## 10. Sự cố thường gặp

Xem mục **10. Cách xử lý các lỗi thường gặp** trong
[HUONG_DAN_SU_DUNG.md](HUONG_DAN_SU_DUNG.md). Khi báo lỗi, gửi kèm
`logs/install.log` và `logs/environment_check.log`.

---

_Trợ Lý Số Liệu AI — Script created by Phan Nam — Version 1.0.0_
