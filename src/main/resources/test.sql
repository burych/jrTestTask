DROP DATABASE IF EXISTS test;
CREATE DATABASE test CHARACTER SET utf8 COLLATE utf8_general_ci;

CREATE TABLE test.User (
id INT(8) NOT NULL AUTO_INCREMENT
, name VARCHAR(25) NOT NULL
, age INT NOT NULL
, isAdmin BIT NOT NULL
, createdDate TIMESTAMP
, PRIMARY KEY (id)
);

USE test;
DELIMITER //
CREATE PROCEDURE fillusers()
BEGIN
  DECLARE v1 INT DEFAULT 1;

  WHILE v1 <= 16 DO
    INSERT INTO test.User (name, age, isAdmin) VALUES (CONCAT('Name', v1), 19, 0);
    SET v1 = v1 + 1;
  END WHILE;
END;
//
DELIMITER ;

CALL fillusers();