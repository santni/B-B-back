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

//* Insert de  Endereço de usuarios*//
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Campinas', 'Rua das Oliveiras', 'Jardim das Flores', 234, 'Casa Verde', '13050-123');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('Rio de Janeiro', 'Niterói', 'Avenida das Palmeiras', 'Icaraí', 678, 'Apartamento 502', '24220-456');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('Minas Gerais', 'Belo Horizonte', 'Rua dos Ipês', 'Funcionários', 321, 'Bloco C Sala 101', '30130-321');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('Bahia', 'Salvador', 'Avenida das Gaivotas', 'Itapuã', 876, 'Casa Amarela', '41615-876');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('Bahia', 'Porto Seguro', 'Rua das Acácias', 'Petrópolis', 543, 'Fundos', '90470-543');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('Santa Catarina', 'Florianópolis', 'Rua das Rosas', 'Trindade', 871, 'Casa Verde', '88036-876');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('Santa Catarina', 'Criciúma', 'Avenida dos Coqueiros', 'Boa Viagem', 237, 'Bloco D, Apartamento 204', '51111-234');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Valinhos', 'Rua das Mangueiras', 'Aldeota', 567, 'Casa Azul de esquina', '60140-567');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('Rio de Janeiro', 'Paraty', 'Avenida das Castanheiras', 'Nazaré', 890, 'Sala 301', '66035-890');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('Espírito Santo', 'Vitória', 'Rua dos Pinheiros', 'Jardim da Penha', 765, 'Perto do mercado PagueMenos', '29060-765');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('Paraná', 'Londrina', 'Avenida das Acácias', 'Jardim São Paulo', 321, 'Casa Azul', '86035-321');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('Goiás', 'Goiânia', 'Rua dos Girassóis', 'Setor Oeste', 654, 'Apartamento 102', '74120-654');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('Rio Grande do Norte', 'Natal', 'Avenida das Orquídeas', 'Tirol', 284, 'Sala 203', '59022-234');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('Paraíba', 'João Pessoa', 'Rua das Papoulas', 'Manaíra', 987, 'Casa Branca', '58038-987');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('Alagoas', 'Maceió', 'Avenida das Magnólias', 'Ponta Verde', 896, 'Bloco E, Apartamento 301', '57035-876');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('Sergipe', 'Aracaju', 'Rua das Violetas', 'Jardins', 543, 'Perto da farmácia Drogasil', '49025-543');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('Rio de Janeiro', 'Rio de Janeiro', 'Avenida das Bromélias', 'Adrianópolis', 789, 'Apartamento 402', '69057-789');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('Minas Gerais', 'Varginha', 'Rua dos Cravos', 'Plano Diretor Sul', 658, 'Do lado de um portão Vermelho', '77015-654');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Ribeirão Preto', 'Avenida das Azaleias', 'Bosque', 312, 'Sala 201', '76804-987');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('Paraná', 'Curitiba', 'Avenida dos Lírios', 'Tancredo Neves', 124, 'Casa de esquina', '69314-876');

//* Insert de Usuarios*//
INSERT INTO users (name, email, cpf, telephone, password, addres) VALUES ('Maria Luiza Neves', 'maluneves@gmail.com', '544.685.560-48', '(41) 96448-1317', 'MaluN3ves87', 1),
('João Guilherme Caetano dos Santos', 'joaoguicaet23@gmail.com', '676.903.400-08', '(27) 98019-3604', 'Guilh3rm&C4etano', 2),
('Nicolly Isabeli dos Santos Silva', 'nicollyisabeliss@gmail.com', '234.048.098-15', '(16) 96486-1576', 'Nicolly3856??', 3),
('Silvia Batista da Silva', 'silvabatistasilvia@gmail.com', '566.954.890-68', '(31) 99666-5386', 'B4atistaSilvia123', 4),
('Mariana Pereira', 'maripereira34@gmail.com', '499.743.040-40', '(79) 98391-5975', 'MariPereira2354', 5),
('Ana Livia Meirelles', 'meirellesana@gmail.com', '752.559.950-53', '(47) 99757-6059', 'MeirellesA22', 6),
('Bianca Moraes Bandeira', 'moraesbia@gmail.com', '979.093.080-19', '(33) 96069-4835', 'BiaMoraes14##', 7),
('Caio Constantino Arruda', 'caioarruda12@gmail.com', '088.293.520-80', '(69) 96771-9063', 'CaioConst**', 8),
('Danilo Alves Correia', 'alvessdanilo@gmail.com', '023.783.990-30', '(44) 96264-8996', '4lvesDanilo90', 9),
('Evandro Lima', 'evandrolima23@gmail.com', '424.934.430-47', '(75) 96796-6734', '3vandr0Lima', 10),
('Felipe Augusto Ferreira', 'felipeaugustof@gmail.com', '117.660.310-80', '(93) 98000-7134', 'August0F3lipe#', 11),
('Luiz Henrique Fernandes', 'luizfernandes67@gmail.com', '182.706.440-48', '(17) 96287-6888', 'LuizF3rn4nd3s33', 12),
('Gabriella Marcondes', 'marcondesgabi@gmail.com', '516.877.290-00', '(32) 98893-3163', 'm4rcondesGabriella412', 13),
('Helena Luz', 'luzhelena@gmail.com', '589.837.030-75', '(27) 96401-0794', 'Luzz66#', 14),
('Iara Bernotti', 'iarabernotti@gmail.com', '024.584.540-20', '(95) 98185-8063', '1araB3rnotti3', 15),
('Juliana Aparecida Santini', 'santinijuliana@gmail.com', '756.391.730-68', '(47) 99873-9480', 'Santini18#', 16),
('Karina Fagundes Anjos', 'karinaanjos@gmail.com', '338.408.700-38', '(51) 96195-7635', '4njosska', 17),
('Leonardo Pontes', 'pontessleo@gmail.com', '348.445.480-69', '(37) 99009-5287', 'PontesLeo16', 18),
('Manuela Queiroz Machado', 'manuqueiroz14@gmail.com', '848.712.180-23', '(19) 99471-6069', 'manuqueiroz1356', 19),
('Otavio Biori', 'bioriotavio@gmail.com', '010.915.590-40', '(24) 96195-1032', '0tavio8iori', 20);

//* Insert de endereço de restaurante*//
USUARIOS

INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Campinas', 'Rua das Oliveiras', 'Jardim das Flores', 234, 'Casa Verde', '13050-123');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Valinhos', 'Avenida das Palmeiras', 'Icaraí', 678, 'Apartamento 502', '13220-456');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Hortolândia', 'Rua dos Ipês', 'Funcionários', 321, 'Bloco C Sala 101', '13130-321');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Hortolândia', 'Avenida das Gaivotas', 'Itapuã', 876, 'Casa Amarela', '13615-876');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Campinas', 'Rua das Acácias', 'Petrópolis', 543, 'Fundos', '13470-543');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Valinhos', 'Rua das Rosas', 'Trindade', 871, 'Casa Verde', '13036-876');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Hortolândia', 'Avenida dos Coqueiros', 'Boa Viagem', 237, 'Bloco D, Apartamento 204', '13111-234');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Valinhos', 'Rua das Mangueiras', 'Aldeota', 567, 'Casa Azul de esquina', '13140-567');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Campinas', 'Avenida das Castanheiras', 'Nazaré', 890, 'Sala 301', '13035-890');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Valinhos', 'Rua dos Pinheiros', 'Jardim da Penha', 765, 'Perto do mercado PagueMenos', '13060-764');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Hortolândia', 'Avenida das Acácias', 'Jardim São Paulo', 321, 'Casa Azul', '13035-321');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Campinas', 'Rua dos Girassóis', 'Setor Oeste', 654, 'Apartamento 102', '13120-654');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Campinas', 'Avenida das Orquídeas', 'Tirol', 284, 'Sala 203', '13022-234');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Valinhos', 'Rua das Papoulas', 'Manaíra', 987, 'Casa Branca', '13038-987');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Hortolândia', 'Avenida das Magnólias', 'Ponta Verde', 896, 'Bloco E, Apartamento 301', '13035-876');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Valinhos', 'Rua das Violetas', 'Jardins', 543, 'Perto da farmácia Drogasil', '13025-543');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Campinas', 'Avenida das Bromélias', 'Adrianópolis', 789, 'Apartamento 402', '13057-789');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Valinhos', 'Rua dos Cravos', 'Plano Diretor Sul', 658, 'Do lado de um portão Vermelho', '13015-654');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Hortolândia', 'Avenida das Azaleias', 'Bosque', 312, 'Sala 201', '13804-987');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Campinas', 'Avenida dos Lírios', 'Tancredo Neves', 124, 'Casa de esquina', '13314-876');


RESTAURANTES

INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Campinas', 'R. Eng. Carlos Stevenson', 'Nova Campinas', 323, '13025-320');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Valinhos', 'Av. Dom Nery', 'Vila Embare', 646, '13271-170');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Hortolândia', 'R. Zacarias Costa Camargo', 'Lot. Remanso Campineiro', 280, '13184-280');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Campinas', 'AV. JOÃO ERBOLATO', 'JARDIM CHAPADÃO', 67, '13070-071');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Valinhos', 'Av. Tiradentes', 'Vila Angeli', 36,'13271-060');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Hortolândia', 'Av. Olívio Franceschini', 'Parque Ortolândia', 1885, '13184-160');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Campinas', 'Av. Mal. Rondon', 'Jardim Chapadão', 985, '13066-001');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Valinhos', 'Av. Dom Nery', 'Vila Embare', 531, '13271-170');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Hortolândia', 'Av. Olívio Franceschini', 'Lot. Remanso Campineiro', 1684 , '13184-505');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Valinhos', 'R. Paiquerê', 'Jardim Paiquere', 200, '13271-600');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Campinas', 'Av. Guilherme Campos', 'Parque das Flores', 500, '13087-091');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Hortolândia', 'Rua Terezinha de Jesus', 'Jardim Santa Rita de Cassia', 174, 'sala 1', '13186-242');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Campinas', 'Av. Dr. Ângelo Simões', 'Pte. Preta', 580, '13041-455');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Valinhos', 'R. Dom Paulo de Társo Campos', 'Jardim Vila Rosa', 72, '13270-240');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Hortolândia', 'R. Pico do Cruzeiro', 'Jardim Everest', 54, '13186-042');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Campinas', 'Av. das Amoreiras', 'Chácaras Campos Elíseos', 1461, '13030-405');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Valinhos', 'R. Luís Spiandorelli Neto', 'Jardim Paiquere', 161, '13271-600');
INSERT INTO address (states, city, street, neighborhood, number, complement, cep) VALUES ('São Paulo', 'Hortolândia', 'Av. Santana', 'Parque Ortolândia', 857, '13184-210');