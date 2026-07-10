<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="model.Course" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bảng điều khiển | Quản lý môn học</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <%
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
    %>

    <header class="header-nav glass-panel">
        <a href="${pageContext.request.contextPath}/course?action=list" class="logo-brand">DHV HCM</a>
        <div class="user-profile">
            <div class="user-role"><%= currentUser.getRole().equals("admin") ? "Quản trị viên" : "Sinh viên" %></div>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-secondary btn-sm">Đăng xuất</a>
        </div>
    </header>

    <main class="main-content">
        <div class="dashboard-title-bar">
            <div>
                <h1>Danh sách Môn học</h1>
                <p style="color: var(--text-muted); margin-top: 4px;">Hệ thống quản lý học phần giữa kỳ</p>
            </div>
            <a href="${pageContext.request.contextPath}/course?action=new" class="btn btn-primary btn-sm" style="width: auto;">
                Thêm Môn học Mới
            </a>
        </div>

        <div class="course-grid">
            <%
                List<Course> courses = (List<Course>) request.getAttribute("courseList");
                if (courses != null && !courses.isEmpty()) {
                    for (Course c : courses) {
            %>
                <div class="course-card glass-panel">
                    <span class="course-badge"><%= c.getCode() %></span>
                    <h3 class="course-title"><%= c.getName() %></h3>
                    <div class="course-lecturer">
                        Giảng viên: <strong><%= c.getLecturer() %></strong>
                    </div>
                    <p class="course-desc">
                        <%= c.getDescription() != null && !c.getDescription().isEmpty() ? c.getDescription() : "Không có mô tả chi tiết cho môn học này." %>
                    </p>
                    <div class="course-stats">
                        <span class="credits-badge">
                            Tín chỉ: <strong><%= c.getCredits() %></strong>
                        </span>
                        <div class="course-actions">
                            <a href="${pageContext.request.contextPath}/course?action=edit&id=<%= c.getId() %>" class="btn btn-secondary btn-sm">Sửa</a>
                            <a href="${pageContext.request.contextPath}/course?action=delete&id=<%= c.getId() %>" 
                               class="btn btn-danger btn-sm"
                               onclick="return confirm('Bạn có chắc chắn muốn xóa môn học <%= c.getName() %> (<%= c.getCode() %>) không?');">Xóa</a>
                        </div>
                    </div>
                </div>
            <%
                    }
                } else {
            %>
                <div class="empty-state glass-panel">
                    <h3>Chưa có môn học nào</h3>
                    <p>Hãy thêm môn học đầu tiên để bắt đầu quản lý chương trình.</p>
                    <a href="${pageContext.request.contextPath}/course?action=new" class="btn btn-primary btn-sm">Thêm môn học</a>
                </div>
            <%
                }
            %>
        </div>
    </main>


</body>
</html>
