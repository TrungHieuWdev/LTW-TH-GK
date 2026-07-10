package com.midterm.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String DEFAULT_URL = "jdbc:mysql://localhost:3306/product_management?useSSL=false&serverTimezone=UTC";
    private static final String DEFAULT_USERNAME = "root";
    private static final String DEFAULT_PASSWORD = "";

    private DBConnection() {
    }

    public static Connection getConnection() throws SQLException {
        String url = getEnvironmentValue("DB_URL", DEFAULT_URL);
        String username = getEnvironmentValue("DB_USERNAME", DEFAULT_USERNAME);
        String password = getEnvironmentValue("DB_PASSWORD", DEFAULT_PASSWORD);

        return DriverManager.getConnection(url, username, password);
    }

    private static String getEnvironmentValue(String key, String defaultValue) {
        String value = System.getenv(key);
        if (value == null || value.trim().isEmpty()) {
            return defaultValue;
        }
        return value;
    }
}
