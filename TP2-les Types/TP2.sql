-- know your user
SELECT USER FROM dual;
-- 

-- A. Creation de types et tables
-- 1
CREATE OR REPLACE TYPE adress_type AS OBJECT (
    numeroRue VARCHAR2(50),
    NomRue VARCHAR2(50),
    codePostal CHAR(5),
    ville VARCHAR2(20)
) NOT FINAL;
-- 

-- 2
CREATE OR REPLACE TYPE adresseWithEmail_type UNDER adress_type (
    adresseEmail VARCHAR2(50)
) NOT FINAL;
-- 

-- 3
CREATE OR REPLACE TYPE personne_type AS OBJECT (
    numero VARCHAR2(50),
    nom VARCHAR2(50),
    prenom VARCHAR2(50),
    adresse adress_type,
    age INTEGER
) NOT FINAL;
-- 

-- 4
CREATE OR REPLACE TYPE etudiant_type UNDER personne_type (
    numCarteEtudiant VARCHAR2(50),
    anneeInscription INTEGER

);
-- 

-- 5
CREATE OR REPLACE TYPE enseignant_type UNDER personne_type (
    grade VARCHAR2(50)

);
-- 

-- 6: creatioin des tables
CREATE TABLE Personnes OF personne_type (
    CONSTRAINT pk PRIMARY KEY (numero),
    CONSTRAINT age_check CHECK (age BETWEEN 17 AND 60)
);
-- 

-- for deleting
DROP TABLE Personnes CASCADE CONSTRAINTS;
-- 

-- B. Insertions

-- for checking
SELECT * FROM Personnes_age;
-- 

-- 6: creatioin des tables
CREATE TABLE Personnes_age OF personne_type;
-- 

-- Insertion using VALUE
INSERT INTO Personnes_age
SELECT VALUE(P)
FROM Personnes P
WHERE P.age > 40;
-- 

-- 1
INSERT INTO Personnes VALUES (
    personne_type(
        200, 
        'KADI', 
        'Yasmine', 
        adress_type(
            '5', 
            'rue BENBOUALI Hassiba', 
            06000, 
            'Béjaia'
            ), 
        30
    )
);
-- 

-- 2
INSERT INTO ALI.PERSONNES VALUES (
    enseignant_type(
        'ENS-2010',  -- numero
        'ZAID',      -- nom
        'Samir',     -- prenom
        adresseWithEmail_type(
            12, 
            'rue DIDOUCHE Mourad', 
            '19000', 
            'Sétif', 
            'kzaidi@estin.dz'
        ), 
        42,  -- age
        'Professeur des universités' -- grade
    )
);
-- 

-- 3
INSERT INTO Personnes VALUES (
    etudiant_type(
        'MI-2017-100', 
        'SALMY', 
        'Islam', 
        adresseWithEmail_type(
            '10', 
            'boulevard KRIM Belkacem', 
            '16000', 
            'Alger', 
            'nselmi@estin.dz'
        ), 
        19, 
        'MI-100', 
        2018
    )
);
-- 


