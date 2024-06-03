    CREATE DATABASE bandb;
    \c bandb;

    CREATE TABLE avaliations(
        id SERIAL PRIMARY KEY,
        avaliation INT,
        restaurantID INT,
        userEmail VARCHAR(100),
        FOREIGN KEY(restaurantID) REFERENCES restaurants(id),
        FOREIGN KEY(userEmail) REFERENCES users(email));
    INSERT INTO avaliations(avaliation, restaurantID, userEmail) VALUES(5, 1, 'pedrormont@gmail.com');

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
    street VARCHAR(100) NOT NULL,
    neighborhood VARCHAR(50) NOT NULL,
    number INT NOT NULL,
    complement TEXT,
    cep CHAR(8) NOT NULL);

    CREATE TABLE orders(
    id SERIAL PRIMARY KEY,
    userEmail VARCHAR(100),
    restaurantID INT,
    dateandhour CHAR(16) NOT NULL,
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

INSERT INTO users(name, email, cpf, telephone, password) VALUES('pedro', 'pedrormont@gmail.com', '47355397869', '19997908453', 'Pedro@4739');

INSERT INTO address(state, city, neighborhood, number, cep) VALUES ('SP', 'Valinhos', 'teste3', 23, '12345678');
INSERT INTO restaurants(name, type, operation, address) VALUES ('MC', 'FAST-FOOD', '07:30-23:30', 1);
INSERT INTO orders(useremail, restaurantid, dateandhour, state) VALUES ('pedrormont@gmail.com', 1, '19-11-2006 18:16', 'pending');
INSERT INTO itensorders(orderid, productid, quantity) VALUES (3, 1, 2);
INSERT INTO products(name, description, price, restaurantid) VALUES ('teste', '123', 10.50, 1);

INSERT INTO orders(useremail, restaurantid, dateandhour, state) VALUES ('pedrormont@gmail.com', 1, '19-11-2006 18:16', 'delivered');
INSERT INTO itensorders(orderid, productid, quantity) VALUES (4, 1, 4);

SELECT 
    restaurants.name AS restaurant,
    restaurants.type AS type,
    products.name AS product,
    products.description AS product_desc,
    products.price AS price_product,
    avaliations.avaliation AS avaliation
FROM 
    restaurants
JOIN 
    products ON restaurants.id = products.restaurantid
LEFT JOIN 
    avaliations ON restaurants.id = avaliations.restaurantid;

//* Insert de Restaurantes*//
//* Insert de Restaurantes Pizza*//
INSERT INTO restaurants(name, type, operation, image, address) VALUES ('Pizzaria Castelo', 'Pizza', '07:30-23:30', 'https://i.imgur.com/FJqH8rY.png', 21);
INSERT INTO restaurants(name, type, operation, image, address) VALUES ('Pizzaria Maremonti', 'Pizza', '07:30-23:30', 'https://i.imgur.com/56pMn1y.png', 22);
INSERT INTO restaurants(name, type, operation, image, address) VALUES ('Pizzaria Serata', 'Pizza', '07:30-23:30', 'https://i.imgur.com/eMwHRzO.png', 23);
//* Insert de Restaurantes Sushi*//
INSERT INTO restaurants(name, type, operation, image, address) VALUES ('Katori Sushi', 'Sushi', '07:30-23:30', 'https://i.imgur.com/Ouil1wP.png', 24);
INSERT INTO restaurants(name, type, operation, image, address) VALUES ('Kitaki Sushi', 'Sushi', '07:30-23:30', 'https://i.imgur.com/9tuipO3.png', 25);
INSERT INTO restaurants(name, type, operation, image, address) VALUES ('Satoshy Sushi', 'Sushi', '07:30-23:30', 'https://i.imgur.com/7otf5Dd.jpg', 26);
//* Insert de Restaurantes Sorvete*//
INSERT INTO restaurants(name, type, operation, image, address) VALUES ('Sergel', 'Sorvete', '07:30-23:30', 'https://i.imgur.com/tXYbXW1.jpg', 27);
INSERT INTO restaurants(name, type, operation, image, address) VALUES ('Tô indo açai', 'Sorvete', '07:30-23:30', 'https://i.imgur.com/acwU0Sa.png', 28);
INSERT INTO restaurants(name, type, operation, image, address) VALUES ('Sorveteria eskimó', 'Sorvete', '07:30-23:30', 'https://i.imgur.com/PCWNqzF.png', 29);
//* Insert de Restaurantes Massa*//
INSERT INTO restaurants(name, type, operation, image, address) VALUES ('Spoleto', 'Massa', '07:30-23:30', ' https://i.imgur.com/sbYss67.png', 30);
INSERT INTO restaurants(name, type, operation, image, address) VALUES ('Famiglia mancini', 'Massa', '07:30-23:30', 'https://i.imgur.com/AoS31Ox.jpg', 31);
INSERT INTO restaurants(name, type, operation, image, address) VALUES ('jamies s italian', 'Massa', '07:30-23:30', ' https://i.imgur.com/ZzIeJ4T.png', 32);
//* Insert de Restaurantes Marmita*//
INSERT INTO restaurants(name, type, operation, image, address) VALUES ('Sabor Imperial', 'Marmita', '07:30-23:30', 'https://i.imgur.com/TOmaWQ0.png', 33);
INSERT INTO restaurants(name, type, operation, image, address) VALUES ('FASTNFIT', 'Marmita', '07:30-23:30', 'https://i.imgur.com/g3sSWED.jpg' 34);
INSERT INTO restaurants(name, type, operation, image, address) VALUES ('Marmitas do Zé', 'Marmita', '07:30-23:30', 'https://i.imgur.com/z9PuTCs.png', 35);
//* Insert de Restaurantes FastFood*//
INSERT INTO restaurants(name, type, operation, image, address) VALUES ('Mc Donald', 'FastFood', '07:30-23:30', 'https://i.imgur.com/LwkxTQX.png', 36);
INSERT INTO restaurants(name, type, operation, image, address) VALUES ('Burger King', 'FastFood', '07:30-23:30', 'https://i.imgur.com/GtkS4Aa.jpg', 37);
INSERT INTO restaurants(name, type, operation, image, address) VALUES ('Subway', 'FastFood', '07:30-23:30', 'https://i.imgur.com/pJosNk9.jpg', 38);