CREATE DATABASE IF NOT EXISTS product_management
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE product_management;

DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(12, 2) NOT NULL,
    quantity INT NOT NULL,
    description TEXT
);

-- Tai khoan demo: admin / 123456
INSERT INTO users (username, password_hash)
VALUES ('admin', '$2a$10$ohvPxp4Cf3.MnL6Wr9N.7.AfVEGl41/YR7kVpgTZ6YHxQoQvlhkNS');

INSERT INTO products (name, price, quantity, description) VALUES
('But bi Thien Long', 5000, 100, 'But bi muc xanh dung cho hoc sinh'),
('Vo ke ngang', 12000, 50, 'Vo 200 trang'),
('Thuoc ke 20cm', 7000, 35, 'Thuoc ke nhua trong suot'),
('Hop but', 25000, 20, 'Hop dung but don gian');
