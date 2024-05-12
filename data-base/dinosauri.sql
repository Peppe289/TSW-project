DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE prodotto (
    /* Identifica univocamente le proprietà del prodotto */
    id_prodotto VARCHAR(50) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    photo_path VARCHAR(50),
    alimentazione VARCHAR(50),
    descrizione VARCHAR(255) NOT NULL,
    /* identifica la classificazione per tipo */
    categoria VARCHAR(50),
    prezzo float
);

CREATE TABLE elemento_prodotto (
    /* id_prodotto specifica il tipo di prodotto. */
    id_prodotto VARCHAR(50),
    /* id_elemento specifica il singolo elemento come prodotto. */
    id_elemento INT AUTO_INCREMENT PRIMARY KEY,
    iva FLOAT DEFAULT 0.22,
    /**
     * Consideriamo questo valore solo se non c'è più disponibilità.
     * Significa che il prodotto è già acquistato e dobbiamo vedere il prezzo "congelato".
     * Se c'è disponibilità allora andiamo a vedere il prezzo dentro prodotto.
     */
    prezzo FLOAT,
    /**
     * Disponibilità per singola entità.
     * Quando si va a vedere un prodotto di questo tipo si cerca
     * il primo con la disponibilità true.
     */
    disponibilita boolean NOT NULL,
    /**
     * quantita INT DEFAULT 0, => non è necessario, tramite
     * il model java andiamo a vedere tutta la tabella con
     * quelli venduti e quelli disponibili:
     * 	ResultSet rs = ps.executeQuery();
     * 		while (rs.next()) {...}
     */
     foreign key (id_prodotto) references prodotto (id_prodotto) ON DELETE SET NULL ON UPDATE CASCADE
);
CREATE INDEX idx_id_prodotto ON prodotto (id_prodotto);

create table utente (
id_utente int auto_increment primary key,
password_utente varchar(255) not null,
nome varchar(255) not null,
cognome varchar(255) not null, 
email varchar(255) not null unique
);

create table ordini (
numero_ordine int auto_increment primary key,
prezzo_totale double not null,
lista_prodotti varchar (255) not null,
data_acquisto date not null,
id_utente int,
foreign key (id_utente) references utente (id_utente) ON DELETE SET NULL ON UPDATE CASCADE
);

create table indirizzo_spedizione (
nome varchar (255) not null,
cognome varchar (255) not null,
cf char(16) primary key,
via varchar(255) not null,
cap char(5) not null,
provincia char(2) not null,
comune varchar(255) not null,
numero_civico varchar(255) not null
);

create table amministratore (
identificativo int auto_increment primary key,
password varchar (255) not null
);

CREATE TABLE offerte (
    id_offerta INT AUTO_INCREMENT PRIMARY KEY,
    id_prodotto varchar (50),
    descrizione VARCHAR(255) NOT NULL,
    prezzo_scontato FLOAT NOT NULL,
    data_inizio DATE NOT NULL,
    data_fine DATE NOT NULL,
    foreign key (id_prodotto) references prodotto (id_prodotto) ON DELETE SET NULL ON UPDATE CASCADE
);
