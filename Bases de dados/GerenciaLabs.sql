CREATE DATABASE GerenciaLabs

USE GerenciaLabs

CREATE TABLE Maquinas(
	idMaquina int not null identity,
	memoriaRAM int not null,
	HDtotal int not null,
	HDlivre int not null,
	nomeLab VARCHAR(60),
	PRIMARY KEY (idMaquina)
)

INSERT INTO Maquinas VALUES (4, 128, 100, 'LCC101')
INSERT INTO Maquinas VALUES (8, 256, 180, 'LCC101')
INSERT INTO Maquinas VALUES (4, 128, 40, 'BSI202')
INSERT INTO Maquinas VALUES (8, 1000, 800, 'BSI202')
INSERT INTO Maquinas VALUES (8, 256, 50, 'BSI204')
INSERT INTO Maquinas VALUES (8, 532, 250, 'LCC103')

CREATE TABLE Programas(
	idPrograma int not null identity,
	nome varchar(50) not null,
	minimoRAM int not null,
	espacoDisco int not null,
	quantLicencas int not null,
	PRIMARY KEY (idPrograma),
	CHECK(espacoDisco > 0),
	CHECK (minimoRAM > 0)
)

INSERT INTO Programas VALUES ('Avast!', 2, 4, 15)
INSERT INTO Programas VALUES ('SQL Server', 4, 50, 20)
INSERT INTO Programas VALUES ('Firefox', 5, 20, 10)
INSERT INTO Programas VALUES ('GTA', 8, 72, 7)
INSERT INTO Programas VALUES ('Photoshop', 8, 110, 13)

CREATE TABLE Instalacoes(
	idInstalacao int not null identity,
	idMaquina int not null,
	idPrograma int not null,
	responsavel varchar(60) not null,
	data date not null,
	PRIMARY KEY(idInstalacao),
	FOREIGN KEY(idMaquina) REFERENCES Maquinas,
	FOREIGN KEY(idPrograma) REFERENCES Programas
)

INSERT INTO Instalacoes VALUES (1, 1, 'Danilo Guedes', '06/06/2020')
INSERT INTO Instalacoes VALUES (1, 2, 'Ludmila Nogueira', '08/06/2020')
INSERT INTO Instalacoes VALUES (2, 3, 'Sílvio Cunha', '10/07/2020')
INSERT INTO Instalacoes VALUES (3, 1, 'Danilo Guedes', '16/07/2020')
INSERT INTO Instalacoes VALUES (4, 2, 'Paloma Luna', '24/08/2020')
INSERT INTO Instalacoes VALUES (2, 2, 'Ludmila Nogueira', '15/09/2020')
INSERT INTO Instalacoes VALUES (5, 4, 'Tales Pinto', '31/10/2020')
INSERT INTO Instalacoes VALUES (3, 5, 'Sílvio Cunha', '03/11/2020')
INSERT INTO Instalacoes VALUES (4, 1, 'Andrea Nóbrega', '09/11/2020')

SELECT * FROM Maquinas
SELECT * FROM Programas
SELECT * FROM Instalacoes

----------------------ITEN A--------------------------------
Create trigger verificaLicencas ON Instalacoes For Insert AS
BEGIN
	Declare 
	@idPrograma int,
	@Quantlicencas int

	SET @idPrograma = (Select idPrograma From inserted)
	SET @Quantlicencas = (SELECT quantLicencas From Programas where idPrograma = @idPrograma)

	IF(@Quantlicencas > 0)
	BEGIN
	Update Programas
	SET quantLicencas = quantLicencas - 1
	WHERE idPrograma = @idPrograma
	END

	ElSE
	BEGIN
	print 'Sua licença para este programa esgotou!'
	ROLLBACK 
	END
END

----------------------TESTE-------------------------------
insert into Instalacoes values(2,1,'Cleyton','08-07-2021')
Select*From Instalacoes 
select*From Programas

---------------------Item B----------------------------
Create or Alter Function maiorMemoriaRAM(@nome varchar(10))
RETURNS int AS
BEGIN
	DECLARE 
	@maior int 

	SET @maior = (SELECT MAX(minimoRAM) FROM Programas where idPrograma IN
	(Select idPrograma from Instalacoes where idMaquina IN
	(Select idMaquina from Maquinas where nomeLab = @nome))) 
	return @maior 
END 

-------------Teste-----------------
select dbo.maiorMemoriaRAM('BSI202')
select dbo.maiorMemoriaRAM('LCC101')
select dbo.maiorMemoriaRAM('BSI204')
select dbo.maiorMemoriaRAM('LCC103')

Select*from Maquinas
select*From Instalacoes
select*from Programas


---------------------ITEM C---------------------------------
CREATE PROCEDURE dobraLicencas (@responsavel VARCHAR(60)) AS
UPDATE Programas
	SET quantLicencas += quantLicencas
	WHERE idPrograma IN 
	(SELECT idPrograma FROM Instalacoes 
	WHERE responsavel = @responsavel)

----------Teste----------------
EXEC dobraLicencas 'Sílvio Cunha'
EXEC dobraLicencas 'Ludmila Nogueira'

select*from Instalacoes
Select*from Programas


