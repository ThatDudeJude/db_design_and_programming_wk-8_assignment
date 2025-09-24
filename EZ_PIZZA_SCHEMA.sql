-- Build a Complete Database Management System
--
-- Objective:
-- Design and implement a full-featured relational database using MySQL.
--
-- Instructions:
-- Choose a real-world use case (e.g., Library Management, Student Records, Clinic Booking System, Inventory Tracking, E-commerce Store, etc.).
-- Create a relational database schema that includes:
-- Well-structured tables.
-- Proper constraints (PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE).
-- Relationships (One-to-One, One-to-Many, Many-to-Many, where applicable).
-- Use SQL to implement your design. 
--
-- Deliverables:
-- A single .sql file containing:
-- CREATE DATABASE statement
-- CREATE TABLE statements
-- Relationship constraints
--
--
-- This database was created to exemplify the creation of an online Pizza ordering app inspired 
-- by Pinocchio's Pizza & Subs from the website https://www.pinocchiospizza.net/
CREATE DATABASE EzPizza;
USE EzPizza;
-- User: 
CREATE TABLE User (
    id INT AUTO_INCREMENT PRIMARY KEY,
    password VARCHAR(128) NOT NULL,
    username VARCHAR(150) NOT NULL UNIQUE,
    first_name VARCHAR(64) NOT NULL,
    last_name VARCHAR(64) NOT NULL,
    email VARCHAR(254) NOT NULL UNIQUE,
    is_staff BOOLEAN NOT NULL,
    date_joined DATETIME NOT NULL,
    address VARCHAR(255),
    phone_number VARCHAR(32),
);
-- Menu (Food) Items: Regular Pizza, Sicillian Pizza, Toppings (for Regular Pizza or Sicillian ) Sicillian Special, 
-- Regular Special, Sub (sandwich), Pasta, Salad or Platter
-- Regular pizza, Sicillan Pizza, Sub and Platter have two prices, one for small and the other 
-- for large
CREATE TABLE Regular (
    id INT AUTO_INCREMENT PRIMARY KEY,
    small_price DECIMAL(4, 2),
    large_price DECIMAL(4, 2),
    delicacy VARCHAR(64) UNIQUE
);
CREATE TABLE Sicillian (
    id INT AUTO_INCREMENT PRIMARY KEY,
    small_price DECIMAL(4, 2),
    large_price DECIMAL(4, 2),
    delicacy VARCHAR(64) UNIQUE
);
CREATE TABLE Topping (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(64) UNIQUE
);
CREATE TABLE Sub (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(64) UNIQUE,
    small_price DECIMAL(4, 2),
    large_price DECIMAL(4, 2)
);
CREATE TABLE Pasta (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(64) UNIQUE,
    fixed_price DECIMAL(4, 2)
);
CREATE TABLE Salad (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(64) UNIQUE,
    fixed_price DECIMAL(4, 2)
);
CREATE TABLE Platter (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(64) UNIQUE,
    small_price DECIMAL(4, 2),
    large_price DECIMAL(4, 2)
);
CREATE TABLE SpecialRegular (
    id INT AUTO_INCREMENT PRIMARY KEY,
    small_price DECIMAL(4, 2),
    large_price DECIMAL(4, 2),
    delicacy VARCHAR(64)
);
CREATE TABLE SpecialSicillian (
    id INT AUTO_INCREMENT PRIMARY KEY,
    small_price DECIMAL(4, 2),
    large_price DECIMAL(4, 2),
    delicacy VARCHAR(64)
);
-- Shopping Cart Item for storing each food item added to the shopping cart
CREATE TABLE ShoppingCartItem (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT,
    food_item VARCHAR(64) NOT NULL,
    choices VARCHAR(64) NOT NULL,
    price DECIMAL(5, 2) NOT NULL,
    created DATETIME NOT NULL,
    FOREIGN KEY (client_id) REFERENCES User(id) ON DELETE
    SET NULL
);
-- OrderItem stores an order placed by a specific user. The foods have to be in the Shopping Cart
-- It stores the client id (user) food item (Regular Pizza, Sicillian Pizza, , Sicillian Special, Regular Special, 
-- Sub, Pasta, Salad or Platter)
CREATE TABLE OrderedItem (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT,
    food_item VARCHAR(64) NOT NULL,
    choices VARCHAR(64) NOT NULL,
    price DECIMAL(5, 2) NOT NULL,
    status VARCHAR(10) NOT NULL DEFAULT 'PLACED',
    created DATETIME NOT NULL,
    FOREIGN KEY (client_id) REFERENCES User(id) ON DELETE
    SET NULL
);
-- OrderedItems: Many-to-Many relationship between User and OrderedItem
-- This table records all items a user has ever ordered
CREATE TABLE OrderedItems (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    ordered_item_id INT NOT NULL,
    order_date DATETIME NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE,
    FOREIGN KEY (ordered_item_id) REFERENCES OrderedItem(id) ON DELETE CASCADE
);