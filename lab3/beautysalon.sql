CREATE DATABASE IF NOT EXISTS beauty_salon;
CREATE TABLE IF NOT EXISTS beauty_salon.users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    password VARCHAR(20) NOT NULL,
    is_active BOOLEAN DEFAULT false
);
CREATE TABLE IF NOT EXISTS beauty_salon.clients (
    date_of_birth DATE NOT NULL,
    phone_number VARCHAR(255) NOT NULL,
    id INT PRIMARY KEY,
    FOREIGN KEY (id) REFERENCES beauty_salon.users(id)
);
CREATE TABLE IF NOT EXISTS beauty_salon.services (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    price INT NOT NULL,
    duration INT NOT NULL
);
CREATE TABLE IF NOT EXISTS beauty_salon.offices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(255) NOT NULL
);
CREATE TABLE IF NOT EXISTS beauty_salon.masters (
    service_id INT NOT NULL,
    office_id INT NOT NULL,
    id INT PRIMARY KEY,
    FOREIGN KEY (service_id) REFERENCES beauty_salon.services(id),
    FOREIGN KEY (office_id) REFERENCES beauty_salon.offices(id),
    FOREIGN KEY (id) REFERENCES beauty_salon.users(id)
);
CREATE TABLE IF NOT EXISTS beauty_salon.admins (
    email VARCHAR(50) NOT NULL,
    id INT PRIMARY KEY,
    office_id INT NOT NULL,
    FOREIGN KEY (office_id) REFERENCES beauty_salon.offices(id),
    FOREIGN KEY (id) REFERENCES beauty_salon.users(id)
);
CREATE TABLE IF NOT EXISTS beauty_salon.credit_cards (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numder INT NOT NULL,
    client_id INT NOT NULL,
    FOREIGN KEY (client_id) REFERENCES beauty_salon.clients(id)
);
CREATE TABLE IF NOT EXISTS beauty_salon.actions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    type_of_action ENUM(
        'registration',
        'authorization',
        'register',
        'payment',
        'review',
        'request'
    ) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES beauty_salon.users(id)
);
CREATE TABLE IF NOT EXISTS beauty_salon.registers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    master_id INT NOT NULL,
    reg_time TIME NOT NULL,
    reg_date DATE NOT NULL,
    FOREIGN KEY (client_id) REFERENCES beauty_salon.clients(id),
    FOREIGN KEY (master_id) REFERENCES beauty_salon.masters(id)
);
CREATE TABLE IF NOT EXISTS beauty_salon.payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    card_id INT NOT NULL,
    register_id INT NOT NULL,
    price INT NOT NULL,
    FOREIGN KEY (card_id) REFERENCES beauty_salon.credit_cards(id),
    FOREIGN KEY (register_id) REFERENCES beauty_salon.registers(id)
);
CREATE TABLE IF NOT EXISTS beauty_salon.reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    text VARCHAR(255) NULL,
    rate INT NOT NULL,
    master_id INT NOT NULL,
    rev_date DATE NOT NULL,
    FOREIGN KEY (client_id) REFERENCES beauty_salon.clients(id),
    FOREIGN KEY (master_id) REFERENCES beauty_salon.masters(id)
);
CREATE TABLE IF NOT EXISTS beauty_salon.requests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    service_id INT NOT NULL,
    prefered_date DATE NULL,
    prefered_time TIME NULL,
    office_id INT NOT NULL,
    FOREIGN KEY (client_id) REFERENCES beauty_salon.clients(id),
    FOREIGN KEY (office_id) REFERENCES beauty_salon.offices(id),
    FOREIGN KEY (service_id) REFERENCES beauty_salon.services(id)
);
CREATE TABLE IF NOT EXISTS beauty_salon.replies (
    id INT AUTO_INCREMENT PRIMARY KEY,
    request_id INT NOT NULL,
    master_id INT NOT NULL,
    offer_date DATE NOT NULL,
    offer_time TIME NOT NULL,
    approved BOOLEAN DEFAULT false,
    FOREIGN KEY (master_id) REFERENCES beauty_salon.masters(id),
    FOREIGN KEY (request_id) REFERENCES beauty_salon.requests(id)
);
ALTER TABLE beauty_salon.offices
ADD CONSTRAINT UNIQUE (address);
-- CREATE INDEX price ON beauty_salon.services(price);
-- SELECT * FROM beauty_salon.services ORDER BY price;
-- CREATE INDEX duration ON beauty_salon.services(duration);
-- SELECT * FROM beauty_salon.services WHERE duration < 120;
-- CREATE INDEX id_date ON beauty_salon.registers(client_id, reg_date);
-- SELECT * FROM beauty_salon.registers WHERE client_id = 5 ORDER BY reg_date;
-- CREATE UNIQUE INDEX address_uniq ON beauty_salon.offices(address);
-- SELECT * FROM beauty_salon.offices  WHERE address = 'Pinsk';