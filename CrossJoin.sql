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