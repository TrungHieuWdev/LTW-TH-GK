<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="model.Course" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Biểu mẫu môn học | Quản lý môn học</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Course c = (Course) request.getAttribute("course");
        boolean isEdit = (c != null);
        String formAction = isEdit ? "update" : "insert";
        String pageTitle = isEdit ? "Cập Nhật Môn Học" : "Thêm Môn Học Mới";
    %>

    <header class="header-nav glass-panel">
        <a href="${pageContext.request.contextPath}/course?action=list" class="logo-brand">DHV EdTech</a>
        <div class="user-profile">
            <div class="user-info">
                <div class="user-name"><%= currentUser.getFullname() %></div>
                <div class="user-role"><%= currentUser.getRole().equals("admin") ? "Quản trị viên" : "Sinh viên" %></div>
            </div>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary btn-sm">Đăng xuất</a>
        </div>
    </header>

    <main class="main-content">
        <div class="form-panel glass-panel">
            <h2 class="form-panel-title"><%= pageTitle %></h2>

            <%
                String error = (String) request.getAttribute("error");
                if (error != null) {
            %>
                <div class="alert alert-danger">
                    <%= error %>
                </div>
            <%
                }
            %>

            <form action="${pageContext.request.contextPath}/course?action=<%= formAction %>" method="post">
                <% if (isEdit) { %>
                    <input type="hidden" name="id" value="<%= c.getId() %>">
                <% } %>

                <div class="form-group">
                    <label class="form-label" for="code">Mã môn học</label>
                    <input type="text" id="code" name="code" class="form-control" placeholder="Ví dụ: IT001, MATH102..." 
                           value="<%= isEdit && c.getCode() != null ? c.getCode() : "" %>" required autocomplete="off">
                </div>

                <div class="form-group">
                    <label class="form-label" for="name">Tên môn học</label>
                    <input type="text" id="name" name="name" class="form-control" placeholder="Nhập tên môn học..." 
                           value="<%= isEdit && c.getName() != null ? c.getName() : "" %>" required autocomplete="off">
                </div>

                <div class="form-group">
                    <label class="form-label" for="credits">Số tín chỉ</label>
                    <input type="number" id="credits" name="credits" class="form-control" min="1" max="10" placeholder="Nhập số tín chỉ..." 
                           value="<%= isEdit && c.getCredits() > 0 ? c.getCredits() : "" %>" required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="lecturer">Giảng viên phụ trách</label>
                    <input type="text" id="lecturer" name="lecturer" class="form-control" placeholder="Nhập tên giảng viên..." 
                           value="<%= isEdit && c.getLecturer() != null ? c.getLecturer() : "" %>" required autocomplete="off">
                </div>

                <div class="form-group">
                    <label class="form-label" for="description">Mô tả chi tiết</label>
                    <textarea id="description" name="description" class="form-control form-textarea" placeholder="Nhập mô tả tóm tắt học phần..."><%= isEdit && c.getDescription() != null ? c.getDescription() : "" %></textarea>
                </div>

                <div class="form-actions-row">
                    <button type="submit" class="btn btn-primary">Lưu thông tin</button>
                    <a href="${pageContext.request.contextPath}/course?action=list" class="btn btn-secondary">Hủy bỏ</a>
                </div>
            </form>
        </div>
    </main>


</body>
</html>
