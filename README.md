
# EZ_PIZZA_SCHEMA.sql Documentation

## Overview
This project implements a complete relational database schema for an online pizza ordering application, inspired by Pinocchio's Pizza & Subs. The schema is designed for MySQL and demonstrates best practices in database design, including:
- Well-structured tables for users, menu items, shopping cart, and orders
- Proper use of constraints (PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE)
- Implementation of various relationships (One-to-Many, Many-to-Many)

## Database Structure

### 1. User Table
Stores user account and delivery information.
- Fields: id, password, username, first_name, last_name, email, is_staff, date_joined, address, phone_number
- Constraints: Unique username and email

### 2. Menu Item Tables
Separate tables for each menu category:
- **Regular**: Regular pizzas (small/large prices)
- **Sicillian**: Sicillian pizzas (small/large prices)
- **Topping**: Pizza toppings
- **Sub**: Sandwiches (small/large prices)
- **Pasta**: Pasta dishes (fixed price)
- **Salad**: Salads (fixed price)
- **Platter**: Platters (small/large prices)
- **SpecialRegular**: Special regular pizzas (small/large prices)
- **SpecialSicillian**: Special Sicillian pizzas (small/large prices)

### 3. ShoppingCartItem Table
Stores each food item added to a user's shopping cart.
- Fields: id, client_id (FK to User), food_item, choices, price, created
- Relationship: Many ShoppingCartItems per User

### 4. OrderedItem Table
Represents an order placed by a user. Each item must have been in the shopping cart.
- Fields: id, client_id (FK to User), food_item, choices, price, status, created
- Relationship: Many OrderedItems per User

### 5. OrderedItems Table (Join Table)
Implements a Many-to-Many relationship between User and OrderedItem.
- Fields: id, user_id (FK to User), ordered_item_id (FK to OrderedItem), order_date
- Purpose: Records all items a user has ever ordered

## Relationships
- **User ↔ ShoppingCartItem**: One-to-Many (a user can have many cart items)
- **User ↔ OrderedItem**: One-to-Many (a user can have many ordered items)
- **User ↔ OrderedItem (via OrderedItems)**: Many-to-Many (a user can have many ordered items, and an ordered item can belong to many users if needed)

## Usage
Run the `EZ_PIZZA_SCHEMA.sql` file in a MySQL environment to create the database and all tables with the defined relationships and constraints.

## Inspiration
This schema is inspired by the menu and ordering process of Pinocchio's Pizza & Subs: https://www.pinocchiospizza.net/
