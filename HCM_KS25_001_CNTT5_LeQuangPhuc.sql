CREATE DATABASE SalesManagement;

USE SalesManagement;

CREATE TABLE Product(
    id VARCHAR(10) PRIMARY KEY ,
    product_name VARCHAR(100),
    brand VARCHAR(100),
    price DECIMAL(18,2),
    stock INT
);

CREATE TABLE Customer(
    id VARCHAR(10) PRIMARY KEY ,
    full_name VARCHAR(100),
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(10),
    address VARCHAR(150)
);

CREATE TABLE Orders(
    id VARCHAR(10) PRIMARY KEY,
    order_date DATE,
    total DECIMAL(18,2),
    customer_id VARCHAR(10),
    FOREIGN KEY (customer_id) REFERENCES Customer(id)
);

CREATE TABLE Order_Detail(
    order_id VARCHAR(10),
    product_id VARCHAR(10),
    quantity INT,
    price_current DECIMAL(18,2),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES Orders(id),
    FOREIGN KEY (product_id) REFERENCES Product(id)
);

ALTER TABLE Orders
ADD note TEXT;

ALTER TABLE Product
CHANGE brand nha_san_xuat VARCHAR (100);

DROP TABLE Order_Detail;
DROP TABLE Orders;

INSERT INTO Product VALUES
('P001','pad control artisan', 'artisan',300000, 10),
('P002', 'MacBook Air M2', 'Apple', 25000000, 10),
('P003', 'HP Pavilion', 'HP', 15000000, 15),
('P004', 'Asus ROG', 'Asus', 30000000, 5),
('P005', 'Lenovo ThinkPad', 'Lenovo', 18000000, 12);

INSERT INTO Customer VALUES
('C001', 'Nguyen Van A', 'a@gmail.com', '0901234567', 'HCM'),
('C002', 'Tran Thi B', 'b@gmail.com', NULL, 'HN'),
('C003', 'Le Van C', 'c@gmail.com', '0912345678', 'DN'),
('C004', 'Pham Thi D', 'd@gmail.com', '0923456789', 'HCM'),
('C005', 'Hoang Van E', 'e@gmail.com', NULL, 'CT');


INSERT INTO Orders VALUES
('DH001', '2025-04-01', 25000000, 'C001', NULL),
('DH002', '2025-04-02', 22000000, 'C003', NULL),
('DH003', '2025-04-03', 15000000, 'C004', NULL),
('DH004', '2025-04-04', 30000000, 'C001', NULL),
('DH005', '2025-04-05', 18000000, 'C003', NULL);

INSERT INTO Order_Detail VALUES
('DH001', 'P001', 1, 25000000),
('DH002', 'P002', 1, 22000000),
('DH003', 'P003', 1, 15000000),
('DH004', 'P004', 1, 30000000),
('DH005', 'P005', 1, 18000000);

UPDATE Product
SET price = price * 1.1
WHERE nha_san_xuat = 'Apple';

DELETE FROM Customer
WHERE phone IS NULL;

SELECT * FROM Product
WHERE price BETWEEN 10000000 AND 20000000;

SELECT product_name
FROM Product
WHERE id IN (
    SELECT product_id
    FROM Order_Detail
	WHERE order_id = 'DH001'
);

SELECT *
FROM Customer
WHERE id IN (
    SELECT customer_id
    FROM Orders
    WHERE id IN (
        SELECT order_id
        FROM Order_Detail
        WHERE product_id = (
            SELECT id
            FROM Product
            WHERE product_name = 'MacBook Air M2'
        )
    )
);


