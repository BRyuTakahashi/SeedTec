drop database Ceres;

create database Ceres;
use Ceres;

create table Usuario(
idUser int auto_increment,
tipo varchar(45),
nome varchar(45),
CNPJ char(14),
ddd char(2),
telefone varchar(9),
estado varchar(45),
cidade varchar(45),
CEP char(8),
complemento varchar(45),
email varchar(60), 
username varchar(45),
senha varchar(30),
constraint chktipo check (tipo in ('empresa', 'produtor autônomo')),
constraint chkemail check (email like '%@%'),
constraint chkestado check (estado in ('AC','AL','AP','AM','BA','CE','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO')),
primary key (idUser)
);

create table Armazem(
idArmazem int auto_increment,
tamanho int,
especie varchar(45),
estado char(2),
cidade varchar(45),
CEP char(8),
fkUser int,
constraint chkestado2 check (estado in ('AC','AL','AP','AM','BA','CE','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO')),
constraint chkespecie check (especie in ('Café','Araucária','Cacau')),
constraint fkusuario foreign key (fkUser) references Usuario(idUser),
primary key (idArmazem)
);

create table Sensor(
idSensor int auto_increment,
tipo varchar(45),
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
constraint fksensor foreign key (fkSensor) references Sensor(idSensor),
primary key (idMetrica, fkSensor)
);

-- INSERTS
insert into Usuario (tipo, nome, CNPJ, ddd, telefone, estado, cidade, CEP, complemento, email, username, senha) values
('Empresa', 'Ceres Seed', '12345678901234', '11', '999999999', 'SP', 'São Paulo' , '01234567', null, 'ceres@seeddashboard.com', 'CERESadmin', '1234');

insert into armazem (tamanho, especie, estado, cidade, CEP, fkuser) values
(20, 'Café', 'SP','São Paulo','11111111',1),
(29, 'Café', 'RJ','Rio de Janeiro','22222222',1),
(8, 'Cacau',  'MG','Extrema','33333333',1),
(33, 'Araucária', 'SC','Florianópolis','44444444',1),
(32, 'Café', 'MT','Juína','55555555',1),
(21, 'Cacau', 'AC','Rio Branco','66666666',1),
(37, 'Araucária', 'RO','Porto Velho','77777777',1);

insert into Sensor (tipo, fkArmazem) values
('DHT11', 1), 
('DHT11', 1), 
('DHT11', 2), 
('DHT11', 2), 
('DHT11', 3), 
('DHT11', 4), 
('DHT11', 4), 
('DHT11', 5), 
('DHT11', 5), 
('DHT11', 6), 
('DHT11', 6), 
('DHT11', 7), 
('DHT11', 7), 
('DHT11', 7);

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

select m.horario, m.temperatura, m.umidade, a.especie, a.estado, a.cidade, u.nome, u.CNPJ, u.email from Metrica as m
	join Sensor as s on m.fkSensor = s.idSensor
    join Armazem as a on a.idArmazem = s.fkArmazem
    join Usuario as u on u.idUser = a.fkUser;
    
    select * from Metrica as m
	join Sensor as s on m.fkSensor = s.idSensor
    join Armazem as a on a.idArmazem = s.fkArmazem
    join Usuario as u on u.idUser = a.fkUser;
