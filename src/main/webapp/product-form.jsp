<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Sua san pham</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
</head>
<body>
<div class="container small">
    <h1>Sua san pham</h1>

    <form action="${pageContext.request.contextPath}/products" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="${product.id}">

        <label for="name">Ten san pham</label>
        <input type="text" id="name" name="name" value="${product.name}" required>

        <label for="price">Gia</label>
        <input type="number" id="price" name="price" min="0" step="1000" value="${product.price}" required>

        <label for="quantity">So luong</label>
        <input type="number" id="quantity" name="quantity" min="0" value="${product.quantity}" required>

        <label for="description">Mo ta</label>
        <textarea id="description" name="description" rows="3">${product.description}</textarea>

        <button type="submit">Luu</button>
        <a class="button-link" href="${pageContext.request.contextPath}/products">Quay lai</a>
    </form>
</div>
</body>
</html>
