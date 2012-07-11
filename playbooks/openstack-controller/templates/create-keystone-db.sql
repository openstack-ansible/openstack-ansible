DROP DATABASE IF EXISTS keystone;
CREATE DATABASE keystone;
GRANT ALL ON keystone.* TO 'keystone'@'%' IDENTIFIED BY '{{ keystone_db_password }}';