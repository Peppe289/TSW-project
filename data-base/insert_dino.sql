USE ecommerce;

INSERT INTO prodotto (id_prodotto, nome, photo_path, descrizione, alimentazione, categoria, prezzo) VALUES
('TR', 'T-rex', NULL, 'predatore gigantesco e uno dei più famosi dinosauri carnivori. Si ritiene che cacciasse grandi erbivori', 'carnivoro', 'rettile',  21.00),
('BR', 'Brachiosauro', NULL, 'Il Brachiosaurus era un grande dinosauro erbivoro caratterizzato dal lungo collo e le zampe anteriori più lunghe delle zampe posteriori.', 'erbivoro', 'rettile',  25.50),
('ST', 'Stegosauro', NULL, 'Aveva piccoli denti piatti adatti a triturare il materiale vegetale.', 'erbivoro','rettile',  18.00),
('VL', 'Velociraptor', NULL, 'Si ritiene che cacciasse in branco e si nutrisse di piccoli animali come piccoli dinosauri, rettili e insetti.', 'carnivoro', 'rettile',  15.00),
('TC', 'Triceratopo', NULL, 'Aveva un becco robusto e denti adatti per strappare e triturare il cibo.', 'erbivoro', 'rettile',  17.00),
('PT', 'Pterodattilo', NULL, 'Era uno dei più grandi e più conosciuti dinosauri. Aveva una apertura alare di oltre 6 metri e si ritiene che fosse principalmente un pescatore.', 'carnivoro', 'uccello',  17.50),
('UTR', 'Uovo di T-rex', NULL, 'Uovo di T-rex trovato in buono stato', NULL, 'uovo',  10.5),
('UBR', 'Uovo di Brachiosauro', NULL, 'Uovo di Brachiosauro parzialmente danneggiato', NULL, 'uovo',  15.0),
('UST', 'Uovo di Stegosauro', NULL, 'Uovo di Stegosauro ben conservato', NULL, 'uovo',  7.99),
('UVL', 'Uovo di Velociraptor', NULL, 'Uovo di Velociraptor ben conservato', NULL, 'uovo',  10.0),
('UTC', 'Uovo di Triceratopo', NULL, 'Uovo di Triceratopo leggermente aperto', NULL, 'uovo',  6.99),
('UPT', 'Uovo di Pterodattilo', NULL, 'Uovo di Pterodattilo ben conservato', NULL, 'uovo',  8.50),
('OC', 'Osso per dinosauro Carnivoro', NULL, 'Osso grande per dinosauro carnivoro', NULL, 'osso',  25.00),
('OE', 'Osso per dinosauro Erbivoro', NULL, 'Osso piccolo per dinosauro erbivoro', NULL, 'osso',  15.00),
('GM', 'Guizaglio medio', NULL, 'Guinzaglio in pelle per dinosauro di taglia media', NULL, 'guinzaglio',  20.00),
('GG', 'Guinzaglio gigante', NULL, 'Guinzaglio robusto per dinosauro gigante', NULL, 'guinzaglio',  30.00);

INSERT INTO elemento_prodotto (id_prodotto, prezzo, disponibilita) VALUES
('TR', NULL, true),
('BR', NULL, true),
('ST', NULL, true),
('VL', NULL, true),
('TC', NULL, true),
('PT', NULL, true),
('UTR', NULL, true),
('UBR', NULL, true),
('UST', NULL, true),
('UVL', NULL, true),
('UTC', NULL, true),
('UPT', NULL, true),
('OC', NULL, true),
('OE', NULL, true),
('GM', NULL, true),
('GG', NULL, true);

INSERT INTO utente (password_utente, nome, cognome, email) VALUES 
(sha1('ciao1'), 'Mario', 'Rossi', 'mario.rossi@gmail.com'),
(sha1('sole2'), 'Ciro', 'Esposito', 'ciro.esposito@gmail.com');

INSERT INTO indirizzo_spedizione (nome, cognome, cf, via, cap, provincia, comune, numero_civico) VALUES
('Mario', 'Rossi', 'RSSMRA80M07L219U','via Roma', '10024', 'TO', 'Torino', '3' ),
('Ciro', 'Esposito', 'SPSCRI78L06F839T', 'via Chiaia', '80013', 'NA', 'Napoli', '144');

INSERT INTO amministratore (password) VALUES
('admin1'),
('admin2');

INSERT INTO ordini (prezzo_totale, lista_prodotti, data_acquisto) VALUES
('35.5','UTR, BR','2024-01-20'),
('26','UTC, TC','2024-03-15');

INSERT INTO offerte (descrizione, prezzo_scontato, data_inizio, data_fine) 
VALUES 
('Offerta speciale - 10% di sconto su tutti i dinosauri', 18.90, '2024-04-01', '2024-04-15'),
('Offerta guinzagli - Acquista 2 e ottieni il 50% di sconto sul secondo', 7.50, '2024-04-05', '2024-04-30');
