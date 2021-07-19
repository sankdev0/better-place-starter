USE `betterplace` ;

DROP TABLE IF EXISTS `betterplace`.`address`;
DROP TABLE IF EXISTS `betterplace`.`city`;

DROP TABLE IF EXISTS `betterplace`.`animal`;
DROP TABLE IF EXISTS `betterplace`.`animal_type`;
DROP TABLE IF EXISTS `betterplace`.`animal_status`;

DROP TABLE IF EXISTS `betterplace`.`product`;
DROP TABLE IF EXISTS `betterplace`.`product_category`;

CREATE TABLE IF NOT EXISTS `betterplace`.`city` (
	`id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(80) NOT NULL,
    `country` VARCHAR(80) NOT NULL,
    `region` VARCHAR(80) NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    INDEX(`name`)
    )
ENGINE=InnoDB
AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `betterplace`.`address` (
	`id` BIGINT(20) NOT NULL AUTO_INCREMENT,
    `main` BIT DEFAULT 1,
    `address` VARCHAR(80) NOT NULL DEFAULT 'No address',
    `city_id` BIGINT(20) NOT NULL,
    `latitude` DECIMAL(8,6) NULL DEFAULT NULL,
    `longitude` DECIMAL(9,6) NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    INDEX(`address`),
    KEY `fk_city` (`city_id`),
    CONSTRAINT `fk_city` FOREIGN KEY (`city_id`) REFERENCES `city` (`id`)
    )
ENGINE=InnoDB
AUTO_INCREMENT = 1;

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

CREATE TABLE IF NOT EXISTS `betterplace`.`animal_type` (
  `id` INT(4) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NOT NULL DEFAULT 'unknown',
  PRIMARY KEY (`id`),
  INDEX(`name`)
  )
ENGINE=InnoDB
AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `betterplace`.`animal_status` (
  `id` INT(2) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NOT NULL DEFAULT 'unknown',
  PRIMARY KEY (`id`))
ENGINE=InnoDB
AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `betterplace`.`animal` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL DEFAULT 'Beast',
  `birth_date` DATE,
  `description` VARCHAR(255) DEFAULT NULL,
  `image_url` VARCHAR(255) DEFAULT NULL,
  `active` BIT DEFAULT 1,
   `date_created` DATETIME(6) DEFAULT NULL,
  `last_updated` DATETIME(6) DEFAULT NULL,
  `type_id` INT(4) NOT NULL,
  `status_id` INT(2) DEFAULT NULL,
  `address_id` BIGINT(20) DEFAULT NULL,
  INDEX(`name`),
  PRIMARY KEY (`id`),
  KEY `fk_type` (`type_id`),
  CONSTRAINT `fk_type` FOREIGN KEY (`type_id`) REFERENCES `animal_type` (`id`),
  KEY `fk_status` (`status_id`),
  CONSTRAINT `fk_status` FOREIGN KEY (`status_id`) REFERENCES `animal_status` (`id`),
  KEY `fk_address` (`address_id`),
  CONSTRAINT `fk_address` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`)
) 
ENGINE=InnoDB
AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `betterplace`.`product_category` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE=InnoDB
AUTO_INCREMENT = 1;

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