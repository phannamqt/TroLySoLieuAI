# HƯỚNG DẪN SỬ DỤNG — Trợ Lý Số Liệu AI

> Dành cho người **chưa từng dùng VS Code**. Làm theo từng bước có đánh số.
> Nếu gặp khó khăn, xem mục **10. Lỗi thường gặp** hoặc liên hệ **người phụ trách công cụ** (mục 12).

---

## 1. Cách chạy bộ cài (chỉ làm 1 lần đầu)

1. Mở thư mục **Trợ Lý Số Liệu AI** (thư mục chứa các file này).
2. Bấm **chuột phải** vào file **`01_CAI_DAT_CONG_CU.bat`**.
3. Chọn **Run as administrator** (Chạy bằng quyền quản trị).
4. Nếu Windows hỏi cho phép, bấm **Yes**.
5. Chờ đến khi thấy dòng **"CAI DAT HOAN TAT!"**.
6. **Không tắt cửa sổ** trong lúc đang cài.

## 2. Cách mở công cụ (dùng hằng ngày)

1. Bấm đúp vào **`03_MO_CONG_CU_AI.cmd`**
   (hoặc bấm đúp shortcut **"Excel AI Starter"** trên màn hình Desktop).
2. VS Code sẽ tự mở toàn bộ dự án.

## 3. Cách bỏ file Excel vào thư mục file_can_xu_ly

1. Mở thư mục **`file_can_xu_ly`** trong thư mục **Trợ Lý Số Liệu AI**.
2. **Copy** file Excel của bạn vào đây.
3. Lưu ý: file gốc sẽ **không bị sửa**. Công cụ chỉ đọc, không ghi đè.

## 4. Cách mở trợ lý AI trong VS Code

Bộ cài đã **cài sẵn** 3 trợ lý AI (bạn chỉ cần đăng nhập khi dùng):

- **OpenAI Codex**, **Claude Code**, **GitHub Copilot**.

Cách mở:

1. Trong VS Code, nhìn thanh dọc bên trái.
2. Bấm biểu tượng của trợ lý bạn muốn dùng (ví dụ **Codex**) để mở khung chat.
3. Nếu chưa thấy biểu tượng: nhấn **Ctrl + Shift + X** (macOS: **Cmd + Shift + X**),
   kiểm tra các extension đã cài; nếu thiếu thì gõ tên (ví dụ `Codex`,
   `Claude Code`, `GitHub Copilot`) và bấm **Install**.

> Gợi ý: với công cụ Excel này, **Codex** hoặc **Claude Code** đều dùng tốt.

## 5. Cách đăng nhập bằng tài khoản được công ty cấp

1. Trong khung Codex, bấm **Sign in** (Đăng nhập).
2. Trình duyệt sẽ mở ra.
3. Đăng nhập bằng **tài khoản công ty đã cấp cho bạn**.
4. **Không dùng** tài khoản cá nhân nếu công ty không cho phép.
5. Sau khi đăng nhập xong, quay lại VS Code.

## 6. Cách copy prompt mẫu

1. Mở file **`PROMPT_MAU.md`** trong VS Code.
2. Chọn một mẫu phù hợp (ví dụ: "Lọc dữ liệu theo điều kiện").
3. Bôi đen cả khối prompt, nhấn **Ctrl + C** để copy.
4. Bấm vào khung chat Codex, nhấn **Ctrl + V** để dán.

## 7. Cách mô tả yêu cầu nghiệp vụ

1. Trong prompt vừa dán, tìm các chỗ có dấu `[ ]`.
2. **Thay** nội dung trong `[ ]` bằng yêu cầu thật của bạn.
   - Ví dụ: `[tên cột]` → `Số tiền`.
   - Ví dụ: `[điều kiện]` → `lớn hơn 1.000.000`.
3. Viết bằng tiếng Việt, càng rõ ràng càng tốt.
4. Nhấn **Enter** để gửi cho Codex.

## 8. Cách chạy script

- **Cách 1 (đơn giản nhất):** Codex thường tự chạy giúp bạn và báo kết quả.
- **Cách 2 (chạy lại):** Mở thư mục **`scripts`**, bấm đúp file **`RUN.cmd`**
  mà Codex đã tạo. Chờ chạy xong rồi xem thông báo.

## 9. Cách tìm file kết quả

1. Mở thư mục **`file_da_xu_ly`**.
2. File kết quả có **ngày giờ** trong tên (ví dụ:
   `ket_qua_2026-07-15_09-30-00.xlsx`).
3. Bấm đúp để mở bằng Excel.

## 10. Cách xử lý các lỗi thường gặp

| Hiện tượng | Cách xử lý |
|---|---|
| Không mở được VS Code | Chạy lại `01_CAI_DAT_CONG_CU.bat` (Run as administrator). |
| Báo thiếu thư viện Python | Chạy `02_KIEM_TRA_MOI_TRUONG.bat` để xem thiếu gì, rồi chạy lại bộ cài. |
| Không thấy nút Codex | Mở Extensions (Ctrl+Shift+X), cài lại extension Codex. |
| Không đăng nhập được Codex | Kiểm tra mạng, dùng đúng tài khoản công ty, thử lại. |
| Không thấy file kết quả | Kiểm tra thư mục `file_da_xu_ly`; xem thông báo lỗi của Codex. |
| Chạy `.bat` bị đóng ngay | Bấm chuột phải chọn Run as administrator; đọc `logs\install.log`. |

> Mẹo: Chạy **`02_KIEM_TRA_MOI_TRUONG.bat`** bất cứ lúc nào để kiểm tra
> mọi thứ có sẵn sàng không.

## 11. ⚠️ Cảnh báo về dữ liệu nhạy cảm

- **Không** đưa dữ liệu nhạy cảm (thông tin cá nhân khách hàng, lương, hợp đồng
  bí mật…) vào công cụ **nếu công ty chưa cho phép**.
- Hỏi người phụ trách công cụ / phụ trách bảo mật **trước khi** xử lý dữ liệu quan trọng.
- Công cụ này xử lý **trên máy của bạn**; tuy nhiên vẫn cần tuân thủ chính sách
  bảo mật của công ty.

## 12. Cách báo lỗi / liên hệ hỗ trợ

Khi báo lỗi, hãy gửi kèm:

1. Ảnh chụp màn hình thông báo lỗi.
2. File **`logs\install.log`** (lỗi khi cài).
3. File **`logs\environment_check.log`** (lỗi môi trường).
4. Tên file Excel bạn đang xử lý (**không gửi dữ liệu nhạy cảm** nếu chưa được phép).

> Liên hệ hỗ trợ: _[Ghi số điện thoại / email người phụ trách tại đây]_
