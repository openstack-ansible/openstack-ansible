DROP DATABASE IF EXISTS glance;
CREATE DATABASE glance;
GRANT ALL ON glance.* TO 'glance'@'%' IDENTIFIED BY '{{ glance_db_password }}';