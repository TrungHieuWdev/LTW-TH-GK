<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
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
</body>
</html>
