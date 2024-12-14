-- CREATE TYPE Etablissement_Type AS OBJECT (
--     Code VARCHAR2(10),
--     Nom VARCHAR2(100),
--     Type VARCHAR2(50)
-- );

-- CREATE TYPE Chercheur_Type AS OBJECT (
--     Code VARCHAR2(10),
--     Nom VARCHAR2(50),
--     Prenom VARCHAR2(50),
--     Grade VARCHAR2(50),
--     Affiliation REF Etablissement_Type
-- );

-- CREATE TYPE Projet_Type AS OBJECT (
--     Code VARCHAR2(10),
--     Intitule VARCHAR2(100),
--     Duree NUMBER,
--     Domaine VARCHAR2(100),
--     Filiere VARCHAR2(50),
--     Etablissement_Financement REF Etablissement_Type,
--     Chef_Projet REF Chercheur_Type
-- );

-- CREATE TABLE Etablissements OF Etablissement_Type (
--     PRIMARY KEY (Code)
-- );

-- CREATE TABLE Chercheurs OF Chercheur_Type (
--     PRIMARY KEY (Code),
--     SCOPE FOR (Affiliation) IS Etablissements
-- );

-- CREATE TABLE Projets OF Projet_Type (
--     PRIMARY KEY (Code),
--     SCOPE FOR (Etablissement_Financement) IS Etablissements,
--     SCOPE FOR (Chef_Projet) IS Chercheurs
-- );

-- CREATE TYPE Chercheur_List AS TABLE OF REF Chercheur_Type;

-- CREATE OR REPLACE TYPE Projet_Type AS OBJECT (
--     Code VARCHAR2(10),
--     Intitule VARCHAR2(100),
--     Duree NUMBER,
--     Domaine VARCHAR2(100),
--     Filiere VARCHAR2(50),
--     Etablissement_Financement REF Etablissement_Type,
--     Chef_Projet REF Chercheur_Type,
--     Participants Chercheur_List
-- );

-- CREATE TABLE Projets OF Projet_Type (
--     PRIMARY KEY (Code),
--     SCOPE FOR (Etablissement_Financement) IS Etablissements,
--     SCOPE FOR (Chef_Projet) IS Chercheurs
-- )
-- NESTED TABLE Participants STORE AS Participants_Table;