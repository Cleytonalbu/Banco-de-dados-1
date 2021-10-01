create database tv
use tv

CREATE TABLE Canais(
idCanal int not null,
Nome varchar(30) not null,
Categoria varchar(30) not null,
Tipo char(13) not null



PRIMARY KEY(IDCanal),

)

CREATE TABLE ComposicaoPacotes(
IDPacote int not null,
IDCanal int not null


FOREIGN KEY (IDPacote) REFERENCES Pacotes,
FOREIGN KEY (IDCanal) REFERENCES Canais,


)

CREATE TABLE Pacotes(
IDPacote int not null,
Nome varchar(30) not null,
Mensalidade numeric (5,2),
QuantAssinantes int 

PRIMARY KEY(IDPacote),

)

select * from Canais
select * from ComposicaoPacotes
select * from Pacotes
drop table Pacotes
drop table Canais
drop table ComposicaoPacotes


---------------------------------------------------------------------------------------------------
INSERT INTO Canais VALUES (25, 'MTV', 'Musical', 'Aberto')
INSERT INTO Canais VALUES (07, 'Globo', 'Variedades', 'Aberto')
INSERT INTO Canais VALUES (47, 'Warner', 'Séries', 'Fechado')
INSERT INTO Canais VALUES (50, 'Fox', 'Séries', 'Fechado')
INSERT INTO Canais VALUES (48, 'TNT', 'Filmes', 'Fechado')
INSERT INTO Canais VALUES (10, 'Band', 'Variedades', 'Aberto')
INSERT INTO Canais VALUES (95, 'Discovery', 'Documentários', 'Fechado')
INSERT INTO Canais VALUES (38, 'Sport TV', 'Esportes', 'Fechado')
INSERT INTO Canais VALUES (64, 'Telecine Pipoca', 'Filmes', 'Pay-per-view')
INSERT INTO Canais VALUES (05, 'SBT', 'Variedades', 'Aberto')
INSERT INTO Canais VALUES (49, 'Sony', 'Séries', 'Fechado')
INSERT INTO Canais VALUES (43, 'Universal', 'Séries', 'Fechado')
INSERT INTO Canais VALUES (61, 'Telecine Premium', 'Filmes', 'Pay-per-view')
INSERT INTO Canais VALUES (84, 'E!', 'Variedades', 'Fechado')
INSERT INTO Canais VALUES (41, 'GNT', 'Variedades', 'Fechado')
INSERT INTO Canais VALUES (102, 'Campeonato Brasileiro', 'Esportes', 'Pay-per-view')
INSERT INTO Canais VALUES (42, 'Multishow', 'Musical', 'Fechado')
INSERT INTO Canais VALUES (105, 'Campeonato Carioca', 'Esportes', 'Pay-per-view')

INSERT INTO ComposicaoPacotes VALUES (101, 05)
INSERT INTO ComposicaoPacotes VALUES (212, 07)
INSERT INTO ComposicaoPacotes VALUES (415, 64)
INSERT INTO ComposicaoPacotes VALUES (415, 49)
INSERT INTO ComposicaoPacotes VALUES (340, 47)
INSERT INTO ComposicaoPacotes VALUES (340, 50)
INSERT INTO ComposicaoPacotes VALUES (212, 10)
INSERT INTO ComposicaoPacotes VALUES (340, 42)
INSERT INTO ComposicaoPacotes VALUES (212, 25)
INSERT INTO ComposicaoPacotes VALUES (340, 38)
INSERT INTO ComposicaoPacotes VALUES (415, 25)
INSERT INTO ComposicaoPacotes VALUES (101, 07)
INSERT INTO ComposicaoPacotes VALUES (340, 41)
INSERT INTO ComposicaoPacotes VALUES (415, 41)
INSERT INTO ComposicaoPacotes VALUES (415, 61)
INSERT INTO ComposicaoPacotes VALUES (101, 25)
INSERT INTO ComposicaoPacotes VALUES (415, 48)
INSERT INTO ComposicaoPacotes VALUES (340, 48)
INSERT INTO ComposicaoPacotes VALUES (415, 102)
INSERT INTO ComposicaoPacotes VALUES (415, 10)
INSERT INTO ComposicaoPacotes VALUES (101, 10)
INSERT INTO ComposicaoPacotes VALUES (415, 07)
INSERT INTO ComposicaoPacotes VALUES (415, 05)
INSERT INTO ComposicaoPacotes VALUES (340, 10)
INSERT INTO ComposicaoPacotes VALUES (340, 84)
INSERT INTO ComposicaoPacotes VALUES (415, 43)
INSERT INTO ComposicaoPacotes VALUES (212, 42)
INSERT INTO ComposicaoPacotes VALUES (415, 38)
INSERT INTO ComposicaoPacotes VALUES (212, 05)
INSERT INTO ComposicaoPacotes VALUES (415, 105)

INSERT INTO Pacotes VALUES (101, 'Básico', 55.20, 380)
INSERT INTO Pacotes VALUES (212, 'Avançado', 72.46, 510)
INSERT INTO Pacotes VALUES (340, 'Master', 89.00, 145)
INSERT INTO Pacotes VALUES (415, 'Premium', 106.15, 20)

SELECT COUNT(*) FROM ComposicaoPacotes CP, Canais C WHERE C.idCanal = CP.idCanal AND idPacote IN (340,101) AND Nome LIKE '%o%'
SELECT Tipo, COUNT(*) 'quant' FROM Canais C, ComposicaoPacotes CP, Pacotes P WHERE C.idCanal = CP.idCanal AND CP.idPacote = P.idPacote AND QuantAssinantes > 200 GROUP BY Tipo
SELECT P.Nome, C.Nome FROM Canais C, ComposicaoPacotes CP, Pacotes P WHERE C.idCanal = CP.idCanal AND CP.idPacote = P.idPacote AND Categoria = 'Musical' AND Mensalidade BETWEEN 70 AND 100
---------------------------------------------------------------------------------------------------------


CREATE DATABASE ConsultorioMedico

USE ConsultorioMedico

CREATE TABLE Especialidades(
	idCode INT NOT NULL,
	nome VARCHAR(50) NOT NULL,
	
	PRIMARY KEY(IDCode)

)

CREATE TABLE Consultas(
	IDCodm integer  NOT NULL,
	dataConsulta date NOT NULL,
	paciente VARCHAR(40) NOT NULL,
	
	FOREIGN KEY(IDCodm) REFERENCES Medicos,


)

CREATE TABLE Medicos(
	IDCodm integer  NOT NULL,
	nome VARCHAR(30) NOT NULL,
	code INT NOT NULL,
	salario NUMERIC(5,3)
	
	PRIMARY KEY (IDCodm),
	FOREIGN KEY (code) REFERENCES Especialidades
	
)

select *from Especialidades
select *from Consultas
select *from Medicos
drop table Especialidades
drop table Consultas
drop table Medicos

INSERT INTO Especialidades VALUES (100, 'Pediatria')
INSERT INTO Especialidades VALUES (200, 'Cardiologia')
INSERT INTO Especialidades VALUES (300, 'Neurologia')
INSERT INTO Especialidades VALUES (400, 'Oftalmologia')
INSERT INTO Especialidades VALUES (500, 'Cirurgia')


INSERT INTO Consultas VALUES (m1, '01-12-2018 08:00:00', 'joao')
INSERT INTO Consultas VALUES ('m1', '01-12-2018 08:10:00', 'pedro')
INSERT INTO Consultas VALUES ('m2', '01-12-2018 08:00:00', 'carla')
INSERT INTO Consultas VALUES ('m3', '01-12-2018 08:00:00', 'paulo')
INSERT INTO Consultas VALUES ('m3', '01-12-2018 08:10:00', 'jose')
INSERT INTO Consultas VALUES ('m4', '01-12-2018 08:00:00', 'maria')

INSERT INTO Medicos VALUES (m1, 'antenor', 400 , 5000)
INSERT INTO Medicos VALUES (m2, 'beatriz', 400 , 6000)
INSERT INTO Medicos VALUES (m3, 'catarina', 300 , 15000)
INSERT INTO Medicos VALUES (m4, 'luisa', 100 , 20000)
INSERT INTO Medicos VALUES (m5, 'denilson', 300 , 17000)
INSERT INTO Medicos VALUES (m6, 'jocasta', 200 , 3000)
INSERT INTO Medicos VALUES (m7, 'inacio', 200 , 5000)
