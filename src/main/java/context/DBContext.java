package context;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {

    private final String SERVER = getConfig("DB_HOST", "db.host", "127.0.0.1");
    private final String PORT = getConfig("DB_PORT", "db.port", "3306");
    private final String DATABASE = getConfig("DB_NAME", "db.name", "appdb");
    private final String USER = getConfig("DB_USER", "db.user", "root");
    private final String PASSWORD = getConfig("DB_PASSWORD", "db.password", "Admin@123456");

    private String getConfig(String envName, String propertyName, String defaultValue) {
        String propertyValue = System.getProperty(propertyName);
        if (propertyValue != null && !propertyValue.isBlank()) {
            return propertyValue;
        }

        String envValue = System.getenv(envName);
        if (envValue != null && !envValue.isBlank()) {
            return envValue;
        }

        return defaultValue;
    }

    public Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://" + SERVER + ":" + PORT + "/" + DATABASE
                    + "?useSSL=false"
                    + "&serverTimezone=Asia/Ho_Chi_Minh"
                    + "&allowPublicKeyRetrieval=true"
                    + "&useUnicode=true"
                    + "&characterEncoding=UTF-8";

            conn = DriverManager.getConnection(url, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("[LỖI] Kết nối CSDL thất bại: " + e.getMessage());
            e.printStackTrace();
        }
        return conn;
    }

    public static void main(String[] args) {
        DBContext db = new DBContext();
        if (db.getConnection() != null) {
            System.out.println("Kết nối MySQL thành công!");
        } else {
            System.out.println("Kết nối MySQL thất bại!");
        }
    }
}
