drop database Ceres;

create database Ceres;
use Ceres;

create table Usuario(
idUser int auto_increment,
nome varchar(45),
CNPJ char(14),
ddd char(2),
telefone varchar(9),
CEP char(8),
complemento varchar(45),
email varchar(60), constraint chkemail check (email like '%@%'),
username varchar(45),
senha varchar(30),
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
idArmazem int auto_increment,
tamanho int,
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

create table DHT11(
idSensor int auto_increment,
fkArmazem int,
constraint fkarmazem foreign key (fkArmazem) references Armazem(idArmazem),
primary key (idSensor)
);

create table Metrica(
idMetrica int,
horario datetime default current_timestamp,
temperatura double,
umidade double,
fkSensor int,
constraint fksensor foreign key (fkSensor) references DHT11(idSensor),
primary key (idMetrica, fkSensor)
);

-- INSERTS
insert into Usuario (nome, CNPJ, ddd, telefone, CEP, complemento, email, username, senha) values
('Ceres Seed', '12345678901234', '11', '999999999', '01234567', null, 'ceres@seeddashboard.com', 'CERESadmin', '1234');

insert into especie (nome, temp_min, temp_max, umi_min, umi_max) values
('Espécie 1', 10.0, 15.0, 15.0, 20.0),
('Espécie 2', 5.0, 20.0, 10.0, 25.0);

insert into armazem (tamanho, estado, cidade, bairro, fkuser, fkespecie) values
(20, 'SP','São Paulo','Bela Vista',1,1),
(29, 'RJ','Rio de Janeiro','Rocinha',1,2),
(8, 'MG','Extrema','Agenor',1,1),
(33, 'SC','Florianópolis','Centro',1,2),
(32, 'MT','Juína','Filadélfia',1,2),
(21, 'AC','Rio Branco','Ayrton Senna',1,1),
(37, 'RO','Porto Velho','Eldorado',1,2);

insert into DHT11 (fkArmazem) values
(1), (1), (2), (2), (3), (4), (4), (5), (5), (6), (6), (7), (7), (7);

insert into metrica (idMetrica, temperatura, umidade, fksensor) values
(1,11,29,10),
(1,4,74,5),
(1,2,22,3),
(1,19,16,7),
(1,13,26,9),
(1,14,38,1),
(1,3,67,8),
(2,12,47,9),
(1,9,10,14),
(3,11,25,9),
(1,18,59,11),
(2,8,39,10),
(1,15,58,12),
(1,8,42,13),
(1,19,25,4),
(2,6,24,14),
(2,9,99,11),
(2,6,71,13),
(1,15,89,2),
(2,20,44,4),
(2,11,60,8),
(1,1,50,6),
(2,20,93,3),
(2,18,54,7),
(2,8,77,5),
(3,9,63,13),
(2,5,30,1);

-- SELECT

select m.horario, m.temperatura, m.umidade, s.idSensor, a.estado, a.cidade, e.nome, u.nome, u.username, u.email from Metrica as m
	join DHT11 as s on m.fkSensor = s.idSensor
    join Armazem as a on a.idArmazem = s.fkArmazem
    join Especie as e on e.idEspecie = a.fkEspecie
    join Usuario as u on u.idUser = a.fkUser;
    
    select * from Metrica as m
	join DHT11 as s on m.fkSensor = s.idSensor
    join Armazem as a on a.idArmazem = s.fkArmazem
    join Especie as e on e.idEspecie = a.fkEspecie
    join Usuario as u on u.idUser = a.fkUser;