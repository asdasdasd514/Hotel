# HotelManagerment -> MongoDB export

Nguồn: SQL Server database `HotelManagerment`.

Đã chuyển:
- 41 SQL tables -> 41 MongoDB collections
- 1568 documents có dữ liệu
- Collection rỗng: PaymentMethods, ServiceComments
- `Id` của SQL được chuyển thành MongoDB `_id` (giữ nguyên số nguyên) khi bảng có cột Id.
- `bit` -> boolean.
- `datetime/datetime2` -> MongoDB Extended JSON `$date`.
- `decimal/numeric` -> MongoDB Decimal128 Extended JSON `$numberDecimal`.
- Các foreign key vẫn giữ dưới dạng ID để việc đổi backend dễ hơn.

## Import
1. Cài MongoDB Database Tools để có `mongoimport`.
2. Tạo MongoDB Atlas cluster/database.
3. Sửa `import_all.bat` với connection string.
4. Chạy `import_all.bat`.

Có thể import từng collection bằng:
`mongoimport --uri "<URI>" --db HotelManagerment --collection Amenities --file Amenities.json --jsonArray --mode=upsert --upsertFields _id`

## Lưu ý
Đây là bản migration 1-1 (SQL table -> Mongo collection), ưu tiên giữ dữ liệu và giảm công sức sửa backend.
MongoDB không bắt buộc schema như SQL Server, nên sau khi chạy ổn có thể tối ưu tiếp bằng cách embed các dữ liệu quan hệ phù hợp.
