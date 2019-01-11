SELECT USER();

USE facebook;

INSERT mycomments(komment, datum, felhasznalo)
  VALUES ('Szia', CURDATE(), USER());

SELECT * FROM mycomments;