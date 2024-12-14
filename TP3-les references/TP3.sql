-- Creating custom types

-- Define the type for `ecole_type`
CREATE TYPE ecole_type AS OBJECT (
    nom_ecole VARCHAR2(20)
);

-- Define the type for `specialites_type`
CREATE TYPE specialites_type AS OBJECT (
    nom_specialite VARCHAR2(50),
    ref_ecole REF ecole_type

);

-- Define the type for `etudiant_type`
CREATE TYPE etudiant_type AS OBJECT (
    matricule NUMBER(4),
    nom VARCHAR2(20),
    prenom VARCHAR2(20),
    ref_specialite REF specialites_type
);

-- Creating tables
CREATE TABLE Ecole OF Ecole_Type (
    CONSTRAINT pk_ecole PRIMARY KEY (nom_ecole)
);

CREATE TABLE Specialite OF specialites_type (
    CONSTRAINT pk_specialite PRIMARY KEY (nom_specialite),
    CONSTRAINT ref_ref_ecole ref_ecole REFERENCES Ecole
);

CREATE TABLE Etudiant OF etudiant_type (
    CONSTRAINT pk_etudiant PRIMARY KEY (matricule),
    CONSTRAINT ref_ref_specialite ref_specialite REFERENCES Specialite
);

-- 2. Inserting data
-- Insert schools
INSERT INTO Ecole VALUES ('ESTIN');
INSERT INTO Ecole VALUES ('ESI ALG');
INSERT INTO Ecole VALUES ('ESI SBA');

-- Insert specialties
INSERT INTO Specialite 
VALUES ('IA et DS', (SELECT REF(e) FROM Ecole e WHERE e.nom_ecole = 'ESTIN'));

INSERT INTO Specialite 
VALUES ('Cyber sécurité', (SELECT REF(e) FROM Ecole e WHERE e.nom_ecole = 'ESTIN'));

INSERT INTO Specialite 
VALUES ('System informatique et logiciels', (SELECT REF(e) FROM Ecole e WHERE e.nom_ecole = 'ESI ALG'));

INSERT INTO Specialite 
VALUES ('System intelligent et données', (SELECT REF(e) FROM Ecole e WHERE e.nom_ecole = 'ESI ALG'));

INSERT INTO Specialite 
VALUES ('Systèmes information et web', (SELECT REF(e) FROM Ecole e WHERE e.nom_ecole = 'ESI SBA'));

-- Test
SELECT * FROM Ecole;
SELECT * FROM Specialite;

-- Insert students
INSERT INTO Etudiants 
VALUES (0110, 'Mohamed', 'Benali', (SELECT REF(s) FROM Specialite s WHERE s.nom_specialite = 'IA et DS'));

INSERT INTO Etudiants 
VALUES (0111, 'Fatima', 'Khelif', (SELECT REF(s) FROM Specialite s WHERE s.nom_specialite = 'System intelligent et données'));



-- 3. Queries using object references
-- a. Display all school references
SELECT REF(e) FROM Ecole e;

-- b. Display OIDs of all schools
SELECT DEREF(s.ref_ecole) FROM Specialite s;

-- c. Display the school referenced by Cyber sécurité specialty
SELECT DEREF(s.ref_ecole).NomEcole 
FROM Specialite s 
WHERE s.NomSpecialite = 'Cyber sécurité';

-- d. Display all specialties of ESI ALG
SELECT s.NomSpecialite 
FROM Specialite s 
WHERE DEREF(s.ref_ecole).NomEcole = 'ESI ALG';

-- e. Count students per school
SELECT DEREF(DEREF(e.ref_specialite).ref_ecole).NomEcole, COUNT(*)
FROM Etudiants ecole_type
GROUP BY DEREF(DEREF(e.ref_specialite).ref_ecole).NomEcole;

-- 4. Update student 0115's specialty
UPDATE Etudiants et
SET et.ref_specialite = (
    SELECT REF(s) 
    FROM Specialite s 
    WHERE s.NomSpecialite = 'Systèmes information et web'
)
WHERE et.Matricule = '0115';