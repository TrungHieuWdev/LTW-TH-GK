package com.midterm.controller;

import com.midterm.dao.UserDAO;
import com.midterm.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (isBlank(username) || isBlank(password) || isBlank(confirmPassword)) {
            request.setAttribute("errorMessage", "Vui long nhap day du thong tin.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Mat khau xac nhan khong khop.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        try {
            if (userDAO.existsByUsername(username)) {
                request.setAttribute("errorMessage", "Ten dang nhap da ton tai.");
                request.getRequestDispatcher("/register.jsp").forward(request, response);
                return;
            }

            String passwordHash = PasswordUtil.hashPassword(password);
            userDAO.insert(username, passwordHash);
            request.setAttribute("successMessage", "Tao tai khoan thanh cong. Vui long dang nhap.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } catch (SQLException exception) {
            throw new ServletException("Loi khi tao tai khoan", exception);
        }
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }
}
