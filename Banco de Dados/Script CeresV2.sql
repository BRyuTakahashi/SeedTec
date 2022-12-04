-- drop database Ceres;

create database Ceres;
use Ceres;

CREATE TABLE Tipo(
idTipo INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45)
);

CREATE TABLE Endereco(
idEndereco INT PRIMARY KEY AUTO_INCREMENT,
estado CHAR(2),
cidade VARCHAR(65),
CEP CHAR(8),
complemento VARCHAR(45),
numero INT
);

create table Usuario(
idUsuario int auto_increment,
nome varchar(45),
CNPJ char(14),
ddd char(2),
telefone varchar(9),
email varchar(60), 
username varchar(45),
senha varchar(30),
fkEndereco INT,
FOREIGN KEY (fkEndereco) REFERENCES Endereco(idEndereco),
fkTipo INT,
FOREIGN KEY (fkTipo) REFERENCES Tipo(idTipo),
constraint chkemail check (email like '%@%'),
primary key (idUsuario)
);

create table Armazem(
idArmazem int PRIMARY KEY auto_increment,
tamanho int,
sacas INT,
fkUsuario INT,
FOREIGN KEY (fkUsuario) REFERENCES Usuario(idUsuario),
fkEndereco INT,
FOREIGN KEY (fkEndereco) REFERENCES Endereco(idEndereco)
);

create table Semente(
idSemente INT PRIMARY KEY AUTO_INCREMENT,
especie VARCHAR(45),
nome VARCHAR(45)
);

CREATE TABLE SementeArmazenada(
fkArmazen INT,
FOREIGN KEY (fkArmazen) REFERENCES Armazem(idArmazem),
fkSemente INT,
FOREIGN KEY (fkSemente) REFERENCES Semente(idSemente),
dtArmazenamento DATETIME
);

create table Sensor(
idSensor INT PRIMARY KEY,
nome VARCHAR(45),
fkArmazem INT,
FOREIGN KEY (fkArmazem) REFERENCES Armazem(idArmazem)
);

create table Metrica(
idMetrica INT,
horario DATETIME,
temperatura DOUBLE,
umidade DOUBLE,
fkSensor INT,
PRIMARY KEY (idMetrica, fkSensor),
FOREIGN KEY (fkSensor) REFERENCES Sensor(idSensor)
);

-- INSERTS

INSERT INTO Tipo VALUES
	(null, 'Produtor Autônomo'),
    (null, 'Empresa');

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
    
SELECT * FROM Usuario;
