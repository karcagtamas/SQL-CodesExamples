CREATE DATABASE facebook
CHARACTER SET utf8
  COLLATE utf8_hungarian_ci;

CREATE TABLE kommentek(
  id int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  felhasznlaloId int(11) UNSIGNED NOT NULL,
  komment text,
  felhasznalo varchar(50),
  datum date,
  PRIMARY KEY (id)
);

CREATE USER 'user1'@'localhost';
CREATE USER 'user2'@'localhost';
CREATE USER 'user3'@'localhost';