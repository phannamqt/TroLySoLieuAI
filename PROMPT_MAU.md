# PROMPT_MẪU.md — Bộ prompt mẫu tiếng Việt cho Codex

> Cách dùng: **Copy** cả khối prompt bên dưới, dán vào Codex trong VS Code,
> rồi **sửa phần trong dấu `[ ]`** cho đúng yêu cầu của bạn.
> Nhớ: file Excel phải nằm trong thư mục **`file_can_xu_ly`**, kết quả ra thư mục **`file_da_xu_ly`**.

> **Bố cục file này:**
> - **PHẦN A — Phân tích kinh doanh & đề xuất chiến lược** (trọng tâm, xem ngay bên dưới).
> - **PHẦN B — Xử lý dữ liệu cơ bản** (lọc, gộp, đối chiếu… đánh số 1–10 ở cuối).

---

# PHẦN A — PHÂN TÍCH KINH DOANH & ĐỀ XUẤT CHIẾN LƯỢC

> Các prompt này yêu cầu AI **phân tích số liệu thật** rồi **đề xuất chiến lược
> kèm dẫn chứng bằng con số**. Kết quả xuất ra `file_da_xu_ly` gồm: sheet số liệu,
> sheet biểu đồ/tổng hợp và một **bản tóm tắt đề xuất** (sheet `DE_XUAT` hoặc
> file `.md` trong `file_da_xu_ly`).

### ⚠️ Nguyên tắc chung cho mọi prompt chiến lược (đã gộp sẵn trong mỗi mẫu)

- Không sửa file gốc; xuất kết quả vào `file_da_xu_ly` (tên file có ngày giờ).
- **Chỉ kết luận dựa trên số liệu có thật trong file — KHÔNG bịa số.**
- Mọi nhận định phải kèm **con số dẫn chứng** (giá trị, tỷ lệ %, xu hướng).
- **Ghi rõ giả định** khi dữ liệu chưa đủ, và nêu **dữ liệu còn thiếu** nếu có.
- Đối chiếu tổng tiền/số dòng trước–sau để bảo đảm không sai lệch.
- Tạo script Python trong `scripts` và file RUN để chạy lại.

## A1. Phân tích doanh thu tổng thể → đề xuất tăng trưởng

```text
Hãy phân tích file Excel trong thư mục file_can_xu_ly (dữ liệu kinh doanh).

Yêu cầu nghiệp vụ:
- Cột doanh thu: [tên cột]. Cột thời gian: [tên cột ngày]. Cột phân loại: [ví dụ: Sản phẩm/Khu vực/Nhân viên].
- Tính tổng doanh thu, tăng trưởng theo kỳ, nhóm đóng góp nhiều nhất (quy tắc 80/20).
- Chỉ ra điểm mạnh, điểm yếu và cơ hội tăng trưởng.
- ĐỀ XUẤT 3–5 hành động chiến lược cụ thể để tăng doanh thu, mỗi đề xuất kèm số liệu dẫn chứng và mức tác động ước tính (ghi rõ giả định).

Nguyên tắc:
- Không sửa file gốc; xuất kết quả vào file_da_xu_ly (tên có ngày giờ).
- Chỉ dùng số liệu thật, không bịa số; mọi nhận định kèm con số.
- Tạo sheet DU_LIEU_GOC, sheet TONG_HOP, sheet DE_XUAT (đề xuất chiến lược).
- Ghi rõ giả định và dữ liệu còn thiếu (nếu có).
- Báo số dòng trước/sau, đối chiếu tổng tiền; tạo script trong scripts và RUN để chạy lại.
```

## A2. Phân tích sản phẩm bán chạy / bán chậm → chiến lược danh mục

```text
Hãy phân tích file Excel trong thư mục file_can_xu_ly.

Yêu cầu nghiệp vụ:
- Cột sản phẩm: [tên cột]. Cột số lượng: [tên cột]. Cột doanh thu: [tên cột].
- Xếp hạng sản phẩm bán chạy nhất và bán chậm nhất; tính tỷ trọng đóng góp doanh thu của mỗi sản phẩm.
- Chỉ ra sản phẩm nên ĐẨY MẠNH, sản phẩm nên XEM XÉT LOẠI BỎ hoặc giảm tồn.
- ĐỀ XUẤT chiến lược danh mục sản phẩm kèm dẫn chứng số liệu.

Nguyên tắc:
- Không sửa file gốc; xuất kết quả vào file_da_xu_ly (tên có ngày giờ).
- Chỉ dùng số liệu thật; mọi nhận định kèm con số; ghi rõ giả định.
- Tạo sheet DU_LIEU_GOC, sheet XEP_HANG, sheet DE_XUAT.
- Tạo script trong scripts và RUN để chạy lại.
```

## A3. Phân tích khách hàng (RFM) → chiến lược giữ chân & chăm sóc

```text
Hãy phân tích file Excel trong thư mục file_can_xu_ly (dữ liệu đơn hàng/khách hàng).

Yêu cầu nghiệp vụ:
- Cột khách hàng: [tên cột]. Cột ngày mua: [tên cột]. Cột giá trị đơn: [tên cột].
- Phân nhóm khách hàng theo RFM: gần đây (Recency), tần suất (Frequency), giá trị (Monetary).
- Xác định: khách hàng VIP, khách hàng có nguy cơ rời bỏ, khách hàng mới tiềm năng.
- ĐỀ XUẤT chiến lược chăm sóc/giữ chân cho từng nhóm, kèm số liệu.

Nguyên tắc:
- Không sửa file gốc; xuất kết quả vào file_da_xu_ly (tên có ngày giờ).
- Chỉ dùng số liệu thật; ghi rõ giả định (ví dụ ngưỡng phân nhóm).
- Tạo sheet DU_LIEU_GOC, sheet PHAN_NHOM_RFM, sheet DE_XUAT.
- Tạo script trong scripts và RUN để chạy lại.
```

## A4. Phân tích theo khu vực / chi nhánh → phân bổ nguồn lực

```text
Hãy phân tích file Excel trong thư mục file_can_xu_ly.

Yêu cầu nghiệp vụ:
- Cột khu vực/chi nhánh: [tên cột]. Cột doanh thu: [tên cột]. Cột chi phí (nếu có): [tên cột].
- So sánh hiệu quả giữa các khu vực/chi nhánh (doanh thu, tăng trưởng, hiệu suất).
- Chỉ ra khu vực dẫn đầu và khu vực cần cải thiện.
- ĐỀ XUẤT cách phân bổ nguồn lực / ngân sách theo hiệu quả, kèm dẫn chứng.

Nguyên tắc:
- Không sửa file gốc; xuất kết quả vào file_da_xu_ly (tên có ngày giờ).
- Chỉ dùng số liệu thật; mọi nhận định kèm con số; ghi rõ giả định.
- Tạo sheet DU_LIEU_GOC, sheet SO_SANH_KHU_VUC, sheet DE_XUAT.
- Tạo script trong scripts và RUN để chạy lại.
```

## A5. Phân tích xu hướng theo thời gian / mùa vụ → kế hoạch kinh doanh

```text
Hãy phân tích file Excel trong thư mục file_can_xu_ly.

Yêu cầu nghiệp vụ:
- Cột thời gian: [tên cột ngày]. Chỉ số cần theo dõi: [ví dụ: doanh thu/số đơn].
- Phân tích xu hướng theo tháng/quý, phát hiện tính mùa vụ (tháng cao điểm/thấp điểm).
- Dự đoán định tính kỳ tới dựa trên xu hướng (ghi rõ đây là ước tính, kèm giả định).
- ĐỀ XUẤT kế hoạch theo mùa vụ: thời điểm đẩy mạnh bán, thời điểm tối ưu chi phí.

Nguyên tắc:
- Không sửa file gốc; xuất kết quả vào file_da_xu_ly (tên có ngày giờ).
- Chỉ dùng số liệu thật, không bịa số; nêu rõ phần nào là ước tính.
- Tạo sheet DU_LIEU_GOC, sheet XU_HUONG_THEO_THANG, sheet DE_XUAT.
- Tạo script trong scripts và RUN để chạy lại.
```

## A6. Phân tích lợi nhuận / biên lợi nhuận → chiến lược giá & chi phí

```text
Hãy phân tích file Excel trong thư mục file_can_xu_ly.

Yêu cầu nghiệp vụ:
- Cột doanh thu: [tên cột]. Cột giá vốn/chi phí: [tên cột]. Cột phân loại: [ví dụ: Sản phẩm/Khách hàng].
- Tính lợi nhuận và biên lợi nhuận (%) theo từng nhóm.
- Chỉ ra nhóm sinh lời cao và nhóm đang lỗ hoặc biên thấp.
- ĐỀ XUẤT chiến lược giá và cắt giảm chi phí, kèm số liệu và mức tác động ước tính.

Nguyên tắc:
- Không sửa file gốc; xuất kết quả vào file_da_xu_ly (tên có ngày giờ).
- Chỉ dùng số liệu thật; đối chiếu tổng doanh thu/chi phí trước–sau; ghi rõ giả định.
- Tạo sheet DU_LIEU_GOC, sheet LOI_NHUAN, sheet DE_XUAT.
- Tạo script trong scripts và RUN để chạy lại.
```

## A7. So sánh kỳ này với kỳ trước → điều chỉnh chiến lược

```text
Hãy phân tích các file Excel trong thư mục file_can_xu_ly (kỳ này và kỳ trước).

Yêu cầu nghiệp vụ:
- File/sheet kỳ này: [tên]. File/sheet kỳ trước: [tên]. Chỉ số so sánh: [ví dụ: doanh thu theo sản phẩm].
- So sánh tăng/giảm theo từng nhóm (số tuyệt đối và %).
- Chỉ ra nhóm tăng trưởng tốt và nhóm sụt giảm đáng lo.
- ĐỀ XUẤT điều chỉnh chiến lược cho kỳ tới, kèm dẫn chứng.

Nguyên tắc:
- Không sửa file gốc; xuất kết quả vào file_da_xu_ly (tên có ngày giờ).
- Chỉ dùng số liệu thật; mọi nhận định kèm con số; ghi rõ giả định.
- Tạo sheet SO_SANH, sheet DE_XUAT; báo dòng lỗi/không khớp.
- Tạo script trong scripts và RUN để chạy lại.
```

## A8. Báo cáo điều hành tổng hợp (Executive Summary) + đề xuất

```text
Hãy phân tích file Excel trong thư mục file_can_xu_ly và lập BÁO CÁO ĐIỀU HÀNH ngắn gọn.

Yêu cầu nghiệp vụ:
- Dữ liệu: [mô tả ngắn]. Các chỉ số chính (KPI): [ví dụ: doanh thu, số đơn, khách mới, biên lợi nhuận].
- Tóm tắt tình hình kinh doanh trong 8–12 gạch đầu dòng, mỗi ý kèm số liệu.
- Nêu 3 điểm sáng, 3 rủi ro, và 3–5 ĐỀ XUẤT hành động ưu tiên (kèm mức độ ưu tiên).
- Trình bày dễ đọc cho cấp quản lý không chuyên số liệu.

Nguyên tắc:
- Không sửa file gốc; xuất kết quả vào file_da_xu_ly (tên có ngày giờ).
- Chỉ dùng số liệu thật, không bịa; ghi rõ giả định và dữ liệu còn thiếu.
- Tạo sheet KPI_TONG_HOP và sheet DE_XUAT; kèm một bản tóm tắt .md trong file_da_xu_ly.
- Tạo script trong scripts và RUN để chạy lại.
```

## A9. Prompt chiến lược TỔNG QUÁT (chỉ cần điền vào chỗ trống)

```text
Hãy phân tích file Excel trong thư mục file_can_xu_ly để đề xuất chiến lược kinh doanh.

Thông tin đầu vào:
- Tên file: [ví dụ: doanh_thu_2026.xlsx]   - Sheet: [ví dụ: Sheet1]
- Cột thời gian: [ ]   - Cột doanh thu/số tiền: [ ]
- Cột phân loại chính: [ví dụ: Sản phẩm / Khu vực / Khách hàng / Kênh bán]
- Mục tiêu kinh doanh: [ví dụ: tăng doanh thu 20% / giảm chi phí / giữ chân khách]
- Câu hỏi cần trả lời: [ví dụ: nên tập trung vào sản phẩm/khu vực nào?]

Yêu cầu:
- Phân tích số liệu liên quan tới mục tiêu trên.
- Đưa ra 3–5 ĐỀ XUẤT chiến lược cụ thể, mỗi đề xuất kèm số liệu dẫn chứng,
  lợi ích kỳ vọng và mức độ ưu tiên.

Nguyên tắc:
- Không sửa file gốc; xuất kết quả vào file_da_xu_ly (tên có ngày giờ).
- Chỉ dùng số liệu thật trong file, KHÔNG bịa số; mọi nhận định kèm con số.
- Ghi rõ giả định và nêu dữ liệu còn thiếu để kết luận chắc chắn hơn.
- Tạo sheet DU_LIEU_GOC, sheet PHAN_TICH, sheet DE_XUAT.
- Nếu tên cột chưa rõ, hãy hỏi lại hoặc ghi rõ giả định, không tự suy đoán.
- Tạo script Python trong scripts và file RUN để chạy lại.
```

---

# PHẦN B — XỬ LÝ DỮ LIỆU CƠ BẢN

> Các prompt tiện ích để làm sạch / chuẩn bị dữ liệu trước khi phân tích chiến lược.

## 1. Lọc dữ liệu theo điều kiện

```text
Hãy phân tích file Excel trong thư mục file_can_xu_ly.

Yêu cầu nghiệp vụ:
Lọc các dòng có [tên cột] [điều kiện, ví dụ: lớn hơn 1.000.000 / bằng "Đã thanh toán"].
Xuất các dòng thỏa điều kiện ra file kết quả.

Nguyên tắc:
- Không sửa file gốc.
- Xuất file kết quả vào file_da_xu_ly.
- Giữ nguyên dữ liệu gốc trong một sheet riêng.
- Tạo sheet kết quả.
- Báo số dòng trước và sau xử lý.
- Báo các dòng lỗi.
- Tạo script Python trong scripts.
- Tạo file RUN.cmd để chạy lại.
```

## 2. Xóa dòng trùng

```text
Hãy phân tích file Excel trong thư mục file_can_xu_ly.

Yêu cầu nghiệp vụ:
Xóa các dòng bị trùng dựa trên [cột hoặc các cột dùng để xác định trùng, ví dụ: Mã khách hàng].
Giữ lại dòng [đầu tiên / cuối cùng].

Nguyên tắc:
- Không sửa file gốc.
- Xuất file kết quả vào file_da_xu_ly.
- Giữ nguyên dữ liệu gốc trong một sheet riêng.
- Tạo sheet kết quả.
- Báo số dòng trước và sau xử lý.
- Báo các dòng lỗi.
- Tạo script Python trong scripts.
- Tạo file RUN.cmd để chạy lại.
```

## 3. Đối chiếu hai file Excel

```text
Hãy phân tích các file Excel trong thư mục file_can_xu_ly.

Yêu cầu nghiệp vụ:
Đối chiếu file [tên file A] với file [tên file B] dựa trên cột khóa [ví dụ: Mã đơn hàng].
Liệt kê: dòng chỉ có ở A, dòng chỉ có ở B, dòng có ở cả hai nhưng khác nhau ở cột [tên cột].

Nguyên tắc:
- Không sửa file gốc.
- Xuất file kết quả vào file_da_xu_ly.
- Giữ nguyên dữ liệu gốc trong một sheet riêng.
- Tạo sheet kết quả.
- Báo số dòng trước và sau xử lý.
- Báo các dòng lỗi.
- Tạo script Python trong scripts.
- Tạo file RUN.cmd để chạy lại.
```

## 4. Đối chiếu hai sheet

```text
Hãy phân tích file Excel trong thư mục file_can_xu_ly.

Yêu cầu nghiệp vụ:
Đối chiếu sheet [tên sheet 1] với sheet [tên sheet 2] trong cùng một file, dựa trên cột khóa [tên cột].
Chỉ ra các khác biệt và các dòng bị thiếu ở mỗi sheet.

Nguyên tắc:
- Không sửa file gốc.
- Xuất file kết quả vào file_da_xu_ly.
- Giữ nguyên dữ liệu gốc trong một sheet riêng.
- Tạo sheet kết quả.
- Báo số dòng trước và sau xử lý.
- Báo các dòng lỗi.
- Tạo script Python trong scripts.
- Tạo file RUN.cmd để chạy lại.
```

## 5. Gộp nhiều file Excel

```text
Hãy phân tích tất cả các file Excel trong thư mục file_can_xu_ly.

Yêu cầu nghiệp vụ:
Gộp tất cả các file (hoặc các file có cùng cấu trúc cột) thành một bảng duy nhất.
Thêm một cột "Nguồn file" để biết mỗi dòng đến từ file nào.

Nguyên tắc:
- Không sửa file gốc.
- Xuất file kết quả vào file_da_xu_ly.
- Giữ nguyên dữ liệu gốc trong một sheet riêng.
- Tạo sheet kết quả.
- Báo số dòng trước và sau xử lý.
- Báo các dòng lỗi.
- Tạo script Python trong scripts.
- Tạo file RUN.cmd để chạy lại.
```

## 6. Chia file theo phòng ban

```text
Hãy phân tích file Excel trong thư mục file_can_xu_ly.

Yêu cầu nghiệp vụ:
Tách dữ liệu thành nhiều file, mỗi giá trị trong cột [ví dụ: Phòng ban] thành một file riêng.
Đặt tên file kết quả theo tên phòng ban.

Nguyên tắc:
- Không sửa file gốc.
- Xuất file kết quả vào file_da_xu_ly.
- Giữ nguyên dữ liệu gốc trong một sheet riêng.
- Tạo sheet kết quả.
- Báo số dòng trước và sau xử lý.
- Báo các dòng lỗi.
- Tạo script Python trong scripts.
- Tạo file RUN.cmd để chạy lại.
```

## 7. Tổng hợp doanh thu

```text
Hãy phân tích file Excel trong thư mục file_can_xu_ly.

Yêu cầu nghiệp vụ:
Tính tổng doanh thu theo [ví dụ: Nhân viên bán hàng / Sản phẩm / Chi nhánh].
Cột số tiền là [tên cột tiền]. Sắp xếp giảm dần theo tổng.

Nguyên tắc:
- Không sửa file gốc.
- Xuất file kết quả vào file_da_xu_ly.
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
Hãy phân tích file Excel trong thư mục file_can_xu_ly.

Yêu cầu nghiệp vụ:
Tổng hợp [ví dụ: doanh thu / số lượng đơn] theo từng tháng dựa trên cột ngày [tên cột ngày].
Kết quả có dạng bảng: Tháng | Tổng.

Nguyên tắc:
- Không sửa file gốc.
- Xuất file kết quả vào file_da_xu_ly.
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
Hãy phân tích file Excel trong thư mục file_can_xu_ly.

Yêu cầu nghiệp vụ:
Chuẩn hóa cột ngày [tên cột] về định dạng dd/mm/yyyy.
Chuẩn hóa cột tiền [tên cột] về dạng số (bỏ dấu chấm/phẩy ngăn cách, ký hiệu tiền tệ).
Đánh dấu các dòng không thể chuẩn hóa.

Nguyên tắc:
- Không sửa file gốc.
- Xuất file kết quả vào file_da_xu_ly.
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
Hãy phân tích file Excel trong thư mục file_can_xu_ly.

Yêu cầu nghiệp vụ:
Tìm các ô trống, dữ liệu thiếu, giá trị bất thường (ví dụ: số âm ở cột số lượng,
ngày trong tương lai, số tiền quá lớn bất thường) trong các cột [liệt kê cột].
Liệt kê rõ vị trí dòng và lý do bị đánh dấu.

Nguyên tắc:
- Không sửa file gốc.
- Xuất file kết quả vào file_da_xu_ly.
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
Hãy phân tích file Excel trong thư mục file_can_xu_ly.

Thông tin đầu vào:
- Tên file: [tên file, ví dụ: bao_cao_thang_7.xlsx]
- Tên sheet: [tên sheet, ví dụ: Sheet1]
- Cột cần xử lý: [liệt kê cột, ví dụ: Ngày, Số tiền, Khách hàng]
- Điều kiện xử lý: [mô tả điều kiện, ví dụ: chỉ lấy đơn đã thanh toán trong tháng 7]
- Kết quả mong muốn: [mô tả rõ, ví dụ: bảng tổng tiền theo khách hàng, sắp xếp giảm dần]

Nguyên tắc:
- Không sửa file gốc.
- Xuất file kết quả vào file_da_xu_ly (tên file có ngày giờ).
- Giữ nguyên dữ liệu gốc trong một sheet riêng.
- Tạo sheet kết quả.
- Báo số dòng trước và sau xử lý.
- Nếu có cột tiền, đối chiếu tổng tiền trước và sau.
- Báo các dòng lỗi, dòng bị loại và các giả định.
- Tạo script Python trong scripts.
- Tạo file RUN.cmd để chạy lại.
- Nếu tên cột chưa rõ, hãy hỏi lại hoặc ghi rõ giả định, không tự suy đoán.
```
