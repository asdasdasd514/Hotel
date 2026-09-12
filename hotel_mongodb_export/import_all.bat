@echo off
REM Run from this folder with MongoDB Database Tools installed.
REM Replace the URI with your MongoDB Atlas connection string.

set MONGO_URI="mongodb+srv://<USERNAME>:<PASSWORD>@<CLUSTER>/<DB>?retryWrites=true&w=majority"
set DB_NAME=HotelManagerment

mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "Amenities" --file "Amenities.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "AmenityDetails" --file "AmenityDetails.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "ArticleCategories" --file "ArticleCategories.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "ArticleComments" --file "ArticleComments.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "Articles" --file "Articles.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "AttractionImages" --file "AttractionImages.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "Attractions" --file "Attractions.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "AuditLogs" --file "AuditLogs.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "AuditLogSettings" --file "AuditLogSettings.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "BookingDetails" --file "BookingDetails.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "Bookings" --file "Bookings.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "EquipmentHistories" --file "EquipmentHistories.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "Equipments" --file "Equipments.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "Guests" --file "Guests.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "Invoices" --file "Invoices.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "Loss_And_Damages" --file "Loss_And_Damages.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "Memberships" --file "Memberships.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "Notifications" --file "Notifications.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "Order_Service_Details" --file "Order_Service_Details.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "Order_Services" --file "Order_Services.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "PaymentMethods" --file "PaymentMethods.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "Payments" --file "Payments.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "Permissions" --file "Permissions.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "Reviews" --file "Reviews.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "Role_Dashboard_Period_States" --file "Role_Dashboard_Period_States.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "RolePermissions" --file "RolePermissions.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "Roles" --file "Roles.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "RoomAmenities" --file "RoomAmenities.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "RoomImages" --file "RoomImages.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "RoomInventory" --file "RoomInventory.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "Rooms" --file "Rooms.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "RoomTypeAmenities" --file "RoomTypeAmenities.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "RoomTypes" --file "RoomTypes.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "ServiceCategories" --file "ServiceCategories.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "ServiceComments" --file "ServiceComments.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "ServiceImages" --file "ServiceImages.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "Services" --file "Services.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "UserPaymentMethods" --file "UserPaymentMethods.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "Users" --file "Users.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "UserVouchers" --file "UserVouchers.json" --jsonArray --mode=upsert --upsertFields _id
mongoimport --uri %MONGO_URI% --db %DB_NAME% --collection "Vouchers" --file "Vouchers.json" --jsonArray --mode=upsert --upsertFields _id