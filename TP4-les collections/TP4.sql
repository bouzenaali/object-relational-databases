-- Exercice 1

CREATE TYPE Marque AS OBJECT (  
Nom VARCHAR2(10),  
Fournisseur VARCHAR2(10) 
); -- creating a normal type

CREATE TABLE EnsMarque OF Marque; 
  
CREATE TYPE Voile AS OBJECT (  
Numero NUMBER(6),  
Surface NUMBER(3),  
MarqueV REF Marque
); -- 1. creating a normal type

CREATE TYPE LesVoiles AS TABLE OF Voile ; -- 2. creating the element of the collection

CREATE TYPE Moteur AS OBJECT (  
Numero NUMBER(6),  
Puissance NUMBER(3),  
MarqueM REF Marque 
);

CREATE TYPE Bateau AS OBJECT (  
Numero NUMBER(6),  
MoteurB Moteur,  
Voiles LesVoiles,  
MarqueB REF Marque 
);

CREATE TABLE EnsBateau OF Bateau(
    CONSTRAINT pk2 PRIMARY KEY (Numero),
    CONSTRAINT un1 UNIQUE (moteurB.Numero),
    CONSTRAINT ref1 MarqueB REFERENCES EnsMarque,
    CONSTRAINT cn1 CHECK (MarqueB IS NOT NULL)
) NESTED TABLE Voiles STORE AS tabvoiles(( CONSTRAINT pk3 PRIMARY KEY (numero) )); -- 3. creating a nested table

-- Insertion
INSERT INTO EnsMarque VALUES (Marque ('Bobato','Omonbato'));
INSERT INTO EnsMarque VALUES (Marque ('jolivoile', 'voilou'));
INSERT INTO EnsBateau VALUES (
        115643, -- Numero
        NULL, -- MoteurB
        LesVoiles(
            voile(333412, 20, (SELECT REF(m) FROM EnsMarque m WHERE m.Nom='Joilivoile')) -- Nested table
                ), 
        (SELECT REF(m) FROM EnsMarque m WHERE M.Nom='Bobato') -- REF
                            );

-- tests
SELECT * FROM EnsMarque;
SELECT * FROM EnsBateau;
-- 

-- 2. Mise à jour
-- Ajouter un moteur de 75 CV, de marque ‘Bobato’ et de numéro 555466 au bateau precedent
UPDATE EnsBateau 
SET MoteurB = Moteur(555466, 75, (SELECT REF(m) FROM EnsMarque m WHERE m.Nom='Bobato')) 
WHERE Numero=115643;

-- 3. Reqûete
-- a. Les numéros des bateaux fournis par la société ‘Omonbato’ dont le moteur a une puissance supérieure à 50 CV.
SELECT B.Numero
FROM EnsBateau B
WHERE (B.MoteurB.Puissance > 50) AND (B.MarqueB.Fournisseur = 'Omonbato');

-- b. Les numéros des bateaux ayant plus de 4 voiles.
SELECT B.Numero
FROM EnsBateau B
WHERE (SELECT COUNT(*) FROM TABLE(B.Voiles)) > 4;

-- c. Pour chaque marque de bateau, donnez le nom de la marque et la surface moyenne des voiles pour un bateau de cette marque.
SELECT B.MarqueB.Nom AS Marque, AVG(V.Surface) AS SurfaceMoyenne
FROM EnsBateau B, TABLE(B.Voiles) V
GROUP BY B.MarqueB.Nom;