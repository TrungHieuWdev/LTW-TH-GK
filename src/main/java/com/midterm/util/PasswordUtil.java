package com.midterm.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {
    private PasswordUtil() {
    }

    public static String hashPassword(String plainPassword) {
        // Bam mat khau bang BCrypt truoc khi luu vao database.
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(10));
    }

    public static boolean checkPassword(String plainPassword, String passwordHash) {
        // So sanh mat khau nguoi dung nhap voi password_hash trong database.
        if (plainPassword == null || passwordHash == null) {
            return false;
        }
        return BCrypt.checkpw(plainPassword, passwordHash);
    }
}
