CREATE DATABASE bandb;
\c bandb;

CREATE TABLE users (
name VARCHAR(75),
email VARCHAR(100) NOT NULL PRIMARY KEY,
cpf CHAR(11) NOT NULL UNIQUE,
telephone CHAR(11) NOT NULL UNIQUE,
password TEXT,
address INT,
FOREIGN KEY(address) REFERENCES address(id));

CREATE TABLE restaurants(
id SERIAL PRIMARY KEY,
name VARCHAR(75) NOT NULL,
type VARCHAR(50) NOT NULL,
operation CHAR(11) NOT NULL,
address INT,
FOREIGN KEY(address) REFERENCES address(id));

CREATE TABLE address(
id SERIAL PRIMARY KEY,
state CHAR(2) NOT NULL,
city VARCHAR(50) NOT NULL,
neighborhood VARCHAR(50) NOT NULL,
number INT NOT NULL,
complement TEXT,
cep CHAR(8));

CREATE TABLE orders(
id SERIAL PRIMARY KEY,
userEmail VARCHAR(100),
restaurantID INT,
dateandhour CHAR(16) NOT NULL,
state VARCHAR(10) NOT NULL,
total DECIMAL(10,2) NOT NULL,
FOREIGN KEY(userEmail) REFERENCES users(email),
FOREIGN KEY(restaurantID) REFERENCES restaurants(id));

CREATE TABLE itensOrders(
id SERIAL PRIMARY KEY,
orderid INT,
productid INT,
quantity INT NOT NULL,
priceByUnit DECIMAL(10,2) NOT NULL,
FOREIGN KEY(orderid) REFERENCES orders(id),
FOREIGN KEY(productid) REFERENCES products(id));

