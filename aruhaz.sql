CREATE DATABASE aruhaz
CHARACTER SET utf8
COLLATE utf8_hungarian_ci;
USE aruhaz;
CREATE TABLE veznevek (veznev varchar(50));
CREATE TABLE kernevek (kernev varchar(50));
CREATE TABLE telepulesek (telepules varchar(50));
CREATE TABLE tnev1 (tnev1 varchar(50));
CREATE TABLE tnev2 (tnev2 varchar(50));

INSERT INTO veznevek VALUES
('Alpári'),('Bornemissza'),('Ceglédi'),('Dunai'),('Epres'),('Faragó'),('Gazember'),('Hajós'),('Igaz'),('Jeney'),('Kolompár'),('Lakatos'),('Mayer'),('Nagy'),('Olajos'),('Péter'),('Rakonczai'),('Sóbányász'),('Telekdy'),('Urambátyám'),('Véres'),('Ximpatikus'),('Yzaura'),('Zuglóckzky');

INSERT INTO kernevek VALUES
('Aladár'),('Beáta'),('Csongor'),('Dóri'),('Elemér'),('Fruzsina'),('Géza'),('Henrietta'),('Ibrahim'),('Júlia'),('Konrád'),('Lajos'),('Mária'),('Nóra'),('Ottó'),('Pamela'),('Róbert'),('Sára'),('Tamás'),('Ursula'),('Vazul'),('Xavér'),('Yvette'),('Zénó');

INSERT INTO telepulesek VALUES
('Agárd'),('Budapest'),('Cegléd'),('Dunavarsány'),('Egerszalók'),('Fót'),('Gíza'),('Honolulu'),('Isaszeg'),('Jászárokszállás'),('Kisújszállás'),('Lenti'),('Mosonmagyaróvár'),('Nagykovácsi'),('Orosháza'),('Pétervár'),('Róma'),('Seattle'),('Tel Aviv'),('Ulánbátor'),('Vecsés'),('Zebegény');

INSERT INTO tnev1 VALUES
('Agyag'),('Beton'),('Cián'),('Darabolt'),('Elemes'),('Fa'),('Gép'),('Hó'),('Izzó'),('Jég'),('Kavics'),('Lap'),('Maradék'),('Nyeles'),('Olcsó'),('Porcelán'),('Remek'),('Soros'),('Tele'),('Ugató'),('Víz'),('Zizi');

INSERT INTO tnev2 VALUES
('alma'),('bolha'),('cica'),('daru'),('ér'),('fúró'),('galamb'),('homár'),('iron'),('jel'),('kocka'),('lepel'),('mosó'),('narancs'),('orsó'),('pohár'),('relé'),('szék'),('tévé'),('undor'),('varrás'),('zongora');

USE aruhaz;
CREATE TABLE termek(
  tId int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  tnev varchar(255),
  tdatum timestamp DEFAULT CURRENT_TIMESTAMP,
  keszlet int(11) DEFAULT 0,
  egysAr decimal DEFAULT 0
  );

INSERT INTO termek (tnev)
  (SELECT CONCAT(tnev1, tnev2) FROM tnev1 CROSS JOIN tnev2);

UPDATE termek SET keszlet = FLOOR(RAND() * 1000), egysAr = RAND() * 100000 WHERE true;

CREATE TABLE vevo(
  vId int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  vnev varchar(255) NOT NULL,
  knev varchar(255) NOT NULL,
  telepules varchar(100) NOT NULL,
  szuldatum datetime,
  isValid bool,
  rdatum datetime DEFAULT CURRENT_TIMESTAMP
  );

INSERT INTO vevo (vnev, knev, telepules)
  SELECT veznev, kernev, telepules FROM veznevek
  CROSS JOIN kernevek
  CROSS JOIN telepulesek;

CREATE TABLE shopping(
  sId int(11) NOT NULL AUTO_INCREMENT,
  vId int(11) NOT NULL,
  tId int(11) NOT NULL,
  datum datetime DEFAULT CURRENT_TIMESTAMP,
  darab int(11),
  ar decimal NOT NULL,
  fizetve tinyint DEFAULT 0,
  PRIMARY KEY(sId),
  CONSTRAINT fk_vevo FOREIGN KEY (vId)
  REFERENCES vevo(vId),
  CONSTRAINT fk_termek FOREIGN KEY (tId)
  REFERENCES termek(tId)
);

CREATE OR REPLACE PROCEDURE shoppinggolo(vasarloSzam int(11)) 
  BEGIN
  DECLARE db int(11) DEFAULT FLOOR(RAND() * 40) + 1;
  DECLARE termek int(11) DEFAULT  FLOOR(RAND() * 484) + 1;
  DECLARE ar decimal;

  WHILE vasarloSzam > 0 DO
    SET termek = FLOOR(RAND() * 484) + 1;
    SET db =  FLOOR(RAND() * 40) + 1;
    SELECT termek.egysAr * db INTO ar FROM termek
    WHERE tId = termek;
    INSERT INTO shopping (vId, tId, darab, ar)
    VALUES (FLOOR(RAND() * 12672) + 1, termek, db, ar);
    SET vasarloSzam = vasarloSzam - 1;
  END WHILE;
  END;

CALL shoppinggolo(10);