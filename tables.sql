-- Créations

CREATE TABLE IF NOT EXISTS Pilote (
    id_pilote INTEGER PRIMARY KEY NOT NULL,
    num_pilote INTEGER CHECK(num_pilote > 0) NOT NULL,
    nom_pilote TEXT NOT NULL,
    age INTEGER CHECK(Age >= 18) NOT NULL,
    classement_gen INTEGER CHECK (classement_gen <= 20) NOT NULL,
    nb_victoire INTEGER NOT NULL,
    nb_pole_pos INTEGER NOT NULL,
    id_ecurie INTEGER NOT NULL,
    FOREIGN KEY(id_ecurie) REFERENCES Ecurie(id_ecurie)
);

CREATE TABLE IF NOT EXISTS Moteur (
    id_moteur INTEGER PRIMARY KEY NOT NULL,
    id_fabricant INTEGER NOT NULL,
    nom_moteur TEXT NOT NULL,
    FOREIGN KEY(id_fabricant) REFERENCES Fabricant(id_fabricant)
);

CREATE TABLE IF NOT EXISTS Staff (
    id_staff INTEGER PRIMARY KEY NOT NULL,
    nom_staff TEXT NOT NULL,
    age INTEGER NOT NULL,
    id_role INTEGER NOT NULL,
    id_ecurie INTEGER NOT NULL,
    FOREIGN KEY(id_ecurie) REFERENCES Ecurie(id_ecurie),
    FOREIGN KEY(id_role) REFERENCES Role(id_role)
);

CREATE TABLE IF NOT EXISTS Voiture (
    id_voiture INTEGER PRIMARY KEY NOT NULL,
    nom_voiture TEXT NOT NULL,
    id_moteur INTEGER NOT NULL,
    id_ecurie INTEGER NOT NULL,
    vit_max INTEGER CHECK(vit_max > 0) NOT NULL,
    FOREIGN KEY(id_moteur) REFERENCES Moteur(id_moteur),
    FOREIGN KEY(id_ecurie) REFERENCES Ecurie(id_ecurie)
);

CREATE TABLE IF NOT EXISTS Ecurie (
    id_ecurie INTEGER PRIMARY KEY NOT NULL,
    nom_ecurie TEXT NOT NULL,
    date_crea INTEGER NOT NULL,
    class_constru INTEGER CHECK (class_constru <= 10) NOT NULL
);

CREATE TABLE IF NOT EXISTS Circuit (
    id_circuit INTEGER PRIMARY KEY NOT NULL,
    nom_circuit TEXT NOT NULL,
    nb_tours INTEGER CHECK (nb_tours > 0) NOT NULL,
    distance FLOAT CHECK (distance > 260) NOT NULL
);

CREATE TABLE IF NOT EXISTS Fabricant (
    id_fabricant INTEGER PRIMARY KEY,
    nom_fabricant TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS Role(
    id_role INTEGER PRIMARY KEY,
    nom_role TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS Roule(
    id_pilote INTEGER NOT NULL,
    id_circuit INTEGER NOT NULL,
    classement INTEGER NOT NULL,
    CONSTRAINT roule_pk PRIMARY KEY(id_pilote, id_circuit),
    FOREIGN KEY(id_pilote) REFERENCES Pilote(id_pilote),
    FOREIGN KEY(id_circuit) REFERENCES Circuit(id_circuit)
);

CREATE TABLE IF NOT EXISTS Couleur(
    id_couleur INTEGER PRIMARY KEY,
    nom_couleur TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS Peinte(
    id_voiture INTEGER NOT NULL,
    id_couleur INTEGER NOT NULL,
    CONSTRAINT peinte_pk PRIMARY KEY(id_voiture, id_couleur),
    FOREIGN KEY(id_voiture) REFERENCES Voiture(id_voiture),
    FOREIGN KEY(id_couleur) REFERENCES Couleur(id_couleur)
);



-- Insertions

INSERT INTO
    Pilote (id_pilote, num_pilote, nom_pilote, age, classement_gen, nb_victoire, nb_pole_pos, id_ecurie)
VALUES
    (1, 7, 'Raikkonen Kimi', 42, 16, 0, 0, 1),
    (2, 99, 'Giovinazzi Antonio', 28, 18, 0, 0, 1),
    (3, 14, 'Alonso Fernando', 40, 10, 0, 0, 2),
    (4, 31, 'Ocon Esteban', 25, 11, 1, 0, 2),
    (5, 5, 'Vettel Sebastian', 35, 12, 0, 0, 3),
    (6, 18, 'Lance Stroll', 23, 13, 0, 0, 3),
    (7, 3, 'Ricciardo Daniel', 32, 8, 1, 0, 4),
    (8, 4, 'Norris Lando', 22, 6, 0, 1, 4),
    (9, 44, 'Hamilton Lewis', 37, 2, 8, 5, 5),
    (10, 77, 'Bottas Valtteri', 32, 3, 1, 4, 5),
    (11, 11, 'Perez Sergio', 32, 4, 1, 0, 6),
    (12, 33, 'Verstappen Max', 24, 1, 10, 10, 6),
    (13, 10, 'Gasly Pierre', 26, 9, 0, 0, 7),
    (14, 22, 'Tsunoda Yuki', 21, 14, 0, 0, 7),
    (15, 16, 'Leclerc Charles', 24, 7, 0, 2, 8),
    (16, 55, 'Sainz Carlos', 27, 5, 0, 0, 8),
    (17, 9, 'Mazepin Nikita', 23, 20, 0, 0, 9),
    (18, 47, 'Schumacher Mick', 23, 19, 0, 0, 9),
    (19, 6, 'Latifi Nicholas', 26, 17, 0, 0, 10),
    (20, 63, 'Russell Georges', 24, 15, 0, 0, 10);

INSERT INTO
    Moteur (id_moteur, id_fabricant, nom_moteur)
VALUES
    (1, 1, 'Ferrari 065/6'),
    (2, 2, 'Honda RA621H'),
    (3, 3, 'Mercedes F1M12 E Performance'),
    (4, 4, 'Renault E-Tech 20B');

INSERT INTO
    Fabricant(id_fabricant, nom_fabricant)
VALUES
    (1, 'Scuderia Ferrari Mission Winnow'),
    (2, 'Oracle Red Bull Racing'),
    (3, 'Mercedes-AMG Petronas Formula One Team'),
    (4, 'Alpine F1 Team');

INSERT INTO
    Role(id_role, nom_role)
VALUES
    (1, 'Directeur ecurie'),
    (2, 'Directeur technique'),
    (3, 'Ingenieur moteur');

INSERT INTO
    Staff (id_staff, nom_staff, age, id_role, id_ecurie)
VALUES
    (1, 'Toto Wolff', 50, 1, 5),
    (2, 'Mike Elliott', 47, 2, 5),
    (3, 'Hywel Thomas', 49, 3, 5),
    (4, 'Christian Horner', 48, 1, 6),
    (5, 'Pierre Waché', 47, 2, 6),
    (6, 'Adrian Newey', 63, 3, 6),
    (7, 'Otmar Szafnauer', 57, 1, 2),
    (8, 'Pat Fry', 58, 2, 2),
    (9, 'Matt Harman', 48, 3, 2),
    (10, 'Mattia Binotto', 52, 1, 8),
    (11, 'Enrico Cardile', 48, 2, 8),
    (12, 'Enrico Gualtieri', 47, 3, 8),
    (13, 'Franz Tost', 66, 1, 7),
    (14, 'Jody Egginton', 48, 2, 7),
    (15, 'Zak Brown', 50, 1, 4),
    (16, 'James Key', 50, 2, 4),
    (18, 'Jost Capito', 63, 1, 10),
    (19, 'Francois-Xavier Demaison', 53, 2, 10),
    (20, 'Frederic Vasseur', 53, 1, 1),
    (21, 'Jan Monchaux', 43, 2, 1),
    (22, 'Gunther Steiner', 56, 1, 9),
    (23, 'Simone Resta', 51, 2, 9),
    (24, 'Mike Krack', 50, 1, 3),
    (25, 'Andrew Green', 56, 2, 3);

INSERT INTO
    Voiture (id_voiture, nom_voiture, id_moteur, id_ecurie, vit_max)
VALUES
    (1, 'Alfa Romeo C41', 1, 1, 331),
    (2, 'Alpha Tauri AT02', 2, 7, 337),
    (3, 'Alpine A521', 4, 2, 340),
    (4, 'Aston Martin AMR21', 3, 3, 330),
    (5, 'Ferrari FS21', 1, 8, 342),
    (6, 'Haas VF-21', 1, 9, 325),
    (7, 'McLaren MCL35M', 3, 4, 340),
    (8, 'Mercedes F1 W12 E Performance', 3, 5, 350),
    (9, 'Red Bull RB16B', 2, 6, 347),
    (10, 'Williams FW43B', 3, 10, 328);

INSERT INTO
    Ecurie (id_ecurie, nom_ecurie, date_crea, class_constru)
VALUES
    (1, 'Alfa Romeo F1 Team ORLEN', 1950, 9),
    (2, 'Alpine F1 Team', 2020, 5),
    (3, 'Aston Martin Aramco Cognizant F1 Team', 2021, 7),
    (4, 'McLaren F1 Team', 1963, 4),
    (5, 'Mercedes-AMG Petronas Formula One Team', 1954, 1),
    (6, 'Oracle Red Bull Racing', 2005, 2),
    (7, 'Scuderia Alpha Tauri', 2006, 6),
    (8, 'Scuderia Ferrari Mission Winnow', 1950, 3),
    (9, 'Uralkali Haas F1 Team', 2016, 10),
    (10, 'Williams Racing', 1977, 8);

INSERT INTO
    Circuit (id_circuit, nom_circuit, nb_tours, distance)
VALUES
    (1, 'Bahreïn', 57, 302.826),
    (2, 'Imola', 63, 309.049),
    (3, 'Portimao', 66, 306.826),
    (4, 'Barcelone', 66, 308.424),
    (5, 'Monaco', 78, 260.286),
    (6, 'Bakou', 51, 306.049),
    (7, 'Le Castellet', 53, 309.690),
    (8, 'Spielberg', 71, 307.146),
    (9, 'Spielberg', 71, 307.146),
    (10, 'Sylverstone', 52, 306.198),
    (11, 'Budapest', 70, 306.630),
    (12, 'Spa-Francorchamps', 44, 308.176),
    (13, 'Zandvoort', 72, 306.648),
    (14, 'Monza', 53, 306.720),
    (15, 'Sotchi', 53, 309.745),
    (16, 'Istanbul', 58, 309.396),
    (17, 'Austin', 56, 308.405),
    (18, 'Mexico', 72, 305.354),
    (19, 'Sao Paulo', 71, 305.909),
    (20, 'Qatar', 57, 306.660),
    (21, 'Djeddah', 50, 308.750),
    (22, 'Yas Marina', 58, 306.183);

INSERT INTO
    Roule(id_pilote, id_circuit, classement)
VALUES
    (1, 1, 11),
    (2, 1, 12),
    (3, 1, 19),
    (4, 1, 13),
    (5, 1, 15),
    (6, 1, 10),
    (7, 1, 7),
    (8, 1, 4),
    (9, 1, 1),
    (10, 1, 3),
    (11, 1, 5),
    (12, 1, 2),
    (13, 1, 17),
    (14, 1, 9),
    (15, 1, 6),
    (16, 1, 8),
    (17, 1, 20),
    (18, 1, 16),
    (19, 1, 18),
    (20, 1, 14);

INSERT INTO
    Couleur(id_couleur, nom_couleur)
VALUES
    (1, 'Verte'),
    (2, 'Rouge'),
    (3, 'Blanche'),
    (4, 'Bleue'),
    (5, 'Orange'),
    (6, 'Noire'),
    (7, 'Grise');

INSERT INTO
    Peinte(id_voiture, id_couleur)
VALUES
    (1, 2),
    (1, 3),
    (2, 4),
    (2, 3),
    (3, 4),
    (3, 3),
    (3, 2),
    (4, 1),
    (5, 7),
    (6, 3),
    (6, 2),
    (7, 5),
    (8, 7),
    (9, 6),
    (9, 5),
    (10, 4);



-- Vues

CREATE VIEW info_pilote AS
SELECT
    nom_pilote,
    age,
    num_pilote,
    nom_ecurie,
    classement_gen,
    nb_victoire,
    nb_pole_pos
FROM
    Pilote
    INNER JOIN Ecurie USING(id_ecurie)
ORDER BY
    nom_pilote;

CREATE VIEW info_circuit AS
SELECT
    nom_circuit,
    nom_pilote,
    classement
FROM
    Roule
    INNER JOIN circuit USING(id_circuit)
    INNER JOIN Pilote USING(id_pilote)
ORDER BY
    nom_circuit,
    classement;

CREATE VIEW info_voiture AS
SELECT
    nom_voiture,
    nom_ecurie,
    nom_moteur,
    vit_max
FROM
    Voiture
    INNER JOIN Ecurie USING(id_ecurie)
    INNER JOIN Moteur USING(id_moteur)
ORDER BY
    nom_voiture;

CREATE VIEW info_staff AS
SELECT
    nom_staff,
    age,
    nom_role,
    nom_ecurie
FROM
    Staff
    INNER JOIN Role USING(id_role)
    INNER JOIN Ecurie USING(id_ecurie)
ORDER BY
    nom_staff;

CREATE VIEW classement_pilote AS
SELECT
    classement_gen,
    nom_pilote,
    nom_ecurie
FROM
    Pilote
    INNER JOIN Ecurie USING(id_ecurie)
ORDER BY
    classement_gen;



-- Déclencheurs

CREATE TRIGGER IF NOT EXISTS update_id_circuit BEFORE
UPDATE
    ON Circuit FOR EACH ROW BEGIN
UPDATE
    Roule
SET
    id_circuit = NEW.id_circuit
WHERE
    id_circuit = OLD.id_circuit;

END;

CREATE TRIGGER IF NOT EXISTS update_id_pilote BEFORE
UPDATE
    ON Pilote FOR EACH ROW BEGIN
UPDATE
    Roule
SET
    id_pilote = NEW.id_pilote
WHERE
    id_pilote = OLD.id_pilote;

END;

CREATE TRIGGER IF NOT EXISTS update_id_voiture BEFORE
UPDATE
    ON Voiture FOR EACH ROW BEGIN
UPDATE
    Peinte
SET
    id_voiture = NEW.id_voiture
WHERE
    id_voiture = OLD.id_voiture;

END;

CREATE TRIGGER IF NOT EXISTS update_id_couleur BEFORE
UPDATE
    ON Couleur FOR EACH ROW BEGIN
UPDATE
    Peinte
SET
    id_couleur = NEW.id_couleur
WHERE
    id_couleur = OLD.id_couleur;

END;