CREATE DATABASE Fidelizacao

USE Fidelizacao

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

select * from Clientes
select * from Compras
select * from Premios
select * from Trocas

--Sempre que um cliente faz uma compra, ele ganha pontos. Crie um
--gatilho chamado AumentaPontosCliente para atualizar o saldo de um cliente a cada
--compra cadastrada.
Create trigger AumentaPontosCliente ON Compras For Insert AS
BEGIN
	Declare
	@pontos int,
	@client int
	Set @pontos = (Select pontosGanhos From inserted)
	Set @client = (Select idCliente From inserted)

	Update Clientes
	set saldoPontos = saldoPontos + @pontos
	where idCliente = @client
END

----Testantando AumentaPontosCliente
Insert into Compras values(8,'04-07-2021', 20.00, 100) 


--Sempre que ocorre uma troca, o estoque do prêmio escolhido precisa
--ser diminuído. Crie um gatilho chamado RealizaTroca para atualizar a quantidade em
--estoque de um prêmio a cada troca cadastrada.
Create trigger RealizaTroca ON Trocas For insert AS
BEGIN
	Declare 
	@QuantTrocada int,
	@idpremio int

	Set @QuantTrocada = (Select quantidade From inserted)
	Set @idpremio = (Select idPremio From inserted)

	Update Premios
	set quantEstoque = quantEstoque - @QuantTrocada
	where idPremio = @idpremio
END

--Testando Trigger realizatroca
INSERT INTO Trocas VALUES (1,2,2,'05-07-2018')

--Sempre que ocorre uma troca, o saldo de pontos do cliente precisa
--ser diminuído, considerando a quantidade de itens trocados e o valor em pontos de cada
--prêmio. Altere o gatilho RealizaTroca para atualizar o saldo de pontos do cliente a cada
--troca cadastrada.
Alter trigger RealizaTroca ON Trocas for Insert AS
Begin
	Declare 
	@QuantTrocada int,
	@idpremio int,
	@QuantPontos int,
	@PontosTotais int,
	@cliente int

	Set @QuantTrocada = (Select quantidade From inserted)
	Set @idpremio = (Select idPremio From inserted)
	Set @QuantPontos = (Select valorPontos from Premios where idPremio = @idpremio)
	set @cliente = (Select idCliente from inserted)
	Set @PontosTotais = (select saldoPontos From Clientes where idCliente = @cliente)

	Update Premios
	set quantEstoque = quantEstoque - @QuantTrocada
	where idPremio = @idpremio 
	
	Update Clientes
	set saldoPontos = saldoPontos - @QuantPontos
	where idCliente = @cliente

END
---Testando Alter Trigger Realizatroca
INSERT INTO Trocas VALUES (8,2,1,'05-07-2018')

--A troca só pode ser realizada se o cliente tiver pontos suficientes.
--Altere o gatilho RealizaTroca para testar se a troca pode ser realizada ou não. Caso seja
--possível, as ações anteriores devem ser mantidas. Caso contrário, deve ser exibida uma
--mensagem de erro adequada e a transação deve ser desfeita.