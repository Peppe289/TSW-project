DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;

CREATE TABLE prodotto (
id_prodotto varchar (50) primary key,
nome varchar (100) not null,
iva float default 0.22,
descrizione VARCHAR(255) NOT NULL,
prezzo FLOAT NOT NULL,
disponibilita ENUM ("SI", "NO") NOT NULL,
quantita INT DEFAULT 0,
alimentazione varchar (50),
categoria varchar (50)
);

create table utente (
id_utente varchar(255) primary key,
password_utente varchar(255) not null,
nome varchar(255) not null,
cognome varchar(255) not null, 
email varchar(255) not null
);

create table ordini (
numero_ordine int auto_increment primary key,
prezzo_totale double not null,
lista_prodotti varchar (255) not null,
data_acquisto date not null,
id_utente varchar(255) ,
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
