DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE prodotto (
    /* Identifica univocamente le proprietà del prodotto */
    id_prodotto VARCHAR(50) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    photo_path VARCHAR(50),
    alimentazione VARCHAR(50),
    descrizione TEXT NOT NULL,
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

create table token (
    id_utente int primary key,
    token varchar(50) not null,
    foreign key (id_utente) references utente (id_utente) ON DELETE SET NULL ON UPDATE CASCADE
);

create table prodotto_carrello (
    /* Relativo al prodotto generale */
    id_prodotto int,
    numero_ordine int,
    primary key (id_prodotto, numero_ordine),
    foreign key (id_prodotto) references prodotto (id_prodotto) ON UPDATE CASCADE,
    foreign key (numero_ordine) references ordini (numero_ordine)
);

create table prodotto_ordine (
    /* Relativo allo specifico elemento */
    id_elemento int,
    numero_ordine int,
    primary key (id_elemento, numero_ordine),
    foreign key (id_elemento) references elemento_prodotto (id_elemento) ON UPDATE CASCADE,
    foreign key (numero_ordine) references ordini (numero_ordine)
);

create table ordini (
    numero_ordine int auto_increment primary key,
    data_acquisto date,
    id_utente int,
    foreign key (id_utente) references utente (id_utente) ON DELETE SET NULL ON UPDATE CASCADE
);

create table dati_spedizione (
nome varchar (255) not null,
cognome varchar (255) not null,
id_spedizione int auto_increment primary key,
via varchar(255) not null,
cap char(5) not null,
provincia char(2) not null,
comune varchar(255) not null,
numero_civico varchar(255) not null
);

create table amministratore (
    identificativo int auto_increment primary key,
    password varchar (255) not null,
    /* Permessi differenti per admin differenti. */
    permission int NOT NULL default 2,
    check ( permission >= 0 AND permission < 3 )
);

CREATE TABLE offerte (
    id_offerta INT AUTO_INCREMENT PRIMARY KEY,
    id_prodotto varchar (50),
    descrizione VARCHAR(255) NOT NULL,
    percentuale INT NOT NULL,
    data_inizio DATE NOT NULL,
    data_fine DATE NOT NULL,
    foreign key (id_prodotto) references prodotto (id_prodotto) ON DELETE SET NULL ON UPDATE CASCADE
);
