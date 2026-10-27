# AUDIT: xác nhận đã thẩm định script

# Định nghĩa đường dẫn tương đối (chạy từ thư mục scripts/)
# Giả định file log-he-thong.log nằm ở thư mục gốc, nếu nằm trong data/ hãy đổi thành "..\data\log-he-thong.log"
$LogPath = "..\data\log-he-thong.log"
$ReportPath = "..\backup\bao-cao-su-co.txt"

# Lấy ngày giờ hiện tại
$CurrentDate = Get-Date -Format "dd/MM/yyyy HH:mm"

# 1. Tạo tiêu đề báo cáo và ghi đè (>) vào file báo cáo (để làm mới nội dung mỗi lần chạy)
Write-Output "========================================" > $ReportPath
Write-Output "    BAO CAO SU CO - SMARTFARM" >> $ReportPath
Write-Output "    Ngay gio: $CurrentDate" >> $ReportPath
Write-Output "========================================" >> $ReportPath

# 2. Dùng Pipeline lọc các dòng CRITICAL hoặc ERROR và chèn nối (>>)
Get-Content $LogPath | Select-String -Pattern "CRITICAL|ERROR" >> $ReportPath

# 3. Dùng thêm Pipeline đếm số sự cố và ghi vào cuối file
Write-Output "----------------------------------------" >> $ReportPath
Write-Output "TONG SO SU CO:" >> $ReportPath
Get-Content $LogPath | Select-String -Pattern "CRITICAL|ERROR" | Measure-Object | Select-Object -ExpandProperty Count >> $ReportPath

# Thông báo ra màn hình console (tùy chọn để biết script đã chạy xong)
Write-Host "Da tao bao cao thanh cong tai: $ReportPath" -ForegroundColor Green
