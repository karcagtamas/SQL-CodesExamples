CREATE TABLE IF NOT EXISTS alkatreszek (
    alk_id VARCHAR(18) PRIMARY KEY,
    leiras VARCHAR(40),
    koltseg DECIMAL(10 , 2 ) NOT NULL CHECK(koltseg > 0),
    ar DECIMAL(10,2) NOT NULL
);

CREATE PROCEDURE check_alkatreszek (IN koltseg decimal(10, 2), IN ar decimal(10,2))
BEGIN
  IF koltseg < 0 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'A koltseg nem lehet negatív!';
  END IF;
  IF ar < 0 THEN
    SIGNAL SQLSTATE '45001'
    SET MESSAGE_TEXT = 'Az ar nem lehet negatív!';
  END IF;
  IF ar < koltseg THEN
    SIGNAL SQLSTATE '45002'
    SET MESSAGE_TEXT = 'Így nem éri meg előállítani!';
  END IF;
END;

CREATE TRIGGER alk_before_insert BEFORE INSERT ON alkatreszek
FOR EACH ROW
BEGIN
    CALL check_alkatreszek(new.koltseg,new.ar);
END;

CREATE TRIGGER alk_before_update BEFORE UPDATE ON alkatreszek
FOR EACH ROW
BEGIN
    CALL check_alkatreszek(new.koltseg,new.ar);
END;

INSERT INTO alkatreszek(alk_id, leiras,koltseg,ar)
VALUES('A-001','Cooler',100,120);
INSERT INTO alkatreszek(alk_id, leiras,koltseg,ar)
VALUES('A-002','Heater',-100,120);
INSERT INTO alkatreszek(alk_id, leiras,koltseg,ar)
VALUES('A-002','Heater',100,-120);
INSERT INTO alkatreszek(alk_id, leiras,koltseg,ar)
VALUES('A-003','wiper',120,100);

UPDATE alkatreszek SET ar = 10 WHERE alk_id = 'A-001';

DROP TABLE IF EXISTS alkatreszek;

CREATE TABLE IF NOT EXISTS alk_adatok (
  alk_id varchar(18) PRIMARY KEY,
  leiras varchar(40),
  koltseg decimal(10, 2) NOT NULL,
  ar decimal(10, 2) NOT NULL
);

CREATE VIEW alkatreszek
AS
SELECT
  alk_id,
  LEIRAS,
  koltseg,
  ar
FROM alk_adatok
WHERE koltseg > 0
AND ar > 0
AND ar >= koltseg
WITH CHECK OPTION;

INSERT INTO alkatreszek(alk_id, leiras,koltseg,ar)
VALUES('A-001','Cooler',100,120);
INSERT INTO alkatreszek(alk_id, leiras,koltseg,ar)
VALUES('A-002','Heater',-100,120);
INSERT INTO alkatreszek(alk_id, leiras,koltseg,ar)
VALUES('A-002','Heater',100,-120);
INSERT INTO alkatreszek(alk_id, leiras,koltseg,ar)
VALUES('A-003','wiper',120,100);
SELECT * FROM alkatreszek;
UPDATE alkatreszek SET ar = 10 WHERE alk_id = 'A-001';
