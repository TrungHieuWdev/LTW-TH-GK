package dao;

import context.DBContext;
import model.Course;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CourseDAO {

    public List<Course> getAllCourses() {
        List<Course> list = new ArrayList<>();
        String sql = "SELECT id, code, name, credits, lecturer, description FROM courses ORDER BY id DESC";
        
        try (
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()
        ) {
            while (rs.next()) {
                list.add(new Course(
                    rs.getInt("id"),
                    rs.getString("code"),
                    rs.getString("name"),
                    rs.getInt("credits"),
                    rs.getString("lecturer"),
                    rs.getString("description")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Course getCourseById(int id) {
        String sql = "SELECT id, code, name, credits, lecturer, description FROM courses WHERE id = ?";
        try (
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Course(
                        rs.getInt("id"),
                        rs.getString("code"),
                        rs.getString("name"),
                        rs.getInt("credits"),
                        rs.getString("lecturer"),
                        rs.getString("description")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addCourse(Course course) {
        String sql = "INSERT INTO courses (code, name, credits, lecturer, description) VALUES (?, ?, ?, ?, ?)";
        try (
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, course.getCode());
            ps.setString(2, course.getName());
            ps.setInt(3, course.getCredits());
            ps.setString(4, course.getLecturer());
            ps.setString(5, course.getDescription());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateCourse(Course course) {
        String sql = "UPDATE courses SET code = ?, name = ?, credits = ?, lecturer = ?, description = ? WHERE id = ?";
        try (
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, course.getCode());
            ps.setString(2, course.getName());
            ps.setInt(3, course.getCredits());
            ps.setString(4, course.getLecturer());
            ps.setString(5, course.getDescription());
            ps.setInt(6, course.getId());
            
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteCourse(int id) {
        String sql = "DELETE FROM courses WHERE id = ?";
        try (
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkCodeExists(String code, int excludeId) {
        String sql = "SELECT 1 FROM courses WHERE code = ? AND id != ?";
        try (
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {
            ps.setString(1, code);
            ps.setInt(2, excludeId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
