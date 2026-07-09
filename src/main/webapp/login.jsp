<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập | Hệ thống quản lý môn học</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="auth-wrapper">
        <div class="auth-card glass-panel">
            <div class="auth-header">
                <h2>Đăng Nhập</h2>
                <p>Hệ thống Quản lý Môn học Giữa kỳ</p>
            </div>

            <%
                String error = (String) request.getAttribute("error");
                String success = (String) request.getAttribute("success");
                String username = (String) request.getAttribute("username");
                if (username == null) username = "";

                if (error != null) {
            %>
                <div class="alert alert-danger">
                    <%= error %>
                </div>
            <%
                }
                if (success != null) {
            %>
                <div class="alert alert-success">
                    <%= success %>
                </div>
            <%
                }
            %>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label class="form-label" for="username">Tên đăng nhập</label>
                    <input type="text" id="username" name="username" class="form-control" placeholder="Nhập tên tài khoản..." value="<%= username %>" required autocomplete="off">
                </div>

                <div class="form-group">
                    <label class="form-label" for="password">Mật khẩu</label>
                    <input type="password" id="password" name="password" class="form-control" placeholder="Nhập mật khẩu..." required>
                </div>

                <button type="submit" class="btn btn-primary">Đăng Nhập</button>
            </form>

            <div class="auth-footer">
                Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register.jsp">Đăng ký ngay</a>
            </div>
        </div>
    </div>


</body>
</html>
