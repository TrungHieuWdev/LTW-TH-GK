package com.midterm.controller;

import com.midterm.dao.UserDAO;
import com.midterm.model.User;
import com.midterm.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            User user = userDAO.findByUsername(username);

            // Kiem tra dang nhap bang username va mat khau BCrypt.
            if (user != null && PasswordUtil.checkPassword(password, user.getPasswordHash())) {
                HttpSession session = request.getSession();
                session.setAttribute("loggedInUser", user);
                response.sendRedirect(request.getContextPath() + "/products");
                return;
            }

            request.setAttribute("errorMessage", "Ten dang nhap hoac mat khau khong dung.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } catch (SQLException exception) {
            throw new ServletException("Loi khi kiem tra dang nhap", exception);
        }
    }
}
