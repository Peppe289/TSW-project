USE ecommerce;

INSERT INTO prodotto (id_prodotto, nome, photo_path, descrizione, alimentazione, categoria, prezzo) VALUES
('TR', 'T-rex', NULL, 'Il Tyrannosaurus rex, comunemente noto come T-rex, è uno dei più grandi e famosi dinosauri carnivori. Caratterizzato da un cranio massiccio con denti lunghi e appuntiti, è un predatore formidabile. Con le sue poderose zampe posteriori, il T-rex è in grado di raggiungere velocità sorprendenti durante la caccia, rendendolo uno dei predatori dominanti.', 'carnivoro', 'dinosauro',  21.00),
('BR', 'Brachiosauro', NULL, 'Il Brachiosaurus è uno dei più grandi e imponenti dinosauri erbivori conosciuti. Caratterizzato da un corpo massiccio sostenuto da zampe anteriori più lunghe delle zampe posteriori, il Brachiosaurus si distingue per il suo lungo collo che gli consente di raggiungere i rami più alti degli alberi per nutrirsi. ', 'erbivoro', 'dinosauro',  25.50),
('ST', 'Stegosauro', NULL, 'Lo Stegosauro era un dinosauro erbivoro caratterizzato da una serie di placche ossee lungo il dorso e una lunga coda dotata di punte o spuntoni. Questa creatura preistorica vagava sulle terre del periodo Giurassico, nutrendosi di materiale vegetale grazie ai suoi piccoli denti piatti adatti a triturare.', 'erbivoro','dinosauro',  18.00),
('VL', 'Velociraptor', NULL, 'Il Velociraptor era un dinosauro carnivoro noto per la sua agilità e intelligenza. Viveva durante il periodo Cretaceo e si ritiene che cacciasse in branco, nutrendosi principalmente di piccoli animali come altri dinosauri, rettili e insetti. Con le sue lunghe zampe posteriori e artigli affilati sulle zampe, il Velociraptor era un predatore formidabile, capace di raggiungere velocità sorprendenti durante la caccia.', 'carnivoro', 'dinosauro',  15.00),
('TC', 'Triceratopo', NULL, 'Il Triceratopo era un grande dinosauro erbivoro caratterizzato da tre corna distintive sul cranio. Viveva durante il periodo Cretaceo e si distingueva per il suo becco robusto e i denti adatti per strappare e triturare il cibo. Con il suo aspetto imponente e le sue difese naturali, il Triceratopo rappresentava una presenza dominante nel suo habitat. Si pensa che fosse un animale pacifico, ma capace di difendersi dagli attacchi dei predatori con le sue corna e il suo grande corpo robusto.', 'erbivoro', 'dinosauro',  17.00),
('PT', 'Pterodattilo', NULL, 'Lo Pterodattilo era un dinosauro volante appartenente al gruppo dei pterosauri. Viveva durante il periodo Cretaceo e si distingueva per la sua grande apertura alare, che poteva superare i sei metri. Si ritiene che fosse principalmente un pescatore, ma poteva cacciare anche piccoli animali terrestri. Con il suo corpo leggero e le sue ali membranose, lo Pterodattilo dominava i cieli preistorici, rappresentando una delle più grandi creature volanti conosciute nella storia della Terra.', 'carnivoro', 'dinosauro',  17.50),
('CR', 'Ciro', NULL, 'Cir o Dinosaur', 'carnivoro', 'dinosauro', 120000),
('OVR', 'Oviraptor', NULL, 'L\'Oviraptor è un piccolo dinosauro onnivoro noto per il suo becco adatto a rompere uova e ossa. Con il suo corpo leggero e le sue caratteristiche uniche, l\'Oviraptor è uno degli esemplari più interessanti e studiati della sua epoca.', 'onnivoro', 'dinosauro', 12.00),
('MR', 'Microraptor', NULL, 'Il Microraptor è un  piccolo dinosauro provvisto di quattro ali, originario del Cretaceo. Con i suo circa 40 cm di lunghezza in età adulta ed un peso di circa 1 Kg, il Microraptor rappresenta il più piccolo dinosauro carnivoro mai scoperto', 'carnivoro', 'dinosauro', 9.0),
('UTR', 'Uovo di T-rex', NULL, 'Uovo di T-rex trovato in buono stato', NULL, 'uovo',  10.5),
('UBR', 'Uovo di Brachiosauro', NULL, 'Uovo di Brachiosauro parzialmente danneggiato', NULL, 'uovo',  15.0),
('UST', 'Uovo di Stegosauro', NULL, 'Uovo di Stegosauro ben conservato', NULL, 'uovo',  7.99),
('UVL', 'Uovo di Velociraptor', NULL, 'Uovo di Velociraptor ben conservato', NULL, 'uovo',  10.0),
('UTC', 'Uovo di Triceratopo', NULL, 'Uovo di Triceratopo leggermente aperto', NULL, 'uovo',  6.99),
('UPT', 'Uovo di Pterodattilo', NULL, 'Uovo di Pterodattilo ben conservato', NULL, 'uovo',  8.50),
('OTR', 'Ossa di T-rex', NULL, 'Ossa di uno dei più grandi e famosi dinosauri carnivori', NULL, 'ossa',  25.00),
('OBR', 'Ossa di Brachiosauro', NULL, 'Ossa del più grande dinosauro erbivoro', NULL, 'ossa',  15.00),
('OST', 'Ossa di Stegosauro', NULL, 'Ossa di uno dei più iconici dinosauri erbivori, con le caratteristiche placche dorsali', NULL, 'ossa',  7.99),
('OVL', 'Ossa di Velociraptor', NULL, 'Ossa di uno dei più noti e agili dinosauri carnivori, famoso per la sua velocità e intelligenza', NULL, 'ossa',  10.0),
('OTC', 'Ossa di Triceratopo', NULL, 'Ossa del grande dinosauro erbivoro dotato di corna distintive', NULL, 'ossa',  6.99),
('OPT', 'Ossa di Pterodattilo', NULL, 'Ossa del grande rettile volante noto come Pterodattilo, con una vasta apertura alare', NULL, 'ossa',  8.50),
('GM', 'Guizaglio medio', NULL, 'Guinzaglio in pelle per dinosauro di taglia media', NULL, 'guinzaglio',  20.00),
('GG', 'Guinzaglio gigante', NULL, 'Guinzaglio robusto per dinosauro gigante', NULL, 'guinzaglio',  30.00);

INSERT INTO elemento_prodotto (id_prodotto, prezzo, disponibilita) VALUES
('TR', NULL, true),
('BR', NULL, true),
('ST', NULL, true),
('VL', NULL, true),
('TC', NULL, true),
('PT', NULL, true),
('CR', NULL, true),
('OVR', NULL, true),
('MR', NULL, true),
('UTR', NULL, true),
('UBR', NULL, true),
('UST', NULL, true),
('UVL', NULL, true),
('UTC', NULL, true),
('UPT', NULL, true),
('OTR', NULL, true),
('OBR',NULL, true),
('OST', NULL, true),
('OVL', NULL, true),
('OTC', NULL, true),
('OPT', NULL, true),
('GM', NULL, true),
('GG', NULL, true);

INSERT INTO utente (password_utente, nome, cognome, email) VALUES 
(sha1('ciao1'), 'Mario', 'Rossi', 'mario.rossi@gmail.com'),
(sha1('sole2'), 'Ciro', 'Esposito', 'ciro.esposito@gmail.com');

INSERT INTO dati_spedizione (nome, cognome, via, cap, provincia, comune, numero_civico) VALUES
('Mario', 'Rossi', 'via Roma', '10024', 'TO', 'Torino', '3' ),
('Ciro', 'Esposito', 'via Chiaia', '80013', 'NA', 'Napoli', '144');

INSERT INTO amministratore (password) VALUES
('admin1'),
('admin2');

INSERT INTO ordini (prezzo_totale, lista_prodotti, data_acquisto) VALUES
('35.5','UTR, BR','2024-01-20'),
('26','UTC, TC','2024-03-15');

INSERT INTO offerte (id_prodotto, descrizione, percentuale, data_inizio, data_fine) VALUES 
('TR', 'Offerta speciale - 10% di sconto sui T-rex', 10, '2024-04-01', '2024-04-15'),
('GM', 'Offerta guinzagli medi - 20% di sconto sui guinzagli medi', 20, '2024-04-05', '2024-04-30');
