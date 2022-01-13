-- MIT License
-- Copyright (c) 2021 san k
-- -------------------------

-- DANGEROUS! Drops existing tables.
-- Recreates schema for Fluffy Best backend.
-- Supports (TODO: i.e. attempts to, not fully tested yet!):
-- elaborate location addressing for international addresses;
-- i18n internationalization/localization;

USE `fluffybest` ;

-- Drop tables
-- ------------

-- drop other tables
DROP TABLE IF EXISTS `fluffybest`.`product_translations`;
DROP TABLE IF EXISTS `fluffybest`.`product`;
DROP TABLE IF EXISTS `fluffybest`.`product_category_translations`;
DROP TABLE IF EXISTS `fluffybest`.`product_category`;

-- drop linking tables
DROP TABLE IF EXISTS `fluffybest`.`animal_translations`;
DROP TABLE IF EXISTS `fluffybest`.`animal_address`;
DROP TABLE IF EXISTS `fluffybest`.`animal_geo_coordinates`;
DROP TABLE IF EXISTS `fluffybest`.`animal`;
DROP TABLE IF EXISTS `fluffybest`.`animal_status_translations`;
DROP TABLE IF EXISTS `fluffybest`.`animal_status`;
DROP TABLE IF EXISTS `fluffybest`.`animal_type_translations`;
DROP TABLE IF EXISTS `fluffybest`.`animal_type`;

-- drop tables in the order reverse to the creation order
DROP TABLE IF EXISTS `fluffybest`.`geo_coordinates`;

DROP TABLE IF EXISTS `fluffybest`.`address`;
DROP TABLE IF EXISTS `fluffybest`.`address_type_translations`;
DROP TABLE IF EXISTS `fluffybest`.`address_type`;
DROP TABLE IF EXISTS `fluffybest`.`locality_translations`;
DROP TABLE IF EXISTS `fluffybest`.`locality`;
DROP TABLE IF EXISTS `fluffybest`.`locality_type_translations`;
DROP TABLE IF EXISTS `fluffybest`.`locality_type`;
DROP TABLE IF EXISTS `fluffybest`.`region_translations`;
DROP TABLE IF EXISTS `fluffybest`.`region`;
DROP TABLE IF EXISTS `fluffybest`.`region_type_translations`;
DROP TABLE IF EXISTS `fluffybest`.`region_type`;
DROP TABLE IF EXISTS `fluffybest`.`country_translations`;
DROP TABLE IF EXISTS `fluffybest`.`country`;
DROP TABLE IF EXISTS `fluffybest`.`language`;

-- Aux tables
-- -----------
CREATE TABLE IF NOT EXISTS `fluffybest`.`language` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `alpha_two_code` VARCHAR(2) NOT NULL, -- ISO 639‑1 codes
    `name` VARCHAR(255) NOT NULL,
    `native_name` VARCHAR(255) NOT NULL,
    `date_format` VARCHAR(255) NOT NULL,
    `currency` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT = 1;

-- Location description
-- ---------------------
CREATE TABLE IF NOT EXISTS `fluffybest`.`country` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `alpha_two_code` VARCHAR(2) NOT NULL, -- ISO 3166-1 alpha-2 codes
    `short_name` VARCHAR(80) NULL DEFAULT NULL,
    `name` VARCHAR(120) NULL DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `fluffybest`.`country_translations` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `short_name_translation` VARCHAR(80) NOT NULL,
    `name_translation` VARCHAR(120) NOT NULL,
    `language_id` INT NOT NULL,
    `country_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_language` (`language_id`),
    CONSTRAINT `fk_country_translations_language`
    FOREIGN KEY (`language_id`) REFERENCES `language` (`id`),
    KEY `fk_country` (`country_id`),
    CONSTRAINT `fk_country_translations_country`
    FOREIGN KEY (`country_id`) REFERENCES `country` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT = 1;

-- The first-level Administrative division type 
-- Example: state in the USA, oblast in Russia, etc.
CREATE TABLE IF NOT EXISTS `fluffybest`.`region_type` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NULL DEFAULT NULL,
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `fluffybest`.`region_type_translations` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `name_translation` VARCHAR(255) NOT NULL,
	`language_id` INT NOT NULL,
    `region_type_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_language` (`language_id`),
    CONSTRAINT `region_type_translations_language` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`),
    KEY `fk_region_type` (`region_type_id`),
    CONSTRAINT `region_type_translations_country` FOREIGN KEY (`region_type_id`) REFERENCES `region_type` (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT = 1;

-- The region in which the locality is, and which is in the country (first-level Administrative division). 
-- For example, California or another appropriate first-level Administrative division
-- see https://en.wikipedia.org/wiki/List_of_administrative_divisions_by_country
CREATE TABLE IF NOT EXISTS `fluffybest`.`region` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NULL DEFAULT NULL,
	`type_id` INT NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_type` (`type_id`),
    CONSTRAINT `fk_region_type` FOREIGN KEY (`type_id`) REFERENCES `region_type` (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `fluffybest`.`region_translations` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `name_translation` VARCHAR(255) NOT NULL,
	`language_id` INT NOT NULL,
    `region_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_language` (`language_id`),
    CONSTRAINT `region_translations_language` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`),
    KEY `fk_region_translations_region` (`region_id`),
    CONSTRAINT `region_translations_country` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT = 1;

-- The locality type example: town, city, etc.
CREATE TABLE IF NOT EXISTS `fluffybest`.`locality_type` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NULL DEFAULT NULL,
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `fluffybest`.`locality_type_translations` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `name_translation` VARCHAR(255) NOT NULL,
	`language_id` INT NOT NULL,
    `locality_type_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_language` (`language_id`),
    CONSTRAINT `locality_type_translations_language` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`),
    KEY `fk_locality_type` (`locality_type_id`),
    CONSTRAINT `locality_type_translations_locality_type` FOREIGN KEY (`locality_type_id`) REFERENCES `locality_type` (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT = 1;

-- The locality in which the street address is, and which is in the region. For example, Mountain View.
CREATE TABLE IF NOT EXISTS `fluffybest`.`locality` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NULL DEFAULT NULL,
	`type_id` INT NULL DEFAULT NULL,
    `region_id` INT NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    INDEX(`name`),
    KEY `fk_region` (`region_id`),
    CONSTRAINT `fk_locality_region` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`),
    KEY `fk_type` (`type_id`),
    CONSTRAINT `fk_locality_type` FOREIGN KEY (`type_id`) REFERENCES `locality_type` (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `fluffybest`.`locality_translations` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `name_translation` VARCHAR(255) NOT NULL,
	`language_id` INT NOT NULL,
    `locality_id` BIGINT NOT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_language` (`language_id`),
    CONSTRAINT `locality_translations_language` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`),
    KEY `fk_locality` (`locality_id`),
    CONSTRAINT `locality_translations_locality` FOREIGN KEY (`locality_id`) REFERENCES `locality` (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT = 1;

-- E.g.: postal address, billing address, delivery address, etc.
CREATE TABLE IF NOT EXISTS `fluffybest`.`address_type` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(80) NULL DEFAULT NULL,
    PRIMARY KEY (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `fluffybest`.`address_type_translations` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `name_translation` VARCHAR(255) NOT NULL,
	`language_id` INT NOT NULL,
    `address_type_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_language` (`language_id`),
    CONSTRAINT `address_type_translations_language` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`),
    KEY `fk_address_type` (`address_type_id`),
    CONSTRAINT `address_type_translations_address_type` FOREIGN KEY (`address_type_id`) REFERENCES `address_type` (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT = 1;

-- Follows recommendations on https://schema.org/PostalAddress
CREATE TABLE IF NOT EXISTS `fluffybest`.`address` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
    `address_type_id` INT NOT NULL, -- TODO fill in with viable default
    `country_id` INT NOT NULL, -- The country. For example, USA.
    `locality_id` BIGINT NULL DEFAULT NULL, -- The locality in which the street address is
    `region_id` INT NULL DEFAULT NULL, -- first-level Administrative division
    `post_office_box_number` VARCHAR(80) NULL DEFAULT NULL, -- The post office box number for PO box addresses.
    `postal_code` VARCHAR(80) NULL DEFAULT NULL, -- The postal code. For example, 94043.
    `street` VARCHAR(255) NOT NULL DEFAULT 'No address',
    `building` VARCHAR(80) NULL DEFAULT NULL, -- In some countries names instead of numbers
    `apartment` VARCHAR(80) NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_address_type` (`address_type_id`),
    CONSTRAINT `fk_address_type` FOREIGN KEY (`address_type_id`) REFERENCES `address_type` (`id`),
    KEY `fk_country` (`country_id`),
    CONSTRAINT `fk_address_country` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`),
    KEY `fk_locality` (`locality_id`),
    CONSTRAINT `fk_address_locality` FOREIGN KEY (`locality_id`) REFERENCES `locality` (`id`),
    KEY `fk_region` (`region_id`),
    CONSTRAINT `fk_address_region` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT = 1;

-- Follows recommendations on https://schema.org/GeoCoordinates guidelines
CREATE TABLE IF NOT EXISTS `fluffybest`.`geo_coordinates` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`address_id` BIGINT NULL DEFAULT NULL, -- For handling coordinates of a certain address
    `country_id` INT NULL DEFAULT NULL,
    `elevation` INT NULL DEFAULT NULL, -- WGS84
    `latitude` DECIMAL(16,14) NOT NULL, -- WGS84
    `longitude` DECIMAL(17,14) NOT NULL, -- WGS84
    PRIMARY KEY (`id`),
    KEY `fk_country` (`country_id`),
    CONSTRAINT `fk_geo_coordinates_country` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`),
    KEY `fk_address` (`address_id`),
	CONSTRAINT `fk_geo_coordinates_address` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT = 1;

-- Domain tables
-- --------------

-- Animal description
-- -------------------

CREATE TABLE IF NOT EXISTS `fluffybest`.`animal_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `breed` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unq_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `fluffybest`.`animal_type_translations` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `name_translation` VARCHAR(255) NOT NULL,
    `breed_translation` VARCHAR(255) NOT NULL,
	`language_id` INT NOT NULL,
    `animal_type_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_language` (`language_id`),
    CONSTRAINT `animal_type_translations_language` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`),
    KEY `fk_animal_type` (`animal_type_id`),
    CONSTRAINT `animal_type_translations_animal_type` FOREIGN KEY (`animal_type_id`) REFERENCES `animal_type` (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `fluffybest`.`animal_status` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL DEFAULT 'unknown',
  PRIMARY KEY (`id`)
  ) ENGINE=InnoDB AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `fluffybest`.`animal_status_translations` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `name_translation` VARCHAR(255) NOT NULL,
	`language_id` INT NOT NULL,
    `animal_status_id` INT NOT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_language` (`language_id`),
    CONSTRAINT `animal_status_translations_language` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`),
    KEY `fk_animal_status` (`animal_status_id`),
    CONSTRAINT `animal_status_translations_animal_status` FOREIGN KEY (`animal_status_id`) REFERENCES `animal_status` (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `fluffybest`.`animal` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  `birth_date` DATE NULL DEFAULT NULL,
  `description` VARCHAR(15600) NULL DEFAULT NULL,
  `aggression_level` TINYINT NULL DEFAULT NULL,
  `full_bio` TEXT NULL DEFAULT NULL,
  `image_url` VARCHAR(255) NULL DEFAULT NULL,
  `active` BIT DEFAULT 1,
  `date_created` DATETIME(6) NULL DEFAULT NULL,
  `last_updated` DATETIME(6) NULL DEFAULT NULL,
  `type_id` INT NULL DEFAULT NULL,
  `status_id` INT NULL DEFAULT NULL,
  INDEX(`name`),
  PRIMARY KEY (`id`),
  KEY `fk_type` (`type_id`),
  CONSTRAINT `fk_animal_type` FOREIGN KEY (`type_id`) REFERENCES `animal_type` (`id`),
  KEY `fk_status` (`status_id`),
  CONSTRAINT `fk_animal_status` FOREIGN KEY (`status_id`) REFERENCES `animal_status` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `fluffybest`.`animal_translations` (
    `id` BIGINT NOT NULL AUTO_INCREMENT,
    `name_translation` VARCHAR(255) NULL DEFAULT NULL,
    `description_translation` VARCHAR(15800) NULL DEFAULT NULL,
    `full_bio_translation` TEXT NULL DEFAULT NULL,
 	`language_id` INT NOT NULL,
    `animal_id` BIGINT NOT NULL,
  INDEX(`name_translation`),
  PRIMARY KEY (`id`),
    KEY `fk_language` (`language_id`),
    CONSTRAINT `animal_translations_language` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`),
    KEY `fk_animal_id` (`animal_id`),
    CONSTRAINT `animal_translations_animal` FOREIGN KEY (`animal_id`) REFERENCES `animal` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `fluffybest`.`animal_geo_coordinates` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `animal_id` BIGINT NOT NULL,
  `geo_coordinates_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_animal` (`animal_id`),
  CONSTRAINT `fk_animal_geo_coordinates_animal` FOREIGN KEY (`animal_id`) REFERENCES `animal` (`id`),
  KEY `fk_geo_coordinates` (`geo_coordinates_id`),
  CONSTRAINT `fk_animal_geo_coordinates_coordinates` FOREIGN KEY (`geo_coordinates_id`) REFERENCES `geo_coordinates` (`id`)
  ) ENGINE=InnoDB AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `fluffybest`.`animal_address` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `animal_id` BIGINT NOT NULL,
  `address_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_animal` (`animal_id`),
  CONSTRAINT `fk_animal_address_animal` FOREIGN KEY (`animal_id`) REFERENCES `animal` (`id`),
  KEY `fk_address` (`address_id`),
  CONSTRAINT `fk_animal_address_address` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`)
  ) ENGINE=InnoDB AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `fluffybest`.`product_category` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`)) ENGINE=InnoDB AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `fluffybest`.`product_category_translations` (
	`id` INT NOT NULL AUTO_INCREMENT,
    `name_translation` VARCHAR(255) NOT NULL,
	`language_id` INT NOT NULL,
    `product_category_id` BIGINT NOT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_language` (`language_id`),
    CONSTRAINT `product_category_translations_language` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`),
    KEY `fk_product_category` (`product_category_id`),
    CONSTRAINT `product_category_translations_product_category` FOREIGN KEY (`product_category_id`) REFERENCES `product_category` (`id`)
    ) ENGINE=InnoDB AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `fluffybest`.`product` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `sku` VARCHAR(255) DEFAULT NULL,
  `name` VARCHAR(255) DEFAULT NULL,
  `description` VARCHAR(255) DEFAULT NULL,
  `unit_price` DECIMAL(13,2) DEFAULT NULL,
  `image_url` VARCHAR(255) DEFAULT NULL,
  `active` BIT DEFAULT 1,
  `units_in_stock` INT DEFAULT NULL,
   `date_created` DATETIME(6) DEFAULT NULL,
  `last_updated` DATETIME(6) DEFAULT NULL,
  `category_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_category` (`category_id`),
  CONSTRAINT `fk_category` FOREIGN KEY (`category_id`) REFERENCES `product_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `fluffybest`.`product_translations` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(255) DEFAULT NULL,
	`description` VARCHAR(255) DEFAULT NULL,
	`language_id` INT NOT NULL,
	`product_id` BIGINT NOT NULL,
	PRIMARY KEY (`id`),
	KEY `fk_language` (`language_id`),
    CONSTRAINT `product_translations_language` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`),
    KEY `fk_product` (`product_id`),
    CONSTRAINT `product_translations_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT = 1;

SET FOREIGN_KEY_CHECKS = 1;