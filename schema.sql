CREATE DATABASE IF NOT EXISTS appdb CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE appdb;

DROP TABLE IF EXISTS registrations;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(256) NOT NULL,
    fullname VARCHAR(100) NOT NULL,
    role VARCHAR(20) DEFAULT 'student'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(20) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    credits INT NOT NULL,
    lecturer VARCHAR(100) NOT NULL,
    description TEXT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tai khoan mau de dang nhap:
-- admin / admin123
-- student / student123
-- Mat khau duoc luu bang SHA-256 hash, dung voi HashUtil.hashSHA256().
INSERT INTO users (username, password, fullname, role) VALUES
('admin', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'Quan tri vien', 'admin'),
('student', '703b0a3d6ad75b649a28adde7d83c6251da457549263bc7ff45ec709b0a8448b', 'Sinh vien mau', 'student');
