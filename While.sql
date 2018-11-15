USE test;

  CREATE TABLE test.users (
  UID int(11) NOT NULL AUTO_INCREMENT,
  Nev varchar(50) NOT NULL,
  Pwd varchar(50) NOT NULL,
  Email varchar(50) NOT NULL,
  Age int(2) NOT NULL,
  PRIMARY KEY (UID)
)
ENGINE = INNODB
AUTO_INCREMENT = 1
CHARACTER SET utf8mb4
COLLATE utf8mb4_hungarian_ci;


CREATE PROCEDURE uploadTable(IN darab int)
  BEGIN
    DECLARE i int DEFAULT 1;
    DECLARE v_nev, v_pw, v_email varchar(50);
    DECLARE v_kor int(2);
    WHILE i <= darab DO
      SET v_nev = CONCAT('TesztNév_',i);
      SET v_pw = CONCAT('TesztPw_',i);
      SET v_email = CONCAT('t_',i, '@teszt.hu');
      SET v_kor = i;
      INSERT INTO users(Nev, Pwd, Email, Age)
        VALUES (v_nev, v_pw, v_email, v_kor);
      SET i = i + 1;
    END WHILE;
  END;

CALL uploadTable(10000);