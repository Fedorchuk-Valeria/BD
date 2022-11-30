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
        'register',
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
-- ALTER TABLE beauty_salon.offices
-- ADD CONSTRAINT UNIQUE (address);
-- CREATE INDEX price ON beauty_salon.services(price);
-- SELECT * FROM beauty_salon.services ORDER BY price;
-- CREATE INDEX duration ON beauty_salon.services(duration);
-- SELECT * FROM beauty_salon.services WHERE duration < 120;
-- CREATE INDEX id_date ON beauty_salon.registers(client_id, reg_date);
-- SELECT * FROM beauty_salon.registers WHERE client_id = 5 ORDER BY reg_date;
-- CREATE UNIQUE INDEX address_uniq ON beauty_salon.offices(address);
-- SELECT * FROM beauty_salon.offices  WHERE address = 'Pinsk';
-- SELECT *
-- FROM beauty_salon.services
-- WHERE duration < 120
--     AND price <= 60;
-- SELECT * FROM beauty_salon.requests WHERE prefered_date IS NULL;
-- UPDATE  beauty_salon.replies
-- SET approved = true WHERE id = 1;
-- SELECT * FROM beauty_salon.replies;
-- SELECT * FROM beauty_salon.services
-- WHERE price < 55
-- LIMIT 2;
-- SELECT MIN(price)
-- FROM beauty_salon.services;
-- SELECT COUNT(office_id)
-- FROM beauty_salon.masters
-- where office_id = 3;
-- SELECT SUM(price)
-- FROM beauty_salon.payments
-- WHERE card_id = 2;
-- SELECT beauty_salon.masters.id, beauty_salon.services.name, beauty_salon.offices.address
-- FROM ((beauty_salon.masters
-- INNER JOIN beauty_salon.offices ON beauty_salon.masters.office_id = beauty_salon.offices.id)
-- INNER JOIN beauty_salon.services ON beauty_salon.services.id = beauty_salon.masters.service_id);
-- SELECT COUNT(id), service_id
-- FROM beauty_salon.masters
-- GROUP BY service_id;
-- SELECT *
-- FROM beauty_salon.services
-- WHERE duration < 100 AND
-- EXISTS
-- (SELECT price FROM beauty_salon.services WHERE price < 50);
-- SELECT id, service_id,
-- CASE 
-- WHEN service_id = 1 THEN 'manicure master'
-- WHEN service_id = 2 THEN 'pedicure master'
-- WHEN service_id = 3 THEN 'haircut master'
-- WHEN service_id = 4 THEN 'eyelash extension master'
-- WHEN service_id = 5 THEN 'eyebrow correction master'
-- END AS master_type
-- FROM beauty_salon.masters;
-- CREATE TRIGGER beauty_salon.add_log AFTER INSERT ON beauty_salon.users
-- FOR EACH ROW BEGIN
--     INSERT INTO beauty_salon.actions SET user_id = NEW.id, type_of_action = 'registration';
-- END;
-- CREATE TRIGGER beauty_salon.add_reglog
-- AFTER
-- INSERT ON beauty_salon.registers FOR EACH ROW BEGIN
-- INSERT INTO beauty_salon.actions
-- SET user_id = NEW.client_id,
--     type_of_action = 'register';
-- END;
-- CREATE TRIGGER beauty_salon.add_revlog
-- AFTER
-- INSERT ON beauty_salon.reviews FOR EACH ROW BEGIN
-- INSERT INTO beauty_salon.actions
-- SET user_id = NEW.client_id,
--     type_of_action = 'review';
-- END;
-- CREATE TRIGGER beauty_salon.add_reqlog
-- AFTER
-- INSERT ON beauty_salon.requests FOR EACH ROW BEGIN
-- INSERT INTO beauty_salon.actions
-- SET user_id = NEW.client_id,
--     type_of_action = 'request';
-- END;
-- CREATE PROCEDURE beauty_salon.Select_user_by_id (IN get_id INT)
-- begin
-- SELECT * FROM beauty_salon.users WHERE id = get_id;
-- END;
-- CREATE PROCEDURE beauty_salon.Select_all_services()
-- BEGIN
-- SELECT * FROM beauty_salon.services;
-- END;
-- CREATE PROCEDURE beauty_salon.Select_master_by_service (IN get_service_id INT)
-- BEGIN
-- SELECT * FROM beauty_salon.masters WHERE service_id = get_service_id;
-- END;
-- CREATE PROCEDURE beauty_salon.Select_master_by_office (IN get_office_id INT)
-- BEGIN
-- SELECT * FROM beauty_salon.masters WHERE office_id = get_office_id;
-- END;
-- CREATE PROCEDURE beauty_salon.Select_office_by_address (IN get_address VARCHAR(30))
-- BEGIN
-- SELECT * FROM beauty_salon.offices WHERE address = get_address;
-- END;
-- CALL beauty_salon.Select_all_services();
-- CALL beauty_salon.Select_user_by_id(3);
CALL beauty_salon.Select_master_by_office(3);