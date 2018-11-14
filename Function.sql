USE `13a_filmszineszek`;

CREATE FUNCTION times(a int) RETURNS integer
  BEGIN
   RETURN a * a;
  END;

SELECT times(2);