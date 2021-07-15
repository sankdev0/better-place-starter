# better-place-project starter db-script

-- -----------------------------------------------------
-- Schema betterplace
-- -----------------------------------------------------
# Schema and database are synonyms
DROP SCHEMA IF EXISTS `betterplace`;
CREATE SCHEMA `betterplace`;

ALTER SCHEMA `betterplace`
  DEFAULT CHARACTER SET `utf8`
  DEFAULT COLLATE `utf8_general_ci`;

CREATE USER 'betterplace'@'localhost' IDENTIFIED BY 'betterplace';

GRANT ALL PRIVILEGES ON `betterplace`.* TO 'betterplace'@'localhost';

#
# Starting with MySQL 8.0.4, the MySQL team changed the 
# default authentication plugin for MySQL server 
# from mysql_native_password to caching_sha2_password.
#
# The command below will make the appropriate updates for your user account.
#
# See the MySQL Reference Manual for details: 
# https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html
#
ALTER USER 'betterplace'@'localhost' IDENTIFIED WITH mysql_native_password BY 'betterplace';