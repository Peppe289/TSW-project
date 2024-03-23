USE ecommerce;
INSERT INTO dinosauro (id, nome, categoria, lunghezza, alimentazione, regione_geografica, prezzo, descrizione, disponibilita, quantità) VALUES
('TR', 'T-rex', 'rettile', 15, 'carnivoro', 'Nord America', 21.0, 'predatore gigantesco e uno dei più famosi dinosauri carnivori. Si ritiene che cacciasse grandi erbivori', 'SI', 30),
('BR', 'Brachiosauro', 'rettile', 25, 'erbivoro', 'Nord America', 25.5, 'Il Brachiosaurus era un grande dinosauro erbivoro caratterizzato dal lungo collo e le zampe anteriori più lunghe delle zampe posteriori.', 'SI', 25),
('ST', 'Stegosauro', 'rettile', 9, 'erbivoro', 'Europa Occidentale', 18.0, 'Aveva piccoli denti piatti adatti a triturare il materiale vegetale.', 'SI', 38),
('VL', 'Velociraptor', 'rettile', 2 , 'carnivoro', 'Asia Centrale', 15.0, 'Si ritiene che cacciasse in branco e si nutrisse di piccoli animali come piccoli dinosauri, rettili e insetti.', 'SI', 50),
('TC', 'Triceratopo', 'rettile', 9 , 'erbivoro', 'Nord America', 17.0, 'Aveva un becco robusto e denti adatti per strappare e triturare il cibo.', 'SI', 60);

INSERT INTO uova (id_dinosauro, id_uova, dimensione, peso, descrizione, prezzo, disponibilita, quantità) VALUES
('TR', 'UovoTR', 'Grande', 1.5, 'Uovo di T-rex trovato in buono stato', 10 ,'SI', 30),
('BR', 'UovoBR', 'Molto grande', 2.0, 'Uovo di Brachiosauro parzialmente danneggiato', 15 , 'SI', 52),
('ST', 'UovoST', 'Piccolo', 0.7, 'Uovo di Stegosauro ben conservato', 7, 'SI', 20),
('VL', 'UovoVL', 'Grande', 1.7, 'Uovo di Velociraptor ben conservato',10 , 'SI', 25),
('TC', 'UovoTC','Piccolo', 0.6, 'Uovo di Triceratopo leggermente aperto', 6, 'SI', 10);

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
('35.5','UovoTR, BR','2024-01-20', 'MR1'),
('26','UovoTC, TC','2024-03-15', 'CE1');