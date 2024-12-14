DROP TABLE EMP_IND;

CREATE TABLE EMP_IND (
    EMPNO NUMBER CONSTRAINT EMP_IND_PK PRIMARY KEY,
    ENAME VARCHAR(100) UNIQUE,
    NICKNAME VARCHAR(100),
    email VARCHAR(100)
);

INSERT INTO EMP_IND (EMPNO, ENAME, NICKNAME, email) VALUES (1, 'Ahmed Samer', 'Ahmed.Samer','Ahmed.Samer@gmail.com');
INSERT INTO EMP_IND (EMPNO, ENAME, NICKNAME, email) VALUES (2, 'Rami Nader', 'Rami.Nader', 'Rami.Nader@hotmail.com');
INSERT INTO EMP_IND (EMPNO, ENAME, NICKNAME, email) VALUES (3, 'Ali Samir', 'Ali.Samir', 'Ali.Samir@gmail.com');
COMMIT;
INSERT INTO EMP_IND (EMPNO, ENAME, NICKNAME, email) VALUES (4, 'djafar', 'djafar.djafar','Ahmed.Samer@gmail.com');
-- display the indexes
SELECT * FROM USER_INDEXES 
WHERE TABLE_NAME = 'EMP_IND';

-- display the columns of the indexes
SELECT * FROM USER_IND_COLUMNS 
WHERE TABLE_NAME = 'EMP_IND';

SELECT * FROM EMP_IND
WHERE EMPNO = 1; -- This will use the index


SELECT * FROM EMP_IND
WHERE ENAME = 'Ahmed Samer'; -- This will use the index

SELECT * FROM EMP_IND
WHERE NICKNAME = 'Ahmed.Samer'; -- This will use the index

-- create an index on the nickname column
CREATE INDEX EMP_IND_NICKNAME ON EMP_IND (NICKNAME);
CREATE INDEX EMP_IND_EMAIL ON EMP_IND (email);

-- create unique indexes
CREATE UNIQUE INDEX EMP_IND_EMAIL_UNIQUE ON EMP_IND (email);


-- NOTES:
/*
system creat index on primary key and unique columns by default
*/