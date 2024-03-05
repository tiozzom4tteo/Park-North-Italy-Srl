/*
    Visto che abbiamo riscontrato problemi con l'importazione del backup del database fatto seguendo le istruzioni da voi date, 
    per sicurezza abbiamo preferito fornire il codice necessario alla creazione e al popolamento del database. In fondo al file 
    sono contenuti degli esempi delle query che si possono effettuare in questo database.
*/

drop table if exists Cliente cascade;
drop table if exists BigliettoTour cascade;
drop table if exists BigliettoEvento cascade;
drop table if exists Evento cascade;
drop table if exists TourGuidato cascade;
drop table if exists Parco cascade;
drop table if exists Area cascade;
drop table if exists Pianta cascade;
drop table if exists Animale cascade;
drop table if exists Dipendente cascade;
drop index if exists indicePianta;
drop index if exists indiceAnimale;


CREATE TABLE Cliente (
codiceFiscale VARCHAR(255),
nome VARCHAR(255) NOT NULL,
cognome VARCHAR(255) NOT NULL,
dataNascita TIMESTAMP,
PRIMARY KEY(codiceFiscale)
);

CREATE TABLE Parco (
nome VARCHAR(255),
luogo VARCHAR(255) NOT NULL,
dimensione DOUBLE PRECISION,
PRIMARY KEY(nome)
);

CREATE TYPE enumDipendente AS ENUM ('Guida', 'Ricercatore', 'Responsabile', 'Organizzatore', 'Manutenzione', 'Sicurezza');
CREATE TABLE Dipendente (
id SERIAL,
nome VARCHAR(255) NOT NULL,
cognome VARCHAR(255) NOT NULL,
dataNascita TIMESTAMP,
guadagno DOUBLE PRECISION NOT NULL,
tipoDipendente enumDipendente NOT NULL,
lingueParlate VARCHAR(255),
specializzazione VARCHAR(255),
compitoSpecifico VARCHAR(255),
corsiFrequentati VARCHAR(255),
parco varchar(255),
PRIMARY KEY(id),
FOREIGN KEY (parco) REFERENCES Parco(nome) ON UPDATE CASCADE
);
ALTER TABLE Dipendente ADD CHECK ((tipoDipendente = 'Guida' AND lingueParlate IS NOT NULL) OR (tipoDipendente = 'Ricercatore' AND specializzazione IS NOT NULL)
OR (tipoDipendente = 'Manutenzione' AND compitoSpecifico IS NOT NULL) OR (tipoDipendente = 'Sicurezza' AND corsiFrequentati IS NOT NULL)
OR (tipoDipendente = 'Responsabile') OR (tipoDipendente = 'Organizzatore'));

CREATE TYPE enumTour AS ENUM ('Flora', 'Fauna');
CREATE TABLE TourGuidato (
id VARCHAR(255),
numeroPersone INT NOT NULL,
data TIMESTAMP NOT NULL,
tipoTour enumTour NOT NULL,
PRIMARY KEY(id)
);

CREATE TABLE Spiega(
dipendente SERIAL,
tour VARCHAR(255),
PRIMARY KEY(dipendente, tour),
FOREIGN KEY(dipendente) REFERENCES Dipendente(id)  ON UPDATE CASCADE,
FOREIGN KEY(tour) REFERENCES TourGuidato(id) ON UPDATE CASCADE
);

CREATE TABLE BigliettoTour (
id SERIAL,
ridotto BOOLEAN NOT NULL,
data TIMESTAMP NOT NULL,
prezzo DOUBLE PRECISION NOT NULL,
codiceFiscaleCliente VARCHAR(255),
tour VARCHAR(255),
parco VARCHAR(255),
PRIMARY KEY(id),
FOREIGN KEY (codiceFiscaleCliente) REFERENCES Cliente (codiceFiscale) ON UPDATE CASCADE,
FOREIGN KEY (tour) REFERENCES TourGuidato (id) ON UPDATE CASCADE,
FOREIGN KEY (parco) REFERENCES Parco (nome) ON UPDATE CASCADE
);
ALTER TABLE BigliettoTour ADD CHECK (prezzo > 0);

CREATE TYPE enumEvento AS ENUM ('Musicale', 'Artistico', 'Naturalistico');
CREATE TABLE Evento (
id VARCHAR(255),
numeroPersone INT NOT NULL,
data TIMESTAMP NOT NULL,
tipoEvento enumEvento NOT NULL,
organizzatore INT,
PRIMARY KEY(id),
FOREIGN KEY (organizzatore) REFERENCES Dipendente (id) ON UPDATE CASCADE
);

CREATE TABLE BigliettoEvento (
id SERIAL,
ridotto BOOLEAN NOT NULL,
data TIMESTAMP NOT NULL,
prezzo DOUBLE PRECISION NOT NULL,
codiceFiscaleCliente VARCHAR(255),
evento VARCHAR(255),
parco VARCHAR(255),
PRIMARY KEY(id),
FOREIGN KEY (codiceFiscaleCliente) REFERENCES Cliente (codiceFiscale) ON UPDATE CASCADE,
FOREIGN KEY (evento) REFERENCES Evento (id) ON UPDATE CASCADE,
FOREIGN KEY (parco) REFERENCES Parco (nome) ON UPDATE CASCADE
);
ALTER TABLE BigliettoEvento ADD CHECK (prezzo > 0);

CREATE TABLE Area (
id SERIAL,
nome VARCHAR(255) NOT NULL,
posizione VARCHAR(255) NOT NULL,
parco VARCHAR(255) NOT NULL,
responsabile INT NOT NULL,
PRIMARY KEY(id),
FOREIGN KEY (parco) REFERENCES Parco (nome) ON UPDATE CASCADE,
FOREIGN KEY (responsabile) REFERENCES Dipendente (id) ON UPDATE CASCADE
);

CREATE TYPE enumFoglie AS ENUM('Filiformi', 'Aghiformi', 'Oblunghe', 'Ovali', 'Seghettate');
CREATE TABLE Pianta (
id VARCHAR(255),
descrizione VARCHAR(255),
nomeLatino VARCHAR(255) NOT NULL,
acquaNecessaria DOUBLE PRECISION NOT NULL,
locazione VARCHAR(255) NOT NULL,
tipoFoglie enumFoglie,
dataTrapianto TIMESTAMP NOT NULL,
età SMALLINT,
area INT,
PRIMARY KEY(id),
FOREIGN KEY (area) REFERENCES Area(id) ON UPDATE CASCADE
);

CREATE TYPE enumClasseAnimale AS ENUM('Mammifero', 'Pesce', 'Uccello', 'Rettile','Anfibio', 'Porifero', 'Celenterato', 'Artropode', 'Mollusco', 'Verme', 'Echinoderma');
CREATE TYPE enumAlimentazione AS ENUM('Carnivoro', 'Erbivoro', 'Onnivoro');
CREATE TABLE Animale (
id VARCHAR(255),
descrizione VARCHAR(255),
nomeLatino VARCHAR(255) NOT NULL,
alimentazione enumAlimentazione NOT NULL,
dataNascita TIMESTAMP NOT NULL,
età SMALLINT,
classe enumClasseAnimale NOT NULL,
famiglia VARCHAR(255),
area INT,
PRIMARY KEY(id),
FOREIGN KEY (area) REFERENCES Area(id) ON UPDATE CASCADE
);

CREATE UNIQUE INDEX indicePianta ON Pianta(id,descrizione, nomeLatino, acquaNecessaria, locazione);
CREATE UNIQUE INDEX indiceAnimale ON Animale(id,descrizione, nomeLatino, alimentazione, dataNascita);




--Popolamento del database:
insert into Cliente (codiceFiscale, nome, cognome, dataNascita) values 
('610-86-1925', 'Tucker', 'Gerish', '1993-06-07'),
('850-20-1383', 'Cordi', 'Nettle', '1998-07-11'),
('542-70-7587', 'Darius', 'Assad', '1997-06-05'),
('624-83-2281', 'Elinor', 'Scholig', '1987-08-30'),
('321-59-4010', 'Johna', 'Dibbe', '1989-07-07'),
('462-45-2627', 'Immanuel', 'Leworthy', '2001-02-10'),
('447-75-9453', 'Darren', 'Mee', '1999-09-26'),
('603-97-2041', 'Meggy', 'Curson', '1985-04-21'),
('383-58-9178', 'Alford', 'Wittey', '1996-02-09'),
('429-90-5672', 'Hercule', 'Ray', '1997-04-23'),
('168-57-6934', 'Jeralee', 'Yakov', '1991-03-29'),
('716-10-6207', 'Grace', 'Ewles', '2001-01-24'),
('864-39-9520', 'Wilmar', 'Coil', '2005-08-23'),
('817-56-2969', 'Alair', 'Jain', '2001-02-12'),
('274-11-5075', 'Ludvig', 'Zavattero', '1988-02-05'),
('568-72-0542', 'Martainn', 'Kupisz', '1996-09-05'),
('339-79-6748', 'Tucky', 'Ivan', '1996-10-27'),
('437-46-6883', 'Andriana', 'Hook', '1990-08-07'),
('390-62-9877', 'Letizia', 'Sloegrave', '1995-12-09'),
('218-29-5617', 'Boyce', 'Calvert', '1994-04-14'),
('791-87-5229', 'Rodolph', 'Sedge', '2001-06-19'),
('434-97-0717', 'Rosene', 'Trunby', '1985-02-08'),
('892-19-0009', 'Mahmud', 'Beverstock', '1992-04-10'),
('169-65-7563', 'Jake', 'Blade', '1998-08-25'),
('687-05-3528', 'Gleda', 'Langworthy', '1991-07-22'),
('123-12-7561', 'Corinna', 'Salling', '2002-02-04'),
('512-68-2495', 'Aurlie', 'Dell Casa', '1986-07-30'),
('651-18-3600', 'Timmie', 'Terram', '1998-12-09'),
('821-84-4678', 'Gael', 'Durrans', '1992-06-24'),
('404-87-7274', 'Robert', 'Guyot', '1991-07-31'),
('876-27-8044', 'Sibley', 'Venney', '2001-04-20'),
('168-77-9561', 'Donny', 'Bethell', '1994-08-04'),
('765-34-6733', 'Aldwin', 'McAline', '1992-08-08'),
('299-51-9664', 'Jobey', 'Bluck', '1989-12-01'),
('119-97-3751', 'Henrietta', 'Laux', '2001-01-18'),
('655-24-1339', 'Pauletta', 'Baccas', '2000-08-19'),
('277-06-0346', 'Janina', 'Altimas', '1991-10-15'),
('758-34-6771', 'Keenan', 'Desvignes', '1995-07-28'),
('329-68-0127', 'Warner', 'Thewles', '1985-08-16'),
('870-05-6425', 'Natka', 'Heavens', '1988-11-26'),
('699-29-0318', 'Luella', 'Chaperlin', '2005-06-21'),
('784-49-7651', 'Vitia', 'Ralestone', '2001-02-17'),
('154-56-9692', 'Gael', 'Corcut', '1997-06-17'),
('836-85-0679', 'Chrissie', 'Sparrow', '2004-04-07'),
('120-26-1291', 'Elsinore', 'Kehri', '1985-06-19'),
('707-89-6237', 'Meryl', 'Thurlby', '1997-08-13'),
('139-97-1893', 'Randa', 'Brompton', '1990-05-13'),
('423-07-2436', 'Myrlene', 'Knotte', '2000-07-21'),
('439-91-1723', 'Wood', 'Rymill', '1992-08-03'),
('680-13-5568', 'Flynn', 'Hrihorovich', '1995-02-28'),
('343-11-1370', 'Dalton', 'Harewood', '1987-04-15'),
('166-31-8683', 'Isaac', 'Dogerty', '2000-03-29'),
('480-69-2766', 'Gage', 'Jeaffreson', '1992-09-13'),
('492-59-8797', 'Marguerite', 'McGirl', '1996-08-23'),
('650-03-0408', 'Joshuah', 'Dolman', '2002-12-05'),
('464-17-9230', 'Alexander', 'Cawley', '1994-09-18'),
('590-26-4546', 'Rolland', 'Matthew', '1999-09-15'),
('253-62-4244', 'Jocelin', 'Toler', '1987-05-15'),
('612-54-6736', 'Gris', 'Poller', '1999-06-03'),
('449-55-3114', 'Winny', 'Agnew', '1990-02-21'),
('397-99-8395', 'Danny', 'Labone', '2003-05-21'),
('196-78-3197', 'Mayer', 'Spirit', '1994-08-12'),
('544-13-0833', 'Vidovic', 'Dreye', '1993-12-18'),
('713-37-7873', 'Sheffy', 'Stansby', '2005-09-12'),
('730-93-0076', 'Rebekah', 'Farra', '1993-07-26'),
('363-26-4065', 'Christa', 'Arnolds', '2005-02-18'),
('661-41-3101', 'Lavena', 'Bellino', '1992-03-11'),
('293-15-6901', 'Barbra', 'Enrdigo', '1989-10-21'),
('206-99-3195', 'Angelita', 'Breffit', '1995-11-11'),
('166-09-3544', 'Jan', 'Bearsmore', '1994-02-24'),
('126-36-9862', 'Tersina', 'Juschka', '2003-11-06'),
('830-81-4564', 'Marchall', 'Smiz', '1997-07-30'),
('218-97-3505', 'Orella', 'Burgyn', '1996-02-13'),
('724-82-7580', 'Phaidra', 'Buckthought', '1999-07-05'),
('143-30-5420', 'Vinny', 'Fortey', '1986-01-17'),
('231-46-4162', 'Naomi', 'Scocroft', '1990-11-29'),
('483-29-5126', 'Gary', 'Swett', '1991-09-19'),
('609-22-3888', 'Sawyer', 'Cumine', '1989-01-24'),
('237-53-9877', 'Dina', 'Likly', '1997-10-18'),
('121-64-6056', 'Tracie', 'Culpan', '2005-07-13'),
('391-74-6833', 'Faunie', 'Battershall', '1989-06-13'),
('100-30-1935', 'Raynard', 'Dils', '1994-09-17'),
('865-67-4633', 'Richmond', 'Krishtopaittis', '1996-04-08'),
('506-28-2861', 'Arel', 'Horick', '2004-03-22'),
('538-89-9886', 'Helga', 'Brown', '2002-05-07'),
('727-60-7349', 'Gillie', 'Bernot', '1992-07-13'),
('298-24-3122', 'Beniamino', 'Henri', '1986-03-05'),
('374-17-6525', 'Marcellina', 'Cullon', '1995-09-03'),
('808-22-3703', 'Doroteya', 'Lyndon', '2003-06-26'),
('784-21-8836', 'Lettie', 'Noller', '2003-03-25'),
('265-79-3790', 'Brook', 'Beazley', '2004-08-17'),
('152-19-0103', 'Ulises', 'Kobiela', '1992-06-19'),
('844-85-7794', 'Bette', 'Falk', '1992-09-17'),
('474-86-3989', 'Ferdy', 'Lagde', '2000-10-30'),
('813-19-2972', 'Dur', 'Bumphries', '1989-11-20'),
('522-31-4106', 'Ricky', 'Hartland', '1989-01-30'),
('316-40-0889', 'Stanislas', 'Wake', '1994-12-18'),
('142-46-4522', 'Sondra', 'Mancktelow', '1994-12-10'),
('581-26-6071', 'Sindee', 'Vaune', '1997-05-27'),
('520-88-6112', 'Derby', 'Simenon', '1995-03-13'),
('285-26-0230', 'Tomas', 'Webber', '1987-05-27'),
('826-33-6034', 'Suzanne', 'Bale', '2001-12-28'),
('783-22-5493', 'Abdul', 'Buckett', '1989-12-12'),
('544-97-5975', 'Fancie', 'Pfleger', '1991-03-10'),
('835-10-3948', 'Carina', 'Sauvain', '2003-11-10'),
('175-75-7878', 'Shirlee', 'Izakovitz', '2005-09-30'),
('531-01-5962', 'Dita', 'McGillreich', '1985-12-18'),
('738-26-1525', 'Craig', 'Overlow', '2004-06-26'),
('702-08-9656', 'Hazel', 'Guiver', '2002-11-17'),
('238-19-1124', 'Josee', 'Hampson', '2001-01-19'),
('131-89-1859', 'Robby', 'Byne', '2000-07-09'),
('377-04-2790', 'Rosana', 'Attkins', '1997-04-10'),
('173-46-0895', 'Marena', 'Breakwell', '1993-06-05'),
('818-30-2512', 'Powell', 'Moult', '1996-09-05'),
('631-71-6521', 'Morgen', 'Rossander', '1997-03-10'),
('168-07-9718', 'Hailee', 'Starling', '2004-01-08'),
('634-93-5729', 'Andria', 'Cardoso', '2001-04-20'),
('289-73-0768', 'Ally', 'Ealam', '2001-08-07'),
('325-80-9772', 'Miguel', 'Lindroos', '1990-12-09'),
('826-43-7893', 'Robbin', 'Sinnie', '1990-04-08');



insert into Parco (nome, luogo, dimensione) values 
('Parco Naturale del Gran Paradiso', 'Piemonte', 75690),
('Parco Nazionale di Camponogara', 'Venezia', 95486),
('Riserva Naturale Misquilese', 'Mussolente', 6087),
('Parco Nazionale dello Stelvio', 'Lombardia', 12420);



insert into Dipendente (id, nome, cognome, dataNascita, guadagno, tipoDipendente, lingueParlate, specializzazione, compitoSpecifico, corsiFrequentati, parco) values 
(1, 'Prescott', 'MacLaverty', '1987-12-11', 3419, 'Guida', 'Tedesco, Inglese, Italiano', NULL, NULL, 'Corso Inglese, Corso Tedesco', 'Parco Naturale del Gran Paradiso'),
(2, 'Avram', 'McGarahan', '2001-07-15', 3572, 'Guida','Tedesco, Inglese, Italiano', NULL, NULL, 'Corso Inglese, Corso Tedesco', 'Parco Naturale del Gran Paradiso'),
(3, 'Rooney', 'Housden', '2004-03-10', 1233, 'Responsabile', NULL, NULL, NULL, NULL, 'Parco Naturale del Gran Paradiso'),
(4, 'Brigit', 'Gopsell', '1997-11-09', 1662, 'Guida',  'Tedesco, Inglese, Italiano, Spagnolo', NULL, NULL, 'Corso Inglese, Corso Tedesco, Corso Spagnolo', 'Parco Naturale del Gran Paradiso'),
(5, 'Dyan', 'Itzkowicz', '1998-01-05', 2860, 'Guida', 'Tedesco, Inglese', NULL, NULL, 'Corso Tedesco', 'Parco Naturale del Gran Paradiso'),
(6, 'Carla', 'Kentish', '1991-05-31', 2459, 'Organizzatore', NULL, NULL, NULL, NULL, 'Parco Naturale del Gran Paradiso'),
(7, 'Georgeanne', 'Daintith', '1991-12-31', 2637, 'Organizzatore', NULL, NULL, NULL, NULL, 'Parco Naturale del Gran Paradiso'),
(8, 'Yelena', 'Moule', '1996-11-29', 2229, 'Manutenzione', NULL, NULL, 'Idraulico Elettricista Giardiniere', NULL, 'Parco Naturale del Gran Paradiso'),
(9, 'Davide', 'Tiozzo', '2001-04-04', 1740, 'Ricercatore', NULL, 'Zoologo', NULL, NULL, 'Parco Naturale del Gran Paradiso'),
(10, 'Trudi', 'Lofty', '1998-12-03', 3429, 'Sicurezza', NULL, NULL, NULL, 'Primo soccorso', 'Parco Naturale del Gran Paradiso'),
(11, 'Jenica', 'Halladay', '1997-03-31', 3467, 'Guida', 'Spagnolo, Inglese', NULL, NULL, 'Corso Spagnolo', 'Parco Nazionale di Camponogara'),
(12, 'Trina', 'Dodle', '1987-07-28', 1659, 'Guida', 'Spagnolo, Francese, Tedesco, Inglese', NULL, NULL, 'Corso Tedesco, Corso Spagnolo, Corso Francese', 'Parco Nazionale di Camponogara'),
(13, 'Sherline', 'Osipenko', '1994-03-27', 3904, 'Manutenzione', NULL, NULL, 'Idraulico Giardiniere', NULL, 'Parco Nazionale di Camponogara'),
(14, 'Roda', 'Graine', '1993-03-19', 1653, 'Ricercatore', NULL, 'Botanico', NULL, NULL, 'Parco Nazionale di Camponogara'),
(15, 'Salomo', 'Shanks', '2000-05-02', 3825, 'Sicurezza',  NULL, NULL, NULL, 'Primo soccorso', 'Parco Nazionale di Camponogara'),
(16, 'Harvey', 'Carlton', '1997-11-20', 4527, 'Guida', 'Tedesco, Francese, Italiano, Russo', NULL, NULL, 'Corso Tedesco, Corso Francese, Corso Russo', 'Parco Nazionale di Camponogara'),
(17, 'Link', 'Oran', '2004-06-05', 2291, 'Guida', 'Tedesco, Inglese', NULL, NULL, 'Corso Inglese', 'Parco Nazionale di Camponogara'),
(18, 'Kerby', 'Edmonstone', '2003-01-06', 4886, 'Responsabile',  NULL, NULL, NULL, NULL, 'Parco Nazionale di Camponogara'),
(19, 'Ronnie', 'St. Aubyn', '2005-10-16', 2298, 'Organizzatore', NULL, NULL, NULL, NULL, 'Parco Nazionale di Camponogara'),
(20, 'Nettle', 'Simmans', '1997-02-07', 3789, 'Organizzatore', NULL, NULL, NULL, NULL, 'Parco Nazionale di Camponogara'),
(21, 'Delmore', 'Battista', '1991-07-15', 4240, 'Responsabile',  NULL, NULL, NULL, NULL, 'Riserva Naturale Misquilese'),
(22, 'Clo', 'Keri', '1986-04-13', 3996, 'Organizzatore', NULL, NULL, NULL, NULL,  'Riserva Naturale Misquilese'),
(23, 'Jessamine', 'Meek', '1985-10-23', 1411, 'Guida', 'Spagnolo, Tedesco', NULL, NULL, 'Corso Spagnolo', 'Riserva Naturale Misquilese'),
(24, 'Dickie', 'Malkie', '1996-01-14', 2544, 'Ricercatore', NULL, 'Ornitologo', NULL, NULL, 'Riserva Naturale Misquilese'),
(25, 'Viviana', 'Ecob', '1992-04-24', 1700, 'Guida', 'Francese, Inglese', NULL, NULL, 'Corso Francese', 'Riserva Naturale Misquilese'),
(26, 'Hugibert', 'Batkin', '2003-05-16', 3505, 'Guida','Tedesco, Italiano, Inglese', NULL, NULL, 'Corso Tedesco, Corso Italiano', 'Riserva Naturale Misquilese'),
(27, 'Hi', 'Knights', '2001-06-30', 1959, 'Manutenzione', NULL, NULL, 'Elettricista Giardiniere', NULL, 'Riserva Naturale Misquilese'),
(28, 'Matteo', 'Donanzan', '2002-10-01', 3499, 'Organizzatore', NULL, NULL, NULL, NULL, 'Riserva Naturale Misquilese'),
(29, 'Patrizius', 'Gravenor', '2001-09-04', 2193, 'Guida', 'Tedesco', NULL, NULL, 'Corso Tedesco', 'Riserva Naturale Misquilese'),
(30, 'Calv', 'Synnot', '1987-02-14', 1320, 'Sicurezza',  NULL, NULL, NULL, 'Primo soccorso', 'Riserva Naturale Misquilese'),
(31, 'Iggie', 'Stitt', '1990-06-25', 1799, 'Guida', 'Tedesco, Inglese, Italiano', NULL, NULL, 'Corso Tedesco', 'Parco Nazionale dello Stelvio'),
(32, 'Remington', 'Torrent', '2003-12-30', 1750, 'Guida', 'Francese, Inglese, Spagnolo', NULL, NULL, 'Corso Francese, Corso Spagnolo', 'Parco Nazionale dello Stelvio'),
(33, 'Silas', 'Cleghorn', '1988-01-03', 2140, 'Guida', 'Russo, Inglese', NULL, NULL, 'Corso Russo', 'Parco Nazionale dello Stelvio'),
(34, 'Gaspar', 'Dunlop', '2002-08-31', 2723, 'Guida', 'Arabo, Inglese', NULL, NULL, 'Corso Arabo', 'Parco Nazionale dello Stelvio'),
(35, 'Kathie', 'Tschersich', '2001-03-18', 4290, 'Ricercatore', NULL, 'Chimico', NULL, NULL, 'Parco Nazionale dello Stelvio'),
(36, 'Wilhelmine', 'Haney`', '2001-02-26', 3281, 'Manutenzione',  NULL, NULL, 'Idraulico Elettricista Giardiniere',NULL, 'Parco Nazionale dello Stelvio'),
(37, 'Linoel', 'Llewelly', '1987-10-04', 4882, 'Responsabile',  NULL, NULL, NULL, NULL, 'Parco Nazionale dello Stelvio'),
(38, 'Dulsea', 'Pescud', '1992-06-13', 3112, 'Organizzatore', NULL, NULL, NULL, NULL, 'Parco Nazionale dello Stelvio'),
(39, 'Finlay', 'Notman', '1993-01-06', 3584, 'Organizzatore', NULL, NULL, NULL, NULL, 'Parco Nazionale dello Stelvio'),
(40, 'Howie', 'Stollenberg', '1989-02-16', 2288, 'Sicurezza',  NULL, NULL, NULL, 'Primo soccorso', 'Parco Nazionale dello Stelvio');



insert into TourGuidato (id, numeroPersone, data, tipoTour) values 
('A12BC', 8, '2023-08-28', 'Flora'),
('A13BC', 8, '2024-09-02', 'Fauna'),
('A14BC', 8, '2023-07-04', 'Fauna'),
('A15BC', 8, '2024-01-07', 'Flora'),
('A16BC', 8, '2024-04-29', 'Fauna'),
('A17BC', 4, '2023-09-12', 'Flora'),
('A18BC', 8, '2023-02-09', 'Fauna'),
('A19BC', 8, '2023-04-04', 'Flora');



insert into Spiega(dipendente,tour) values
(1,'A12BC'), 
(2,'A13BC'),
(4,'A12BC'),
(5,'A13BC'),
(11,'A14BC'),
(12,'A15BC'),
(16,'A14BC'),
(17,'A15BC'),
(23,'A16BC'),
(25,'A17BC'),
(26,'A16BC'),
(29,'A17BC'),
(31,'A18BC'),
(32,'A19BC'),
(33,'A18BC'),
(34,'A19BC');



insert into BigliettoTour (id, ridotto, data, prezzo, codiceFiscaleCliente, tour, parco) values 
(1, false, '2023-05-08', '18.59', '610-86-1925', 'A12BC', 'Parco Naturale del Gran Paradiso'),
(2, true, '2023-10-14', '10.00', '850-20-1383', 'A13BC', 'Parco Naturale del Gran Paradiso'),
(3, true, '2023-05-09', '10.00', '542-70-7587', 'A12BC', 'Parco Naturale del Gran Paradiso'),
(4, true, '2023-02-11', '10.00', '624-83-2281', 'A13BC', 'Parco Naturale del Gran Paradiso'),
(5, true, '2023-07-01', '10.00', '321-59-4010', 'A12BC', 'Parco Naturale del Gran Paradiso'),
(6, false, '2023-03-04', '26.75', '462-45-2627', 'A13BC', 'Parco Naturale del Gran Paradiso'),
(7, true, '2023-03-05', '10.00', '447-75-9453', 'A12BC', 'Parco Naturale del Gran Paradiso'),
(8, false, '2023-11-22', '14.21', '603-97-2041', 'A13BC', 'Parco Naturale del Gran Paradiso'),
(9, true, '2023-10-14', '10.00', '383-58-9178', 'A12BC', 'Parco Naturale del Gran Paradiso'),
(10, false, '2023-11-23', '17.49', '429-90-5672', 'A13BC', 'Parco Naturale del Gran Paradiso'),
(11, true, '2023-01-04', '10.00', '168-57-6934', 'A14BC', 'Parco Nazionale di Camponogara'),
(12, true, '2023-08-13', '10.00', '716-10-6207', 'A15BC', 'Parco Nazionale di Camponogara'),
(13, true, '2023-02-11', '10.00', '864-39-9520', 'A14BC', 'Parco Nazionale di Camponogara'),
(14, true, '2023-05-02', '10.00', '817-56-2969', 'A15BC', 'Parco Nazionale di Camponogara'),
(15, false, '2023-01-06', '29.97', '274-11-5075', 'A14BC', 'Parco Nazionale di Camponogara'),
(16, false, '2023-10-20', '19.15', '568-72-0542', 'A15BC', 'Parco Nazionale di Camponogara'),
(17, true, '2023-12-27', '10.00', '339-79-6748', 'A14BC', 'Parco Nazionale di Camponogara'),
(18, true, '2023-01-08', '10.00', '437-46-6883', 'A15BC', 'Parco Nazionale di Camponogara'),
(19, true, '2023-11-20', '10.00', '390-62-9877', 'A14BC', 'Parco Nazionale di Camponogara'),
(20, false, '2023-09-12', '13.43', '218-29-5617', 'A15BC', 'Parco Nazionale di Camponogara'),
(21, false, '2023-11-13', '13.52', '791-87-5229', 'A16BC', 'Riserva Naturale Misquilese'),
(22, false, '2023-04-11', '16.98', '434-97-0717', 'A17BC', 'Riserva Naturale Misquilese'),
(23, false, '2023-12-25', '27.35', '892-19-0009', 'A16BC', 'Riserva Naturale Misquilese'),
(24, true, '2023-05-11', '10.00', '169-65-7563', 'A17BC', 'Riserva Naturale Misquilese'),
(25, false, '2023-08-30', '28.82', '687-05-3528', 'A16BC', 'Riserva Naturale Misquilese'),
(26, false, '2023-03-05', '25.95', '123-12-7561', 'A17BC', 'Riserva Naturale Misquilese'),
(27, false, '2023-01-27', '21.76', '512-68-2495', 'A16BC', 'Riserva Naturale Misquilese'),
(28, true, '2023-02-11', '10.00', '651-18-3600', 'A17BC', 'Riserva Naturale Misquilese'),
(29, false, '2023-02-26', '21.90', '821-84-4678', 'A16BC', 'Riserva Naturale Misquilese'),
(30, false, '2023-11-23', '29.26', '404-87-7274', 'A17BC', 'Riserva Naturale Misquilese'),
(31, false, '2023-02-06', '18.64', '876-27-8044', 'A18BC', 'Parco Nazionale dello Stelvio'),
(32, false, '2023-02-09', '18.76', '168-77-9561', 'A19BC', 'Parco Nazionale dello Stelvio'),
(33, true, '2023-02-24', '10.00', '765-34-6733', 'A18BC', 'Parco Nazionale dello Stelvio'),
(34, false, '2023-04-25', '19.15', '299-51-9664', 'A19BC', 'Parco Nazionale dello Stelvio'),
(35, true, '2023-06-30', '10.00', '119-97-3751', 'A18BC', 'Parco Nazionale dello Stelvio'),
(36, true, '2023-04-15', '10.00', '655-24-1339', 'A19BC', 'Parco Nazionale dello Stelvio'),
(37, false, '2023-08-06', '20.62', '277-06-0346', 'A18BC', 'Parco Nazionale dello Stelvio'),
(38, false, '2023-12-12', '25.70', '758-34-6771', 'A19BC', 'Parco Nazionale dello Stelvio'),
(39, true, '2023-10-11', '10.00', '329-68-0127', 'A18BC', 'Parco Nazionale dello Stelvio'),
(40, false, '2023-08-19', '29.18', '870-05-6425', 'A19BC', 'Parco Nazionale dello Stelvio'),
(41, false, '2023-10-13', '13.52', '391-74-6833', 'A12BC', 'Parco Naturale del Gran Paradiso'),
(42, false, '2023-05-11', '16.98', '100-30-1935', 'A13BC', 'Parco Naturale del Gran Paradiso'),
(43, false, '2023-11-25', '27.35', '865-67-4633', 'A12BC', 'Parco Naturale del Gran Paradiso'),
(44, true, '2023-02-11', '10.00', '506-28-2861', 'A13BC', 'Parco Naturale del Gran Paradiso'),
(45, false, '2023-07-24', '28.82', '538-89-9886', 'A12BC', 'Parco Naturale del Gran Paradiso'),
(46, false, '2023-03-05', '25.95', '727-60-7349', 'A15BC', 'Parco Nazionale di Camponogara'),
(47, false, '2023-02-27', '21.76', '298-24-3122', 'A14BC', 'Parco Nazionale di Camponogara'),
(48, true, '2023-03-11', '10.00', '374-17-6525', 'A15BC', 'Parco Nazionale di Camponogara'),
(49, false, '2023-10-26', '21.90', '808-22-3703', 'A14BC', 'Parco Nazionale di Camponogara'),
(50, false, '2023-08-23', '29.26', '784-21-8836', 'A15BC', 'Parco Nazionale di Camponogara'),
(51, false, '2023-06-06', '18.64', '265-79-3790', 'A16BC', 'Riserva Naturale Misquilese'),
(52, false, '2023-01-09', '18.76', '152-19-0103', 'A17BC', 'Riserva Naturale Misquilese'),
(53, true, '2023-12-24', '10.00', '844-85-7794', 'A16BC', 'Riserva Naturale Misquilese'),
(54, false, '2023-07-25', '19.15', '474-86-3989', 'A17BC', 'Riserva Naturale Misquilese'),
(55, true, '2023-09-30', '10.00', '813-19-2972', 'A16BC', 'Riserva Naturale Misquilese'),
(56, true, '2023-02-15', '10.00', '522-31-4106', 'A18BC', 'Parco Nazionale dello Stelvio'),
(57, false, '2023-01-06', '20.62', '316-40-0889', 'A19BC', 'Parco Nazionale dello Stelvio'),
(58, false, '2023-07-12', '25.70', '142-46-4522', 'A19BC', 'Parco Nazionale dello Stelvio'),
(59, true, '2023-11-11', '10.00', '581-26-6071', 'A18BC', 'Parco Nazionale dello Stelvio'),
(60, false, '2023-08-19', '29.18', '520-88-6112', 'A19BC', 'Parco Nazionale dello Stelvio');



insert into Evento (id, numeroPersone, data, tipoEvento, organizzatore) values 
(1, 8, '2023-03-18', 'Musicale', 6),
(2, 8, '2023-12-13', 'Artistico', 7),
(3, 8, '2023-05-02', 'Musicale', 19),
(4, 8, '2024-05-26', 'Artistico', 20),
(5, 6, '2023-06-24', 'Artistico', 22),
(6, 8, '2024-11-23', 'Musicale', 28),
(7, 8, '2024-12-04', 'Naturalistico', 38),
(8, 6, '2023-02-24', 'Naturalistico', 39);



insert into BigliettoEvento (id, ridotto, data, prezzo, codiceFiscaleCliente, evento, parco) values 
(1, false, '2023-06-27', '13.54', '699-29-0318', '1', 'Parco Naturale del Gran Paradiso'),
(2, true, '2023-09-16', '10.00', '784-49-7651', '1', 'Parco Naturale del Gran Paradiso'),
(3, true, '2023-08-13', '10.00', '154-56-9692', '1', 'Parco Naturale del Gran Paradiso'),
(4, false, '2023-07-01', '26.10', '836-85-0679', '1', 'Parco Naturale del Gran Paradiso'),
(5, false, '2023-10-18', '18.37', '120-26-1291', '1', 'Parco Naturale del Gran Paradiso'),
(6, false, '2023-08-23', '28.52', '707-89-6237', '1', 'Parco Naturale del Gran Paradiso'),
(7, true, '2023-10-08', '10.00', '139-97-1893', '5', 'Parco Naturale del Gran Paradiso'),
(8, false, '2023-01-23', '11.22', '423-07-2436', '1', 'Parco Naturale del Gran Paradiso'),
(9, true, '2023-05-06', '10.00', '439-91-1723', '1', 'Parco Naturale del Gran Paradiso'),
(10, true, '2023-03-22', '10.00', '680-13-5568', '2', 'Parco Naturale del Gran Paradiso'),
(11, false, '2023-07-21', '23.75', '343-11-1370', '2', 'Parco Nazionale di Camponogara'),
(12, false, '2023-07-17', '25.52', '166-31-8683', '2', 'Parco Nazionale di Camponogara'),
(13, false, '2023-08-24', '15.30', '480-69-2766', '2', 'Parco Nazionale di Camponogara'),
(14, false, '2023-07-30', '27.91', '492-59-8797', '2', 'Parco Nazionale di Camponogara'),
(15, false, '2023-03-24', '15.52', '650-03-0408', '2', 'Parco Nazionale di Camponogara'),
(16, false, '2023-08-29', '23.39', '464-17-9230', '2', 'Parco Nazionale di Camponogara'),
(17, true, '2023-07-19', '10.00', '590-26-4546', '2', 'Parco Nazionale di Camponogara'),
(18, false, '2023-01-23', '18.76', '253-62-4244', '3', 'Parco Nazionale di Camponogara'),
(19, false, '2023-07-08', '13.33', '612-54-6736', '3', 'Parco Nazionale di Camponogara'),
(20, true, '2023-10-13', '10.00', '449-55-3114', '5', 'Parco Nazionale di Camponogara'),
(21, true, '2023-01-04', '10.00', '397-99-8395', '3', 'Riserva Naturale Misquilese'),
(22, false, '2023-05-24', '15.89', '196-78-3197', '3', 'Riserva Naturale Misquilese'),
(23, true, '2023-03-11', '10.00', '544-13-0833', '3', 'Riserva Naturale Misquilese'),
(24, false, '2023-12-22', '24.17', '713-37-7873', '3', 'Riserva Naturale Misquilese'),
(25, true, '2023-07-27', '10.00', '730-93-0076', '3', 'Riserva Naturale Misquilese'),
(26, true, '2023-08-15', '10.00', '363-26-4065', '3', 'Riserva Naturale Misquilese'),
(27, true, '2023-11-02', '10.00', '661-41-3101', '4', 'Riserva Naturale Misquilese'),
(28, true, '2023-02-07', '10.00', '293-15-6901', '4', 'Riserva Naturale Misquilese'),
(29, false, '2023-07-16', '26.13', '206-99-3195', '4', 'Riserva Naturale Misquilese'),
(30, true, '2023-11-18', '10.00', '166-09-3544', '5', 'Riserva Naturale Misquilese'),
(31, false, '2023-03-23', '17.44', '126-36-9862', '4', 'Parco Nazionale dello Stelvio'),
(32, true, '2023-01-27', '10.00', '830-81-4564', '5', 'Parco Nazionale dello Stelvio'),
(33, true, '2023-02-20', '10.00', '218-97-3505', '4', 'Parco Nazionale dello Stelvio'),
(34, false, '2023-05-28', '13.30', '724-82-7580', '4', 'Parco Nazionale dello Stelvio'),
(35, true, '2023-04-30', '10.00', '143-30-5420', '4', 'Parco Nazionale dello Stelvio'),
(36, false, '2023-11-10', '16.41', '231-46-4162', '4', 'Parco Nazionale dello Stelvio'),
(37, true, '2023-07-09', '10.00', '483-29-5126', '6', 'Parco Nazionale dello Stelvio'),
(38, false, '2023-04-27', '28.42', '609-22-3888', '6', 'Parco Nazionale dello Stelvio'),
(39, false, '2023-08-20', '17.52', '237-53-9877', '6', 'Parco Nazionale dello Stelvio'),
(40, true, '2023-10-18', '10.00', '121-64-6056', '6', 'Parco Nazionale dello Stelvio'),
(41, true, '2023-01-05', '10.00', '285-26-0230', '6', 'Parco Naturale del Gran Paradiso'),
(42, false, '2023-05-25', '15.89', '826-33-6034', '6', 'Parco Naturale del Gran Paradiso'),
(43, true, '2023-03-11', '10.00', '783-22-5493', '6', 'Parco Naturale del Gran Paradiso'),
(44, false, '2023-11-22', '24.17', '544-97-5975', '6', 'Parco Naturale del Gran Paradiso'),
(45, true, '2023-03-27', '10.00', '835-10-3948', '7', 'Parco Naturale del Gran Paradiso'),
(46, true, '2023-05-15', '10.00', '175-75-7878', '7', 'Parco Nazionale di Camponogara'),
(47, true, '2023-01-02', '10.00', '531-01-5962', '7', 'Parco Nazionale di Camponogara'),
(48, true, '2023-10-07', '10.00', '738-26-1525', '7', 'Parco Nazionale di Camponogara'),
(49, false, '2023-11-16', '26.13', '702-08-9656', '7', 'Parco Nazionale di Camponogara'),
(50, true, '2023-06-18', '10.00', '238-19-1124', '5', 'Parco Nazionale di Camponogara'),
(51, false, '2023-07-23', '17.44', '131-89-1859', '7', 'Riserva Naturale Misquilese'),
(52, true, '2023-09-27', '10.00', '377-04-2790', '5', 'Riserva Naturale Misquilese'),
(53, true, '2023-08-20', '10.00', '173-46-0895', '7', 'Riserva Naturale Misquilese'),
(54, false, '2023-05-28', '13.30', '818-30-2512', '7', 'Riserva Naturale Misquilese'),
(55, true, '2023-04-30', '10.00', '631-71-6521', '8', 'Riserva Naturale Misquilese'),
(56, false, '2023-03-10', '16.41', '168-07-9718', '8', 'Parco Nazionale dello Stelvio'),
(57, true, '2023-10-09', '10.00', '634-93-5729', '8', 'Parco Nazionale dello Stelvio'),
(58, false, '2023-09-27', '28.42', '289-73-0768', '8', 'Parco Nazionale dello Stelvio'),
(59, false, '2023-12-20', '17.52', '325-80-9772', '8', 'Parco Nazionale dello Stelvio'),
(60, true, '2023-11-18', '10.00', '826-43-7893', '8', 'Parco Nazionale dello Stelvio');



insert into Area (id, nome, posizione, parco, responsabile) values 
(1, 'Sentiero delle Cascate', 'Prateria del Gran Paradiso', 'Parco Naturale del Gran Paradiso', 3),
(2, 'Bosco degli Ulivi', 'Prateria del Gran Paradiso', 'Parco Naturale del Gran Paradiso', 3),
(3, 'Radura dei Cervi', 'Prateria del Gran Paradiso', 'Parco Naturale del Gran Paradiso', 3),
(4, 'Laghetto delle Ninfee', 'Prateria del Gran Paradiso', 'Parco Naturale del Gran Paradiso', 3),
(5, 'Gola del Torrente', 'Prateria del Gran Paradiso', 'Parco Naturale del Gran Paradiso', 3),
(6, 'Prato dei Fiori', 'Laguna di Venezia', 'Parco Nazionale di Camponogara', 18),
(7, 'Collina Panoramica', 'Laguna di Venezia', 'Parco Nazionale di Camponogara', 18),
(8, 'Valle degli Uccelli', 'Laguna di Venezia', 'Parco Nazionale di Camponogara', 18),
(9, 'Passeggiata dei Pini', 'Laguna di Venezia', 'Parco Nazionale di Camponogara', 18),
(10, 'Rifugio Alpino', 'Laguna di Venezia', 'Parco Nazionale di Camponogara', 18),
(11, 'Laghi Glaciali', 'Vicenza', 'Riserva Naturale Misquilese', 21),
(12, 'Faggeta Millenaria', 'Vicenza', 'Riserva Naturale Misquilese', 21),
(13, 'Valle Incantata', 'Vicenza', 'Riserva Naturale Misquilese', 21),
(14, 'Oasi Avifaunistica', 'Vicenza', 'Riserva Naturale Misquilese', 21),
(15, 'Giardino delle Farfalle', 'Vicenza', 'Riserva Naturale Misquilese', 21),
(16, 'Fontana delle Sorgenti', 'Valle Ortler', 'Parco Nazionale dello Stelvio', 37),
(17, 'Belvedere sul Fiume', 'Valle Ortler', 'Parco Nazionale dello Stelvio', 37),
(18, 'Bosco delle Fate', 'Valle Ortler', 'Parco Nazionale dello Stelvio', 37),
(19, 'Sorgente Cristallina', 'Valle Ortler', 'Parco Nazionale dello Stelvio', 37),
(20, 'Prato dei Gigli', 'Valle Ortler', 'Parco Nazionale dello Stelvio', 37);



insert into Pianta (id, descrizione, nomeLatino, acquaNecessaria, locazione, tipoFoglie, dataTrapianto, età, area) values 
('A1P1', 'Foglie verdi, fiori rosa, alta e elegante', 'Eritrichium nanum ', 16.6, 'Valnontey', 'Filiformi',   '2017-01-01',22, 1),
('A1P2', 'Pianta rampicante con foglie a forma di cuore', 'Dacryodes Vahl', 14.1, 'Cogne', 'Aghiformi',  '2003-01-01',24, 1),
('A1P3', 'Arbusto sempreverde con fiori gialli profumati', 'Centaurea eriophora', 15.3, 'Valsavarenche', 'Filiformi', '2022-01-01',45, 1),
('A1P4', 'Arbusto con foglie variegate e fiori viola', 'Lecanora gyalectodes', 14.1, 'Rhêmes-Notre-Dame', 'Aghiformi', '2001-01-01',25, 1),
('A2P1', 'Pianta tropicale con foglie grandi e vistose', 'Leptospermum laevigatum', 1.4, 'Rhêmes-Saint-Georges', 'Oblunghe', '2013-01-01', 21, 2),
('A2P2', 'Pianta acquatica con fiori galleggianti rosa', 'Lobelia flaccidifolia Small', 11.7, 'Valgrisenche', 'Filiformi',  '2012-01-01',32, 2),
('A2P3', 'Arbusto con foglie piccole e fiori rosa intenso', 'Launaea Cass', 13.9, 'Ceresole Reale', 'Oblunghe',  '2007-01-01',10, 2),
('A2P4', 'Arbusto con foglie lanceolate e frutti rossi', 'Chenopodium Aellen', 11.1, 'Pont', 'Filiformi', '2021-01-01',11,  2),
('A3P1', 'Pianta rampicante con foglie verdi lucide e fiori bianchi', 'Chrysogonum virginianum', 12.7, 'Ronco Canavese', 'Aghiformi', '2004-01-01',50, 3),
('A3P2', 'Albero con foglie palmate e fiori rosa penduli', 'Lathyrus nevadensis', 19.3, 'Villeneuve', 'Oblunghe',  '2008-01-01',12, 3),
('A3P3', 'Erba profumata con foglie sottili e fiori viola', 'Orobanche corymbosa', 16.6, 'Valprato Soana', 'Ovali',  '2011-01-01',15, 3),
('A3P4', 'Pianta acquatica con foglie galleggianti a forma di cuore', 'Baptisia megacarpa', 18.0, 'Eaux Rousses', 'Seghettate',  '2011-01-01',16, 3),
('A4P1', 'Arbusto con foglie argentate e fiori gialli a grappolo', 'Lotus procumbens Greene', 9.7, 'Gimillan', 'Aghiformi', '2006-01-01',14, 4),
('A4P2', 'Pianta rampicante con foglie a forma di stella e fiori profumati', 'Oligoneuron rigidum Small', 11.1, 'Val di Rhêmes', 'Ovali',  '2009-01-01',9, 4),
('A4P3', 'Albero con fiori bianchi a forma di piuma', 'Tricardia Torr', 8.8, 'Valsavarenche', 'Seghettate',  '2001-01-01',8, 4),
('A4P4', 'Albero con foglie lanceolate e frutti dolci ', 'Triodanis texana', 4.8, 'Piantonetto', 'Ovali',  '2008-01-01',5, 4),
('A5P1', 'Albero con fiori bianchi a forma di spiga elegante', 'Peniocereus greggii', 10.2, 'Lauson', 'Filiformi', '2014-01-01',18, 5),
('A5P2', 'Erba ornamentale con foglie a strisce e fiori rosa intenso profumati', 'Tragia glanduligera', 4.8, 'Val di Cogne', 'Seghettate',  '2015-01-01',17, 5),
('A5P3', 'Pianta con foglie strette e fiori gialli a forma di stella', 'Penstemon goodrichii', 18.5, 'Teleccio', 'Aghiformi',  '2017-01-01',15, 5),
('A5P4', 'Albero con foglie strette e fiori gialli profumati a grappolo splendidi', 'Symphyotrichum laurentianum', 15.2, 'Locana', 'Filiformi', '2020-01-01',35, 5),
('A6P1', 'Colorato, a forma di coppa', 'Portulaca quadrifida', 11.2, 'Monterosso al Mare', 'Aghiformi', '2014-01-01',8, 6),
('A6P2', 'Viola, aromatico, lavanda', 'Phlox andicola', 16.4, 'Vernazza', 'Oblunghe', '2006-01-01',9, 6),
('A6P3', 'Alta, foglie verdi, fiori bianchi, profumata', 'Cetrelia chicitae', 9.0, 'Corniglia', 'Aghiformi',  '2021-01-01',13, 6),
('A6P4', 'Fiori rossi, foglie lanceolate, rampicante, vivace', 'Dryopteris xneowherryi', 15.3, 'Manarola', 'Ovali',  '2022-01-01',11, 6),
('A7P1', 'Piccoli fiori rosa, foglie ovali, profumo dolce', 'Calypso bulbosa', 4.0, 'Riomaggiore', 'Filiformi', '2019-01-01', 24,7),
('A7P2', 'Grappoli di fiori gialli, foglie lucide, profumo intenso', 'Thelopsis isiaca', 6.5, 'Portovenere', 'Oblunghe',  '2015-01-01',31, 7),
('A7P3', 'Fiore giallo, foglie sottili, profumo dolce', 'Samolus', 17.0, 'Levanto', 'Aghiformi', '2016-01-01',  15, 7),
('A7P4', 'Fiori bianchi, foglie verdi, rampicante, profumo delicato', 'Sidastrum ', 2.9, 'La Spezia', 'Ovali',  '2005-01-01',32, 7),
('A8P1', 'Fiori rossi, foglie dentate', 'Salix xprincepsrayi', 15.5, 'Portofino', 'Seghettate', '2017-01-01',23, 8),
('A8P2', 'Fiori bianchi, foglie verde scuro, profumo rilassante', 'Capparis incana', 10.0, 'Camogli', 'Ovali', '2015-01-01',22, 8),
('A8P3', 'Fiori arancioni, foglie verde scuro, rampicante, vivace', 'Eleutheranthera ruderalis', 7.3, 'Santa Margherita Ligure', 'Filiformi',  '2004-01-01',21, 8),
('A8P4', 'Fiori gialli, foglie strette, profumo citrico', 'Urera obovata Benth.', 19.8, 'Bonassola', 'Seghettate',  '2008-01-01',16, 8),
('A9P1', 'Fiori rosa, foglie verde brillante, profumo intenso', 'Cardaria draba', 2.3, 'Framura', 'Oblunghe', '2022-01-01',15, 9),
('A9P2', 'Fiori viola, foglie verde chiaro, profumo erbaceo', 'Crossosoma bigelovii', 8.0, 'Lerici', 'Filiformi', '2021-01-01',11, 9),
('A9P3', 'Fiori bianchi, foglie verde scuro, profumo dolce', 'Nesaea', 2.9, 'Tellaro', 'Ovali',  '2013-01-01',43, 9),
('A9P4', 'Fiori blu, foglie lanceolate, profumo rinfrescante', 'Calamagrostis tacomensis', 9.8, 'Volastra', 'Aghiformi', '2008-01-01',26, 9),
('A10P1', 'Fiori rosa, foglie lanceolate, profumo delicato', 'Hymenopappus carrizoanus', 19.0, 'Biassa', 'Ovali',  '2000-01-01',21, 10),
('A10P2', 'Fiori arancioni, foglie verde scuro, rampicante, vivace', 'Baccharis texana', 9.8, 'Riomaggiore Scalo', 'Seghettate', '2016-01-01',15, 10),
('A10P3', 'Fiori bianchi, foglie verde scuro, rampicante, profumo intenso', 'Jacquemontia havanensis', 5.0, 'Pignone', 'Aghiformi',  '2021-01-01',13, 10),
('A10P4', 'Fiori gialli, foglie verdi, rampicante, profumo leggero', 'Paspalum bifidum', 3.1, 'Montaretto', 'Filiformi', '2011-01-01',11, 10),
('A11P1', 'Fiori viola, foglie verde scuro, profumo erbaceo', 'Grindelia hirsutula', 3.0, 'Castelluccio di Norcia', 'Aghiformi',  '2015-01-01',56, 11),
('A11P2', 'Fiori rossi, foglie verdi, rampicante, vivace', 'Saxifraga flagellaris ', 17.6, 'Visso', 'Oblunghe', '2021-01-01',34, 11),
('A11P3', 'Fiori bianchi, foglie verdi, profumo dolce', 'Styrax', 7.6, 'Castelsantangelo sul Nera', 'Ovali', '2001-01-01',23, 11),
('A11P4', 'Fiori rosa, foglie verde scuro, profumo intenso', 'Heracleum', 7.5, 'Ussita', 'Filiformi', '2017-01-01',34, 11),
('A12P1', 'Fiori arancioni, foglie verde scuro, rampicante, vivace', 'Sterculia', 9.6, 'Montemonaco', 'Seghettate', '2022-01-01',11, 12),
('A12P2', 'Fiori gialli, foglie verdi, rampicante, profumo leggero', 'Acarospora smaragdula', 6.1, 'Fiastra', 'Aghiformi',  '2000-01-01',22, 12),
('A12P3', 'Bianco, foglie verde scuro, profumo dolce', 'Spiraea chamaedryfolia', 1.9, 'Bolognola', 'Filiformi',  '2014-01-01',33, 12),
('A12P4', 'Arancione, foglie verde scuro, rampicante, vivace', 'Brickellia frutescens', 20.0, 'Amandola', 'Ovali', '2005-01-01',15, 12),
('A13P1', 'Giallo, foglie strette, profumo citrico', 'Gossypium barbadense', 8.7, 'Sarnano', 'Oblunghe', '2020-01-01',17, 13),
('A13P2', 'Giallo, foglie verde scuro, profumo agrumato', 'Dodecatheon amethystinum', 8.5, 'Acquacanina', 'Ovali', '2015-01-01',16, 13),
('A13P3', 'Rosa, foglie lanceolate, profumo floreale', 'Malvastrum americanum', 14.8, 'Montefortino', 'Aghiformi',  '2014-01-01',67, 13),
('A13P4', 'Bianco, foglie verdi, profumo delicato', 'Actinidia polygama', 17.0, 'Preci', 'Seghettate', '2000-01-01', 85, 13),
('A14P1', 'Rosso, foglie lanceolate, profumo speziato', 'Solidago velutina', 16.9, 'Valfornace', 'Filiformi','2015-01-01',38, 14),
('A14P2', 'Giallo, foglie verdi, rampicante, profumo erbaceo', 'Stenotus', 11.3, 'Montegallo', 'Ovali',  '2005-01-01',12, 14),
('A14P3', 'Viola, foglie verde scuro, profumo intenso', 'Androsace', 11.5, 'Montefalcone Appennino', 'Seghettate', '2007-01-01',34,14),
('A14P4', 'Rosso, foglie verde brillante, profumo fruttato', 'Eugenia uniflora', 11.8, 'Pievebovigliana', 'Aghiformi', '2015-01-01',45, 14),
('A15P1', 'Bianco, foglie verde scuro, profumo fresco', 'Phlox glaberrima', 16.5, 'Colfiorito', 'Ovali', '2020-01-01',26, 15),
('A15P2', 'Blu, foglie lanceolate, profumo erbaceo', 'Saxifraga bryophora', 18.6, 'Pieve Torina', 'Filiformi',  '2022-01-01',13, 15),
('A15P3', 'Giallo, foglie verdi, rampicante, profumo floreale', 'Astragalus soxmaniorum', 11.8, 'Cessapalombo', 'Ovali', '2019-01-01',64, 15),
('A15P4', 'Viola, foglie verde chiaro, profumo dolce', 'Jacquemontia tamnifolia', 13.2, 'Pintura di Bolognola', 'Aghiformi',  '2008-01-01', 65, 15),
('A16P1', 'Bianco, foglie verdi, profumo delicato', 'Ericameria obovata', 2.7, 'Bormio', 'Aghiformi',  '2012-01-01',56, 16),
('A16P2', 'Arancione, foglie verde scuro, rampicante, profumo tropicale', 'Escobaria organensis', 4.2, 'Livigno', 'Oblunghe',  '2018-01-01',43, 16),
('A16P3', 'Giallo, foglie strette, profumo speziato', 'Nama aretioides', 1.8, 'Santa Caterina Valfurva', 'Aghiformi',  '2002-01-01', 41, 16),
('A16P4', 'Rosa, foglie verde brillante, profumo leggero', 'Arctostaphylos hookeri', 9.7, 'Peio', 'Ovali',  '2020-01-01',23, 16),
('A17P1', 'Bianco, foglie verde scuro, profumo rinfrescante', 'Lecidea sublimosa', 1.6, 'Prato allo Stelvio', 'Aghiformi', '2000-01-01',16, 17),
('A17P2', 'Viola, foglie verde scuro, profumo dolce', 'Juncus drummondii', 1.3, 'Solda', 'Seghettate',  '2017-01-01',11, 17),
('A17P3', 'Rosso, foglie verdi, rampicante, profumo intenso', 'Vicia cracca', 13.3, 'Trafoi', 'Filiformi',  '2008-01-01',43, 17),
('A17P4', 'Giallo, foglie verdi, profumo agrumato', 'Croton ciliatoglandulifer', 8.4, 'Valdidentro', 'Ovali',  '2007-01-01',75, 17),
('A18P1', 'Blu, foglie lanceolate, profumo erbaceo', 'Stipa klemenzii', 18.4, 'Sulden', 'Aghiformi', '2022-01-01',23, 18),
('A18P2', 'Rosa, foglie lanceolate, profumo floreale', 'Psychopsis', 10.5, 'Rabbi', 'Seghettate', '2015-01-01', 22, 18),
('A18P3', 'Bianco, foglie verde scuro, profumo delicato', 'Allium oleraceum', 7.6, 'Martello', 'Ovali',  '2001-01-01',30, 18),
('A18P4', 'Arancione, foglie verde scuro, rampicante, profumo esotico', 'Centaurium arizonicum', 9.8, 'Madonna di Senales', 'Filiformi',  '2007-01-01',21, 18),
('A19P1', 'Giallo, foglie strette, profumo speziato', 'Saxifraga hirculus', 10.0, 'Vermiglio', 'Aghiformi', '2000-01-01',23, 19),
('A19P2', 'Viola, foglie verde scuro, profumo intenso', 'Mycocalicium sequoiae', 7.5, 'Santa Maria Val Müstair', 'Seghettate', '2018-01-01',25, 19),
('A19P3', 'Rosso, foglie verde brillante, profumo fruttato', 'Phacelia capitata', 2.3, 'Stelvio Pass', 'Ovali','2014-01-01',21, 19),
('A19P4', 'Bianco, foglie verde scuro, profumo fresco', 'Phoenix sylvestris', 2.5, 'Cogolo di Pejo', 'Aghiformi',  '2003-01-01',54, 19),
('A20P1', 'Blu, foglie lanceolate, profumo erbaceo', 'Penstemon procerus Douglas', 10.9, 'Malè', 'Ovali',  '2019-01-01',43, 20),
('A20P2', 'Giallo, foglie verdi, rampicante, profumo floreale', 'Linum carteri', 13.6, 'Santa Valburga', 'Seghettate',  '2001-01-01',54, 20),
('A20P3', 'Viola, foglie verde chiaro, profumo dolce', 'Vitex parviflora', 11.3, 'Valdisotto', 'Ovali',  '2001-01-01',32, 20),
('A20P4', 'Rosso, foglie verde scuro, profumo piccante', 'Bacopa repens', 7.7, 'Laces', 'Oblunghe', '2018-01-01',56, 20);



insert into Animale (id, descrizione, nomeLatino, alimentazione, dataNascita, età, classe, famiglia, area) values 
('A1A1', 'Aspetto robusto, muniti di lunga coda rettangolare e becco conico e appuntito', 'Uraeginthus bengalus', 'Onnivoro', '2005-11-02', 18, 'Uccello', 'Estrildidae', 1),
('A1A2', 'Uccello della famiglia degli Scolopacidae dell ordine dei Charadriiformes', 'Tringa glareola', 'Erbivoro', '2016-03-01', 7, 'Uccello', 'Scolopacidae', 1),
('A1A3', 'Color nero-azzurro nella parte superiore e grigio e grigio-bianco nelle parti inferiori e nel petto', 'Coluber constrictor foxii', 'Carnivoro', '2016-03-04', 7, 'Rettile', 'Colubridae', 1),
('A1A4', 'È una specie di lucertola diffusa nella Africa meridionale', 'Varanus albigularis', 'Carnivoro', '2019-06-04', 4, 'Rettile', 'Varanidae', 1),
('A2A1', 'È un pipistrello della famiglia dei Vespertilionidi diffuso nella America settentrionale', 'Myotis lucifugus', 'Carnivoro', '2015-09-26', 8, 'Mammifero', 'Vespertilionidae', 2),
('A2A2', 'Raggiunge una lunghezza di oltre 40 centimetri per un peso di 700 grammi. Possiede un corpo robusto e zampe corte, utili al suo stile di vita fossorio. La lingua è di un colore che va dal blu-viola al blu cobalto', 'Tiliqua scincoides', 'Carnivoro', '2019-04-16', 4, 'Rettile', 'Scincidae', 2),
('A2A3', 'È una specie di bovino di grandi dimensioni originario del subcontinente indiano e del sud-est asiatico', 'Bubalus arnee', 'Erbivoro', '2018-02-06', 5, 'Mammifero', 'Bovidae', 2),
('A2A4', 'Non velenoso appartenente al genere Coluber', 'Coluber constrictor', 'Carnivoro', '2000-10-21', 23, 'Rettile', 'Colubridae', 2),
('A3A1', 'È un grande uccello rapace prevalentemente terrestre', 'Sagittarius serpentarius', 'Onnivoro', '2006-08-15', 17, 'Uccello', 'Sagittariidae', 3),
('A3A2', 'È la specie di fenicottero più piccola e più diffusa numericamente in assoluto', 'Phoeniconaias minor', 'Onnivoro', '2018-06-08', 6, 'Uccello', 'Phoenicopteridae', 3),
('A3A3', 'Uccello nero e bianco', 'Chlidonias leucopterus', 'Onnivoro', '2015-03-03', 8, 'Uccello', 'Laridae', 3),
('A3A4', 'Presente nelle zone remote del Nord America e della Eurasia', 'Canis lupus', 'Carnivoro', '2008-12-18', 15, 'Mammifero', 'Canidae', 3),
('A4A1', 'Sono una famiglia di uccelli appartenente allo ordine dei Caprimulgiformi.', 'Chordeiles minor', 'Erbivoro', '2014-07-18', 9, 'Uccello', '	Caprimulgidae', 4),
('A4A2', 'È diffuso in Benin, Burkina Faso, Camerun, Repubblica Centrafricana', 'Merops nubicus', 'Erbivoro', '2009-05-15', 14, 'Uccello', 'Meropidae', 4),
('A4A3', 'La lunghezza totale può superare i 140 cm, compresa la coda che misura circa venti centimetri. La apertura alare raggiunge i 230 cm', 'Ardea golieth', 'Onnivoro', '2011-11-18', 12, 'Uccello', 'Ardeidae', 4),
('A4A4', 'È una specie sudamericana, diffusa nella area al confine fra Brasile, Colombia, Bolivia e Argentina', 'Dasypus septemcincus', 'Onnivoro', '2022-05-02', 1, 'Mammifero', 'Dasypodidae', 4),
('A5A1', 'Piccoli sauri diffusi in Asia e Oceania', 'Cyrtodactylus louisiadensis', 'Carnivoro', '2015-05-07', 8, 'Rettile', 'Gekkonidae', 5),
('A5A2', 'Può essere distinto dagli altri per il suo corpo fortemente appiattito, di circa 290 mm', 'Ctenophorus ornatus', 'Carnivoro', '2008-01-23', 15, 'Rettile', 'Agamidae', 5),
('A5A3', 'Il corpo è lungo sino a 53 cm, con una coda di circa 9 cm. Il dorso e i fianchi sono interamente ricoperti da aculei', 'Tachyglossus aculeatus', 'Erbivoro', '2002-09-14', 21, 'Mammifero', 'Tachiglossidi', 5),
('A5A4', 'La specie è elencata come in Pericolo nella Lista Rossa IUCN, dal 1986, poiché la popolazione rimanente ammonta a meno di 4.000 esemplari', 'Bubalus', 'Onnivoro', '2017-07-28', 7, 'Mammifero', 'Bovidae', 5),
('A6A1', 'Presenta un mantello uniformemente di color bruno-vinaccia, con margine alare grigio-bluastro', 'Streptopelia senegalensis', 'Onnivoro', '2020-01-30', 3, 'Uccello', ' Columbidae', 6),
('A6A2', 'Il suo aspetto è quello tipico dello avvoltoio: testa e collo non hanno un piumaggio sviluppato ma solo un corto piumino', 'Gyps fulvus', 'Carnivoro', '2006-07-20', 17, 'Uccello', ' Accipitridi', 6),
('A6A3', 'È lo orso più comune in America del Nord. Si incontra in una area geografica che si estende dal nord del Canada e della Alaska al nord del Messico, e dalle coste atlantiche alle coste pacifiche della America del Nord', 'Ursus americanus', 'Carnivoro', '2012-12-15', 11, 'Mammifero', 'Ursidae', 6),
('A6A4', 'È di colore variabile dal marrone sabbia al grigio-giallo, con strisce nere sulla coda', 'Felis silvestris lybica', 'Carnivoro', '2016-01-29', 7, 'Mammifero', 'Felini', 6),
('A7A1', 'Ha un muso allungato e appuntito, simile ad una piccola proboscide, e una coda rudimentale', 'Tenrec ecaudatus', 'Erbivoro', '2004-08-04', 19, 'Mammifero', 'Tenrecidae', 7),
('A7A2', 'È un uccello diffuso nel continente australiano', 'Cereopsis novaehollandiae', 'Onnivoro', '2011-01-27', 12, 'Uccello', 'Anatidi', 7),
('A7A3', 'Deve il nome scientifico alle penne di colore bianco e nero, simili agli abiti indossati un tempo dai chierici.', 'Ciconia episcopus', 'Onnivoro', '2005-10-24', 18, 'Uccello', 'Ciconiidae', 7),
('A7A4', 'È una specie esistente di canide di taglia media endemica della parte centrale della America del Sud', 'Dusicyon thous', 'Carnivoro', '2006-02-09', 17, 'Mammifero', 'Canidae', 7),
('A8A1', 'È il rapace americano più diffuso, e vive dal Canada meridionale al Centro America', 'Buteo jamaicensis', 'Carnivoro', '2020-11-16', 3, 'Uccello', 'Accipitridi', 8),
('A8A2', 'Il maschio misura 100 cm di lunghezza, per un peso di 9000-10.000 g; la femmina misura 80 cm di lunghezza, per un peso di 3000 g', 'Neotis denhami', 'Onnivoro', '2019-09-23', 30, 'Uccello', ' Otididi', 8),
('A8A3', 'Questo volatile, lungo 54 cm, è di colore grigio ardesia scuro', 'Hymenolaimus malacorhynchus', 'Erbivoro', '2008-10-20', 15, 'Uccello', 'Anatidi', 8),
('A8A4', 'Bellissimo uccello acquatico lungo poco più di 30 centimetri', 'Actophilornis africanus', 'Erbivoro', '2021-09-25', 2, 'Uccello', 'Jacanidae', 8),
('A9A1', 'Pappagallo di taglia attorno ai 35 cm, presenta una colorazione base verde, fronte e corona bianche', 'Deroptyus accipitrinus', 'Onnivoro', '2013-06-27', 10, 'Uccello', ' Psittacidi', 9),
('A9A2', 'Questo uccello vive nella Africa centrale e meridionale', 'Vanellus armatus', 'Erbivoro', '2014-06-13', 9, 'Uccello', ' Charadriidae', 9),
('A9A3', 'Si tratta di uccelli dall aspetto slanciato, muniti di lunga coda rettangolare e becco conico e appuntito', 'Uraeginthus granatina', 'Onnivoro', '2012-07-04', 11, 'Uccello', ' Estrildidi', 9),
('A9A4', 'Vive in ambienti aridi ed è lunga circa 60 cm di cui la metà spetta alla sola coda', 'Heloderma horridum', 'Carnivoro', '2012-05-02', 11, 'Rettile', '	Helodermatidae', 9),
('A10A1', 'È di un colore tra il rosso e il marrone, il muso verso il grigio; il mantello è fulvo in estate', 'Capreolus capreolus', 'Erbivoro', '2008-10-15', 15, 'Mammifero', 'Cervidae', 10),
('A10A2', 'La lunghezza ed il peso medi di questa specie adulta rientrano tra 250/300cm x 10/15kg i maschi e tra 250/350cm x 10/20kg le femmine', 'Boa constrictor', 'Carnivoro', '2018-05-01', 5, 'Rettile', 'Boidi', 10),
('A10A3', 'Il collo è muscoloso e sorregge una testa adornata da due grandi corna ad anelli che possono raggiungere i 150 cm di lunghezza', 'Oryx gazella', 'Onnivoro', '2005-07-10', 18, 'Mammifero', 'Bovidae', 10),
('A10A4', 'È un piccolo uccello passeriforme che nidifica nella Africa meridionale', 'Nectarinia chalybea', 'Onnivoro', '2015-10-22', 8, 'Uccello', '	Nectariniidae', 10),
('A11A1', 'È lungo da 19 a 21 cm e pesa dai 30 ai 48 gr', 'Pycnonotus nigricans', 'Onnivoro', '2002-07-26', 21, 'Uccello', ' Pycnonotidae', 11),
('A11A2', 'Il pelo è molto folto e di maggiore lunghezza nella parte inferiore del corpo e nella coda', 'Bos mutus', 'Erbivoro', '2011-10-31', 12, 'Mammifero', 'Bovidae', 11),
('A11A3', 'Vive in Australia, Nuova Zelanda e Nuova Caledonia, nonché sulle isole limitrofe', 'Larus novaehollandiae', 'Carnivoro', '2004-08-04', 19, 'Uccello', 'Laridi', 11),
('A11A4', 'Vive su gran parte delle catene montuose della Asia centrale.', 'Ovis ammon', 'Erbivoro', '2001-10-06', 22, 'Mammifero', 'Bovidae', 11),
('A12A1', 'Con i suoi 20 cm di lunghezza per oltre 100 g di peso, questo ragno è uno dei rappresentanti più grandi al mondo dell intero ordine Araneae', 'Lasiodora parahybana', 'Carnivoro', '2006-04-12', 17, 'Rettile', 'Theraphosidae', 12),
('A12A2', 'Vive nella parte occidentale dell areale del panda rosso, in particolare in Nepal, Assam, Sikkim e Bhutan', ' Ailurus fulgens', 'Onnivoro', '2003-06-02', 20, 'Mammifero', 'Ailuridae', 12),
('A12A3', 'Vive nelle regioni montuose del Sichuan', 'Ailuropoda melanoleuca', 'Onnivoro', '2000-04-26', 23, 'Mammifero', 'Ursidae', 12),
('A12A4', 'Diffusa in Australia settentrionale e Nuova Guinea', 'Macropus agilis', 'Carnivoro', '2019-08-10', 4, 'Mammifero', 'Macropodidae', 12),
('A13A1', 'È la specie di dimensioni maggiori: il peso varia tra 15 e 31 kg, la lunghezza del corpo può raggiungere 115 cm, quella della coda i 70 cm', 'Papio ursinus', 'Onnivoro', '2009-04-15', 14, 'Mammifero', 'Cercopithecidae', 13),
('A13A2', 'Medie dimensioni originaria delle pampas', 'Pseudalopex gymnocercus', 'Carnivoro', '2017-06-12', 6, 'Mammifero', 'Canidae', 13),
('A13A3', 'Diffusa in America del Nord e nell estremità nord-orientale dell Asia', 'Grus canadensis', 'Erbivoro', '2011-11-04', 12, 'Uccello', 'Gruidae', 13),
('A13A4', 'È un grande uccello trampoliere', 'Ephipplorhynchus senegalensis', 'Erbivoro', '2004-08-02', 19, 'Uccello', 'Ciconiidae', 13),
('A14A1', 'È la tartaruga terrestre più grande al mondo', 'Geochelone elephantopus', 'Carnivoro', '2002-09-22', 21, 'Rettile', 'Testudinidae', 14),
('A14A2', 'Caratteristici sono gli unghioni che armano le cinque dita degli arti anteriori', 'Priodontes maximus', 'Erbivoro', '2011-06-17', 12, 'Mammifero', 'Chlamyphoridae', 14),
('A14A3', 'Abita le aree aride di Namibia, Botswana, Zimbabwe occidentale e meridionale, Mozambico meridionale e Sudafrica', 'Hyaena brunnea', 'Onnivoro', '2006-06-28', 17, 'Mammifero', 'Hyaenidae', 14),
('A14A4', 'Dopo la tigre, è il più grande dei cinque grandi felidi del genere Panthera', 'Panthera Leo', 'Carnivoro', '2022-07-02', 1, 'Mammifero', 'Felidae', 14),
('A15A1', 'Coda cuneiforme, iride marrone scura con un anello oculare grigio, becco grigio-bluastro chiaro', 'Pterocles gutturalis', 'Erbivoro', '2006-07-26', 17, 'Uccello', 'Pteroclidae', 15),
('A15A2', 'È robusto, abbastanza basso sulle zampe, con una coda relativamente lunga per un animale imparentato con le linci delle regioni fredde-temperate. La testa, piccola, porta orecchie molto lunghe, appuntite', 'Felis caracal', 'Carnivoro', '2008-04-12', 15, 'Mammifero', 'Felidae', 15),
('A15A3', 'Diffuso negli Stati Uniti e nel Canada meridionale lungo la catena delle Montagne Rocciose', 'Spermophilus lateralis', 'Erbivoro', '2002-05-02', 21, 'Mammifero', 'Sciuridae', 15),
('A15A4', 'Abita la volta delle foreste pluviali dall America centrale al Brasile e all Argentina settentrionale', 'Bradypus tridactylus', 'Erbivoro', '2022-01-03', 1, 'Mammifero', 'Bradypodidae', 15),
('A16A1', 'Presente in gran parte del Nordamerica, compreso il Canada meridionale, gli Stati Uniti e il Messico settentrionale', 'Mephitis mephitis', 'Onnivoro', '2001-10-12', 22, 'Mammifero', 'Mephitidae', 16),
('A16A2', 'Alta 60-90 centimetri e pesa tra i 13 e i 16 kilogrammi', 'Gazella thompsonii', 'Onnivoro', '2012-08-10', 11, 'Mammifero', 'Bovidae', 16),
('A16A3', 'È un cosiddetto predatore alfa, ovvero si colloca all apice della catena alimentare, non avendo predatori in natura, a parte l uomo', 'Panthera Tigris', 'Carnivoro', '2005-02-10', 18, 'Mammifero', 'Felidae', 16),
('A16A4', 'Ha un lungo becco appuntito e le palpebre bluastre', 'Cacatua tenuirostris', 'Onnivoro', '2017-05-02', 6, 'Uccello', 'Cacatuidae', 16),
('A17A1', 'Diffuso in Canada e nella parte nord-orientale degli Stati Uniti', 'Marmota monax', 'Erbivoro', '2000-02-24', 23, 'Mammifero', 'Sciuridae', 17),
('A17A2', 'Felino solitario e opportunista, il leopardo è ampiamente diffuso in Africa e in Asia sud-orientale', 'Panthera Pardus', 'Carnivoro', '2015-10-14', 8, 'Mammifero', 'Felidae', 17),
('A17A3', 'È una specie domestica che deriva dal Guanaco e a questo assomiglia per la morfologia e per il comportamento', 'Lama glama', 'Erbivoro', '2022-01-22', 1, 'Mammifero', 'Camelidae', 17),
('A17A4', 'Aspetto robusto e slanciato, muniti di grossa testa arrotondata, becco conico e robusto di media lunghezza', 'Dicrurus adsimilis', 'Erbivoro', '2007-02-10', 16, 'Uccello', 'Dicruridae', 17),
('A18A1', 'Ha il piumaggio completamente bianco che non cambia nell arco dell anno. Il becco è generalmente giallo e le zampe sono di colore nerastro o giallo sbiadito alla base durante l anno', 'Casmerodius albus', 'Onnivoro', '2022-02-21', 1, 'Uccello', 'Ardeidae', 18),
('A18A2', 'Diffuso nel continente americano', 'Egretta thula', 'Erbivoro', '2017-01-25', 6, 'Uccello', 'Ardeidae', 18),
('A18A3', 'Vive prevalentemente in stagni di acqua dolce e paludi', 'Alligator mississippiensis', 'Carnivoro', '2013-04-02', 10, 'Rettile', 'Alligatoridae', 18),
('A18A4', 'Il capo è rosso vivo, petto e penne remiganti sono bianche ed il resto del corpo è grigio scuro', 'Melanerpes erythrocephalus', 'Erbivoro', '2022-05-02', 1, 'Uccello', 'Picidae', 18),
('A19A1', 'Collo lungo diffusa in alcune regioni dell Africa orientale', 'Litrocranius walleri', 'Onnivoro', '2013-02-19', 10, 'Mammifero', 'Bovidae', 19),
('A19A2', 'Nativa della regione artica', 'Alopex lagopus', 'Erbivoro', '2004-12-14', 19, 'Mammifero', 'Canidae', 19),
('A19A3', 'La testa ha forma triangolare, le orecchie sono piccole e prive di pelo, gli occhi sono invece molto grandi', 'Petaurus breviceps', 'Erbivoro', '2008-01-27', 15, 'Mammifero', 'Petauridae', 19),
('A19A4', 'Aspetto robusto e slanciato, muniti di piccola testa arrotondata con un becco massiccio', 'Corvus albicollis', 'Onnivoro', '2003-01-01', 20, 'Uccello', 'Corvidae', 19),
('A20A1', 'La testa e il collo del maschio sono ricoperte di piume blu elettrico dai riflessi metallici. La zona intorno all occhio è nuda,', 'Pavo cristatus', 'Erbivoro', '2005-07-30', 18, 'Uccello', 'Phasianidae', 20),
('A20A2', 'È stato trovato in molte zone del Canada', 'Papilio canadensis', 'Onnivoro', '2013-10-31', 10, 'Artropode', 'Papilionidae', 20),
('A20A3', 'Ha bianche la testa, il petto, la parte anteriore sotto le ali e la coda', 'Haliaetus leucogaster', 'Erbivoro', '2020-11-03', 3, 'Uccello', 'Accipitridae', 20),
('A20A4', 'La testa è grande, il muso è ampio e arrotondato, gli occhi sono di medie dimensioni. Le squame sono lunghe, lisce e oblique', 'Naja haje', 'Carnivoro', '2005-08-13', 18, 'Rettile', 'Elapidae', 20);



--QUERY:
--Query 1:
SELECT nome, luogo FROM Parco

--Query 2:
SELECT età, COUNT(età) FROM Animale GROUP BY età ORDER BY count ASC

--Query 3:
SELECT id, nomeLatino, alimentazione FROM Animale WHERE (id= $1::varchar) --IN QUESTO CASO 'A16A4'

--Query 4:
SELECT id, nomeLatino, acquaNecessaria FROM Pianta WHERE (id= $1::varchar) --IN QUESTO CASO 'A20P4'

--Query 5:
SELECT p.id, p.nomeLatino, p.locazione, p.area, a.parco FROM Pianta AS p, Area AS a WHERE (p.area = a.id AND p.id = $1::varchar) --IN QUESTO CASO 'A20P4'

--Query 6:
SELECT tipoFoglie, COUNT(id) AS Numero_Piante FROM Pianta WHERE (tipoFoglie = $1::enumFoglie) GROUP BY tipoFoglie --IN QUESTO CASO ‘Oblunghe’ 

--Query 7:
SELECT c.nome, c.cognome FROM Cliente AS c, BigliettoEvento AS b, Evento AS e WHERE (c.codiceFiscale = b.codiceFiscaleCliente AND b.evento = e.id AND e.organizzatore = $1::int) --IN QUESTO CASO '7'

--Query 8:
SELECT DISTINCT d.id, d.nome, d.cognome FROM Dipendente AS d, Spiega AS s, TourGuidato AS t WHERE (d.id = s.dipendente AND s.tour = t.id AND t.tipoTour = $1::enumTour) --IN QUESTO CASO 'Fauna'

--Query 9:
SELECT id, nome, tipoDipendente, guadagno FROM Dipendente WHERE (guadagno > $1::int) ORDER BY guadagno DESC --IN QUESTO CASO '4500'

--Query 10:
SELECT COUNT(*)AS Ridotti FROM (SELECT id FROM BigliettoEvento WHERE ridotto = true UNION SELECT id FROM BigliettoTour WHERE ridotto = true) AS r

--Query 11:
SELECT id, nomeLatino, locazione FROM Pianta WHERE (dataTrapianto < $1::timestamp) --IN QUESTO CASO '2001-01-01'

--Query 12:
SELECT nomeLatino FROM Animale WHERE (Animale.id = $1::varchar) /*IN QUESTO CASO 'A16A4' - VUOTO*/ UNION SELECT nomeLatino FROM Pianta WHERE (Pianta.id = $1::varchar) --IN QUESTO CASO 'A16A4' – NON VUOTO

--Query 13:
SELECT parco, AVG(guadagno) FROM Dipendente GROUP BY parco HAVING (parco = $1::varchar) --IN QUESTO CASO 'Parco Nazionale dello Stelvio'

--Query 14:
SELECT tour, SUM(prezzo) AS somma
FROM bigliettoTour
WHERE (parco = $1::varchar) /*IN QUESTO CASO ‘Parco Nazionale dello Stelvio’*/ GROUP BY prezzo, tour
ORDER BY somma DESC

SELECT evento, SUM(prezzo) AS somma
FROM bigliettoEvento
WHERE (parco = $1::varchar) /*IN QUESTO CASO ‘Parco Nazionale dello Stelvio’*/ GROUP BY prezzo, evento ORDER BY somma DESC

SELECT SUM(prezzo) AS totale
FROM (SELECT prezzo FROM BigliettoTour WHERE parco = $1::varchar /*IN QUESTO CASO ‘Parco Nazionale dello Stelvio’*/
UNION ALL
SELECT prezzo FROM BigliettoEvento WHERE parco = $1::varchar) AS u