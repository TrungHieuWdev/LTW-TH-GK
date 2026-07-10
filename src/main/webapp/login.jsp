<<<<<<< HEAD
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
=======
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
>>>>>>> 23873e3d3a5f58ff1b67806cc3adb144c36b9b03
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
<<<<<<< HEAD
    <title>Dang nhap</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>
<body>
<div class="container small">
    <h1>Dang nhap</h1>

    <c:if test="${not empty errorMessage}">
        <p class="error">${errorMessage}</p>
    </c:if>

    <c:if test="${not empty successMessage}">
        <p class="success">${successMessage}</p>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <label for="username">Ten dang nhap</label>
        <input type="text" id="username" name="username" required>

        <label for="password">Mat khau</label>
        <input type="password" id="password" name="password" required>

        <button type="submit">Dang nhap</button>
        <a class="button-link" href="${pageContext.request.contextPath}/register">Dang ky</a>
    </form>
</div>
=======
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập | DHV HCM</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="auth-wrapper">
        <div class="auth-card glass-panel">
            <div class="auth-header">
                <h2>Đăng Nhập</h2>
                <p>DHV HCM</p>
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


>>>>>>> 23873e3d3a5f58ff1b67806cc3adb144c36b9b03
</body>
</html>
