CREATE TABLE `clients`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `date_of_birth` DATE NOT NULL,
    `phone_number` VARCHAR(255) NOT NULL,
    `user_id` INT NOT NULL
);
ALTER TABLE
    `clients` ADD PRIMARY KEY `clients_id_primary`(`id`);
CREATE TABLE `payment`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `credit_card_id` INT NOT NULL,
    `total_price` INT NOT NULL,
    `register_id` INT NOT NULL
);
ALTER TABLE
    `payment` ADD PRIMARY KEY `payment_id_primary`(`id`);
CREATE TABLE `registers`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `client_id` INT NOT NULL,
    `master_id` INT NOT NULL,
    `time` TIME NOT NULL,
    `date` DATE NOT NULL
);
ALTER TABLE
    `registers` ADD PRIMARY KEY `registers_id_primary`(`id`);
CREATE TABLE `masters`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `service_id` INT NOT NULL,
    `office_id` INT NOT NULL,
    `user_id` INT NOT NULL
);
ALTER TABLE
    `masters` ADD PRIMARY KEY `masters_id_primary`(`id`);
CREATE TABLE `admins`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(255) NOT NULL,
    `office_id` INT NOT NULL,
    `user_id` INT NOT NULL
);
ALTER TABLE
    `admins` ADD PRIMARY KEY `admins_id_primary`(`id`);
CREATE TABLE `review`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `client_id` INT NOT NULL,
    `text` VARCHAR(255) NOT NULL,
    `rate` INT NOT NULL,
    `master_id` INT NOT NULL,
    `data` DATE NOT NULL
);
ALTER TABLE
    `review` ADD PRIMARY KEY `review_id_primary`(`id`);
CREATE TABLE `servises`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` INT NOT NULL,
    `price` INT NOT NULL,
    `duration` DECIMAL(8, 2) NOT NULL
);
ALTER TABLE
    `servises` ADD PRIMARY KEY `servises_id_primary`(`id`);
CREATE TABLE `credit_cards`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `card_numder` INT NOT NULL,
    `client_id` INT NOT NULL
);
ALTER TABLE
    `credit_cards` ADD PRIMARY KEY `credit_cards_id_primary`(`id`);
CREATE TABLE `requests`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `client_id` INT NOT NULL,
    `servise_id` INT NOT NULL,
    `prefered_data` DATE NULL,
    `prefered_time` TIME NULL,
    `office_id` INT NOT NULL
);
ALTER TABLE
    `requests` ADD PRIMARY KEY `requests_id_primary`(`id`);
CREATE TABLE `offices`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `address` VARCHAR(255) NOT NULL
);
ALTER TABLE
    `offices` ADD PRIMARY KEY `offices_id_primary`(`id`);
CREATE TABLE `actions`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id` INT NOT NULL,
    `type_of_action` ENUM('') NOT NULL,
    `date_time` DATETIME NOT NULL
);
ALTER TABLE
    `actions` ADD PRIMARY KEY `actions_id_primary`(`id`);
CREATE TABLE `replies`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `request_id` INT NOT NULL,
    `master_id` INT NOT NULL,
    `date` DATE NOT NULL,
    `time` TIME NOT NULL,
    `approved` TINYINT(1) NOT NULL
);
ALTER TABLE
    `replies` ADD PRIMARY KEY `replies_id_primary`(`id`);
CREATE TABLE `users`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `is_active` TINYINT(1) NOT NULL
);
ALTER TABLE
    `users` ADD PRIMARY KEY `users_id_primary`(`id`);
ALTER TABLE
    `registers` ADD CONSTRAINT `registers_client_id_foreign` FOREIGN KEY(`client_id`) REFERENCES `clients`(`id`);
ALTER TABLE
    `registers` ADD CONSTRAINT `registers_master_id_foreign` FOREIGN KEY(`master_id`) REFERENCES `masters`(`id`);
ALTER TABLE
    `clients` ADD CONSTRAINT `clients_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `users`(`id`);
ALTER TABLE
    `payment` ADD CONSTRAINT `payment_credit_card_id_foreign` FOREIGN KEY(`credit_card_id`) REFERENCES `credit_cards`(`id`);
ALTER TABLE
    `payment` ADD CONSTRAINT `payment_register_id_foreign` FOREIGN KEY(`register_id`) REFERENCES `registers`(`id`);
ALTER TABLE
    `masters` ADD CONSTRAINT `masters_service_id_foreign` FOREIGN KEY(`service_id`) REFERENCES `servises`(`id`);
ALTER TABLE
    `masters` ADD CONSTRAINT `masters_office_id_foreign` FOREIGN KEY(`office_id`) REFERENCES `offices`(`id`);
ALTER TABLE
    `masters` ADD CONSTRAINT `masters_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `users`(`id`);
ALTER TABLE
    `admins` ADD CONSTRAINT `admins_office_id_foreign` FOREIGN KEY(`office_id`) REFERENCES `offices`(`id`);
ALTER TABLE
    `admins` ADD CONSTRAINT `admins_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `users`(`id`);
ALTER TABLE
    `review` ADD CONSTRAINT `review_client_id_foreign` FOREIGN KEY(`client_id`) REFERENCES `clients`(`id`);
ALTER TABLE
    `review` ADD CONSTRAINT `review_master_id_foreign` FOREIGN KEY(`master_id`) REFERENCES `masters`(`id`);
ALTER TABLE
    `credit_cards` ADD CONSTRAINT `credit_cards_client_id_foreign` FOREIGN KEY(`client_id`) REFERENCES `clients`(`id`);
ALTER TABLE
    `requests` ADD CONSTRAINT `requests_client_id_foreign` FOREIGN KEY(`client_id`) REFERENCES `clients`(`id`);
ALTER TABLE
    `requests` ADD CONSTRAINT `requests_servise_id_foreign` FOREIGN KEY(`servise_id`) REFERENCES `servises`(`id`);
ALTER TABLE
    `requests` ADD CONSTRAINT `requests_office_id_foreign` FOREIGN KEY(`office_id`) REFERENCES `offices`(`id`);
ALTER TABLE
    `actions` ADD CONSTRAINT `actions_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `users`(`id`);
ALTER TABLE
    `replies` ADD CONSTRAINT `replies_request_id_foreign` FOREIGN KEY(`request_id`) REFERENCES `requests`(`id`);
ALTER TABLE
    `replies` ADD CONSTRAINT `replies_master_id_foreign` FOREIGN KEY(`master_id`) REFERENCES `masters`(`id`);