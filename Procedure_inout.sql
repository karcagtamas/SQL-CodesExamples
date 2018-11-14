CREATE PROCEDURE hatvany (INOUT a int)
  BEGIN
   SET a:= a*a;
  END;

SET @b = 4;
CALL hatvany(@b);
SELECT @b;
CALL hatvany(@b);
SELECT @b;