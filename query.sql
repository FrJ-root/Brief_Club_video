--$$->> Requêtes de Base:

-- Liste des informations de tous les membres

SELECT pseudo, email, date_inscription
FROM MEMBRE;

-- Affichage des listes des jeux disponibles

SELECT titre, genre, studio_developpement
FROM JEU;

-- Affichage des détails du tournoi spécifique à partir de son nom

SELECT *
FROM TOURNOI
WHERE nom_tournoi = 'Fortnite Championship';

-- Liste des emprunts en cours (incluant pseudo du membre et le titre du jeu)

SELECT m.pseudo, j.titre
FROM EMPRUNTER e JOIN MEMBRE m ON e.id_membre = m.id JOIN JEU j ON e.id_jeu = j.id
WHERE e.date_retour_reelle IS NULL;



--$$->> Requêtes avec Jointures:

-- Liste des membres ayant participé à tournoi (pseudo, nom du tournoi, rang final)

SELECT m.pseudo, t.nom_tournoi, p.rang_final
FROM PARTICIPER p JOIN MEMBRE m ON p.id_membre = m.id JOIN TOURNOI t ON p.id_tournoi = t.id;

-- les membres qui ont souscrit à un abonnement annuel

SELECT m.pseudo, a.type_abonnement
FROM ABONNEMENT a JOIN MEMBRE m ON a.id = m.id WHERE a.type_abonnement = 'Annuel';

-- Trouver les jeux empruntés par un membre spécifique (via son pseudo)

SELECT j.titre
FROM EMPRUNTER e JOIN JEU j ON e.id_jeu = j.id
JOIN MEMBRE m ON e.id_membre = m.id WHERE m.pseudo = 'pseudo_du_membre';

-- Lister tous les emprunts (pseudo du membre ,informations sur le jeu (titre , studio de développement))

SELECT m.pseudo, j.titre, j.studio_developpement
FROM EMPRUNTER e JOIN MEMBRE m ON e.id_membre = m.id JOIN JEU j ON e.id_jeu = j.id;

-- Affichage d liste des membres et le type d'abonnement auquel ils sont associés 

SELECT m.pseudo, a.type_abonnement
FROM MEMBRE m JOIN ABONNEMENT a ON m.id = a.id_membre;



--$$->> Requêtes avec Agrégation

-- Calculage du nombre total de jeux disponibles par genre

SELECT genre, COUNT(*) AS nombre_jeux
FROM JEU GROUP BY genre;

-- Le tournoi avec le plus grand nombre de participants

SELECT t.nom_tournoi, COUNT(p.id_membre) AS nombre_participants
FROM TOURNOI t JOIN PARTICIPER p ON t.id = p.id_tournoi
GROUP BY t.id ORDER BY nombre_participants DESC

--Affichage de nombre d'emprunts réalisés par chaque membre

SELECT m.pseudo, COUNT(e.id) AS nombre_emprunts
FROM MEMBRE m LEFT JOIN EMPRUNTER e ON m.id = e.id_membre GROUP BY m.id;



--$$->> Requêtes avec Filtres et Tri

--Affichage des jeux sortis après une certaine année, triés par ordre alphabétique

SELECT titre, annee_sortie FROM JEU
WHERE annee_sortie > 2015 ORDER BY titre ASC;

--Les membres qui ont emprunté un jeu et ne l'ont pas encore rendu

SELECT m.pseudo, j.titre FROM EMPRUNTER e JOIN MEMBRE m ON e.id_membre = m.id
JOIN JEU j ON e.id_jeu = j.id WHERE e.date_retour_reelle IS NULL;

--Liste des tournois ayant eu lieu entre deux dates spécifiques

SELECT * FROM TOURNOI WHERE date_tournoi BETWEEN '2024-06-01' AND '2024-09-01';

--Affichage des membres avec plusieurs emprunts actifs

SELECT m.pseudo FROM EMPRUNTER e JOIN MEMBRE m ON e.id_membre = m.id WHERE e.date_retour_reelle IS NULL GROUP BY m.id
HAVING COUNT(e.id) > 1;