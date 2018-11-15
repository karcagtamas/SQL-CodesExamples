USE teszt;

CREATE PROCEDURE Nap(IN d varchar(20))
  BEGIN
  CASE DAYNAME(d)
    WHEN 'Monday' THEN SELECT d, 'Hétfő';
    WHEN 'Tuesday' THEN SELECT d, 'Kedd';
    WHEN 'Wednesday' THEN SELECT d, 'Szerda';
    WHEN 'Thursday' THEN SELECT d, 'Csütörtök';
    WHEN 'Friday' THEN SELECT d, 'Péntek';
    WHEN 'Saturday' THEN SELECT d, 'Szombat';
    WHEN 'Sunday' THEN SELECT d, 'Vasárnap';
    END CASE;
  END;

  CALL Nap('1999-07-26');