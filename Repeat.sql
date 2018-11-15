USE test;

CREATE PROCEDURE Random()
  BEGIN
  DECLARE db int DEFAULT 0;
    REPEAT
      SELECT FLOOR(RAND() * 10) AS Véletlen;
      SET db = db + 1;
    UNTIL db >= 5 END REPEAT;
  END;

CALL Random();