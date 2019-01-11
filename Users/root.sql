SELECT USER();

USE facebook;

CREATE VIEW MyComments AS
  SELECT komment, datum, felhasznalo FROM kommentek
  WHERE felhasznalo = USER();