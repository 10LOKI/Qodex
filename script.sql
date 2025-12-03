-- Comment j'ai crée la DATABASE 
CREATE DATABASE Qodex;

-- Comment j'ai crée le Tableau 
CREATE TABLE Utilisateurs (
	idUtilisateur INT ,
    nom VARCHAR(255),
	email VARCHAR(255),
	motDePasse VARCHAR(255),
	role VARCHAR(255),
	PRIMARY KEY (idUtilisateur)
);

-- Creation du tableau Categories
CREATE TABLE Categories(
	idCategorie INT,
	nomCategorie VARCHAR(255),
	PRIMARY KEY (idCategorie)
);

-- Creation du tableau Quiz avec des FK's
CREATE TABLE Quiz(
	idQuiz INT,
	titreQuiz VARCHAR(255),
	description VARCHAR(255),
	idCategorie INT,
	idEnseignant INT,
	dureeMinutes INT,
	PRIMARY KEY (idQuiz),
	FOREIGN KEY (idCategorie) REFERENCES Categories(idCategorie)
);

-- Creation Table Questions
CREATE TABLE Questions (
	idQuestion INT ,
    texteQuestion VARCHAR(255) ,
    reponseCorrecte VARCHAR(255),
	points INT ,
    idQuiz INT ,
    PRIMARY KEY (idQuestion),
    FOREIGN KEY (idQuiz) REFERENCES Quiz(idQuiz)
);

-- Creation du table Resultats
CREATE TABLE Resultats (
	idResultat INT ,
	score INT ,
    datePassage INT ,
    idEtudiant INT ,
    idQuiz INT , 
    PRIMARY KEY (idResultat),
    FOREIGN KEY (idEtudiant) REFERENCES Utilisateurs(idUtilisateur),
    FOREIGN KEY (idQuiz) REFERENCES Quiz(idQuiz)
);

-- Rendre le PK auto incrementé 
ALTER TABLE utilisateurs
MODIFY idUtilisateur INT AUTO_INCREMENT;

-- Ajouter la contrainte Unique pour email
ALTER TABLE Utilisateurs
ADD CONSTRAINT constEmail UNIQUE (email);

-- Assurer que les valeurs ne sont pas null ou vides 
ALTER TABLE Utilisateurs
MODIFY nom VARCHAR(255) NOT NULL;

ALTER TABLE Utilisateurs
MODIFY email VARCHAR(255) NOT NULL;

ALTER TABLE Utilisateurs
MODIFY motDePasse VARCHAR(255) NOT NULL;

ALTER TABLE Utilisateurs
MODIFY role VARCHAR(255) NOT NULL;

-- Ajouter la contraintte check pour verifier et accepter juste dux roles
ALTER TABLE Utilisateurs
ADD CONSTRAINT checkRole CHECK (role IN ('enseignant' , 'etudiant'));

-- tout ca pour les autres tables 
ALTER TABLE Categories
MODIFY idCategorie INT AUTO_INCREMENT;

ALTER TABLE Categories
MODIFY nomCategorie VARCHAR(255) UNIQUE NOT NULL;

ALTER TABLE Quiz
MODIFY idQuiz INT AUTO_INCREMENT;
ALTER TABLE Quiz
MODIFY titreQuiz VARCHAR(255) NOT NULL;
ALTER TABLE Quiz
MODIFY idCategorie INT NOT NULL;
ALTER TABLE Quiz
MODIFY idEnseignant INT NOT NULL;

--ajouter une FK 
ALTER TABLE Quiz
ADD CONSTRAINT FK_Quiz_Enseignant
FOREIGN KEY (idEnseignant) REFERENCES Utilisateurs(idUtilisateur);

ALTER TABLE Questions
MODIFY idQuestion INT AUTO_INCREMENT;

ALTER TABLE Questions
MODIFY texteQuestion VARCHAR(255) NOT NULL;

ALTER TABLE Questions
MODIFY reponseCorrecte VARCHAR(255) NOT NULL;

ALTER TABLE Questions
MODIFY points INT NOT NULL;

ALTER TABLE Questions
MODIFY idQuiz INT NOT NULL;

ALTER TABLE Resultats
MODIFY idResultat INT AUTO_INCREMENT;

ALTER TABLE Resultats
MODIFY datePassage DATETIME NOT NULL;

ALTER TABLE Resultats
MODIFY score INT NOT NULL;

ALTER TABLE Resultats
MODIFY idEtudiant INT NOT NULL;

ALTER TABLE Resultats
MODIFY idQuiz INT NOT NULL;

ALTER TABLE Resultats
ADD CONSTRAINT UC_Etudiant_Quiz UNIQUE (idEtudiant, idQuiz);

-- Remplissage des tableaux :
INSERT INTO Utilisateurs (nom,email,motDePasse,role) VALUES
('Yahya Jabrane', 'yahya.jabrane@wac.com', 'mdpWac1', 'etudiant'),
('Aymane El Hassouni', 'aymane.hassouni@wac.com', 'mdpWac2', 'etudiant'),
('Arsène Zola', 'arsene.zola@wac.com', 'mdpWac3', 'etudiant'),
('Badi Aouk', 'badi.aouk@wac.com', 'mdpWac4', 'etudiant'),
('Montasser Lahtimi', 'montasser.lahtimi@wac.com', 'mdpWac5', 'etudiant');

INSERT INTO Categories (nomCategorie) VALUES
('Programmation'),
('Bases de Données'),
('Réseaux'),
('Sécurité Informatique');

INSERT INTO Quiz (titreQuiz, description, idCategorie, idEnseignant, dureeMinutes) VALUES
('Introduction au SQL', 'Quiz de base sur le langage SQL (SELECT, INSERT, UPDATE).', 2, 1, 30),
('Fondamentaux de Python', 'Questions sur la syntaxe et les structures de contrôle de Python.', 1, 2, 45),
('Les couches du modèle OSI', 'Évaluation des connaissances sur les 7 couches du modèle OSI.', 3, 1, 20);

INSERT INTO Questions (texteQuestion, reponseCorrecte, points, idQuiz) VALUES
-- Questions pour "Introduction au SQL" (idQuiz = 1)
('Quelle clause utilise-t-on pour filtrer les lignes ?', 'WHERE', 10, 1),
('Quel mot-clé est utilisé pour insérer de nouvelles données ?', 'INSERT INTO', 10, 1),
-- Questions pour "Fondamentaux de Python" (idQuiz = 2)
('Quel est l\'opérateur de modulo en Python ?', '%', 15, 2),
('Comment écrit-on un commentaire sur une seule ligne en Python ?', '# Ceci est un commentaire', 15, 2),
-- Questions pour "Les couches du modèle OSI" (idQuiz = 3)
('Quelle couche est responsable de l\'adressage logique (IP) ?', 'Couche Réseau', 5, 3);


-- Requête 1 : Ajouter un nouveau quiz créé par un enseignant
INSERT INTO Quiz (titreQuiz, description, idCategorie, idEnseignant, dureeMinutes) 
VALUES ('Requêtes Avancées en SQL', 'Quiz sur les JOINs, GROUP BY et sous-requêtes.', 2, 1, 25);


-- Requête 2 : Modifier la durée d'un quiz existant
UPDATE Quiz
SET dureeMinutes = 10
WHERE idQuiz = 1;

-- Requête 3 : Afficher tous les utilisateurs
SELECT * FROM Utilisateurs;

--Requête 4 : Afficher uniquement les noms et emails des utilisateurs
SELECT nom,email FROM Utilisateurs;

--Requête 5 : Afficher tous les quiz
SELECT * FROM Quiz;

--Requête 6 : Afficher uniquement les titres des quiz
SELECT titreQuiz FROM Quiz;

-- Requête 7 : Afficher toutes les catégories
SELECT * FROM Categories;

-- Requête 8 : Afficher les utilisateurs qui sont enseignants
SELECT * FROM Utilisateurs
WHERE role='enseignant';

-- Requête 9 : Afficher les utilisateurs qui sont étudiants
SELECT * FROM Utilisateurs
WHERE role='etudiant';

-- Requête 10 : Afficher les quiz de durée supérieure à 30 minutes
SELECT * FROM Quiz
WHERE dureeMinutes > 30;

-- Requête 11 : Afficher les quiz de durée inférieure ou égale à 45 minutes
SELECT * FROM Quiz
WHERE dureeMinutes <= 45;

-- Requête 12 : Afficher les questions valant plus de 5 points
SELECT * FROM Questions
WHERE points > 5;

-- Requête 13 : Afficher les quiz de durée entre 20 et 40 minutes
SELECT * FROM Quiz
WHERE dureeMinutes BETWEEN 20 AND 40;

-- Requête 14 : Afficher les résultats avec un score supérieur ou égal à 60
SELECT * FROM Resultats
WHERE score >= 60;

-- Requête 15 : Afficher les résultats avec un score inférieur à 50
SELECT * FROM Resultats
WHERE score < 50;

-- Requête 16 : Afficher les questions valant entre 5 et 15 points
SELECT * FROM Questions
WHERE points BETWEEN 5 AND 15;

-- Requête 17 : Afficher les quiz créés par l'enseignant avec id_enseignant = 1
SELECT * FROM Utilisateurs
WHERE role = 'enseignant' AND idUtilisateur = 1;

-- Requête 18 : Afficher tous les quiz triés par durée (du plus court au plus long)
SELECT * FROM Quiz
ORDER BY dureeMinutes ASC;

-- Requête 19 : Afficher tous les résultats triés par score (du plus élevé au plus faible)
SELECT * FROM Resultats
ORDER BY score DESC;

-- Requête 20 : Afficher les 5 meilleurs scores
SELECT * FROM Resultats
ORDER BY score DESC
LIMIT 5;

-- Requête 21 : Afficher les questions triées par points (du plus faible au plus élevé)
SELECT * FROM Questions
ORDER BY points ASC;

-- Requête 22 : Afficher les 3 derniers résultats (triés par date_passage décroissante)
SELECT * FROM (
    SELECT * FROM Resultats 
    ORDER BY idResultat DESC 
    LIMIT 3
) AS DerniersResultats
ORDER BY idResultat ASC;

-- Requête 23 : Afficher le nom de chaque quiz avec sa catégorie
SELECT Q.titreQuiz,C.nomCategorie 
FROM Quiz AS Q
INNER JOIN Categories AS C ON Q.idCategorie = C.idCategorie;