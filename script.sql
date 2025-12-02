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