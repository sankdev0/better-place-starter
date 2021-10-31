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

-- TODO: replace with batch insert of empty rows, if possible.
INSERT INTO region_type ()
VALUES ();

INSERT INTO region_type ()
VALUES ();

INSERT INTO region_type ()
VALUES ();

INSERT INTO region_type_translations (name_translation, language_id, region_type_id)
VALUES ('oblast', 1, 1);

INSERT INTO region_type_translations (name_translation, language_id, region_type_id)
VALUES ('respublica', 1, 2);

INSERT INTO region_type_translations (name_translation, language_id, region_type_id)
VALUES ('state', 1, 3);

INSERT INTO region_type_translations (name_translation, language_id, region_type_id)
VALUES ('область', 2, 1);

INSERT INTO region_type_translations (name_translation, language_id, region_type_id)
VALUES ('республика', 2, 2);

INSERT INTO region_type_translations (name_translation, language_id, region_type_id)
VALUES ('штат', 2, 3);

INSERT INTO region (type_id)
VALUES (1);

INSERT INTO region (type_id)
VALUES (2);

INSERT INTO region (type_id)
VALUES (3);

INSERT INTO region_translations (name_translation, language_id, region_id)
VALUES ('Orenburgskaya', 1, 1);

INSERT INTO region_translations (name_translation, language_id, region_id)
VALUES ('Bashkortostan', 1, 2);

INSERT INTO region_translations (name_translation, language_id, region_id)
VALUES ('California', 1, 3);

INSERT INTO region_translations (name_translation, language_id, region_id)
VALUES ('Оренбургская', 2, 1);

INSERT INTO region_translations (name_translation, language_id, region_id)
VALUES ('Башкортостан', 2, 2);

INSERT INTO region_translations (name_translation, language_id, region_id)
VALUES ('Калифорния', 2, 3);

INSERT INTO locality_type ()
VALUES ();

INSERT INTO locality_type_translations (name_translation, language_id, locality_type_id)
VALUES ('city', 1, 1);

INSERT INTO locality_type_translations (name_translation, language_id, locality_type_id)
VALUES ('город', 2, 1);

INSERT INTO locality (type_id, region_id)
VALUES (1, 1);

INSERT INTO locality_translations (name_translation, language_id, locality_id)
VALUES ('Orenburg', 1, 1);

INSERT INTO locality_translations (name_translation, language_id, locality_id)
VALUES ('Оренбург', 2, 1);

INSERT INTO locality (type_id, region_id)
VALUES (1, 2);

INSERT INTO locality_translations (name_translation, language_id, locality_id)
VALUES ('Ufa', 1, 2);

INSERT INTO locality_translations (name_translation, language_id, locality_id)
VALUES ('Уфа', 2, 2);

INSERT INTO locality (type_id, region_id)
VALUES (1, 3);

INSERT INTO locality_translations (name_translation, language_id, locality_id)
VALUES ('San-Franсisco', 1, 3);

INSERT INTO locality_translations (name_translation, language_id, locality_id)
VALUES ('Сан-Франциско', 2, 3);

INSERT INTO address_type ()
VALUES ();

INSERT INTO address_type_translations (name_translation, language_id, address_type_id)
VALUES ('postal', 1, 1);

INSERT INTO address_type_translations (name_translation, language_id, address_type_id)
VALUES ('почтовый', 2, 1);

INSERT INTO address (address_type_id, country_id, locality_id, region_id, postal_code, street, building)
VALUES (1, 1, 1, 1, '460021', 'ул. Чкалова',  '15А');

INSERT INTO address (address_type_id, country_id, locality_id, region_id, postal_code, street, building)
VALUES (1, 1, 2, 2, '320011', 'ул. Солнечная', '22');

INSERT INTO address (address_type_id, country_id, locality_id, region_id, postal_code, street, building)
VALUES (1, 2, 3, 3, '3571', 'Flowers str', 'Cray house');

-- 1
INSERT INTO geo_coordinates (country_id, latitude, longitude)
VALUES (1, 51.77454129277207, 55.15962312303773);

-- 2
INSERT INTO geo_coordinates (country_id, latitude, longitude)
VALUES (1, 51.77379113062797, 55.16037414148665);

-- 3
INSERT INTO geo_coordinates (country_id, latitude, longitude)
VALUES (1, 51.77515867350963, 55.16534159233501);

-- 4
INSERT INTO geo_coordinates (country_id, latitude, longitude)
VALUES (1, 51.769305360823175, 55.194258914661965);

-- 5
INSERT INTO geo_coordinates (country_id, latitude, longitude)
VALUES (1, 51.771496282640044, 55.19372247306536);

-- 6
INSERT INTO geo_coordinates (country_id, latitude, longitude)
VALUES (1, 51.77146972664905, 55.19355081170561);

-- Dog
INSERT INTO animal_type (name)
VALUES ('Dog');

-- Cat
INSERT INTO animal_type (name)
VALUES ('Cat');

INSERT INTO animal_type_translations (name_translation, language_id, animal_type_id)
VALUES ('Dog', 1, 1);

INSERT INTO animal_type_translations (name_translation, language_id, animal_type_id)
VALUES ('Cat', 1, 2);

INSERT INTO animal_type_translations (name_translation, language_id, animal_type_id)
VALUES ('Собака', 2, 1);

INSERT INTO animal_type_translations (name_translation, language_id, animal_type_id)
VALUES ('Кошка', 2, 2);

-- Chipped means All good
INSERT INTO animal_status (name)
VALUES ('chipped');

-- In distress
INSERT INTO animal_status (name)
VALUES ('in distress');

-- Died
INSERT INTO animal_status (name)
VALUES ('dead');

-- In care
INSERT INTO animal_status (name)
VALUES ('in care');

INSERT INTO animal_status_translations (name_translation, language_id, animal_status_id)
VALUES ('chipped', 1, 1);

INSERT INTO animal_status_translations (name_translation, language_id, animal_status_id)
VALUES ('in distress', 1, 2);

INSERT INTO animal_status_translations (name_translation, language_id, animal_status_id)
VALUES ('dead', 1, 3);

INSERT INTO animal_status_translations (name_translation, language_id, animal_status_id)
VALUES ('in care', 1, 4);

INSERT INTO animal_status_translations (name_translation, language_id, animal_status_id)
VALUES ('чипирован', 1, 1);

INSERT INTO animal_status_translations (name_translation, language_id, animal_status_id)
VALUES ('в беде', 1, 2);

INSERT INTO animal_status_translations (name_translation, language_id, animal_status_id)
VALUES ('мертв', 1, 3);

INSERT INTO animal_status_translations (name_translation, language_id, animal_status_id)
VALUES ('под опекой', 1, 4);

INSERT INTO animal (birth_date, aggression_level, image_url, date_created, last_updated, type_id, status_id)
VALUES ('2010-01-02', 0, 'assets/images/products/placeholder.png', NOW(), NOW(), 1, 1);
INSERT INTO animal (birth_date, aggression_level, image_url, date_created, last_updated, type_id, status_id)
VALUES ('2012-01-02', 4, 'assets/images/products/placeholder.png', NOW(), NOW(), 1, 2);
INSERT INTO animal (birth_date, aggression_level, image_url, date_created, last_updated, type_id, status_id)
VALUES (NULL, 6, 'assets/images/products/placeholder.png', NOW(), NOW(), 1, 3);
INSERT INTO animal (birth_date, aggression_level, image_url, date_created, last_updated, type_id, status_id)
VALUES ('2012-03-11', 0, 'assets/images/products/placeholder.png', NOW(), NOW(), 1, 4);

INSERT INTO animal_translations (name_translation, description_translation, language_id, animal_id)
VALUES ('Боба', 'Большой пес черного чвета с коричневой грудью. Любит прыгать, адекватный',
2, 1);
INSERT INTO animal_translations (name_translation, description_translation, language_id, animal_id)
VALUES ('Гефест', 'Мелкий упырь, коренастый. Перелом лапы после наезда машины',
2, 2);
INSERT INTO animal_translations (name_translation, description_translation, language_id, animal_id)
VALUES ('Дана', 'Гаражная собака, реагирует на заход на территорию.',
2, 3);
INSERT INTO animal_translations (name_translation, description_translation, language_id, animal_id)
VALUES ('Шуша', 'Мелкая дворняжка. Временно на передержке.',
2, 4);

INSERT INTO animal_geo_coordinates (animal_id, geo_coordinates_id)
VALUES (1, 1);
INSERT INTO animal_geo_coordinates (animal_id, geo_coordinates_id)
VALUES (1, 2);
INSERT INTO animal_geo_coordinates (animal_id, geo_coordinates_id)
VALUES (1, 3);
INSERT INTO animal_geo_coordinates (animal_id, geo_coordinates_id)
VALUES (2, 4);
INSERT INTO animal_geo_coordinates (animal_id, geo_coordinates_id)
VALUES (2, 5);
INSERT INTO animal_geo_coordinates (animal_id, geo_coordinates_id)
VALUES (2, 6);

INSERT INTO animal_address (animal_id, address_id)
VALUES (4, 1);

---
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
