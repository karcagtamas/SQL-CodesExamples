DROP DATABASE IF EXISTS rendelesek;

CREATE DATABASE rendelesek
  CHARACTER SET utf8
  COLLATE utf8_hungarian_ci;

USE rendelesek;

CREATE TABLE rendeles_fej(
  rendszam int(11) NOT NULL AUTO_INCREMENT,
  vkod int(11) NOT NULL,
  kelt datetime NOT NULL,
  hatarido date NOT NULL,
  osszertek decimal(10,2) NOT NULL,
  PRIMARY KEY (rendszam)
);

CREATE TABLE cikk (
  cikkszam int(11) NOT NULL AUTO_INCREMENT,
  cikknev varchar(100) NOT NULL,
  egysegar decimal(10, 2) NOT NULL,
  keszlet int(11) UNSIGNED NOT NULL,
  PRIMARY KEY (cikkszam)
);

CREATE TABLE rendeles_tetel (
  rendszam int(11) NOT NULL,
  cikkszam int(11) NOT NULL,
  rendmenny int(11) NOT NULL,
  PRIMARY KEY (rendszam, cikkszam)
);

CREATE TABLE vevo (
  vkod int(11) NOT NULL AUTO_INCREMENT,
  vnev varchar(100) NOT NULL,
  vcim varchar(100) NOT NULL,
  PRIMARY KEY (vkod)
);

INSERT INTO cikk(cikknev, egysegar, keszlet)
  VALUES ('Nyomtató', 100.10, 10), ('Monitor', 100000, 3);

INSERT INTO vevo(vnev, vcim)
  VALUES ('Kő Géza', 'Itt'), ('Teszt Elek', 'Máshol'), ('Kő Géza', 'Valahol');

CREATE PROCEDURE nev_lekerdezes(_name varchar(100))
  BEGIN
    SELECT * FROM vevo
      WHERE vnev LIKE _name;
  END;

CALL nev_lekerdezes('Ko Geza');

INSERT INTO rendeles_fej(vkod, kelt, hatarido, osszertek)
  VALUES (4, NOW(), DATE_ADD(CURDATE(), INTERVAL 14 DAY), 0);

CREATE FUNCTION termekkod(_name varchar(100))
  RETURNS int(11)
  BEGIN
    DECLARE id int(11) DEFAULT 0;
    SELECT cikkszam INTO id FROM cikk WHERE cikknev LIKE _name;
    RETURN id;
  END;

INSERT INTO rendeles_tetel(rendszam, cikkszam, rendmenny)
  VALUES (LAST_INSERT_ID(), termekkod("Nyomtató"), 4);

UPDATE rendeles_tetel SET rendmenny = 1 WHERE rendszam = LAST_INSERT_ID() AND cikkszam = termekkod("Nyomtató");

UPDATE cikk SET keszlet = keszlet - 3 WHERE cikkszam = termekkod("Nyomtató");

DELETE FROM rendeles_tetel WHERE rendszam = LAST_INSERT_ID() AND cikkszam = termekkod("Monitor");


CREATE TRIGGER update_keszlet_insert
  AFTER INSERT ON rendeles_tetel
  FOR EACH ROW
  BEGIN
      UPDATE cikk SET keszlet = keszlet - NEW.rendmenny WHERE cikkszam = NEW.cikkszam;
  END;

CREATE TRIGGER update_keszlet_update
  AFTER UPDATE ON rendeles_tetel
  FOR EACH ROW
  BEGIN
      UPDATE cikk SET keszlet = keszlet + (OLD.rendmenny - NEW.rendmenny) WHERE cikkszam = NEW.cikkszam;
  END;

CREATE TRIGGER update_keszlet_delete
  AFTER DELETE ON rendeles_tetel
  FOR EACH ROW
  BEGIN
      UPDATE cikk SET keszlet = keszlet + OLD.rendmenny WHERE cikkszam = OLD.cikkszam;
  END;

START TRANSACTION;

INSERT INTO rendeles_fej(vkod, kelt, hatarido, osszertek)
  VALUES (4, NOW(), DATE_ADD(CURDATE(), INTERVAL 14 DAY), 0);

INSERT INTO rendeles_tetel(rendszam, cikkszam, rendmenny)
  VALUES (LAST_INSERT_ID(), termekkod("Nyomtató"), 4);

COMMIT;
ROLLBACK;



