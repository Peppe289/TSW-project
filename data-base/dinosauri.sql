drop database if exists ecommerce;
create database ecommerce;
use ecommerce;


create table dinosauro (
id varchar(255) primary key,
nome varchar (100) not null,
categoria varchar (50) not null,
lunghezza float not null,
dieta varchar (50) not null,
regione_geografica varchar (100) not null,
prezzo float not null,
descrizione varchar (255) not null
);

create table ordini (
numero_ordine int not null auto_increment,
prezzo_totale double not null,
lista_prodotti varchar (255) not null,
data_acquisto date not null,
primary key (numero_ordine) 
);

create table utente (
password_utente varchar(255) not null,
nome varchar(255) not null,
cognome varchar(255) not null, 
email varchar(255) not null,
via varchar(255) not null,
cap char(5) not null,
provincia varchar(255) not null,
comune varchar(255) not null,
numero_civico varchar(255) not null,
primary key (email)
);

create table admin (
identificativo varchar (50) not null,
password varchar (255)
);
