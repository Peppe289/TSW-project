USE ecommerce;

INSERT INTO prodotto (id_prodotto, nome, descrizione, prezzo, disponibilita, quantita, alimentazione, categoria) VALUES
('TR','T-rex', 'predatore gigantesco e uno dei più famosi dinosauri carnivori. Si ritiene che cacciasse grandi erbivori', 21.00,'SI', 30, 'carnivoro', 'rettile'),
('BR','Brachiosauro', 'Il Brachiosaurus era un grande dinosauro erbivoro caratterizzato dal lungo collo e le zampe anteriori più lunghe delle zampe posteriori.',25.50,  'SI', 25,'erbivoro', 'rettile'),
('ST', 'Stegosauro', 'Aveva piccoli denti piatti adatti a triturare il materiale vegetale.', 18.00,  'SI', 38, 'erbivoro','rettile'),
('VL', 'Velociraptor', 'Si ritiene che cacciasse in branco e si nutrisse di piccoli animali come piccoli dinosauri, rettili e insetti.', 15.00, 'SI', 50, 'carnivoro','rettile'),
('TC', 'Triceratopo', 'Aveva un becco robusto e denti adatti per strappare e triturare il cibo.', 17.00, 'SI', 60,'erbivoro', 'rettile'),
('PT', 'Pterodattilo', 'Era uno dei più grandi e più conosciuti dinosauri. Aveva una apertura alare di oltre 6 metri e si ritiene che fosse principalmente un pescatore.', 17.5, 'SI', 26, 'carnivoro', 'uccello'),
('UTR', 'Uovo di T-rex', 'Uovo di T-rex trovato in buono stato', 10.5 ,'SI', 30, NULL, NULL),
('UBR', 'Uovo di Brachiosauro', 'Uovo di Brachiosauro parzialmente danneggiato', 15.0 , 'SI', 52, NULL, NULL),
('UST', 'Uovo di Stegosauro', 'Uovo di Stegosauro ben conservato', 7.99, 'SI', 20, NULL, NULL),
('UVL', 'Uovo di Velociraptor', 'Uovo di Velociraptor ben conservato',10.00 , 'SI', 25, NULL, NULL),
('UTC', 'Uovo di Triceratopo', 'Uovo di Triceratopo leggermente aperto', 6.99, 'SI', 10, NULL, NULL),
('UPT', 'Uovo di Pterodattilo', 'Uovo di Pterodattilo ben conservato', 8.50, 'SI', 34, NULL, NULL), 
('OC', 'Osso per dinosauro Carnivoro', 'Osso grande per dinosauro carnivoro', 25.00, 'SI', 20, NULL, NULL),
('OE', 'Osso per dinosauro Erbivoro', 'Osso piccolo per dinosauro erbivoro', 15.00, 'SI', 30, NULL, NULL),
('GM', 'Guizaglio medio', 'Guinzaglio in pelle per dinosauro di taglia media', 20.00, 'SI', 15, NULL, NULL),
('GG', 'Guinzaglio gigante', 'Guinzaglio robusto per dinosauro gigante', 30.00, 'SI', 10, NULL, NULL);

INSERT INTO utente (id_utente, password_utente, nome, cognome, email) VALUES 
('MR1', 'ciao1', 'Mario', 'Rossi', 'mario.rossi@gmail.com'),
('CE1', 'sole2', 'Ciro', 'Esposito', 'ciro.esposito@gmail.com');

INSERT INTO indirizzo_spedizione (nome, cognome, cf, via, cap, provincia, comune, numero_civico) VALUES
('Mario', 'Rossi', 'RSSMRA80M07L219U','via Roma', '10024', 'TO', 'Torino', '3' ),
('Ciro', 'Esposito', 'SPSCRI78L06F839T', 'via Chiaia', '80013', 'NA', 'Napoli', '144');

INSERT INTO amministratore (password) VALUES
('admin1'),
('admin2');

INSERT INTO ordini (prezzo_totale, lista_prodotti, data_acquisto, id_utente) VALUES
('35.5','UTR, BR','2024-01-20', 'MR1'),
('26','UTC, TC','2024-03-15', 'CE1');

INSERT INTO offerte (descrizione, prezzo_scontato, data_inizio, data_fine) 
VALUES 
('Offerta speciale - 10% di sconto su tutti i dinosauri', 18.90, '2024-04-01', '2024-04-15'),
('Offerta guinzagli - Acquista 2 e ottieni il 50% di sconto sul secondo', 7.50, '2024-04-05', '2024-04-30');
