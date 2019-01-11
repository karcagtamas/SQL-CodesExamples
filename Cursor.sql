CREATE FUNCTION LGYS () RETURNS int
BEGIN
  DECLARE vegzett int DEFAULT 0;
  DECLARE akt_pont tinyint;
  DECLARE akt_sor_hossz int DEFAULT 0;
  DECLARE max_sor_hossz int DEFAULT 0;
  DECLARE cur CURSOR FOR  SELECT pont FROM lakers;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET vegzett = 1;

  OPEN cur;
start_loop:
  LOOP
    FETCH cur INTO akt_pont;
    SET akt_sor_hossz = 0;

    WHILE vegzett = 0 AND akt_pont = 3 DO
      SET akt_sor_hossz = akt_sor_hossz + 1;
      FETCH cur INTO akt_pont;
    END WHILE;

    IF akt_sor_hossz > max_sor_hossz THEN
      SET max_sor_hossz = akt_sor_hossz;
    END IF;

    IF vegzett = 1 THEN
      LEAVE start_loop;
    END IF;
  END LOOP;
  CLOSE cur;

  RETURN max_sor_hossz;
END;

SELECT LGYS();
