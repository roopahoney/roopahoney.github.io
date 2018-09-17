-- Version 1.0
-- MySQL

-- Create database
CREATE DATABASE baby_db;

-- Using database
USE baby_db;

-- Customer table
CREATE TABLE `customer` (
	`id` int NOT NULL AUTO_INCREMENT,
    `user_name` char(25) NOT NULL UNIQUE,
    `password` char(20) NOT NULL,
    `full_name` char(100) DEFAULT NULL,
    `email` char(100) DEFAULT NULL,
    `phone` char(20) DEFAULT NULL,
    PRIMARY KEY (id)
);

-- Dumping data for customer table
INSERT INTO `customer` (`user_name`,`password`,`full_name`,`email`,`phone`) VALUES ("admin","admin","Administrator","ooadgroup5utd@gmail.com","+1-468-555-1234");

-- Age group table
CREATE TABLE `age_group` (
	`id` int NOT NULL,
	`name` char(25) NOT NULL UNIQUE,
	PRIMARY KEY (id)
);

-- Dumping data for age group table
INSERT INTO `age_group` (`id`,`name`) VALUES (1, "New Born"), (2, "Infant"), (3, "Toddler");

-- Change auto increment for age group table
ALTER TABLE `age_group` AUTO_INCREMENT=4;

-- Subscription table
CREATE TABLE `subscription` (
	`id` int NOT NULL AUTO_INCREMENT,
	`name` char(50) NOT NULL,
	`age_group` int NOT NULL,
	`created_by` int NOT NULL,
	PRIMARY KEY (id),
	CONSTRAINT fk_subscription_created_by FOREIGN KEY (`created_by`) REFERENCES `customer`(`id`),
	CONSTRAINT fk_subscription_age_group FOREIGN KEY (`age_group`) REFERENCES `age_group`(`id`)
);

-- Dumping data for subscription table
INSERT INTO `subscription` (`id`,`name`,`age_group`,`created_by`) VALUES (1,"Standard",1,1), (2,"Standard",2,1), (3,"Standard",3,1),
(4,"Premium",1,1), (5,"Premium",2,1), (6,"Premium",3,1), (7,"Economical",1,1), (8,"Economical",2,1), (9,"Economical",3,1);

-- Change auto increment for subscription table
ALTER TABLE `age_group` AUTO_INCREMENT=10;

-- Product table
CREATE TABLE `product` (
	`id` int NOT NULL,
	`name` char(100) NOT NULL,
	`brand` char(100) NOT NULL,
	`category` char(100) NOT NULL,
	`quantity` char(20) NOT NULL,
	`price` float(5,2) NOT NULL,
	PRIMARY KEY (id)
);

-- Dumping data for product table
INSERT INTO `product` (`id`,`name`,`brand`,`category`,`quantity`,`price`) VALUES (1,"Cerelac Stage-1","Nestle","Instant Cereal","2lbs",17.82),
(2,"Baby Cereal","Gerber","Instant Cereal","2lbs",12.12),
(3,"Creamy Porridge","Hipp","Instant Cereal","2lbs",9.20);

-- Product age group mapping table
CREATE TABLE `product_age_group_mapping` (
	`id` int NOT NULL AUTO_INCREMENT,
	`product_id` int NOT NULL,
	`age_group_id` int NOT NULL,
	PRIMARY KEY (id),
	KEY(`product_id`,`age_group_id`),
	CONSTRAINT fk_product_age_group_mapping_product_id FOREIGN KEY (`product_id`) REFERENCES `product`(`id`),
	CONSTRAINT fk_product_age_group_mapping_age_group_id FOREIGN KEY (`age_group_id`) REFERENCES `age_group`(`id`)
);

-- Dumping data for product age group mapping table
INSERT INTO `product_age_group_mapping` (`product_id`,`age_group_id`) VALUES (1,2), (1,3), (2,2), (2,3), (3,2), (3,3);


-- Subscription product mapping table
CREATE TABLE `subscription_product_mapping` (
	`id` int NOT NULL AUTO_INCREMENT,
	`subscription_id` int NOT NULL,
	`product_id` int NOT NULL,
	`quantity` int NOT NULL,
	PRIMARY KEY (id),
	KEY(`subscription_id`,`product_id`),
	CONSTRAINT fk_subscription_product_mapping_subscription_id FOREIGN KEY (`subscription_id`) REFERENCES `subscription`(`id`),
	CONSTRAINT fk_subscription_product_mapping_product_id FOREIGN KEY (`product_id`) REFERENCES `product`(`id`)
);

-- Dumping data for subscription product mapping table
INSERT INTO `subscription_product_mapping` (`subscription_id`,`product_id`,`quantity`) VALUES (2,2,2), (3,2,2), (5,1,2), (6,1,2), (8,3,2), (9,3,2);

-- Customer subscription mapping table
CREATE TABLE `customer_subscription_mapping` (
	`id` int NOT NULL AUTO_INCREMENT,
	`customer_id` int NOT NULL,
	`subscription_id` int NOT NULL,
	`frequency` char(25) NOT NULL,
	`quantity` int NOT NULL,
	PRIMARY KEY (id),
	CONSTRAINT fk_customer_subscription_mapping_customer_id FOREIGN KEY (`customer_id`) REFERENCES `customer`(`id`),
	CONSTRAINT fk_customer_subscription_mapping_subscription_id FOREIGN KEY (`subscription_id`) REFERENCES `subscription`(`id`),
	CONSTRAINT ck_customer_subscription_mapping_frequency CHECK (`frequency` IN ("weekly","bi-weekly","monthly"))
);


