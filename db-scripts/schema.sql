USE `betterplace` ;

-- in order to easily recreate the schema under development
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `betterplace`.`country`;

CREATE TABLE IF NOT EXISTS `betterplace`.`country` (
	`iso_alpha_2` VARCHAR(2) NOT NULL,
    `name` VARCHAR(80) NOT NULL,
    `full_name` VARCHAR(160) NOT NULL,
    PRIMARY KEY (`iso_alpha_2`),
    UNIQUE (`name`),
    UNIQUE (`full_name`)
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `betterplace`.`city`;

CREATE TABLE IF NOT EXISTS `betterplace`.`city` (
	`id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(80) NOT NULL,
    `country_id` VARCHAR(2) NOT NULL,
    `region` VARCHAR(80) NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_country` (`country_id`),
    CONSTRAINT `fk_country` FOREIGN KEY (`country_id`) REFERENCES `country` (`iso_alpha_2`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT = 1;

DROP TABLE IF EXISTS `betterplace`.`address`;

CREATE TABLE IF NOT EXISTS `betterplace`.`address` (
	`id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `main` BIT DEFAULT 1,
    `address` VARCHAR(80) NULL DEFAULT NULL,
    `city_id` BIGINT(20) NOT NULL,
    `latitude` DECIMAL(8,6) NULL DEFAULT NULL,
    `longitude` DECIMAL(9,6) NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    INDEX(`address`),
    KEY `fk_city` (`city_id`),
    CONSTRAINT `fk_city` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `betterplace`.`area` (
	`id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `main` BIT DEFAULT 1,
    `latitude` DECIMAL(8,6) NULL DEFAULT NULL,
    `longitude` DECIMAL(9,6) NULL DEFAULT NULL,
    `radius` DECIMAL(9,6) NULL DEFAULT NULL,
    PRIMARY KEY (`id`)
    )
ENGINE=InnoDB
AUTO_INCREMENT = 1;

DROP TABLE IF EXISTS `betterplace`.`animal_type`;

CREATE TABLE IF NOT EXISTS `betterplace`.`animal_type` (
  `id` INT(4) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unq_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT = 1;

DROP TABLE IF EXISTS `betterplace`.`animal_status`;

CREATE TABLE IF NOT EXISTS `betterplace`.`animal_status` (
  `id` INT(2) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unq_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT = 1;

DROP TABLE IF EXISTS `betterplace`.`animal`;

CREATE TABLE IF NOT EXISTS `betterplace`.`animal` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL DEFAULT 'Beast',
  `birth_date` DATE NULL DEFAULT NULL,
  `description` VARCHAR(255) NULL DEFAULT NULL,
  `image_url` VARCHAR(255) NULL DEFAULT NULL,
  `active` BIT DEFAULT 1,
	`date_created` DATETIME(6) DEFAULT NULL,
  `last_updated` DATETIME(6) DEFAULT NULL,
  `type_id` INT(4) NOT NULL,
  `status_id` INT(2) NULL DEFAULT NULL,
  INDEX(`name`),
  PRIMARY KEY (`id`),
  KEY `fk_type` (`type_id`),
  CONSTRAINT `fk_type` FOREIGN KEY (`type_id`) REFERENCES `animal_type` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  KEY `fk_status` (`status_id`),
  CONSTRAINT `fk_status` FOREIGN KEY (`status_id`) REFERENCES `animal_status` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT = 1;

DROP TABLE IF EXISTS `betterplace`.`address_animal`;

CREATE TABLE `address_animal` (
  `address_id` BIGINT(20) NOT NULL,
  `animal_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`address_id`,`animal_id`),
  KEY `fk_animal` (`animal_id`), -- KEY is a synonym for INDEX
  CONSTRAINT `fk_address` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`) 
  ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_animal_to_address` FOREIGN KEY (`animal_id`) REFERENCES `animal` (`id`) 
  ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;

DROP TABLE IF EXISTS `betterplace`.`area_animal`;

CREATE TABLE `area_animal` (
  `area_id` BIGINT(20) NOT NULL,
  `animal_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`area_id`,`animal_id`),
  KEY `fk_animal` (`animal_id`), -- KEY is a synonym for INDEX
  CONSTRAINT `fk_area` FOREIGN KEY (`area_id`) REFERENCES `area` (`id`) 
  ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_animal_to_area` FOREIGN KEY (`animal_id`) REFERENCES `animal` (`id`) 
  ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB;

-- aux tables

DROP TABLE IF EXISTS `betterplace`.`product_category`;

CREATE TABLE IF NOT EXISTS `betterplace`.`product_category` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE=InnoDB
AUTO_INCREMENT = 1;

DROP TABLE IF EXISTS `betterplace`.`product`;

CREATE TABLE IF NOT EXISTS `betterplace`.`product` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `sku` VARCHAR(255) DEFAULT NULL,
  `name` VARCHAR(255) DEFAULT NULL,
  `description` VARCHAR(255) DEFAULT NULL,
  `unit_price` DECIMAL(13,2) DEFAULT NULL,
  `image_url` VARCHAR(255) DEFAULT NULL,
  `active` BIT DEFAULT 1,
  `units_in_stock` INT(11) DEFAULT NULL,
   `date_created` DATETIME(6) DEFAULT NULL,
  `last_updated` DATETIME(6) DEFAULT NULL,
  `category_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_category` (`category_id`),
  CONSTRAINT `fk_category` FOREIGN KEY (`category_id`) REFERENCES `product_category` (`id`)
) 
ENGINE=InnoDB
AUTO_INCREMENT = 1;

SET FOREIGN_KEY_CHECKS = 1;