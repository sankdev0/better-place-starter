-- MIT License
-- Copyright (c) 2021 san k
---------------------------

-- DANGEROUS! Might break constrains when run on unprepared database. Recreate the schema first.
-- Enters sample data into the schema for Fluffy Best backend.

USE `fluffybest` ;

-- Add sample data
-- -----------------------------------------------------

INSERT INTO language (alpha_two_code, name, native_name, date_format, currency)
VALUES ('EN', 'English', 'English','mon-dd, yyyy', 'USD');

INSERT INTO language (alpha_two_code, name, native_name, date_format, currency)
VALUES ('RU', 'Russian', 'Русский','dd.mm.yyyy', 'RUB');

INSERT INTO country (alpha_two_code)
VALUES ('RU');

INSERT INTO country (alpha_two_code)
VALUES ('US');

INSERT INTO country_translations (short_name_translation, name_translation, language_id, country_id)
VALUES ('Russia', 'Russian Federation', 1, 1);

INSERT INTO country_translations (short_name_translation, name_translation, language_id, country_id)
VALUES ('USA', 'United States of America', 1, 2);

INSERT INTO country_translations (short_name_translation, name_translation, language_id, country_id)
VALUES ('Россия', 'Российская Федерация', 2, 1);

INSERT INTO country_translations (short_name_translation, name_translation, language_id, country_id)
VALUES ('США', 'Соединенные Штаты Америки', 2, 2);

INSERT INTO product_category(category_name) VALUES ('BOOKS');

INSERT INTO product (sku, name, description, image_url, active, units_in_stock,
unit_price, category_id, date_created)
VALUES ('BOOK-TECH-1000', 'JavaScript - The Fun Parts', 'Learn JavaScript',
'assets/images/products/placeholder.png'
,1,100,19.99,1, NOW());

INSERT INTO product (sku, name, description, image_url, active, units_in_stock,
unit_price, category_id, date_created)
VALUES ('BOOK-TECH-1001', 'Spring Framework Tutorial', 'Learn Spring',
'assets/images/products/placeholder.png'
,1,100,29.99,1, NOW());

INSERT INTO product (sku, name, description, image_url, active, units_in_stock,
unit_price, category_id, date_created)
VALUES ('BOOK-TECH-1002', 'Kubernetes - Deploying Containers', 'Learn Kubernetes',
'assets/images/products/placeholder.png'
,1,100,24.99,1, NOW());

INSERT INTO product (sku, name, description, image_url, active, units_in_stock,
unit_price, category_id, date_created)
VALUES ('BOOK-TECH-1003', 'Internet of Things (IoT) - Getting Started', 'Learn IoT',
'assets/images/products/placeholder.png'
,1,100,29.99,1, NOW());

INSERT INTO product (sku, name, description, image_url, active, units_in_stock,
unit_price, category_id, date_created)
VALUES ('BOOK-TECH-1004', 'The Go Programming Language: A to Z', 'Learn Go',
'assets/images/products/placeholder.png'
,1,100,24.99,1, NOW());
