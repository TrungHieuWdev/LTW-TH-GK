<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký tài khoản | Hệ thống quản lý môn học</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="auth-wrapper">
        <div class="auth-card glass-panel">
            <div class="auth-header">
                <h2>Đăng Ký</h2>
                <p>Tạo tài khoản mới cho sinh viên</p>
            </div>

            <%
                String error = (String) request.getAttribute("error");
                String username = (String) request.getAttribute("username");
                String fullname = (String) request.getAttribute("fullname");
                if (username == null) username = "";
                if (fullname == null) fullname = "";

                if (error != null) {
            %>
                <div class="alert alert-danger">
                    <%= error %>
                </div>
            <%
                }
            %>

            <form id="registerForm" action="${pageContext.request.contextPath}/register" method="post">
                <div class="form-group">
                    <label class="form-label" for="fullname">Họ và tên</label>
                    <input type="text" id="fullname" name="fullname" class="form-control" placeholder="Nhập họ tên của bạn..." value="<%= fullname %>" required autocomplete="off">
                </div>

                <div class="form-group">
                    <label class="form-label" for="username">Tên đăng nhập</label>
                    <input type="text" id="username" name="username" class="form-control" placeholder="Nhập tên tài khoản..." value="<%= username %>" required autocomplete="off">
                </div>

                <div class="form-group">
                    <label class="form-label" for="password">Mật khẩu</label>
                    <input type="password" id="password" name="password" class="form-control" placeholder="Nhập mật khẩu..." required>
                </div>

                <div class="form-group">
                    <label class="form-label" for="confirmpassword">Xác nhận mật khẩu</label>
                    <input type="password" id="confirmpassword" name="confirmpassword" class="form-control" placeholder="Nhập lại mật khẩu..." required>
                </div>

                <button type="submit" class="btn btn-primary">Đăng Ký</button>
            </form>

            <div class="auth-footer">
                Đã có tài khoản? <a href="${pageContext.request.contextPath}/login.jsp">Đăng nhập</a>
            </div>
        </div>
    </div>



    <script>
        const form = document.getElementById('registerForm');
        const pass = document.getElementById('password');
        const confirmPass = document.getElementById('confirmpassword');

        form.addEventListener('submit', function (e) {
            if (pass.value !== confirmPass.value) {
                e.preventDefault();
                alert('Mật khẩu xác nhận không khớp! Vui lòng nhập lại.');
            }
        });
    </script>
</body>
</html>
