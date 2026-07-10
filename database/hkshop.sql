-- HKShop Database Setup
-- Run this file to create the complete database
-- Command: mysql -u root -p < database/hkshop.sql

CREATE DATABASE IF NOT EXISTS hkshop;
USE hkshop;

CREATE TABLE users (
    id       INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50),
    password VARCHAR(60),
    email    VARCHAR(100),
    role     VARCHAR(10)
);

CREATE TABLE products (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100),
    price       DOUBLE,
    description VARCHAR(200),
    quantity    INT DEFAULT 10,
    image       VARCHAR(500)
);

CREATE TABLE customer_info (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    user_id    INT,
    first_name VARCHAR(50),
    last_name  VARCHAR(50),
    city       VARCHAR(50),
    address    VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE orders (
    id             INT AUTO_INCREMENT PRIMARY KEY,
    user_id        INT,
    payment_method VARCHAR(20),
    total_amount   DOUBLE,
    order_date     DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE order_items (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    order_id   INT,
    product_id INT,
    quantity   INT,
    price      DOUBLE,
    FOREIGN KEY (order_id)   REFERENCES orders(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Default admin account
INSERT INTO users (username, password, email, role)
VALUES ('admin', 'admin123', 'admin@hkshop.com', 'admin');

-- Sample products
INSERT INTO products (name, price, description, quantity) VALUES
('Laptop Pro 15',       1200.00, 'Intel i7, 16GB RAM, 512GB SSD', 10),
('Wireless Mouse',        25.00, 'Ergonomic, 2.4GHz, long battery', 10),
('Mechanical Keyboard',   75.00, 'RGB backlit, tactile switches',   10),
('USB-C Hub',             35.00, '7-in-1, 4K HDMI, fast charging',  10),
('Webcam HD 1080p',       60.00, 'Full HD, built-in microphone',     10);