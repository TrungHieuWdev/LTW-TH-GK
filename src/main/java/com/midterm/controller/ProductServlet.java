package com.midterm.controller;

import com.midterm.dao.ProductDAO;
import com.midterm.model.Product;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        try {
            if ("edit".equals(action)) {
                showEditForm(request, response);
            } else if ("delete".equals(action)) {
                deleteProduct(request, response);
            } else {
                showProductList(request, response);
            }
        } catch (SQLException exception) {
            throw new ServletException("Loi khi xu ly san pham", exception);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try {
            if ("update".equals(action)) {
                updateProduct(request, response);
            } else {
                addProduct(request, response);
            }
        } catch (SQLException exception) {
            throw new ServletException("Loi khi luu san pham", exception);
        }
    }

    private boolean isLoggedIn(HttpServletRequest request) {
        // Kiem tra session truoc khi cho xem danh sach san pham.
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("loggedInUser") != null;
    }

    private void showProductList(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        request.setAttribute("products", productDAO.findAll());
        request.getRequestDispatcher("/product-list.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Product product = productDAO.findById(id);
        request.setAttribute("product", product);
        request.getRequestDispatcher("/product-form.jsp").forward(request, response);
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        // Them san pham moi tu du lieu form.
        Product product = readProductFromRequest(request);
        productDAO.insert(product);
        response.sendRedirect(request.getContextPath() + "/products");
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        // Sua thong tin san pham theo id.
        Product product = readProductFromRequest(request);
        product.setId(Integer.parseInt(request.getParameter("id")));
        productDAO.update(product);
        response.sendRedirect(request.getContextPath() + "/products");
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {

        // Xoa san pham theo id.
        int id = Integer.parseInt(request.getParameter("id"));
        productDAO.delete(id);
        response.sendRedirect(request.getContextPath() + "/products");
    }

    private Product readProductFromRequest(HttpServletRequest request) {
        Product product = new Product();
        product.setName(request.getParameter("name"));
        product.setPrice(new BigDecimal(request.getParameter("price")));
        product.setQuantity(Integer.parseInt(request.getParameter("quantity")));
        product.setDescription(request.getParameter("description"));
        return product;
    }
}
