CREATE DATABASE funcoesFidelizacao

USE funcoesFidelizacao

CREATE TABLE Clientes(
	idCliente int NOT NULL IDENTITY,
	nome varchar(30) NOT NULL,
	CPF char(7) NOT NULL,
	profissao varchar(20) NOT NULL,
	saldoPontos int NOT NULL DEFAULT 0,

	PRIMARY KEY (idCliente),
	UNIQUE (CPF),
	CHECK (saldoPontos >= 0)
)

CREATE TABLE Compras (
	idCompra int NOT NULL IDENTITY,
	idCliente int NOT NULL,
	data datetime NOT NULL,
	valor numeric(9,2) NOT NULL,
	pontosGanhos int NOT NULL,

	PRIMARY KEY (idCompra),
	FOREIGN KEY (idCliente) REFERENCES Clientes,
	CHECK (valor > 0),
	CHECK (pontosGanhos > 0)
)

CREATE TABLE Premios(
	idPremio int NOT NULL IDENTITY,
	descricao varchar(20) NOT NULL,
	valorPontos int NOT NULL,
	quantEstoque int NOT NULL,
	PRIMARY KEY (idPremio),
	CHECK (valorPontos > 0),
	CHECK (quantEstoque >= 0)
)

CREATE TABLE Trocas(
	idTroca int NOT NULL IDENTITY,
	idCliente int NOT NULL,
	idPremio int NOT NULL,
	quantidade int NOT NULL,
	data datetime NOT NULL,
	PRIMARY KEY (idTroca),
	FOREIGN KEY (idCliente) REFERENCES Clientes,
	FOREIGN KEY (idPremio) REFERENCES Premios,
	CHECK (quantidade > 0)
)

INSERT INTO Clientes VALUES ('André Carneiro','3252541','Carteiro',80)
INSERT INTO Clientes VALUES ('Márcio Rodrigues','4812072','Engenheiro',65)
INSERT INTO Clientes VALUES ('Cristina Santana','6971238','Contadora',100)
INSERT INTO Clientes VALUES ('Michele Medeiros','9068131','Professora',90)
INSERT INTO Clientes VALUES ('Daniel Maia','0258136','Bancário',120)
INSERT INTO Clientes VALUES ('Larissa Gomes','3254170','Professora',215)
INSERT INTO Clientes VALUES ('Rafaela Costa','9801170','Arquiteta',270)
INSERT INTO Clientes VALUES ('César Fernandes','7428109','Dentista',200)

INSERT INTO Compras VALUES (1,'02-09-2019',22.78,07)
INSERT INTO Compras VALUES (2,'12-10-2019',50.32,14)
INSERT INTO Compras VALUES (4,'30-11-2019',123.14,25)
INSERT INTO Compras VALUES (3,'08-01-2018',108.22,19)
INSERT INTO Compras VALUES (2,'12-01-2020',349.06,92)
INSERT INTO Compras VALUES (5,'22-02-2018',225.56,45)
INSERT INTO Compras VALUES (6,'22-03-2018',79,34)
INSERT INTO Compras VALUES (1,'02-11-2019',63.12,18)
INSERT INTO Compras VALUES (6,'28-07-2019',55.49,16)
INSERT INTO Compras VALUES (8,'17-08-2019',25.29,08)

INSERT INTO Premios VALUES ('Bolsa (100% couro)',300,5)
INSERT INTO Premios VALUES ('Bolsa (palha)',80,12)
INSERT INTO Premios VALUES ('Relógio masculino',160,3)
INSERT INTO Premios VALUES ('Boné (100% algodão)',40,10)
INSERT INTO Premios VALUES ('Óculos',27,30)
INSERT INTO Premios VALUES ('Chaveiro',9, 110)
INSERT INTO Premios VALUES ('Caneta',7,92)


INSERT INTO Trocas VALUES (1,3,2,'15-10-2019')
INSERT INTO Trocas VALUES (2,6,1,'29-01-2019')
INSERT INTO Trocas VALUES (3,7,1,'12-01-2019')
INSERT INTO Trocas VALUES (6,4,1,'15-10-2018')
INSERT INTO Trocas VALUES (5,3,1,'24-10-2018')
INSERT INTO Trocas VALUES (2,2,1,'06-02-2018')
INSERT INTO Trocas VALUES (4,6,2,'12-10-2018')
INSERT INTO Trocas VALUES (5,6,1,'15-12-2019')
INSERT INTO Trocas VALUES (6,7,1,'17-03-2018')

--Crie uma função chamada MediaComprasFeitas que receba por parâmetro o nome de
--um cliente e retorne o valor médio das compras feitas por ele.
Alter Function MediaComprasFeitas(@nome varchar(30))
Returns numeric(10,2)AS
BEGIN
	Declare 
	@idNome int,
	@media numeric(10,2)

	Set @idNome = (Select idCliente from Clientes where nome = @nome)
	Set @media = (select AVG(valor) From Compras where idCliente = @idNome)
	return @media
	
END
--Utilize a função MediaComprasFeitas para visualizar a o valor médio das compras feitas
--por Cristina Santana.
Select dbo.MediaComprasFeitas('Cristina Santana')'Media' 


--Crie uma função chamada PremiosTrocadosPeríodo que receba por parâmetro duas
--datas e retorne a quantidade total de prêmios que foram trocadas nesse período.
Create function PremiosTrocadosPeriodo (@data1 date, @data2 date)
Returns int AS
BEGIN
	Declare 
	@quant int
	Set @quant = (Select SUM(quantidade) FROM Trocas where data BETWEEN @data1 AND @data2)
	return @quant
END

--Utilize a função PremiosTrocadosPeríodo para visualizar quantos prêmios foram
--trocados no segundo semestre de 2018.
Select dbo.PremiosTrocadosPeriodo('01/07/2018', '31/12/2018')'Quantidade'

--Crie uma função chamada GastoMáximoCliente que receba por parâmetro o RG de um
--cliente e retorne o maior valor de uma compra feita por ele.
Create function GastoMaximoCliente(@Cpf varchar(20))
Returns int AS
BEGIN
	Declare 
	@idCliente int,
	@gasto numeric(10,2)
	

	SET @idCliente = (SELECT IdCliente From Clientes where CPF = @Cpf)
	SET @gasto = (Select MAX(valor)From Compras where idCliente = @idCliente)
	return @gasto
END
--Utilize a função GastoMáximoCliente para visualizar o maior gasto de Larissa Gomes,
--usando seu CPF.
Select dbo.GastoMaximoCliente ('3252541')'Compra mais cara'

SELECT dbo.GastoMaximoCliente(CPF)'Compra mais cara' FROM Clientes
WHERE Nome = 'Larissa Gomes'

--Crie uma função chamada HistoricoTrocasPremio que receba por parâmetro a descrição
--de um prêmio e um ano, e retorne o nome do cliente e a data de cada troca daquele
--prêmio realizada naquele ano.
Create function HistoricoTrocasPremio (@descricao varchar(30))
Returns table as
	Return
	Select(    