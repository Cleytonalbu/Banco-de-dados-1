Create database LojaMix
Use LojaMix

Create table Produtos (
	CodProduto int not null,
	Descricao varchar(30)not null,
	Marca varchar(30),
	Preco numeric(6,2) not null,
	Tipo varchar(8) not null

	Primary Key (CodProduto),
	Check(Preco > 0),
	Check(Tipo IN('Móvel','Eletro'))
)
Create table Móveis(
	CodMovel int not null,
	Cor varchar(10) not null,
	Material varchar(13) not null,

	Primary Key (CodMovel),
	Foreign Key (CodMovel) References Produtos,
	Check (Material IN('Madeira','Plástico','Metal', 'Vidro'))
)
Create table Eletrodosmésticos(
	CodEletro int not null,
	Voltagem int not null,
	Garantia int default '1',
	CodBarra varchar(40) not null,

	Primary Key(CodEletro),
	Foreign Key(CodEletro) References Produtos,
	Check(Voltagem IN('110', '220'))
)

Select*From Produtos
Select*From Móveis
Select*From Eletrodosmésticos

Insert into Produtos values ('01','Geladeira','Brastemp','700.00','Eletro')
Insert into 