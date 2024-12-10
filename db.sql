--> Creation des Tables:

-- DataBase Created


CREATE DATABASE ClubVideo_db;
USE ClubVideo_db;


-- Table MEMBRE


CREATE TABLE MEMBRE (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pseudo VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    date_inscription DATE NOT NULL
);


-- Table ABONNEMENT


CREATE TABLE ABONNEMENT (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type_abonnement ENUM('Mensuel', 'Annuel') NOT NULL,
    date_debut date,
    date_fin date,
    membre_id INT ,
	FOREIGN KEY (membre_id) REFERENCES membre(id) ON DELETE CASCADE
);


-- Table JEU


CREATE TABLE JEU (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(100) NOT NULL,
    studio_developpement VARCHAR(100) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    annee_sortie YEAR NOT NULL,
    multijoueur ENUM('oui', 'non') NOT NULL
);


-- Table EMPRUNTER


CREATE TABLE EMPRUNTER (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_membre INT,
    id_jeu INT,
    date_emprunt DATE NOT NULL,
    date_retour_prevue DATE NOT NULL,
    date_retour_reelle DATE,
    FOREIGN KEY (id_membre) REFERENCES MEMBRE(id),
    FOREIGN KEY (id_jeu) REFERENCES JEU(id)
);


-- Table TOURNOI


CREATE TABLE TOURNOI (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom_tournoi VARCHAR(100) NOT NULL,
    date_tournoi DATE NOT NULL,
    recompenses boolean NOT NULL
);


-- Table PARTICIPER


CREATE TABLE PARTICIPER (
    id_membre INT,
    id_tournoi INT,
    score INT,
    rang_final INT,
    PRIMARY KEY (id_membre, id_tournoi),
    FOREIGN KEY (id_membre) REFERENCES MEMBRE(id),
    FOREIGN KEY (id_tournoi) REFERENCES TOURNOI(id)
);


--> Les donnees:

INSERT INTO membre (pseudo, email, date_inscription) VALUES
('olivia_adams', 'olivia@example.com', '2023-12-01'),
('ethan_clark', 'ethan@example.com', '2024-02-15'),
('mia_wilson', 'mia@example.com', '2023-07-20'),
('noah_hall', 'noah@example.com', '2024-04-10'),
('isabella_evans', 'isabella@example.com', '2023-06-05'),
('emma_thomas', 'emma@example.com', '2024-01-30'),
('james_jackson', 'james@example.com', '2023-09-12'),
('amelia_martin', 'amelia@example.com', '2023-10-05');


INSERT INTO abonnement (type_abonnement, date_debut, date_fin) VALUES 
('annuel', '2023-01-01', '2023-12-31'),
('annuel', '2024-01-01', '2024-12-31'),
('mensuel', '2024-12-01', '2024-12-31'),
('mensuel', '2024-11-01', '2024-11-30'),
('mensuel', '2024-10-01', '2024-10-31'),
('hebdomadaire', '2024-12-01', '2024-12-07'),
('hebdomadaire', '2024-11-15', '2024-11-21'),
('hebdomadaire', '2024-11-22', '2024-11-28');


INSERT INTO JEU (titre, studio_developpement, genre, annee_sortie, multijoueur) VALUES
('Game of Thrones: The Game', 'Telltale Games', 2014, 'Aventure', false),
('Fortnite', 'Epic Games', 2017, 'Action', true),
('Minecraft', 'Mojang Studios', 2011, 'Aventure', true),
('The Witcher 3: Wild Hunt', 'CD Projekt', 2015, 'RPG', false),
('Red Dead Redemption 2', 'Rockstar Games', 2018, 'Action', false),
('Call of Duty: Warzone', 'Infinity Ward', 2020, 'Shooter', true),
('FIFA 23', 'EA Sports', 2022, 'Sports', true),
('Animal Crossing: New Horizons', 'Nintendo', 2020, 'Simulation', true);


INSERT INTO TOURNOI (nom_tournoi, date_tournoi, recompenses) VALUES
('Fortnite Championship', '2024-06-10', 'Cash prize, Trophies'),
('Minecraft Build-Off', '2024-07-20', 'Gift cards, Exclusive skins'),
('The Witcher Tournament', '2024-08-15', 'Cash prize, Merchandise'),
('Game of Thrones Quiz', '2024-09-05', 'Gift cards, Trophies'),
('Red Dead Redemption 2 Showdown', '2024-10-15', 'Cash prize, Merchandise'),
('Call of Duty: Warzone Battle', '2024-11-10', 'Gift cards, Trophies'),
('FIFA 23 World Cup', '2024-12-20', 'Trophies, Exclusive skins'),
('Animal Crossing Villager Contest', '2024-08-30', 'Gift cards, Limited edition items');


INSERT INTO emprunter(id_membre, id_jeu, date_emprunt, date_retour_prevue, date_retour_reelle) VALUES
(1, 2, '2024-02-01', '2024-02-15', '2024-02-14'),
(2, 1, '2024-02-20', '2024-03-05', '2024-03-04'),
(3, 3, '2024-03-10', '2024-03-24', NULL),
(3, 5, '2024-03-10', '2024-03-24', NULL),
(3, 2, '2024-03-10', '2024-03-24', NULL),
(4, 4, '2024-04-01', '2024-04-15', NULL),
(5, 5, '2024-06-05', '2024-06-19', NULL),
(6, 6, '2024-05-10', '2024-05-25', NULL),
(7, 7, '2024-06-15', '2024-06-30', '2024-06-28'),
(8, 8, '2024-07-01', '2024-07-15', '2024-07-13');


INSERT INTO Participer (id_membre, id_tournoi, score, rang_final) VALUES
(1, 1, 90, 2),
(2, 2, 85, 1),
(3, 3, 75, 3),
(4, 4, 95, 1),
(5, 5, 80, 4),
(6, 6, 92, 1),
(7, 7, 70, 5),
(8, 8, 85, 2);