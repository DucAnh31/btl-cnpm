# Ứng dụng quản lý và học tập theo khóa học

Base Java Swing dùng chung cho nhóm. Model đã có thuộc tính, getter và setter. DAO có sẵn chữ ký phương thức; View có hàm tạo, `initComponents()` và xử lý sự kiện để triển khai tiếp trên từng nhánh. Các phương thức nghiệp vụ còn TODO, chưa có SQL và sẽ báo chưa triển khai nếu gọi.

## Cấu trúc

```text
btl-cnpm/
├── .env.example
├── database/
│   ├── schema.sql
│   └── seed.sql
├── src/main/java/
│   ├── app/Main.java
│   ├── model/
│   │   └── enums/
│   ├── dao/
│   └── view/
│       ├── MainFrm.java
│       ├── user/
│       ├── admin/
│       ├── course/
│       └── quiz/
└── pom.xml
```

## Cách chạy

Cần Java 17, Maven và MySQL 8. Chạy các lệnh từ thư mục dự án.

1. Sao chép `.env.example` thành `.env`, điền `DB_URL`, `DB_USERNAME`, `DB_PASSWORD`. File `.env` không đưa lên Git.

2. Tạo CSDL rồi thêm dữ liệu mẫu, mỗi script chạy một lần trên CSDL mới:

   ```sh
   mysql -u root -p < database/schema.sql
   mysql -u root -p < database/seed.sql
   ```

3. Build và chạy:

   ```sh
   mvn package
   java -jar target/btl-cnpm-jar-with-dependencies.jar
   ```

Có thể mở bằng IDE dưới dạng Maven project và chạy `app.Main`. Hiện ứng dụng mở `MainFrm`; các form nghiệp vụ chưa gắn luồng xử lý.

Dữ liệu mẫu có `admin`, `teacher01`, `teacher02`, `student01`, `student02`, `student03`, `student_blocked`. Mật khẩu chung là `Demo@123`, lưu dưới dạng BCrypt; `student_blocked` là tài khoản bị khóa. Có khóa nháp/đang mở/đã đóng, quiz, kết quả làm lại, câu bỏ trống và lượt hủy. Tài liệu chỉ có thông tin giả lập, chưa có file thật nên chưa cho tải.
