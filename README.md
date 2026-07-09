# Bai thi giua ky - He thong quan ly mon hoc

Ung dung web quan ly mon hoc viet bang Java Servlet/JSP, dung MySQL va Maven.

## 1. Chuan bi co so du lieu

Chay file `schema.sql` de tao database `appdb` va cac bang can thiet.

Neu dung script da co trong du an:

```powershell
.\setup-db.ps1 -DbUser root -DbPassword "MAT_KHAU_MYSQL"
```

Thay `MAT_KHAU_MYSQL` bang mat khau MySQL tren may cua ban.

## 2. Chay du an

Chay lenh Maven sau tai thu muc goc cua du an:

```bash
mvn tomcat7:run
```

Sau do mo trinh duyet:

```text
http://localhost:8080/
```

Neu MySQL cua ban co mat khau, chay bang script sau de app nhan dung thong tin database:

```powershell
.\run.ps1 -DbUser root -DbPassword "MAT_KHAU_MYSQL"
```
