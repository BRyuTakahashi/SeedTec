 drop database Ceres;

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
complemento VARCHAR(45)
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

delimiter $$
create procedure SP_cadastro_endereco(
in estado char(2),
in cidade varchar(45),
in CEP char(8),
in complemento varchar(45)
)
begin
	INSERT INTO Endereco (estado, cidade, CEP, complemento) VALUES (estado, cidade, CEP, complemento);
    select idEndereco from endereco order by idEndereco desc limit 1;
end $$
delimiter ;

select * from usuario;
select * from endereco;

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
