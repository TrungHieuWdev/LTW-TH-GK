# Java Web Product Management

Project bai giua ky Java Web dung Servlet, JSP, JDBC, MySQL va BCrypt. Project co the chay bang Maven voi `tomcat7:run` hoac deploy file WAR len Tomcat.

## Cong nghe su dung

- Java Servlet voi `javax.servlet`
- JSP va JSTL
- JDBC ket noi MySQL
- BCrypt de bam va kiem tra mat khau
- Maven dong goi file WAR
- Khong dung Spring Boot, React hoac framework giao dien

## Cau truc thu muc

```text
src/main/java/com/midterm/controller
    LoginServlet.java
    LogoutServlet.java
    ProductServlet.java

src/main/java/com/midterm/dao
    UserDAO.java
    ProductDAO.java

src/main/java/com/midterm/model
    User.java
    Product.java

src/main/java/com/midterm/util
    DBConnection.java
    PasswordUtil.java

src/main/webapp
    login.jsp
    product-list.jsp
    product-form.jsp
    assets/style.css
    WEB-INF/web.xml
```

## Huong dan cai dat

1. Cai JDK 8 tro len.
2. Cai Maven.
3. Cai Apache Tomcat 7 hoac Tomcat 9.
4. Cai MySQL Server.
5. Mo MySQL va import file `database.sql`.

Vi du import bang command line:

```bash
mysql -u root -p < database.sql
```

## Cau hinh ket noi MySQL

Mac dinh project ket noi MySQL voi thong tin:

```java
jdbc:mysql://localhost:3306/product_management?useSSL=false&serverTimezone=UTC
root
mat khau rong
```

Neu MySQL cua ban co mat khau, khong nen ghi mat khau truc tiep vao code. Hay dat bien moi truong truoc khi chay:

```powershell
$env:DB_USERNAME="root"
$env:DB_PASSWORD="mat_khau_mysql_cua_ban"
```

Neu database khac ten hoac port khac:

```powershell
$env:DB_URL="jdbc:mysql://localhost:3306/product_management?useSSL=false&serverTimezone=UTC"
```

Luu y: khong push mat khau MySQL len GitHub.

## Build project

Chay lenh:

```bash
.\mvnw.cmd clean package
```

Sau khi build thanh cong, file WAR nam tai:

```text
target/product-management.war
```

## Chay nhanh bang Maven Tomcat 7 plugin

Chay lenh:

```powershell
.\mvnw.cmd tomcat7:run
```

Mo trinh duyet:

```text
http://localhost:8080/product-management/login
```

## Deploy len Tomcat

1. Copy file `target/product-management.war`.
2. Dan vao thu muc `webapps` cua Tomcat.
3. Chay Tomcat bang `startup.bat` tren Windows hoac `startup.sh` tren Linux/macOS.
4. Mo trinh duyet:

```text
http://localhost:8080/product-management/login
```

## Tai khoan demo

```text
Username: admin
Password: 123456
```

Mat khau trong database duoc luu o cot `password_hash` va da duoc bam bang BCrypt, khong luu mat khau thuong.

## Giai thich code ngan gon

- `LoginServlet`: nhan username va password tu `login.jsp`, tim user trong database bang `UserDAO`, sau do dung `PasswordUtil.checkPassword()` de kiem tra mat khau voi BCrypt. Neu dung thi tao session va chuyen sang `/products`. Neu sai thi quay lai `login.jsp` va hien thi loi.
- `LogoutServlet`: huy session hien tai va chuyen ve trang dang nhap.
- `ProductServlet`: kiem tra session truoc khi hien thi danh sach san pham. Neu chua dang nhap thi chuyen ve `/login`. Servlet nay xu ly hien thi danh sach, them, sua va xoa san pham.
- `UserDAO`: dung `PreparedStatement` de lay user theo username, khong noi chuoi SQL truc tiep.
- `ProductDAO`: dung `PreparedStatement` cho cac chuc nang lay danh sach, them, sua va xoa san pham.
- `DBConnection`: tao ket noi JDBC toi MySQL.
- `PasswordUtil`: chua ham bam mat khau va ham kiem tra mat khau bang BCrypt.
- `login.jsp`: form dang nhap va hien thi loi khi dang nhap sai.
- `product-list.jsp`: hien thi bang san pham va form them san pham.
- `product-form.jsp`: form sua san pham.

## Luong chay chinh

1. Nguoi dung vao `/login`.
2. Nhap `admin / 123456`.
3. `LoginServlet` lay user trong MySQL.
4. BCrypt so sanh mat khau nhap vao voi `password_hash`.
5. Neu dung, servlet tao session `loggedInUser` va chuyen sang `/products`.
6. Neu truy cap `/products` khi chua co session, `ProductServlet` chuyen ve `/login`.
7. Nguoi dung co the them, sua, xoa san pham.
8. Bam dang xuat thi `LogoutServlet` huy session.
