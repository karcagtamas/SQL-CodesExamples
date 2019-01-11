SELECT USER();

USE facebook;

INSERT mycomments(komment, datum, felhasznalo)
  VALUES ('Hello', CURDATE(), USER());

SELECT * FROM mycomments;