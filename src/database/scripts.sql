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
INSERT INTO restaurants(name, type, operation, image, address) VALUES ('Pizzaria Castelo', 'Pizza', '07:30-23:30', 'https://i.imgur.com/FJqH8rY.png', 21),
 ('Pizzaria Maremonti', 'Pizza', '07:30-23:30', 'https://i.imgur.com/56pMn1y.png', 22),
 ('Pizzaria Serata', 'Pizza', '07:30-23:30', 'https://i.imgur.com/eMwHRzO.png', 23),
 ('Katori Sushi', 'Sushi', '07:30-23:30', 'https://i.imgur.com/Ouil1wP.png', 24),
 ('Kitaki Sushi', 'Sushi', '07:30-23:30', 'https://i.imgur.com/9tuipO3.png', 25),
 ('Satoshy Sushi', 'Sushi', '07:30-23:30', 'https://i.imgur.com/7otf5Dd.jpg', 26),
 ('Sergel', 'Sorvete', '07:30-23:30', 'https://i.imgur.com/tXYbXW1.jpg', 27),
 ('Tô indo açai', 'Sorvete', '07:30-23:30', 'https://i.imgur.com/acwU0Sa.png', 28),
 ('Sorveteria eskimó', 'Sorvete', '07:30-23:30', 'https://i.imgur.com/PCWNqzF.png', 29),
 ('Spoleto', 'Massa', '07:30-23:30', ' https://i.imgur.com/sbYss67.png', 30),
 ('Famiglia mancini', 'Massa', '07:30-23:30', 'https://i.imgur.com/AoS31Ox.jpg', 31),
 ('jamies s italian', 'Massa', '07:30-23:30', ' https://i.imgur.com/ZzIeJ4T.png', 32),
 ('Sabor Imperial', 'Marmita', '07:30-23:30', 'https://i.imgur.com/TOmaWQ0.png', 33),
 ('FASTNFIT', 'Marmita', '07:30-23:30', 'https://i.imgur.com/g3sSWED.jpg', 34),
 ('Marmitas do Zé', 'Marmita', '07:30-23:30', 'https://i.imgur.com/z9PuTCs.png', 35),
 ('Mc Donald', 'FastFood', '07:30-23:30', 'https://i.imgur.com/LwkxTQX.png', 36),
 ('Burger King', 'FastFood', '07:30-23:30', 'https://i.imgur.com/GtkS4Aa.jpg', 37),
 ('Subway', 'FastFood', '07:30-23:30', 'https://i.imgur.com/pJosNk9.jpg', 38);

//* Insert de  Endereço de usuarios*//
INSERT INTO address (state, city, street, neighborhood, number, complement, cep) VALUES ('SP', 'Campinas', 'Rua das Oliveiras', 'Jardim das Flores', 234, 'Casa Verde', '13050123'),
 ('RJ', 'Niterói', 'Avenida das Palmeiras', 'Icaraí', 678, 'Apartamento 502', '24220456'),
 ('MG', 'Belo Horizonte', 'Rua dos Ipês', 'Funcionários', 321, 'Bloco C Sala 101', '30130321'),
 ('BA', 'Salvador', 'Avenida das Gaivotas', 'Itapuã', 876, 'Casa Amarela', '41615876'),
 ('BA', 'Porto Seguro', 'Rua das Acácias', 'Petrópolis', 543, 'Fundos', '90470543'),
 ('SC', 'Florianópolis', 'Rua das Rosas', 'Trindade', 871, 'Casa Verde', '88036876'),
 ('SC', 'Criciúma', 'Avenida dos Coqueiros', 'Boa Viagem', 237, 'Bloco D, Apartamento 204', '51111234'),
 ('SP', 'Valinhos', 'Rua das Mangueiras', 'Aldeota', 567, 'Casa Azul de esquina', '60140567'),
 ('RJ', 'Paraty', 'Avenida das Castanheiras', 'Nazaré', 890, 'Sala 301', '66035890'),
 ('ES', 'Vitória', 'Rua dos Pinheiros', 'Jardim da Penha', 765, 'Perto do mercado PagueMenos', '29060765'),
 ('PR', 'Londrina', 'Avenida das Acácias', 'Jardim São Paulo', 321, 'Casa Azul', '86035321'),
 ('GO', 'Goiânia', 'Rua dos Girassóis', 'Setor Oeste', 654, 'Apartamento 102', '74120654'),
 ('RN', 'Natal', 'Avenida das Orquídeas', 'Tirol', 284, 'Sala 203', '59022234'),
 ('PB', 'João Pessoa', 'Rua das Papoulas', 'Manaíra', 987, 'Casa Branca', '58038987'),
 ('AL', 'Maceió', 'Avenida das Magnólias', 'Ponta Verde', 896, 'Bloco E, Apartamento 301', '57035876'),
 ('SE', 'Aracaju', 'Rua das Violetas', 'Jardins', 543, 'Perto da farmácia Drogasil', '49025543'),
 ('RJ', 'Rio de Janeiro', 'Avenida das Bromélias', 'Adrianópolis', 789, 'Apartamento 402', '69057789'),
 ('MG', 'Varginha', 'Rua dos Cravos', 'Plano Diretor Sul', 658, 'Do lado de um portão Vermelho', '77015654'),
 ('SP', 'Ribeirão Preto', 'Avenida das Azaleias', 'Bosque', 312, 'Sala 201', '76804987'),
 ('PR', 'Curitiba', 'Avenida dos Lírios', 'Tancredo Neves', 124, 'Casa de esquina', '69314876');

//* Insert de Usuarios*//
INSERT INTO users (name, email, cpf, telephone, password, address) VALUES ('Maria Luiza Neves', 'maluneves@gmail.com', '54468556048', '41964481317', 'MaluN3ves87', 1),
('João Guilherme Caetano dos Santos', 'joaoguicaet23@gmail.com', '67690340008', '27980193604', 'Guilh3rm&C4etano', 2),
('Nicolly Isabeli dos Santos Silva', 'nicollyisabeliss@gmail.com', '23404809815', '16964861576', 'Nicolly3856??', 3),
('Silvia Batista da Silva', 'silvabatistasilvia@gmail.com', '56695489068', '31996665386', 'B4atistaSilvia123', 4),
('Mariana Pereira', 'maripereira34@gmail.com', '49974304040', '79983915975', 'MariPereira2354', 5),
('Ana Livia Meirelles', 'meirellesana@gmail.com', '75255995053', '47997576059', 'MeirellesA22', 6),
('Bianca Moraes Bandeira', 'moraesbia@gmail.com', '97909308019', '33960694835', 'BiaMoraes14##', 7),
('Caio Constantino Arruda', 'caioarruda12@gmail.com', '08829352080', '69967719063', 'CaioConst**', 8),
('Danilo Alves Correia', 'alvessdanilo@gmail.com', '02378399030', '44962648996', '4lvesDanilo90', 9),
('Evandro Lima', 'evandrolima23@gmail.com', '42493443047', '75967966734', '3vandr0Lima', 10),
('Felipe Augusto Ferreira', 'felipeaugustof@gmail.com', '11766031080', '93980007134', 'August0F3lipe#', 11),
('Luiz Henrique Fernandes', 'luizfernandes67@gmail.com', '18270644048', '17962876888', 'LuizF3rn4nd3s33', 12),
('Gabriella Marcondes', 'marcondesgabi@gmail.com', '51687729000', '32988933163', 'm4rcondesGabriella412', 13),
('Helena Luz', 'luzhelena@gmail.com', '58983703075', '27964010794', 'Luzz66#', 14),
('Iara Bernotti', 'iarabernotti@gmail.com', '02458454020', '95981858063', '1araB3rnotti3', 15),
('Juliana Aparecida Santini', 'santinijuliana@gmail.com', '75639173068', '47998739480', 'Santini18#', 16),
('Karina Fagundes Anjos', 'karinaanjos@gmail.com', '33840870038', '51961957635', '4njosska', 17),
('Leonardo Pontes', 'pontessleo@gmail.com', '34844548069', '37990095287', 'PontesLeo16', 18),
('Manuela Queiroz Machado', 'manuqueiroz14@gmail.com', '84871218023', '19994716069', 'manuqueiroz1356', 19),
('Otavio Biori', 'bioriotavio@gmail.com', '01091559040', '24961951032', '0tavio8iori', 20);

//* Insert de endereço de restaurante*//
