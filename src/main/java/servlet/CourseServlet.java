package servlet;

import dao.CourseDAO;
import model.Course;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/course")
public class CourseServlet extends HttpServlet {
    private final CourseDAO courseDAO = new CourseDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteCourse(request, response);
                    break;
                case "list":
                default:
                    listCourses(request, response);
                    break;
            }
        } catch (Exception ex) {
            throw new ServletException("Lỗi doGet trong CourseServlet", ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "insert":
                    insertCourse(request, response);
                    break;
                case "update":
                    updateCourse(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/course?action=list");
                    break;
            }
        } catch (Exception ex) {
            throw new ServletException("Lỗi doPost trong CourseServlet", ex);
        }
    }

    private void listCourses(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Course> list = courseDAO.getAllCourses();
        request.setAttribute("courseList", list);
        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/course-form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                Course existingCourse = courseDAO.getCourseById(id);
                request.setAttribute("course", existingCourse);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID môn học không hợp lệ!");
            }
        }
        request.getRequestDispatcher("/course-form.jsp").forward(request, response);
    }

    private void insertCourse(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        String name = request.getParameter("name");
        String creditsStr = request.getParameter("credits");
        String lecturer = request.getParameter("lecturer");
        String description = request.getParameter("description");


        if (code == null || code.trim().isEmpty() ||
            name == null || name.trim().isEmpty() ||
            creditsStr == null || creditsStr.trim().isEmpty() ||
            lecturer == null || lecturer.trim().isEmpty()) {
            
            request.setAttribute("error", "Tất cả các trường (trừ mô tả) đều bắt buộc!");
            request.getRequestDispatcher("/course-form.jsp").forward(request, response);
            return;
        }

        int credits;
        try {
            credits = Integer.parseInt(creditsStr.trim());
            if (credits <= 0) {
                request.setAttribute("error", "Số tín chỉ phải lớn hơn 0!");
                request.getRequestDispatcher("/course-form.jsp").forward(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Số tín chỉ phải là số nguyên!");
            request.getRequestDispatcher("/course-form.jsp").forward(request, response);
            return;
        }


        if (courseDAO.checkCodeExists(code.trim(), 0)) {
            request.setAttribute("error", "Mã môn học này đã tồn tại!");
            request.getRequestDispatcher("/course-form.jsp").forward(request, response);
            return;
        }

        Course newCourse = new Course(0, code.trim(), name.trim(), credits, lecturer.trim(), description.trim());
        if (courseDAO.addCourse(newCourse)) {
            response.sendRedirect(request.getContextPath() + "/course?action=list");
        } else {
            request.setAttribute("error", "Lỗi CSDL khi thêm môn học!");
            request.getRequestDispatcher("/course-form.jsp").forward(request, response);
        }
    }

    private void updateCourse(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String code = request.getParameter("code");
        String name = request.getParameter("name");
        String creditsStr = request.getParameter("credits");
        String lecturer = request.getParameter("lecturer");
        String description = request.getParameter("description");

        Course course = new Course(id, code, name, 0, lecturer, description);


        if (code == null || code.trim().isEmpty() ||
            name == null || name.trim().isEmpty() ||
            creditsStr == null || creditsStr.trim().isEmpty() ||
            lecturer == null || lecturer.trim().isEmpty()) {
            
            request.setAttribute("error", "Tất cả các trường (trừ mô tả) đều bắt buộc!");
            request.setAttribute("course", course);
            request.getRequestDispatcher("/course-form.jsp").forward(request, response);
            return;
        }

        int credits;
        try {
            credits = Integer.parseInt(creditsStr.trim());
            course.setCredits(credits);
            if (credits <= 0) {
                request.setAttribute("error", "Số tín chỉ phải lớn hơn 0!");
                request.setAttribute("course", course);
                request.getRequestDispatcher("/course-form.jsp").forward(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Số tín chỉ phải là số nguyên!");
            request.setAttribute("course", course);
            request.getRequestDispatcher("/course-form.jsp").forward(request, response);
            return;
        }


        if (courseDAO.checkCodeExists(code.trim(), id)) {
            request.setAttribute("error", "Mã môn học đã bị trùng với môn khác!");
            request.setAttribute("course", course);
            request.getRequestDispatcher("/course-form.jsp").forward(request, response);
            return;
        }

        course.setCode(code.trim());
        course.setName(name.trim());
        course.setLecturer(lecturer.trim());
        course.setDescription(description.trim());

        if (courseDAO.updateCourse(course)) {
            response.sendRedirect(request.getContextPath() + "/course?action=list");
        } else {
            request.setAttribute("error", "Lỗi CSDL khi cập nhật môn học!");
            request.setAttribute("course", course);
            request.getRequestDispatcher("/course-form.jsp").forward(request, response);
        }
    }

    private void deleteCourse(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                courseDAO.deleteCourse(id);
            } catch (NumberFormatException e) {

            }
        }
        response.sendRedirect(request.getContextPath() + "/course?action=list");
    }
}
