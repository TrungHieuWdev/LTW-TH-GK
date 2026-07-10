<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh sach san pham</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>
<body>
<div class="container">
    <div class="top-bar">
        <h1>Danh sach san pham</h1>
        <a href="${pageContext.request.contextPath}/logout">Dang xuat</a>
    </div>

    <h2>Them san pham</h2>
    <form action="${pageContext.request.contextPath}/products" method="post" class="product-form">
        <label for="name">Ten san pham</label>
        <input type="text" id="name" name="name" required>

        <label for="price">Gia</label>
        <input type="number" id="price" name="price" min="0" step="1000" required>

        <label for="quantity">So luong</label>
        <input type="number" id="quantity" name="quantity" min="0" required>

        <label for="description">Mo ta</label>
        <textarea id="description" name="description" rows="3"></textarea>

        <button type="submit">Them</button>
    </form>

    <h2>San pham hien co</h2>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Ten san pham</th>
            <th>Gia</th>
            <th>So luong</th>
            <th>Mo ta</th>
            <th>Thao tac</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="product" items="${products}">
            <tr>
                <td>${product.id}</td>
                <td>${product.name}</td>
                <td>${product.price}</td>
                <td>${product.quantity}</td>
                <td>${product.description}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/products?action=edit&id=${product.id}">Sua</a>
                    |
                    <a href="${pageContext.request.contextPath}/products?action=delete&id=${product.id}"
                       onclick="return confirm('Ban co chac muon xoa san pham nay?');">Xoa</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
