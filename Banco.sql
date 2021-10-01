Create database Banco

Use Banco

Create table Contas(
	Numero int not null,
	agencia int not null,
	tipo varchar(13) not null,
	Saldo numeric(8,2),
	IDCliente int
	
	Primary key(Numero),
	Foreign key(IDCliente) REFERENCES Clientes
)

Create table Clientes(
	IDCliente int not null,
	Nome varchar(30),
	idade int,
	Bairro varchar(20),
	Profissao varchar(30)

	Primary key(IDCliente)
)

Create table Movimentacao(
	IDMov int,
	numero int,
	data date,
	valor numeric(8,2),
	tipo varchar(20)
	check(tipo IN('Saque', 'Pagamento', 'transferencia'))

	Primary Key(IDMov)
	Foreign key(numero) References Contas
)

Insert into Clientes values('1111', 'Danilo', '20', 'Bairro nOvo','estudante')
Insert into Clientes values('2222', 'Pedro', '10', 'Santa cruz','estudante')
Insert into Clientes values('3333', 'dero', '10', 'Santa cruz','mEDICO')

SELECT * FROM Clientes WHERE Nome LIKE 'D%' and Profissao = 'estudante'

INSERT INTO Contas values('1010','29224','Corrente','10.00',1111)
INSERT INTO Contas values('1020','29224','Corrente','20.00',2222)
INSERT INTO Contas values('1030','22222','Corrente','10.00',3333)

	Select AVG (Saldo) From Contas where tipo = 'Corrente' and Agencia = '29224'

insert into Movimentacao values('01','1010','01/01/2009','150.0','Saque')

insert into Movimentacao values('02','1020','01/02/2009','150.0','Saque')

insert into Movimentacao values('03','1030','01/03/2009','10.0','Pagamento')

Select Max (Valor) From Movimentacao where Tipo = 'Saque' and year(data) = '2009'