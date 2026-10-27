# HỆ THỐNG GIÁM SÁT TRẠM CẢM BIẾN NÔNG TRẠI SMARTFARM

## Hướng dẫn chạy script
```powershell
cd scripts
.\auto_report.ps1
```
*(Nếu bị lỗi ExecutionPolicy, hãy dùng lệnh sau: `powershell -ExecutionPolicy Bypass -File .\auto_report.ps1`)*

## Checklist kiểm tra thiết bị
- [x] Tạo cây thư mục (`docs`, `scripts`, `data`, `backup`) và file `.env` ẩn.
- [x] Hoàn thiện script `auto_report.ps1` lọc log không có lỗi phá hoại.
- [x] Xử lý Excel với hàm `TRIM` và `VLOOKUP`.
- [ ] Deploy hệ thống lên server.

## Bảng thông số phần cứng
| Mã linh kiện | Tên thiết bị | Đơn giá | Loại lưu trữ |
| --- | --- | --- | --- |
| LK001 | Cảm biến nhiệt độ độ ẩm | 150000 | N/A |
| LK002 | Modem Wifi | 450000 | N/A |
| LK003 | Thẻ nhớ 32GB | 120000 | SD Card |

## Phân tích hệ thống
### 1. Phân tích mô hình IPO của chức năng lọc log:
*   **Input (I):** Tệp `log-he-thong.log` chứa toàn bộ nhật ký ghi nhận của hệ thống các trạm cảm biến.
*   **Process (P):** Đọc từng dòng log, sử dụng Pipeline và lệnh `Select-String` để lọc ra các dòng chứa từ khóa "ERROR" hoặc "CRITICAL", sau đó đếm số lượng lỗi.
*   **Output (O):** Tệp `bao-cao-su-co.txt` chứa danh sách các dòng lỗi được lọc và tổng số sự cố phát sinh.

### 2. Phân loại theo tháp DIKW:
*   (a) “Quyết định thay modem trạm sensor-03 trước thứ Sáu.” ➜ **Wisdom (Khôn ngoan / Quyết định)**
*   (b) “2026-10-12 08:15:01 [ERROR] sensor-03 Connection TIMEOUT after 30s” ➜ **Data (Dữ liệu thô)**
*   (c) “Hôm nay hệ thống ghi nhận 8 sự cố, trong đó 4 sự cố đến từ trạm sensor-03.” ➜ **Information (Thông tin)**
*   (d) “Trạm sensor-03 hay mất kết nối vào buổi chiều do sóng yếu, nên cần lắp thêm anten.” ➜ **Knowledge (Tri thức)**

## Bẫy phần cứng
Tính toán thời gian tải file log 500 MB qua mạng 100 Mbps:
*   **Bước 1 - Đổi đơn vị:** 100 Mbps = 100 / 8 = 12.5 MB/s (Megabyte trên giây).
*   **Bước 2 - Tính thời gian:** Thời gian = Dung lượng / Tốc độ = 500 MB / 12.5 MB/s = **40 giây**.
