create database Ceres;
use Ceres;

create table Usuario(
idUser int auto_increment,
nome varchar(45),
email varchar(60), constraint chkemail check (email like '%@%'),
senha varchar(30),
username varchar(45),
dtnasc date,
ddd char(2),
telefone varchar(9),
CPF char(14) unique,
primary key (idUser)
);

create table Especie(
idEspecie int primary key auto_increment,
nome varchar(45),
temp_min decimal,
temp_max decimal,
umi_min decimal,
umi_max decimal
);

create table Armazem(
idArmazem int,
estado char(2),
cidade varchar(45),
bairro varchar(45),
fkUser int,
fkEspecie int,
constraint chkestado check (estado in ('AC','AL','AP','AM','BA','CE','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO')),
constraint fkusuario foreign key (fkUser) references Usuario(idUser),
constraint fkespecie foreign key (fkEspecie) references Especie(idEspecie),
primary key (idArmazem)
);

create table Sensor(
idSensor int,
DHT11 varchar(45),
fkArmazem int,
constraint fkarmazem foreign key (fkArmazem) references Armazem(idArmazem),
primary key (idSensor)
);

create table Metrica(
idMetrica int,
horario datetime,
temperatura double,
umidade double,
fkSensor int,
constraint fksensor foreign key (fkSensor) references Sensor(idSensor),
primary key (idMetrica, fkSensor)
);