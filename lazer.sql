Create database Lazer
use Lazer

Create table Cinemas(
	IDCinema int,
	Nome varchar(20),
	endereco varchar(20),
	QuantSala int,
	IDCidade int,

	Primary Key(IDCinema),
	Foreign Key(IDCidade) References Cidades
)
Create table Cidades(
	IDCidade int,
	Nome varchar(20),
	Estado varchar(20),
	Primary Key(IDCidade)
)
drop from Cidades 
drop from Teatros
drop * from Cinemas

Create table Teatros(
	IDTeatro int,
	Nome varchar(20),
	Endereco varchar(20),
	Capacidade int,
	IDCidade int,

	Primary key (IDTeatro),
	Foreign Key(IDCidade) References Cidades
)
 
Select*From Cidades
Select*From Cinemas

Insert into Cinemas values ('01', 'CineMAX','Augusto de almeida', '3',001)
Insert into Cinemas values ('02', 'CineCLUB','Rua maria joana', '5',001)
Insert into Cinemas values ('03', 'CineLandia','Rua joquin Siqueira', '6',002)
Insert into Cinemas values ('04', 'Cinemax','Rua joca ataide', '8',002)

Insert into Cidades values ('001','Guarabira','Paraiba')
Insert into Cidades values ('002','Rio tinto','Paraiba')
Insert into Cidades values ('003','Baiania','bahia')
Insert into Cidades values ('004','Lele','bahia')


Insert into teatros values ('100','Teatro 1', 'Pascal','100',003)
Insert into teatros values ('101','Teatro 2', 'Guara','10',002)
Insert into teatros values ('103','Teatro 3', 'Guara','101',002)
Insert into teatros values ('104','Teatro 4', 'Bhi','103',004)

delete Teatros
Select * From Teatros
Select* From Cidades

Select Distinct Cidades.Nome
from Cidades, Teatros
where cidades.Estado = 'Bahia' and Capacidade > 100 

Select  SUM(QuantSala) From Cinemas, Cidades where cidades.Nome = 'Guarabira' 

Select Distinct Estado, cinemas.Nome
from Cidades, Cinemas
where Cinemas.Nome = 'Cinemax' and Cinemas.QuantSala > '5'

Select * From Teatros
Select * From Cidades
Select * From Cinemas

