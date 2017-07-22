-- phpMyAdmin SQL Dump
-- version 4.7.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le :  Dim 09 juil. 2017 à 09:08
-- Version du serveur :  10.1.21-MariaDB
-- Version de PHP :  5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `gta5_gamemode_essential`
--

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `ID` int(11) NOT NULL,
  `identifier` varchar(30) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
  `group` varchar(50) NOT NULL DEFAULT '0',
  `permission_level` int(11) NOT NULL DEFAULT '0',
  `money` double NOT NULL DEFAULT '0',
  `bankbalance` int(32) DEFAULT '0',
  `job` int(11) DEFAULT '1',
  `police` int(11) DEFAULT '0',
  `enService` int(11) DEFAULT '0',
  `dirtymoney` double(11,0) NOT NULL DEFAULT '0',
  `isFirstConnection` int(11) DEFAULT '1',
  `nom` varchar(30) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
  `prenom` varchar(30) CHARACTER SET utf8mb4 NOT NULL DEFAULT '',
  `telephone` varchar(30) DEFAULT NULL,
  `permisv` varchar(30) NOT NULL DEFAULT '0',
  `permism` varchar(30) NOT NULL DEFAULT '0',
  `permisvel` varchar(30) NOT NULL DEFAULT '0',
  `permisc` varchar(30) NOT NULL DEFAULT '0',
  `permisb` varchar(30) NOT NULL DEFAULT '0',
  `permish` varchar(30) NOT NULL DEFAULT '0',
  `permisgun` varchar(30) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`ID`, `identifier`, `group`, `permission_level`, `money`, `bankbalance`, `job`, `police`, `enService`, `dirtymoney`, `isFirstConnection`, `nom`, `prenom`, `telephone`, `permisv`, `permism`, `permisvel`, `permisc`, `permisb`, `permish`, `permisgun`) VALUES
(20, 'steam:11000010b9ee4ce', 'superadmin', 6, 1767721, 100000000, 14, 6, 0, 0, 1, 'Jones', 'Patrick', '490-1000', '1', '0', '0', '0', '0', '0', '0');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
