USE `betterplace` ;

DROP TABLE IF EXISTS `betterplace`.`animal`;
DROP TABLE IF EXISTS `betterplace`.`animal_type`;
DROP TABLE IF EXISTS `betterplace`.`animal_status`;

DROP TABLE IF EXISTS `betterplace`.`product`;
DROP TABLE IF EXISTS `betterplace`.`product_category`;

DROP TABLE IF EXISTS `betterplace`.`geo_coordinates`;
DROP TABLE IF EXISTS `betterplace`.`address`;
DROP TABLE IF EXISTS `betterplace`.`address_type`;
DROP TABLE IF EXISTS `betterplace`.`locality`;
DROP TABLE IF EXISTS `betterplace`.`locality_type`;
DROP TABLE IF EXISTS `betterplace`.`region`;
DROP TABLE IF EXISTS `betterplace`.`region_type`;
DROP TABLE IF EXISTS `betterplace`.`country`;

# Location description

CREATE TABLE IF NOT EXISTS `betterplace`.`country` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(80) NOT NULL,
    PRIMARY KEY (`id`),
    INDEX(`name`)
    )
ENGINE=InnoDB
AUTO_INCREMENT = 1;

# The first-level Administrative division type 
# Example: state in the USA, oblast in Russia, etc.
CREATE TABLE IF NOT EXISTS `betterplace`.`region_type` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(80) NOT NULL,
    PRIMARY KEY (`id`)
    )
ENGINE=InnoDB
AUTO_INCREMENT = 1;

# The region in which the locality is, and which is in the country (first-level Administrative division). 
# For example, California or another appropriate first-level Administrative division
# see https://en.wikipedia.org/wiki/List_of_administrative_divisions_by_country
CREATE TABLE IF NOT EXISTS `betterplace`.`region` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(80) NOT NULL,
	`type_id` BIGINT NULL DEFAULT NULL,
    `country_id` BIGINT NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    INDEX(`name`),
    KEY `fk_country` (`country_id`),
    CONSTRAINT `fk_region_country` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`),
    KEY `fk_type` (`type_id`),
    CONSTRAINT `fk_region_type` FOREIGN KEY (`type_id`) REFERENCES `region_type` (`id`)
    )
ENGINE=InnoDB
AUTO_INCREMENT = 1;

# The locality type examle: town, city, etc.
CREATE TABLE IF NOT EXISTS `betterplace`.`locality_type` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(80) NOT NULL,
    PRIMARY KEY (`id`)
    )
ENGINE=InnoDB
AUTO_INCREMENT = 1;

# The locality in which the street address is, and which is in the region. For example, Mountain View.
CREATE TABLE IF NOT EXISTS `betterplace`.`locality` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(80) NOT NULL,
	`type_id` BIGINT NULL DEFAULT NULL,
    `region_id` BIGINT NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    INDEX(`name`),
    KEY `fk_region` (`region_id`),
    CONSTRAINT `fk_locality_region` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`),
    KEY `fk_type` (`type_id`),
    CONSTRAINT `fk_locality_type` FOREIGN KEY (`type_id`) REFERENCES `locality_type` (`id`)
    )
ENGINE=InnoDB
AUTO_INCREMENT = 1;

# E.g.: postal address, billing address, delivery address, etc.
CREATE TABLE IF NOT EXISTS `betterplace`.`address_type` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(80) NOT NULL,
    PRIMARY KEY (`id`)
    )
ENGINE=InnoDB
AUTO_INCREMENT = 1;

# Follows recommendations on https://schema.org/PostalAddress
CREATE TABLE IF NOT EXISTS `betterplace`.`address` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
    `address_type_id` BIGINT NOT NULL, # TODO fill in with viable default
    `country_id` BIGINT NOT NULL, # The country. For example, USA.
    `locality_id` BIGINT NULL DEFAULT NULL, # The locality in which the street address is
    `region_id` BIGINT NULL DEFAULT NULL, # first-level Administrative division
    `post_office_box_number` VARCHAR(20) NULL DEFAULT NULL, # The post office box number for PO box addresses.
    `postal_code` VARCHAR(20) NULL DEFAULT NULL, # The postal code. For example, 94043.
    `street` VARCHAR(80) NOT NULL DEFAULT 'No address',
    `building` VARCHAR(60) NULL DEFAULT NULL, # In some countries names instead of numbers
    `apartment` VARCHAR(60) NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_address_type` (`address_type_id`),
    CONSTRAINT `fk_address_type` FOREIGN KEY (`address_type_id`) REFERENCES `address_type` (`id`),
    KEY `fk_country` (`country_id`),
    CONSTRAINT `fk_address_country` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`),
    KEY `fk_locality` (`locality_id`),
    CONSTRAINT `fk_address_locality` FOREIGN KEY (`locality_id`) REFERENCES `locality` (`id`),
    KEY `fk_region` (`region_id`),
    CONSTRAINT `fk_address_region` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`)
    )
ENGINE=InnoDB
AUTO_INCREMENT = 1;

# Follows recommendations on https://schema.org/GeoCoordinates guidelines
CREATE TABLE IF NOT EXISTS `betterplace`.`geo_coordinates` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`address_id` BIGINT NULL DEFAULT NULL, #For handling coordinates of a certain address
    `country_id` BIGINT NULL DEFAULT NULL,
    `elevation` INT NULL DEFAULT NULL, #WGS84
    `latitude` DECIMAL(8,6) NOT NULL, #WGS84
    `longitude` DECIMAL(9,6) NOT NULL, #WGS84
    `postal_code` VARCHAR(20) NULL DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_country` (`country_id`),
    CONSTRAINT `fk_geo_coordinates_country` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`),
    KEY `fk_address` (`address_id`),
	CONSTRAINT `fk_geo_coordinates_address` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`)
    )
ENGINE=InnoDB
AUTO_INCREMENT = 1;

# Animal description

CREATE TABLE IF NOT EXISTS `betterplace`.`animal_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NOT NULL DEFAULT 'unknown',
  PRIMARY KEY (`id`),
  INDEX(`name`)
  )
ENGINE=InnoDB
AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `betterplace`.`animal_status` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(80) NOT NULL DEFAULT 'unknown',
  PRIMARY KEY (`id`))
ENGINE=InnoDB
AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `betterplace`.`animal` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL DEFAULT 'Beast',
  `birth_date` DATE,
  `description` VARCHAR(255) DEFAULT NULL,
  `image_url` VARCHAR(255) DEFAULT NULL,
  `active` BIT DEFAULT 1,
   `date_created` DATETIME(6) DEFAULT NULL,
  `last_updated` DATETIME(6) DEFAULT NULL,
  `type_id` INT NOT NULL,
  `status_id` INT DEFAULT NULL,
  `address_id` BIGINT DEFAULT NULL,
  `geo_coordinates_id` BIGINT DEFAULT NULL,
  INDEX(`name`),
  PRIMARY KEY (`id`),
  KEY `fk_type` (`type_id`),
  CONSTRAINT `fk_animal_type` FOREIGN KEY (`type_id`) REFERENCES `animal_type` (`id`),
  KEY `fk_status` (`status_id`),
  CONSTRAINT `fk_animal_status` FOREIGN KEY (`status_id`) REFERENCES `animal_status` (`id`),
  KEY `fk_address` (`address_id`),
  CONSTRAINT `fk_animal_address` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`),
  KEY `fk_geo_coordinates` (`geo_coordinates_id`),
  CONSTRAINT `fk_animal_geo_coordinates` FOREIGN KEY (`geo_coordinates_id`) REFERENCES `geo_coordinates` (`id`)
) 
ENGINE=InnoDB
AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `betterplace`.`product_category` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE=InnoDB
AUTO_INCREMENT = 1;

CREATE TABLE IF NOT EXISTS `betterplace`.`product` (
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
) 
ENGINE=InnoDB
AUTO_INCREMENT = 1;