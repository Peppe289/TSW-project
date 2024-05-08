DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE prodotto (
    id_categoria VARCHAR(50),
    id_prodotto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    iva FLOAT DEFAULT 0.22,
    descrizione VARCHAR(255) NOT NULL,
    prezzo FLOAT NOT NULL,
    disponibilita ENUM("SI", "NO") NOT NULL,
    quantita INT DEFAULT 0,
    alimentazione VARCHAR(50),
    categoria VARCHAR(50)
);
CREATE INDEX idx_id_categoria ON prodotto (id_categoria);

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
    id_categoria varchar (50),
    descrizione VARCHAR(255) NOT NULL,
    prezzo_scontato FLOAT NOT NULL,
    data_inizio DATE NOT NULL,
    data_fine DATE NOT NULL,
    foreign key (id_categoria) references prodotto (id_categoria) ON DELETE SET NULL ON UPDATE CASCADE
);
