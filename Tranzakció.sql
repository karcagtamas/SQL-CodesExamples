ALTER TABLE cikk ADD COLUMN keszlet int(11) UNSIGNED;

INSERT INTO cikk(cikknev, egys_ar, keszlet)
  VALUES ('HP Nyomtatató', 100, 2);

SELECT * FROM cikk;

DELETE FROM cikk WHERE cikkszam = 7;

INSERT INTO vevo(vnev, vcim)
  VALUES ('Kő Géza', '1234 Kis Pál utca 12.');

SELECT * FROM vevo;

CREATE FUNCTION vevokod(_string varchar(100))
  RETURNS int(11)
  BEGIN
   DECLARE kod int(11);
   SELECT vkod INTO kod FROM vevo
    WHERE vnev LIKE _string;
  RETURN kod;
  END;

CREATE FUNCTION cikkkod(_string varchar(100))
  RETURNS int(11)
  BEGIN
   DECLARE kod int(11);
   SELECT cikkszam INTO kod FROM cikk
    WHERE cikknev LIKE _string;
  RETURN kod;
  END;