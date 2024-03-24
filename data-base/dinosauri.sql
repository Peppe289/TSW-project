DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;


create table dinosauro (
id varchar(255) primary key,
nome varchar (100) not null,
categoria varchar (50) not null,
lunghezza int not null,
alimentazione varchar (50) not null,
regione_geografica varchar (100) not null,
prezzo float not null,
descrizione varchar (255) not null,
disponibilita enum ("SI", "NO") not null,
quantità int default 0,
iva_prodotti float default 0.22
);

create table uova (
id_dinosauro VARCHAR(255),
id_uova varchar (255) not null,
dimensione VARCHAR(50) NOT NULL,
peso FLOAT NOT NULL,
descrizione VARCHAR(255),
prezzo float not null,
disponibilita enum ("SI", "NO") not null,
quantità int default 0,
iva_prodotti float default 0.22,
PRIMARY KEY (id_uova),
FOREIGN KEY (id_dinosauro) REFERENCES dinosauro(id) ON DELETE SET NULL ON UPDATE CASCADE
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