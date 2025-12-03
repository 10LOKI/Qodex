-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 03 déc. 2025 à 10:14
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `qodex`
--

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

CREATE TABLE `categories` (
  `idCategorie` int(11) NOT NULL,
  `nomCategorie` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `categories`
--

INSERT INTO `categories` (`idCategorie`, `nomCategorie`) VALUES
(2, 'Bases de Données'),
(1, 'Programmation'),
(3, 'Réseaux'),
(4, 'Sécurité Informatique');

-- --------------------------------------------------------

--
-- Structure de la table `questions`
--

CREATE TABLE `questions` (
  `idQuestion` int(11) NOT NULL,
  `texteQuestion` varchar(255) NOT NULL,
  `reponseCorrecte` varchar(255) NOT NULL,
  `points` int(11) NOT NULL,
  `idQuiz` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `questions`
--

INSERT INTO `questions` (`idQuestion`, `texteQuestion`, `reponseCorrecte`, `points`, `idQuiz`) VALUES
(1, 'Quelle clause utilise-t-on pour filtrer les lignes ?', 'WHERE', 10, 1),
(2, 'Quel mot-clé est utilisé pour insérer de nouvelles données ?', 'INSERT INTO', 10, 1),
(3, 'Quel est l\'opérateur de modulo en Python ?', '%', 15, 2),
(4, 'Comment écrit-on un commentaire sur une seule ligne en Python ?', '# Ceci est un commentaire', 15, 2),
(5, 'Quelle couche est responsable de l\'adressage logique (IP) ?', 'Couche Réseau', 5, 3);

-- --------------------------------------------------------

--
-- Structure de la table `quiz`
--

CREATE TABLE `quiz` (
  `idQuiz` int(11) NOT NULL,
  `titreQuiz` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `idCategorie` int(11) NOT NULL,
  `idEnseignant` int(11) NOT NULL,
  `dureeMinutes` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `quiz`
--

INSERT INTO `quiz` (`idQuiz`, `titreQuiz`, `description`, `idCategorie`, `idEnseignant`, `dureeMinutes`) VALUES
(1, 'Introduction au SQL', 'Quiz de base sur le langage SQL (SELECT, INSERT, UPDATE).', 2, 1, 10),
(2, 'Fondamentaux de Python', 'Questions sur la syntaxe et les structures de contrôle de Python.', 1, 2, 45),
(3, 'Les couches du modèle OSI', 'Évaluation des connaissances sur les 7 couches du modèle OSI.', 3, 1, 20),
(4, 'Requêtes Avancées en SQL', 'Quiz sur les JOINs, GROUP BY et sous-requêtes.', 2, 1, 10),
(5, 'Mo3ela9ate', 'Khlik b3id al3ziz', 2, 2, 9);

-- --------------------------------------------------------

--
-- Structure de la table `resultats`
--

CREATE TABLE `resultats` (
  `idResultat` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `datePassage` datetime NOT NULL,
  `idEtudiant` int(11) NOT NULL,
  `idQuiz` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `resultats`
--

INSERT INTO `resultats` (`idResultat`, `score`, `datePassage`, `idEtudiant`, `idQuiz`) VALUES
(1, 85, '2023-11-01 10:00:00', 1, 1),
(2, 65, '2023-11-02 14:30:00', 2, 1),
(3, 95, '2023-11-03 09:15:00', 3, 2),
(4, 40, '2023-11-04 11:00:00', 4, 3),
(5, 70, '2023-11-05 16:45:00', 5, 1),
(6, 100, '2023-11-06 13:20:00', 1, 3);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

CREATE TABLE `utilisateurs` (
  `idUtilisateur` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `motDePasse` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL
) ;

--
-- Déchargement des données de la table `utilisateurs`
--

INSERT INTO `utilisateurs` (`idUtilisateur`, `nom`, `email`, `motDePasse`, `role`) VALUES
(1, 'Yahya Jabrane', 'yahya.jabrane@wac.com', 'mdpWac1', 'etudiant'),
(2, 'Aymane El Hassouni', 'aymane.hassouni@wac.com', 'mdpWac2', 'etudiant'),
(3, 'Arsène Zola', 'arsene.zola@wac.com', 'mdpWac3', 'etudiant'),
(4, 'Badi Aouk', 'badi.aouk@wac.com', 'mdpWac4', 'etudiant'),
(5, 'Montasser Lahtimi', 'montasser.lahtimi@wac.com', 'mdpWac5', 'etudiant'),
(6, 'Dupont', 'm.dupont@ecole.fr', 'jfkdjj', 'enseignant');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`idCategorie`),
  ADD UNIQUE KEY `nomCategorie` (`nomCategorie`);

--
-- Index pour la table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`idQuestion`),
  ADD KEY `idQuiz` (`idQuiz`);

--
-- Index pour la table `quiz`
--
ALTER TABLE `quiz`
  ADD PRIMARY KEY (`idQuiz`),
  ADD KEY `idCategorie` (`idCategorie`),
  ADD KEY `FK_Quiz_Enseignant` (`idEnseignant`);

--
-- Index pour la table `resultats`
--
ALTER TABLE `resultats`
  ADD PRIMARY KEY (`idResultat`),
  ADD UNIQUE KEY `UC_Etudiant_Quiz` (`idEtudiant`,`idQuiz`),
  ADD KEY `idQuiz` (`idQuiz`);

--
-- Index pour la table `utilisateurs`
--
ALTER TABLE `utilisateurs`
  ADD PRIMARY KEY (`idUtilisateur`),
  ADD UNIQUE KEY `constEmail` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `categories`
--
ALTER TABLE `categories`
  MODIFY `idCategorie` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `questions`
--
ALTER TABLE `questions`
  MODIFY `idQuestion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `quiz`
--
ALTER TABLE `quiz`
  MODIFY `idQuiz` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `resultats`
--
ALTER TABLE `resultats`
  MODIFY `idResultat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `utilisateurs`
--
ALTER TABLE `utilisateurs`
  MODIFY `idUtilisateur` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`idQuiz`) REFERENCES `quiz` (`idQuiz`);

--
-- Contraintes pour la table `quiz`
--
ALTER TABLE `quiz`
  ADD CONSTRAINT `FK_Quiz_Enseignant` FOREIGN KEY (`idEnseignant`) REFERENCES `utilisateurs` (`idUtilisateur`),
  ADD CONSTRAINT `quiz_ibfk_1` FOREIGN KEY (`idCategorie`) REFERENCES `categories` (`idCategorie`);

--
-- Contraintes pour la table `resultats`
--
ALTER TABLE `resultats`
  ADD CONSTRAINT `resultats_ibfk_1` FOREIGN KEY (`idEtudiant`) REFERENCES `utilisateurs` (`idUtilisateur`),
  ADD CONSTRAINT `resultats_ibfk_2` FOREIGN KEY (`idQuiz`) REFERENCES `quiz` (`idQuiz`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
