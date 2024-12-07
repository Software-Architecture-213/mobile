# mobile

Phân hệ dành cho App.

## Getting Started
lib/
├── main.dart                  # Tệp chính khởi động ứng dụng
├── views/                     # Chứa các màn hình và giao diện người dùng
├── utils/                     # Chứa các tiện ích và hàm hỗ trợ
├── constants/                 # Chứa các hằng số và cấu hình
├── cores/                     # Chứa các thành phần cốt lõi của ứng dụng
├── services/              # Chứa các dịch vụ (services) như API, database
├── viewmodels/                # Chứa các ViewModel cho quản lý trạng thái
└── models/                    # Chứa các mô hình dữ liệu

### Quy tắc lập trình (Coding Conventions)
1. Tên biến và hàm
    Sử dụng camelCase cho tên biến và hàm.
    Ví dụ: userName, getUserData().
2. Tên lớp
    Sử dụng PascalCase cho tên lớp.
    Ví dụ: LoginPage, UserProfile.
3. Tên tệp
    Tên tệp nên sử dụng snake_case và phản ánh nội dung của tệp.
    Ví dụ: login_screen.dart, email_validator.dart.
4. Cấu trúc thư mục
    Tổ chức mã nguồn theo chức năng (feature-based) hoặc theo loại (model, view, controller).
    Đặt các tệp liên quan đến một chức năng cụ thể trong cùng một thư mục.
5. Comment
    Sử dụng comment để giải thích các đoạn mã phức tạp hoặc không rõ ràng.
    Sử dụng comment để mô tả các hàm và lớp.
6. Quản lý trạng thái
    Sử dụng các giải pháp là Provider để quản lý trạng thái ứng dụng.
7. Quản lý phụ thuộc
    Sử dụng pubspec.yaml để quản lý các gói phụ thuộc và đảm bảo rằng các gói được cập nhật thường xuyên.