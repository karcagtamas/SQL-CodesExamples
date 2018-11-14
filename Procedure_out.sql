CREATE PROCEDURE sum1 (IN x1 int, IN x2 int, OUT x3 int)
  BEGIN
    SET x3 := x1 + x2; 
  END;

SET @vv = 1;
CALL sum1(2,5,@vv);
SELECT @vv;