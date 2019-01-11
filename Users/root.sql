SELECT USER();

USE facebook;

CREATE VIEW MyComments AS
  SELECT komment, datum, felhasznalo FROM kommentek
  WHERE felhasznalo = USER();

CREATE PROCEDURE InsertMyComments(_message text)
  BEGIN
    INSERT mycomments(komment, datum, felhasznalo)
    VALUES (_message, CURDATE(), USER());
  END;