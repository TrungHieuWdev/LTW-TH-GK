<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Dang ky</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>
<body>
<div class="container small">
    <h1>Dang ky</h1>

    <c:if test="${not empty errorMessage}">
        <p class="error">${errorMessage}</p>
    </c:if>

    <form action="${pageContext.request.contextPath}/register" method="post">
        <label for="username">Ten dang nhap</label>
        <input type="text" id="username" name="username" required>

        <label for="password">Mat khau</label>
        <input type="password" id="password" name="password" required>

        <label for="confirmPassword">Nhap lai mat khau</label>
        <input type="password" id="confirmPassword" name="confirmPassword" required>

        <button type="submit">Tao tai khoan</button>
        <a class="button-link" href="${pageContext.request.contextPath}/login">Quay lai</a>
    </form>
</div>
</body>
</html>
