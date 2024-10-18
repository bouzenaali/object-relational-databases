-- Table Usine
CREATE TABLE Usine (
    NU NUMBER PRIMARY KEY,
    NomU VARCHAR2(100) NOT NULL,
    Ville VARCHAR2(100) NOT NULL
);
-- Insertion
INSERT INTO Usine (NU, NomU, Ville) VALUES (1, 'Citroen', 'Paris');
INSERT INTO Usine (NU, NomU, Ville) VALUES (2, 'Peugeot', 'Sochaux');
INSERT INTO Usine (NU, NomU, Ville) VALUES (3, 'Citroen', 'Sochaux');
INSERT INTO Usine (NU, NomU, Ville) VALUES (4, 'Renault', 'Paris');
INSERT INTO Usine (NU, NomU, Ville) VALUES (5, 'Toyota', 'Lyon');


-- Table Produit
CREATE TABLE Produit (
    NP NUMBER PRIMARY KEY,
    NomP VARCHAR2(100) NOT NULL,
    Couleur VARCHAR2(50),
    Poids NUMBER CHECK (Poids > 0)
);
-- Insertion
INSERT INTO Produit (NP, NomP, Couleur, Poids) VALUES (1, 'Plaquette', 'Noir', 0.257);
INSERT INTO Produit (NP, NomP, Couleur, Poids) VALUES (2, 'Siège', 'Rouge', 15.230);
INSERT INTO Produit (NP, NomP, Couleur, Poids) VALUES (3, 'Siège', 'Vert', 15.230);
INSERT INTO Produit (NP, NomP, Couleur, Poids) VALUES (4, 'Pare-brise', NULL, 11.900);
INSERT INTO Produit (NP, NomP, Couleur, Poids) VALUES (5, 'Rétroviseur', 'Vert', 1.020);


-- Table Fournisseur
CREATE TABLE Fournisseur (
    NF NUMBER PRIMARY KEY,
    NomF VARCHAR2(100) NOT NULL,
    Statut VARCHAR2(100) NOT NULL,
    Ville VARCHAR2(100) NOT NULL,
    Email VARCHAR2(100) UNIQUE CHECK (Email LIKE '%@%.%')
);
-- Insertion
INSERT INTO Fournisseur (NF, NomF, Statut, Ville, Email) VALUES (1, 'Monroe', 'Producteur', 'Lyon', 'monroe@gmail.com');
INSERT INTO Fournisseur (NF, NomF, Statut, Ville, Email) VALUES (2, 'Au bon siège', 'Sous-traitant', 'Limoges', 'au_bon_siege@gmail.com');
INSERT INTO Fournisseur (NF, NomF, Statut, Ville, Email) VALUES (3, 'Saint Gobain', 'Producteur', 'Paris', 'sait_gobain@gmail.com');

-- Table Livraison
CREATE TABLE Livraison (
    NP NUMBER, 
    NU NUMBER,
    NF NUMBER,
    Quantite NUMBER CHECK (Quantite > 0),
    PRIMARY KEY (NP, NU, NF),
    FOREIGN KEY (NP) REFERENCES Produit(NP),
    FOREIGN KEY (NU) REFERENCES Usine(NU),
    FOREIGN KEY (NF) REFERENCES Fournisseur(NF)
);
-- Insertion
INSERT INTO Livraison (NP, NU, NF, Quantite) VALUES (3, 1, 2, 60);
INSERT INTO Livraison (NP, NU, NF, Quantite) VALUES (1, 2, 3, 2500);
INSERT INTO Livraison (NP, NU, NF, Quantite) VALUES (1, 3, 3, 3000);
INSERT INTO Livraison (NP, NU, NF, Quantite) VALUES (2, 2, 1, 120);
INSERT INTO Livraison (NP, NU, NF, Quantite) VALUES (3, 1, 1, 49);
INSERT INTO Livraison (NP, NU, NF, Quantite) VALUES (3, 2, 1, 45);
INSERT INTO Livraison (NP, NU, NF, Quantite) VALUES (3, 3, 1, 78);
INSERT INTO Livraison (NP, NU, NF, Quantite) VALUES (2, 4, 2, 52);
INSERT INTO Livraison (NP, NU, NF, Quantite) VALUES (2, 1, 1, 250);


-- Queries
-- 1
SELECT NU, Nom, Ville FROM Usine;

-- 2
SELECT NU, Nom FROM Usine WHERE Ville = 'Sochaux';

-- 3
SELECT NF FROM Livraison WHERE NU = 1 AND NP = 3;

-- 4
SELECT NP, Nom FROM Produit WHERE Couleur IS NULL;

-- 5
SELECT DISTINCT Nom FROM Usine ORDER BY Nom ASC;

-- 6
SELECT NU FROM Usine WHERE Nom LIKE 'C%';