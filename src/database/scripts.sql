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
cep CHAR(8) NOT NULL);

CREATE TABLE orders(
id SERIAL PRIMARY KEY,
userEmail VARCHAR(100),
restaurantID INT,
dateandhour CHAR(16) NOT NULL,
/* data e hora da entrega */
state VARCHAR(10) NOT NULL,
FOREIGN KEY(userEmail) REFERENCES users(email),
FOREIGN KEY(restaurantID) REFERENCES restaurants(id));

CREATE TABLE itensOrders(
id SERIAL PRIMARY KEY,
orderid INT,
productid INT,
quantity INT NOT NULL,
FOREIGN KEY(orderid) REFERENCES orders(id),
FOREIGN KEY(productid) REFERENCES products(id));

CREATE TABLE products(
    id SERIAL PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE,
    description TEXT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    restaurantid INT,
    FOREIGN KEY (restaurantid) REFERENCES restaurants(id)
);

SELECT 
    restaurants.name AS restaurant, 
    SUM(itensorders.quantity * products.price) AS total,
    orders.state AS state
FROM 
    orders
INNER JOIN 
    restaurants ON orders.restaurantid = restaurants.id
INNER JOIN 
    itensorders ON orders.id = itensorders.orderid
INNER JOIN 
    products ON itensorders.productid = products.id
GROUP BY 
    restaurants.name, orders.state; 


INSERT INTO address(state, city, neighborhood, number, cep) VALUES ('SP', 'Valinhos', 'teste3', 23, '12345678');
INSERT INTO restaurants(name, type, operation, address) VALUES ('MC', 'FAST-FOOD', '07:30-23:30', 1);
INSERT INTO orders(useremail, restaurantid, dateandhour, state) VALUES ('pedrormont@gmail.com', 1, '19-11-2006 18:16', 'pending');
INSERT INTO itensorders(orderid, productid, quantity) VALUES (1, 1, 2);
INSERT INTO products(name, description, price, restaurantid) VALUES ('teste', '123', 10.50, 1);

INSERT INTO orders(useremail, restaurantid, dateandhour, state) VALUES ('pedrormont@gmail.com', 1, '19-11-2006 18:16', 'delivered');
INSERT INTO itensorders(orderid, productid, quantity) VALUES (1, 1, 5);