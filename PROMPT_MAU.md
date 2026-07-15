# PROMPT_MẪU.md — Bộ prompt mẫu tiếng Việt cho Codex

> Cách dùng: **Copy** cả khối prompt bên dưới, dán vào Codex trong VS Code,
> rồi **sửa phần trong dấu `[ ]`** cho đúng yêu cầu của bạn.
> Nhớ: file Excel phải nằm trong thư mục **`input`**, kết quả ra thư mục **`output`**.

---

## 1. Lọc dữ liệu theo điều kiện

```text
Hãy phân tích file Excel trong thư mục input.

Yêu cầu nghiệp vụ:
Lọc các dòng có [tên cột] [điều kiện, ví dụ: lớn hơn 1.000.000 / bằng "Đã thanh toán"].
Xuất các dòng thỏa điều kiện ra file kết quả.

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

## 2. Xóa dòng trùng

```text
Hãy phân tích file Excel trong thư mục input.

Yêu cầu nghiệp vụ:
Xóa các dòng bị trùng dựa trên [cột hoặc các cột dùng để xác định trùng, ví dụ: Mã khách hàng].
Giữ lại dòng [đầu tiên / cuối cùng].

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

## 3. Đối chiếu hai file Excel

```text
Hãy phân tích các file Excel trong thư mục input.

Yêu cầu nghiệp vụ:
Đối chiếu file [tên file A] với file [tên file B] dựa trên cột khóa [ví dụ: Mã đơn hàng].
Liệt kê: dòng chỉ có ở A, dòng chỉ có ở B, dòng có ở cả hai nhưng khác nhau ở cột [tên cột].

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

## 4. Đối chiếu hai sheet

```text
Hãy phân tích file Excel trong thư mục input.

Yêu cầu nghiệp vụ:
Đối chiếu sheet [tên sheet 1] với sheet [tên sheet 2] trong cùng một file, dựa trên cột khóa [tên cột].
Chỉ ra các khác biệt và các dòng bị thiếu ở mỗi sheet.

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

## 5. Gộp nhiều file Excel

```text
Hãy phân tích tất cả các file Excel trong thư mục input.

Yêu cầu nghiệp vụ:
Gộp tất cả các file (hoặc các file có cùng cấu trúc cột) thành một bảng duy nhất.
Thêm một cột "Nguồn file" để biết mỗi dòng đến từ file nào.

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

## 6. Chia file theo phòng ban

```text
Hãy phân tích file Excel trong thư mục input.

Yêu cầu nghiệp vụ:
Tách dữ liệu thành nhiều file, mỗi giá trị trong cột [ví dụ: Phòng ban] thành một file riêng.
Đặt tên file kết quả theo tên phòng ban.

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

## 7. Tổng hợp doanh thu

```text
Hãy phân tích file Excel trong thư mục input.

Yêu cầu nghiệp vụ:
Tính tổng doanh thu theo [ví dụ: Nhân viên bán hàng / Sản phẩm / Chi nhánh].
Cột số tiền là [tên cột tiền]. Sắp xếp giảm dần theo tổng.

Nguyên tắc:
- Không sửa file gốc.
- Xuất file kết quả vào output.
- Giữ nguyên dữ liệu gốc trong một sheet riêng.
- Tạo sheet kết quả.
- Báo số dòng trước và sau xử lý.
- Đối chiếu tổng tiền trước và sau xử lý.
- Báo các dòng lỗi.
- Tạo script Python trong scripts.
- Tạo file RUN.cmd để chạy lại.
```

## 8. Tổng hợp dữ liệu theo tháng

```text
Hãy phân tích file Excel trong thư mục input.

Yêu cầu nghiệp vụ:
Tổng hợp [ví dụ: doanh thu / số lượng đơn] theo từng tháng dựa trên cột ngày [tên cột ngày].
Kết quả có dạng bảng: Tháng | Tổng.

Nguyên tắc:
- Không sửa file gốc.
- Xuất file kết quả vào output.
- Giữ nguyên dữ liệu gốc trong một sheet riêng.
- Tạo sheet kết quả.
- Báo số dòng trước và sau xử lý.
- Đối chiếu tổng tiền trước và sau xử lý.
- Báo các dòng lỗi.
- Tạo script Python trong scripts.
- Tạo file RUN.cmd để chạy lại.
```

## 9. Chuẩn hóa ngày tháng và số tiền

```text
Hãy phân tích file Excel trong thư mục input.

Yêu cầu nghiệp vụ:
Chuẩn hóa cột ngày [tên cột] về định dạng dd/mm/yyyy.
Chuẩn hóa cột tiền [tên cột] về dạng số (bỏ dấu chấm/phẩy ngăn cách, ký hiệu tiền tệ).
Đánh dấu các dòng không thể chuẩn hóa.

Nguyên tắc:
- Không sửa file gốc.
- Xuất file kết quả vào output.
- Giữ nguyên dữ liệu gốc trong một sheet riêng.
- Tạo sheet kết quả.
- Báo số dòng trước và sau xử lý.
- Đối chiếu tổng tiền trước và sau xử lý.
- Báo các dòng lỗi.
- Tạo script Python trong scripts.
- Tạo file RUN.cmd để chạy lại.
```

## 10. Tìm dữ liệu thiếu hoặc bất thường

```text
Hãy phân tích file Excel trong thư mục input.

Yêu cầu nghiệp vụ:
Tìm các ô trống, dữ liệu thiếu, giá trị bất thường (ví dụ: số âm ở cột số lượng,
ngày trong tương lai, số tiền quá lớn bất thường) trong các cột [liệt kê cột].
Liệt kê rõ vị trí dòng và lý do bị đánh dấu.

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

---

## 11. Prompt TỔNG QUÁT (điền vào chỗ trống)

> Dùng khi yêu cầu của bạn không giống 10 mẫu trên. Chỉ cần điền phần `[ ]`.

```text
Hãy phân tích file Excel trong thư mục input.

Thông tin đầu vào:
- Tên file: [tên file, ví dụ: bao_cao_thang_7.xlsx]
- Tên sheet: [tên sheet, ví dụ: Sheet1]
- Cột cần xử lý: [liệt kê cột, ví dụ: Ngày, Số tiền, Khách hàng]
- Điều kiện xử lý: [mô tả điều kiện, ví dụ: chỉ lấy đơn đã thanh toán trong tháng 7]
- Kết quả mong muốn: [mô tả rõ, ví dụ: bảng tổng tiền theo khách hàng, sắp xếp giảm dần]

Nguyên tắc:
- Không sửa file gốc.
- Xuất file kết quả vào output (tên file có ngày giờ).
- Giữ nguyên dữ liệu gốc trong một sheet riêng.
- Tạo sheet kết quả.
- Báo số dòng trước và sau xử lý.
- Nếu có cột tiền, đối chiếu tổng tiền trước và sau.
- Báo các dòng lỗi, dòng bị loại và các giả định.
- Tạo script Python trong scripts.
- Tạo file RUN.cmd để chạy lại.
- Nếu tên cột chưa rõ, hãy hỏi lại hoặc ghi rõ giả định, không tự suy đoán.
```
