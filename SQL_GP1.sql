-- Creation base de donnees 'cata_swiss'
CREATE DATABASE IF NOT EXISTS cata_swiss;

use cata_swiss;

drop table if exists CatastropheNaturelle;
drop table if exists Duree;
drop table if exists Lieu;
drop table if exists Statistique;
drop table if exists Description;
drop table if exists Canicule;
drop table if exists Eboulement;
drop table if exists TrdeTerre;
drop table if exists Avalanche;
drop table if exists Crue;
drop table if exists Incendie;
drop table if exists GlissementdeTerrain;
drop table if exists Grele;
drop table if exists Tempete;

-- creation des tables
create table `Description`(
	`IDDescription` int not null auto_increment,
	`Explication` text not null,
	`image_name` varchar(255),
	primary key (`IDDescription`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

create table `Statistique` (
	`IDStatistique` int not null auto_increment,
	`NBVictime` int default '0',
	`NBBlesse` int default '0',
	`NBBatimentDetruit` int default '0',
	`CoutDegatMillionFR` float default '0',
	primary key (`IDStatistique`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

create table `Lieu` (
	`IDLieu` int not null auto_increment,
	`Canton` varchar(255),
	`Region` varchar(255),
	`Localite` varchar(255),
	primary key (`IDLieu`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


create table `Duree`(
	`IDDuree` int not null auto_increment,
	`DateDebut` varchar(255),
	`DateFin` varchar(255),
	primary key (`IDDuree`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;




create table `CatastropheNaturelle`(
	`IDCatastrophe` int not null auto_increment,
	`IDDuree` int not null,
	`IDLieu` int not null,
	`IDStatistique` int not null,
	`IDDescription` int not null,
	constraint `Duree_FK` foreign key (`IDDuree`) references `Duree` (`IDDuree`),
	constraint `Lieu_FK` foreign key (`IDLieu`) references `Lieu` (`IDLieu`),
	constraint `Statistique_FK` foreign key (`IDStatistique`) references `Statistique` (`IDStatistique`),
	constraint `Description_FK` foreign key (`IDDescription`) references `Description` (`IDDescription`),
	primary key (`IDCatastrophe`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


create table `Canicule` (
	`IDCanicule` int not null auto_increment,
	`IDCatastrophe` int not null,
	`TemperatureMaxDegre` float,
	constraint `Catastrophe_FK` foreign key (`IDCatastrophe`) references `CatastropheNaturelle` (`IDCatastrophe`),
	primary key (`IDCanicule`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

create table `Eboulement` (
	`IDEboulement` int not null auto_increment,
	`IDCatastrophe` int not null,
	`VolumeRocheM3` float,
	constraint `Catastrophe_FK2` foreign key (`IDCatastrophe`) references `CatastropheNaturelle` (`IDCatastrophe`),
	primary key (`IDEboulement`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

create table `TremblementDeTerre` (
	`IDTremblementDeTerre` int not null auto_increment,
	`IDCatastrophe` int not null,
	`Magnitude` float,
	constraint `Catastrophe_FK3` foreign key (`IDCatastrophe`) references `CatastropheNaturelle` (`IDCatastrophe`),
	primary key (`IDTremblementDeTerre`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

create table `Avalanche` (
	`IDAvalanche` int not null auto_increment,
	`IDCatastrophe` int not null,
	constraint `Catastrophe_FK4` foreign key (`IDCatastrophe`) references `CatastropheNaturelle` (`IDCatastrophe`),
	primary key (`IDAvalanche`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

create table `Crue` (
	`IDCrue` int not null auto_increment,
	`IDCatastrophe` int not null,
	`CourtDEau` varchar(255),
	constraint `Catastrophe_FK5` foreign key (`IDCatastrophe`) references `CatastropheNaturelle` (`IDCatastrophe`),
	primary key (`IDCrue`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

create table `Incendie` (
	`IDIncendie` int not null auto_increment,
	`IDCatastrophe` int not null,
	`HABrulee` int,
	constraint `Catastrophe_FK6` foreign key (`IDCatastrophe`) references `CatastropheNaturelle` (`IDCatastrophe`),
	primary key (`IDIncendie`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

create table `GlissementDeTerrain` (
	`IDGlissementDeTerrain` int not null auto_increment,
	`IDCatastrophe` int not null,
	`VolumeTombeeM3` int,
	`Evacuation` boolean,
	constraint `Catastrophe_FK7` foreign key (`IDCatastrophe`) references `CatastropheNaturelle` (`IDCatastrophe`),
	primary key (`IDGlissementDeTerrain`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

create table `Grele` (
	`IDGrele` int not null auto_increment,
	`IDCatastrophe` int not null,
	`DiametreGrelonCM` int,
	constraint `Catastrophe_FK8` foreign key (`IDCatastrophe`) references `CatastropheNaturelle` (`IDCatastrophe`),
	primary key (`IDGrele`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

create table `Tempete` (
	`IDTempete` int not null auto_increment,
	`IDCatastrophe` int not null,
	`VitesseVentMaxKMH` int,
	`NomTempete` varchar(255),
	constraint `Catastrophe_FK9` foreign key (`IDCatastrophe`) references `CatastropheNaturelle` (`IDCatastrophe`),
	primary key (`IDTempete`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--tremblemt de terre

INSERT INTO Description (Explication, image_name) VALUES ('Le 15 octobre, la terre a tremblé avec une magnitude de 6,6 à Bâle. Pratiquement la totalité des églises, forteresses et châteaux a été détruite sur un rayon d’environ 30 km. Après le tremblement de terre, un incendie a fait rage pendant huit jours et la ville a presque entièrement brûlé. L’intensité maximale de ce séisme, qui a fait entre 100 et 2000 morts, était de IX.', 'TremblementDeTerre1.png');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (2000, NULL, NULL, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Bâle', 'Bâle-Ville', 'Bâle');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('1356-10-15', '1356-10-15');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO TremblementDeTerre (IDCatastrophe, Magnitude) VALUES (@IDCatastrophe, 6.6);

INSERT INTO Description (Explication, image_name) VALUES ('Le tremblement de terre du 8 septembre, d’une magnitude de 5,9 et d’une intensité maximale de VIII, a touché Sarnen, Engelberg, Altdorf et Lucerne. Plusieurs maisons ont été entièrement détruites. Des glissements de terrain et des écroulements se sont produits. La chute de masses rocheuses (écroulement du Bürgenstock), combinée à des glissements de terrain, a en outre provoqué une vague de crue dans le lac des Quatre-Cantons.', 'TremblementDeTerre2.png');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (NULL, NULL, NULL, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Unterwald', 'Suisse centrale', 'Sarnen');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('1601-09-08', '1601-09-08');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO TremblementDeTerre (IDCatastrophe, Magnitude) VALUES (@IDCatastrophe, 5.9);

INSERT INTO Description (Explication, image_name) VALUES ('Le 25 juillet, aux alentours de midi, la terre a tremblé dans la région de Viège avec une magnitude de 6,2. L’épicentre était situé dans le Val de Viège, mais le séisme a été ressenti dans toute la Suisse et au-delà. La secousse principale a été suivie de nombreuses répliques d’une intensité considérable, qui n’ont faibli qu’en automne et se sont poursuivies jusqu’en 1858. Des centaines de bâtiments ont été partiellement gravement endommagés ou entièrement détruits.', 'TremblementDeTerre3.png');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (NULL, NULL, 200, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Valais', 'Haut-Valais', 'Viège');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('1855-07-25', '1855-07-25');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO TremblementDeTerre (IDCatastrophe, Magnitude) VALUES (@IDCatastrophe, 6.2);

INSERT INTO Description (Explication, image_name) VALUES ('Le 25 janvier, Sierre a été secouée par un tremblement de terre d’une magnitude de 5,8, qui a fait quatre morts et endommagé quelque 3500 bâtiments, dont une église, qui a perdu sa flèche. Une panne d’électricité est survenue et les lignes téléphoniques ont été très rapidement saturées, faisant régner le chaos pendant quelques heures.', 'TremblementDeTerre4.png');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (4, NULL, 3500, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Valais', 'Vallée du rhône', 'Sierre');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('1946-01-25', '1946-01-25');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO TremblementDeTerre (IDCatastrophe, Magnitude) VALUES (@IDCatastrophe, 5.8);

--glissement de terrain

INSERT INTO Description (Explication, image_name) VALUES ('Une masse en mouvement de plus de 100 millions de mètres cubes a détruit dix maisons et de nombreuses étables à Campo Vallemaggia (TI).', 'GlissementDeTerrain1.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (NULL, NULL, 10, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Tessin', 'Val Rovana', 'Campo Vallemaggia');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('1857-00-00', '1857-00-00');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO GlissementDeTerrain (IDCatastrophe, VolumeTombeeM3, Evacuation) VALUES (@IDCatastrophe, 100000000, false);

INSERT INTO Description (Explication, image_name) VALUES ('Un glissement de terrain d’un volume de 40 millions de m3 et d’une surface de 2 km2 a détruit partiellement ou totalement plus de 30 chalets de vacances à Falli-Hölli (FR). Les dégâts se sont élevés à quelque 20 millions de francs. Aucun blessé n’a été à déplorer grâce à une évacuation effectuée suffisamment tôt.', 'GlissementDeTerrain2.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (NULL, NULL, 30, 20);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Fribourg', 'Plasselb', 'Falli-Hölli');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('1994-00-00', '1994-00-00');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO GlissementDeTerrain (IDCatastrophe, VolumeTombeeM3, Evacuation) VALUES (@IDCatastrophe, 40000000, true);

INSERT INTO Description (Explication, image_name) VALUES ('Le 14 octobre, une tragédie s’est produite dans le village de Gondo (VS) : la pluie persistante a ramolli les fondations d’un mur de soutènement au-dessus du village. Lorsqu’une coulée de boue a exercé une pression supplémentaire, le mur massif en béton s’est renversé. En l’espace de 20 secondes, une avalanche de boue, de débris et de blocs de rochers s’est déversée sur le village, l’ensevelissant et tuant 13 personnes.', 'GlissementDeTerrain3.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (13, NULL, NULL, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Valais', 'Haut-Valais', 'Gondo');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('2000-10-14', '2000-10-14');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO GlissementDeTerrain (IDCatastrophe, VolumeTombeeM3, Evacuation) VALUES (@IDCatastrophe, NULL, false);

INSERT INTO Description (Explication, image_name) VALUES ('Au cours des intempéries du mois d’août, plus de 5000 glissements de terrain et coulées de boue, qui ont provoqué d’importants dommages aux bâtiments, ont été enregistrés. À Entlebuch (LU), deux pompiers ont été emportés et tués par une coulée de boue. À Weggis (LU), des coulées de boue et des chutes de blocs secondaires ont détruit trois bâtiments. Les habitants avaient toutefois pu être évacués à temps.', 'GlissementDeTerrain4.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (2, NULL, 3, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Lucerne', 'Suisse centrale', 'Entlebuch, Weggis');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('2005-08-00', '2005-08-00');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO GlissementDeTerrain (IDCatastrophe, VolumeTombeeM3, Evacuation) VALUES (@IDCatastrophe, NULL, true);

INSERT INTO Description (Explication, image_name) VALUES ('Le village de Brienz/Brinzauls (GR) est situé sur un grand glissement de terrain, qui s’est accéléré ces dernières années, passant de quelques centimètres à plus d’un mètre par an. De plus, un autre glissement moins important, situé plus haut, menaçait le village. Un éboulement s’est produit à la mi-juin 2023 sans faire trop de dégâts, car les autorités avaient auparavant évacué temporairement la population.', 'GlissementDeTerrain5.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (0, 0, 0, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Grisons', 'Albula', 'Brienz');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('2023-06-15', '2023-06-15');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO GlissementDeTerrain (IDCatastrophe, VolumeTombeeM3, Evacuation) VALUES (@IDCatastrophe, NULL, true);

INSERT INTO Description (Explication, image_name) VALUES ('Fin août, après de fortes chutes de pluie, un glissement de terrain s’étendant sur plus de 400 mètres s’est produit au-dessus de Schwanden (GL). Près de 100 personnes ont pu être évacuées à temps. Au total, 38 bâtiments ont été ensevelis ou détruits.', 'GlissementDeTerrain6.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (0, 0, 38, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Glaris', 'Glaris-Sud', 'Schwanden');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('2023-08-00', '2023-08-00');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO GlissementDeTerrain (IDCatastrophe, VolumeTombeeM3, Evacuation) VALUES (@IDCatastrophe, 400, true);

--Grele

INSERT INTO Description (Explication, image_name) VALUES ('Une année noire pour l’assurance agricole contre la grêle : la compagnie, qui n’était pas encore réassurée, a dû verser des indemnités de 6,7 millions de francs alors que les primes encaissées se montaient à 3,3 millions de francs.', 'Grele1.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (0, 0, NULL, 6.7);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES (NULL, 'Suisse', NULL);
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('1927-00-00', '1927-08-00');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Grele (IDCatastrophe, DiametreGrelonCM) VALUES (@IDCatastrophe, NULL);

INSERT INTO Description (Explication, image_name) VALUES ('Une année record pour les statistiques sur la grêle : le 10 août, un orage de grêle a notamment traversé la région de la Haute-Borne dans le Jura. Des grêlons de la taille de balles de tennis sont tombés à Bassecourt et Pleigne, près de Delémont.', 'Grele2.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (0, 0, NULL, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Jura', 'Haute-Borne', 'Bassecourt, Pleigne');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('1994-08-10', '1994-08-10');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Grele (IDCatastrophe, DiametreGrelonCM) VALUES (@IDCatastrophe, 6);

INSERT INTO Description (Explication, image_name) VALUES ('Les fronts de grêle du 26 mai et du 23 juillet ont laissé derrière eux les traces d’une dévastation. Des grêlons de la taille d’une balle de tennis (> 5 cm) se sont abattus en Suisse romande ; des vents violents et des pluies abondantes ont en outre été enregistrés. Pour les assurances, le coût des dommages s’est élevé à 380 millions de francs pour les véhicules, à plus de 300 millions de francs pour les bâtiments et à environ 10 millions de francs pour l’agriculture.', 'Grele3.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (0, 0, NULL, 690);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES (NULL, 'Suisse romande', NULL);
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('2009-05-26', '2009-07-23');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Grele (IDCatastrophe, DiametreGrelonCM) VALUES (@IDCatastrophe, 5);

INSERT INTO Description (Explication, image_name) VALUES ('Les 12 et 13 juillet, un orage de grêle avec des grêlons d’une taille avoisinant parfois celle d’une balle de tennis s’est abattu vers minuit sur Zofingen (AG) et certaines parties du canton de Zurich. Une analyse montre que cet événement fait partie des orages de grêle les plus puissants jamais enregistrés dans le canton d’Argovie. Les dommages aux bâtiments assurés se sont élevés, à eux seuls, à environ 200 millions de francs (dont 150 millions de francs dans le canton d’AG).', 'Grele4.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (0, 0, NULL, 200);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Argovie', 'Zurich', 'Zofingen');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('2011-07-12', '2011-07-13');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Grele (IDCatastrophe, DiametreGrelonCM) VALUES (@IDCatastrophe, 6);

INSERT INTO Description (Explication, image_name) VALUES ('Le 28 juin, la région de Wolhusen (LU) a connu un épisode de grêle extrême avec des grêlons mesurant jusqu’à 9 cm de diamètre. Bon nombre de toitures et d’installations photovoltaïques ont été détruites sur de vastes surfaces. Les pluies qui ont suivi ont rendu certains bâtiments inhabitables. Au total, les dommages aux bâtiments, aux voitures et aux cultures agricoles se sont élevés à plus de 600 millions de francs.', 'Grele5.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (0, 0, NULL, 600);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Lucerne', 'Suisse centrale', 'Wolhusen');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('2021-06-28', '2021-06-28');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Grele (IDCatastrophe, DiametreGrelonCM) VALUES (@IDCatastrophe, 9);

--tempete

INSERT INTO Description (Explication, image_name) VALUES ('Le 26 août, une tornade a dévasté la Vallée de Joux. La tempête, dont les vents ont atteint des pointes jusqu’à 300 km/h, a provoqué des dégâts s’étendant sur 23 km ; 40 maisons ont été entièrement détruites, 20 personnes ont été blessées et 100 se sont retrouvées sans abri.', 'Tempete1.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (0, 20, 40, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Vaud', 'Vallee de Joux', NULL);
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('1971-08-26', '1971-08-26');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Tempete (IDCatastrophe, VitesseVentMaxKMH, NomTempete) VALUES (@IDCatastrophe, 300, NULL);

INSERT INTO Description (Explication, image_name) VALUES ('Entre le 25 et le 27 février, la tempête hivernale Vivian s’est abattue sur une grande partie de l’Europe. En Suisse, les rafales ont atteint 160 km/h sur le Plateau, occasionnant des dégâts considérables, d’environ un milliard de francs, aux forêts et aux bâtiments. La tempête a fait 64 morts en Europe.', 'Tempete2.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (NULL, NULL, NULL, 1000);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES (NULL, 'Plateau suisse', NULL);
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('1990-02-25', '1990-02-27');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Tempete (IDCatastrophe, VitesseVentMaxKMH, NomTempete) VALUES (@IDCatastrophe, 160, 'Vivian');

INSERT INTO Description (Explication, image_name) VALUES ('Le 26 décembre, la tempête hivernale Lothar a balayé le Plateau avec des rafales de vent atteignant 140 km/h sur une grande partie du territoire. Les dommages totaux se sont élevés à quelque 1,5 milliard de francs (dommages à la forêt et dommages matériels assurés à l’époque).', 'Tempete3.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (NULL, NULL, NULL, 1500);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES (NULL, 'Plateau suisse', NULL);
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('1999-12-26', '1999-12-26');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Tempete (IDCatastrophe, VitesseVentMaxKMH, NomTempete) VALUES (@IDCatastrophe, 140, 'Lothar');

INSERT INTO Description (Explication, image_name) VALUES ('Les 2 et 3 janvier, la tempête hivernale Eleanor a traversé l’Europe à une vitesse allant jusqu’à 195 km/h et provoquant, en Suisse, des dommages s’élevant à 500 millions de francs. La tempête, associée à la fonte des neiges qu’elle avait provoquée, a entraîné des crues.', 'Tempete4.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (NULL, NULL, NULL, 500);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES (NULL, 'Suisse', NULL);
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('2018-01-02', '2018-01-03');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Tempete (IDCatastrophe, VitesseVentMaxKMH, NomTempete) VALUES (@IDCatastrophe, 195, 'Eleanor');

INSERT INTO Description (Explication, image_name) VALUES ('Le 24 juillet, une cellule orageuse a provoqué de violentes rafales de vent et des dommages considérables à La Chaux-de-Fonds et au Locle. Dans le Jura neuchâtelois, le downburst a endommagé 4500 bâtiments, dont 40 gravement. Le montant des dégâts matériels s’élève à plus de 100 millions de francs.', 'Tempete5.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (NULL, NULL, 40, 100);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Neuchatel', 'Jura Neuchatelois', 'Chaux-de-Fonds, Locle');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('2023-07-24', '2023-07-24');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Tempete (IDCatastrophe, VitesseVentMaxKMH, NomTempete) VALUES (@IDCatastrophe, 217, NULL);

--canicule

INSERT INTO Description (Explication, image_name) VALUES ('Le 11 août, une température record de 41 °C a été enregistrée à Grono, dans le Misox grison. Dans le reste de la Suisse, les températures ont dépassé les 33 °C durant douze jours d’affilée à partir du 1er août. Selon un rapport de l’Institut tropical et de santé publique suisse (Swiss TPH), ce fut l’année la plus chaude en Europe depuis 500 ans ; 1402 décès liés à la chaleur ont été enregistrés.', 'Canicule1.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (1402, 0, NULL, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Grison', 'Val Mesolcina', 'Grono');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('2003-08-11', '2003-08-11');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Canicule (IDCatastrophe, TemperatureMaxDegre) VALUES (@IDCatastrophe, 41);

INSERT INTO Description (Explication, image_name) VALUES ('Selon MétéoSuisse, l’été 2015 est entré dans l’histoire des mesures comme le deuxième été le plus chaud depuis plus de 150 ans. Deux vagues de chaleur ont été enregistrées : la première du 1er au 7 juillet, la seconde du 14 au 23 juillet, qui ont causé 747 décès liés à la chaleur.', 'Canicule2.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (747, 0, NULL, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES (NULL, 'Suisse', NULL);
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('2015-07-01', '2015-07-23');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Canicule (IDCatastrophe, TemperatureMaxDegre) VALUES (@IDCatastrophe, NULL);

INSERT INTO Description (Explication, image_name) VALUES ('La Suisse a de nouveau connu cette année-là un été exceptionnellement chaud après ceux de 2003 et 2015. Les températures élevées ont provoqué 391 décès liés à la chaleur.', 'Canicule3.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (391, 0, NULL, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES (NULL, 'Suisse', NULL);
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('2018-07-01', '2018-08-30');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Canicule (IDCatastrophe, TemperatureMaxDegre) VALUES (@IDCatastrophe, NULL);

INSERT INTO Description (Explication, image_name) VALUES ('L’été 2019 est considéré comme le troisième été le plus chaud depuis le début des mesures en 1864. Deux vagues de chaleur intenses, avec une température maximale moyenne de 32 à 34 °C, ont marqué les mois de juin et de juillet ; 336 décès liés à la chaleur ont été enregistrés.', 'Canicule4.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (336, 0, NULL, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES (NULL, 'Suisse', NULL);
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('2019-06-01', '2019-07-31');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Canicule (IDCatastrophe, TemperatureMaxDegre) VALUES (@IDCatastrophe, 34);

INSERT INTO Description (Explication, image_name) VALUES ('L’été 2022 entrera dans l’histoire comme le deuxième été le plus chaud depuis le début des mesures. Marquées par trois épisodes de chaleur extrême, les températures des mois de juin à août ont été supérieures à la normale de 2,3 °C, entraînant 474 décès liés à la chaleur. Seul l’été caniculaire de 2003 avait jusqu’à présent dépassé la normale de 3 °C.', 'Canicule5.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (474, 0, NULL, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES (NULL, 'Suisse', NULL);
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('2022-06-01', '2022-08-30');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Canicule (IDCatastrophe, TemperatureMaxDegre) VALUES (@IDCatastrophe, NULL);

--Eboulement

INSERT INTO Description (Explication, image_name) VALUES ('L’éboulement de Goldau (SZ) est, avec le tremblement de terre de Bâle (en 1356), la plus grande catastrophe naturelle jamais survenue en Suisse. Le 2 septembre, l’écroulement du Rossberg a détruit des villages entiers en l’espace de quelque trois minutes et tué 457 personnes et 323 animaux.', 'Eboulement1.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (457, NULL, NULL, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Schwytz', 'Suisse centrale', 'Goldau');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('1806-09-02', '1806-09-02');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Eboulement (IDCatastrophe, VolumeRocheM3) VALUES (@IDCatastrophe, NULL);

INSERT INTO Description (Explication, image_name) VALUES ('Bien que l’éboulement d’Elm (GL), dont les conséquences ont été dévastatrices, ait été annoncé, plus de 110 personnes sont mortes le 11 septembre, bon nombre d’entre elles parce qu’elles voulaient assister au spectacle de la catastrophe naturelle. À cause de l’exploitation des carrières d’ardoise et du temps pluvieux persistant, 10 millions de m3 de roche se sont déversés dans la vallée ; 83 bâtiments, 4 ponts et 90 ha de terres cultivées ont été détruits.', 'Eboulement2.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (110, NULL, 83, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Glaris', 'Suisse orientale', 'Elm');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('1806-09-02', '1806-09-02');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Eboulement (IDCatastrophe, VolumeRocheM3) VALUES (@IDCatastrophe, 10000000);

INSERT INTO Description (Explication, image_name) VALUES ('Le 18 avril et le 9 mai, deux éboulements d’un volume total de 30 millions de m3 se sont produits près de Randa (VS). La ligne de chemin de fer et la liaison routière en direction de Zermatt ont été interrompues, la Viège a été obstruée, provoquant un embâcle. Toutefois, personne n’a été blessé.', 'Eboulement3.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (0, 0, NULL, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Valais', 'Haut-Valais', 'Randa');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('1991-04-18', '1991-05-09');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Eboulement (IDCatastrophe, VolumeRocheM3) VALUES (@IDCatastrophe, 30000000);

INSERT INTO Description (Explication, image_name) VALUES ('La zone en amont de Preonzo, près de Bellinzone (TI), était en mouvement depuis des années lorsqu’en avril, le canton a constaté une activité accrue. La zone concernée en aval a donc été évacuée et la route cantonale fermée. Le 15 mai, aux premières heures du matin, une partie de la falaise - environ 220 000 m3 de roche - s’est effondrée dans la vallée. L’évacuation de la zone a permis d’éviter les blessés.', 'Eboulement4.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (0, 0, NULL, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Tessin', 'Bellinzone', 'Preonzo');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('2012-05-15', '2012-05-15');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Eboulement (IDCatastrophe, VolumeRocheM3) VALUES (@IDCatastrophe, 220000);

INSERT INTO Description (Explication, image_name) VALUES ('Le 23 août, trois à quatre millions de mètres cubes de roche se sont détachés du Piz Cengalo dans le Val Bregaglia (GR). Plusieurs laves torrentielles se sont ensuite déversées jusqu’au village de Bondo. Huit personnes ont perdu la vie sur un sentier de randonnée. Il s’agit de l’un des plus grands écroulements de ces 100 dernières années. La majeure partie du village a été épargnée grâce à un bassin de rétention des matériaux charriés.', 'Eboulement5.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (8, 0, NULL, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Grison', 'Val Bregaglia', 'Bondo');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('2017-08-23', '2017-08-23');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Eboulement (IDCatastrophe, VolumeRocheM3) VALUES (@IDCatastrophe, 4000000);

--Crue

INSERT INTO Description (Explication, image_name) VALUES ('L’Aar a atteint son niveau le plus élevé jamais enregistré, ce qui a également entraîné une forte montée des eaux du Rhin. Lors de cette crue, le Seeland a été particulièrement touché et les démarches entreprises en faveur d’une correction des eaux du Jura ont profité d’un nouvel élan.', 'Crue1.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (NULL, NULL, NULL, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Berne', 'Seeland', NULL);
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('1852-00-00', '1852-00-00');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Crue (IDCatastrophe, CourtDEau) VALUES (@IDCatastrophe, 'Aar');

INSERT INTO Description (Explication, image_name) VALUES ('Le 24 juillet, après de fortes pluies, un petit ruisseau s’est transformé en lave torrentielle et a enseveli un campement près de Domat-Ems (GR), dans lequel séjournaient des enfants. Bon nombre d’entre eux ont pu s’échapper, mais six fillettes sont décédées.', 'Crue2.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (6, 0, NULL, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Grisons', 'Imboden', 'Domat-Ems');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('1981-07-24', '1981-07-24');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Crue (IDCatastrophe, CourtDEau) VALUES (@IDCatastrophe, NULL);

INSERT INTO Description (Explication, image_name) VALUES ('En août 1987, la Suisse était en état d’urgence: dans quasiment toutes les vallées, routes, habitations, infrastructures ou terres agricoles ont subi de gros dommages. Au total, les dégâts causés par les crues se sont élevés à 800 millions de francs.', 'Crue3.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (NULL, NULL, NULL, 800);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES (NULL, 'Suisse', NULL);
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('1987-08-00', '1987-08-00');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Crue (IDCatastrophe, CourtDEau) VALUES (@IDCatastrophe, NULL);

INSERT INTO Description (Explication, image_name) VALUES ('Le 24 septembre, après plusieurs semaines de précipitations suivies de trois jours de pluie diluvienne, la Saltine est sortie de son lit à Brigue. Des matériaux charriés et du bois flottant se sont accumulés au niveau du pont situé en plein centre de la ville, provoquant un embâcle. En se retirant, les eaux ont laissé derrière elles plusieurs mètres de sable et de matériaux charriés dans les rues, sur les places et dans les bâtiments. Deux personnes ont perdu la vie. Les dégâts matériels provoqués par cet événement se sont montés à plus de 650 millions de francs.', 'Crue4.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (2, NULL, NULL, 650);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Valais', 'Haut-Valais', 'Brigue');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('1993-09-24', '1993-09-24');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Crue (IDCatastrophe, CourtDEau) VALUES (@IDCatastrophe, 'Staline');

INSERT INTO Description (Explication, image_name) VALUES ('Les inondations du mois d’août ont fait six morts en Suisse. Elles ont causé des dommages matériels à hauteur de 3 milliards de francs. Ces dommages financiers ont été les plus élevés depuis le recensement systématique mis en place en 1972. Environ 900 communes ont été touchées. Des localités telles qu’Engelberg ou Lauterbrunnen ont été coupées du monde pendant plusieurs jours. À Berne, l’Aar est sortie de son lit et a inondé le quartier de la Matte.', 'Crue5.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (6, NULL, NULL, 3000);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES (NULL, 'Suisse', 'Engelberg, Lauterbrunnen, Bern');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('2005-08-00', '2005-08-00');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Crue (IDCatastrophe, CourtDEau) VALUES (@IDCatastrophe, 'Aar');

INSERT INTO Description (Explication, image_name) VALUES ('Un autre événement important ayant touché une grande partie du Plateau et du Jura suisse furent les crues des 8 et 9 août. Le système de régulation des lacs du Pied du Jura ainsi que de l’Aar, située en aval, considéré comme présentant une protection efficace contre les crues, a été surchargé. La Birse s’est transformée en une rivière tumultueuse qui a inondé la vieille ville de Laufon (BL).', 'Crue6.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (NULL, NULL, NULL, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Bale', 'Plateau suisse', 'Laufen');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('2007-08-08', '2007-08-09');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Crue (IDCatastrophe, CourtDEau) VALUES (@IDCatastrophe, 'Birse');

--avalanche

INSERT INTO Description (Explication, image_name) VALUES ('Au cours des mois de février et de mars, plus de 1000 avalanches particulièrement destructrices se sont produites en Suisse. Les cantons du Tessin, des Grisons et du Valais ont été les plus touchés. Les conséquences ont été catastrophiques : 49 personnes et 700 têtes de bétail ont péri et 850 bâtiments et 1325 hectares de forêt ont été détruits. Après cet hiver, les événements ont commencé à être documentés. Ce cadastre des événements a constitué une base importante pour le développement de la cartographie des avalanches.', 'Avalanche1.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (49, NULL, 850, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Tessin, Grisons, Valais', 'Suisse', NULL);
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('1888-02-01', '1888-03-31');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Avalanche (IDCatastrophe) VALUES (@IDCatastrophe);

INSERT INTO Description (Explication, image_name) VALUES ('Entre le 16 et le 21 janvier, il est tombé entre 100 et 250 cm de neige fraîche sur une grande partie du territoire au nord de la crête principale des Alpes. Par la suite, une grande partie des Alpes suisses a été touchée par de grosses avalanches. Sur l’ensemble de l’hiver, environ 1500 avalanches se sont produites, faisant 98 morts. Quelque 1500 bâtiments ont été détruits. L’hiver avalancheux de 1951 est considéré comme l’événement du siècle. La prévision des avalanches et la recherche sur les mesures de protection ont ensuite été améliorées. La première carte de dangers d’avalanche de Suisse a été établie en 1953.', 'Avalanche2.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (78, NULL, 1500, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES (NULL, 'Alpes suisse', NULL);
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('1951-01-16', '1951-01-21');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Avalanche (IDCatastrophe) VALUES (@IDCatastrophe);

INSERT INTO Description (Explication, image_name) VALUES ('Le 24 février, une avalanche s’est déclenchée dans le Bächital et s’est abattue sur le village de Reckingen (VS), faisant 30 morts. Elle a surpris les habitants dans leur sommeil et enseveli au total 48 personnes. Parmi les morts, on comptait 11 civils et 19 soldats des troupes de défense aérienne. Il s’agit de l’avalanche la plus meurtrière du 20<sup>e</sup> siècle en Suisse. Après cette catastrophe, les mesures de sécurité ont été renforcées, notamment par la construction de deux digues paravalanches.', 'Avalanche3.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (30, NULL, NULL, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Valais', 'Haut-Valais ', 'Reckingen');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('1970-02-24', '1970-02-24');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Avalanche (IDCatastrophe) VALUES (@IDCatastrophe);

INSERT INTO Description (Explication, image_name) VALUES ('Au cours de cet hiver, près de 1200 grosses avalanches se sont produites dans les Alpes, détruisant près de 1700 bâtiments et tuant 17 personnes. Les dégâts matériels ‒ dommages importants aux forêts, routes ensevelies et pylônes de lignes électriques endommagés ‒ se sont élevés à plus de 600 millions de francs. L’avalanche la plus meurtrière s’est produite à Évolène, dans le Val d’Hérens (VS), faisant 12 victimes, et 5 autres personnes ont perdu la vie dans des avalanches près de Bristen (UR), Geschinen (VS), Wengen (BE) et Lavin (GR). Le « Système intercantonal de préalerte précoce et d’information en cas de crise (IFKIS) » a été créé à la suite de ces événements. ', 'Avalanche4.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (17, NULL, 1700, 600);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Valais, Uri, Berne, Grisons', 'Alpes suisse', 'Evolene, Bristen, Geschinen, Wengen, Lavin');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('1998-12-01', '1999-03-31');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Avalanche (IDCatastrophe) VALUES (@IDCatastrophe);

INSERT INTO Description (Explication, image_name) VALUES ('Le 3 janvier, une plaque de neige s’est détachée dans le Diemtigtal (Oberland bernois) lors du passage d’un groupe de huit randonneurs à ski montant au « Drümännler » et a emporté plusieurs personnes. La deuxième catastrophe s’est produite pendant les opérations de sauvetage : une nouvelle avalanche a dévalé la pente adjacente, ensevelissant douze personnes. Une troisième avalanche, probablement déclenchée par deux autres randonneurs, s’est produite simultanément à 250 mètres du lieu de l’accident. Sept personnes sont mortes, dont le médecin de la Rega.', 'Avalanche5.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (7, NULL, NULL, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Berne', 'Oberland bernois', 'Diemtigtal');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('2010-01-03', '2010-01-03');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Avalanche (IDCatastrophe) VALUES (@IDCatastrophe);

--incendie de foret

INSERT INTO Description (Explication, image_name) VALUES ('Le 20 août, l’un des plus grands incendies de forêt survenus en Suisse a détruit environ 550 hectares de forêt dans le massif du Calanda près de Coire (GR). Le feu a fait rage pendant trois jours et trois nuits ; plus de 3600 pompiers ont été mobilisés.', 'Incendie1.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (NULL, NULL, NULL, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Grisons', 'Massif du Calanda', 'Coire');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('1943-08-20', '1943-08-23');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Incendie (IDCatastrophe, HABrulee) VALUES (@IDCatastrophe, 550);

INSERT INTO Description (Explication, image_name) VALUES ('Dans le sud de la Suisse, 180 incendies de forêt ont été enregistrés, constituant un record pour ce siècle. Environ 1600 hectares de forêt ont été détruits par les flammes.', 'Incendie2.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (NULL, NULL, NULL, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES (NULL, 'Sud de la Suisse', NULL);
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('1973-00-00', '1973-00-00');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Incendie (IDCatastrophe, HABrulee) VALUES (@IDCatastrophe, 1600);

INSERT INTO Description (Explication, image_name) VALUES ('L’incendie de forêt survenu au printemps à Ronco sopra Ascona (TI) illustre de manière frappante les conséquences qu’un feu de forêt peut avoir. En plus de ravager plus de 100 hectares de forêt, il a endommagé au moins 200 hectares de forêt de protection. Quelques semaines plus tard, lors d’orages accompagnés de fortes pluies, la fonction protectrice de la forêt a fait défaut. Une avalanche de boue s’est déclenchée, causant d’importants dégâts.', 'Incendie3.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (NULL, NULL, NULL, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Tessin', 'Tessin', 'Ronco sopra Ascona');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('1997-04-00', '1997-06-00');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Incendie (IDCatastrophe, HABrulee) VALUES (@IDCatastrophe, 300);

INSERT INTO Description (Explication, image_name) VALUES ('L’un des plus grands incendies de forêt en Suisse s’est déclaré les 13 et 14 août dans la forêt protectrice située au-dessus de Loèche (VS). Porté par les vents de montagne ascendants, le feu s’est rapidement propagé jusqu’à la limite de la forêt. Environ 300 à 400 hectares de forêt ont été détruits, entraînant l’évacuation de 260 personnes. Les dégâts matériels causés par l’incendie ont été estimés à environ 7,6 millions de francs.', 'Incendie4.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (NULL, NULL, NULL, 7.6);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Valais', 'Bassin Leman', 'Loeche');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('2003-08-13', '2003-08-14');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Incendie (IDCatastrophe, HABrulee) VALUES (@IDCatastrophe, 400);

INSERT INTO Description (Explication, image_name) VALUES ('Le 2 avril, un incendie s’est déclaré au-dessus de Viège (VS). La combinaison d’une sécheresse exceptionnelle et de vents forts a favorisé la propagation rapide du feu. Heureusement, grâce à l’intervention rapide et importante de l’armée, l’incendie de forêt a été maîtrisé rapidement. Cependant, plus de 100 hectares de forêt de protection ont été détruits lors de cet incident.', 'Incendie5.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (NULL, NULL, NULL, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Valais', 'Haut-Valais ', 'Viege');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('2011-04-02', '2011-04-02');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Incendie (IDCatastrophe, HABrulee) VALUES (@IDCatastrophe, 100);

INSERT INTO Description (Explication, image_name) VALUES ('L’incendie de forêt au-dessus de la commune de Bitsch (VS) a causé la destruction de plus de 100 hectares de forêt. Cette perte a compromis en partie la fonction de protection de la forêt, ce qui pourrait entraîner une augmentation des risques de chutes de pierres dans la région.', 'Incendie6.jpg');
SET @IDDescription = LAST_INSERT_ID();
INSERT INTO Statistique (NBVictime, NBBlesse, NBBatimentDetruit, CoutDegatMillionFR) VALUES (NULL, NULL, NULL, NULL);
SET @IDStatistique = LAST_INSERT_ID();
INSERT INTO Lieu (Canton, Region, Localite) VALUES ('Valais', 'Haut-Valais ', 'Bitsch');
SET @IDLieu = LAST_INSERT_ID();
INSERT INTO Duree (DateDebut, DateFin) VALUES ('2023-00-00', '2023-00-00');
SET @IDDuree = LAST_INSERT_ID();
INSERT INTO CatastropheNaturelle (IDDuree, IDLieu, IDStatistique, IDDescription) VALUES (@IDDuree, @IDLieu, @IDStatistique, @IDDescription);
SET @IDCatastrophe = LAST_INSERT_ID();
INSERT INTO Incendie (IDCatastrophe, HABrulee) VALUES (@IDCatastrophe, 100);