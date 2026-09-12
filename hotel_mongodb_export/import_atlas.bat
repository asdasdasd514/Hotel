@echo off
chcp 65001 > nul
echo =======================================================
echo   TOOL IMPORT DỮ LIỆU LÊN MONGODB ATLAS
echo =======================================================
echo.

set /p MONGODB_URI="Nhập Connection String của MongoDB Atlas: "

if "%MONGODB_URI%"=="" (
    echo.
    echo [Lỗi] Bạn chưa nhập connection string! Vui lòng chạy lại và dán chuỗi kết nối vào.
    echo.
    pause
    exit /b
)

echo.
echo Đang tiến hành nạp dữ liệu lên MongoDB Atlas...
echo.

node import_atlas.js "%MONGODB_URI%" "HotelManagerment"

echo.
pause
