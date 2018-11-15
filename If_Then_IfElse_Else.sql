
USE test;

CREATE PROCEDURE Nap(IN d varchar(20))
  BEGIN
  IF DAYNAME(d) = 'Monday' THEN SELECT d, 'Hétfő';
    ELSEIF DAYNAME(d) = 'Tuesday' THEN SELECT d, 'Kedd';
    ELSEIF DAYNAME(d) = 'Wednesday' THEN SELECT d, 'Szerda';
    ELSEIF DAYNAME(d) = 'Thursday' THEN SELECT d, 'Csütörtök';
  ELSEIF DAYNAME(d) = 'Friday' THEN SELECT d, 'Péntek';
  ELSEIF DAYNAME(d) = 'Saturday' THEN SELECT d, 'Szombat';
  ELSE SELECT d, 'Vasárnap';
  END IF;
  END;

  CALL Nap('1999-07-26');