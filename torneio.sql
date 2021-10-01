Create database torneios
use torneios

Create table Jogadores(
	numJog int not null,
	nome varchar(20),
	anoNasc int,
	Primary key (numJog)
)

Create table Torneios(
	numT int not  null,
	nomeT varchar(20) not null,
	Primary Key(numT)
)

Create  table Resultados(
	numT int not null,
	numJog int not null,
	ano int not null,
	premio numeric(10,2) not null,
	Primary key(numT, ano),
	Foreign Key(numt) References Torneios ON DELETE CASCADE ON UPDATE CASCADE,
	Foreign KEy(numJog) References Jogadores ON DELETE CASCADE
)


			Torneios values(numT, nomeT)
			Resultados values(numT, numJog, ano, premio)
Insert into Jogadores values('56', 'Cleyton','2000')
Insert into Jogadores values('44', 'Joao','2010')
Insert into Jogadores values('20', 'David','2002')
Insert into Jogadores values('12', 'Zezin','2008')
Insert into Jogadores values('13', 'Chorão','2005')

Insert into Torneios values('324','I Torneio mundial')
Insert into Torneios values('206','II Torneio mundial')
Insert into Torneios values('715','III Torneio mundial')
Insert into Torneios values('809','IV Torneio mundial')


Insert into Resultados values(324, 56,'2005','6000.00')
Insert into Resultados values(206, 44,'2007','5500.00')
Insert into Resultados values(715, 20,'2010','7200.00')
Insert into Resultados values(809, 56,'2014','10000.00')
Insert into Resultados values(324, 12,'2017','9500.00')
Insert into Resultados values(715, 12,'2018','9000.00')
Insert into Resultados values(206, 44,'2019','11000.00')
Insert into Resultados values(324, 13,'2015','4000.00')

Select*from Resultados order by ano

SELECT numJog, COUNT(*) FROM Resultados GROUP BY numJog

--SubConsulta
Select nome from Jogadores where numJog IN(Select numJog from Resultados where premio > '5000.00')

Select MAX(Premio) From Resultados where numT  IN (Select numT from Torneios where nomeT = 'I Torneio mundial')

--FIm da SubConsultas

Update Torneios set numT = 423 where numT = 206
Delete from Torneios where numT = 117
Insert into jogadores values(33,'Carolina',2001)
Delete from Torneios where numT = 206
insert into Resultados values(809, 33, 2014, 9800)
Update Jogadores set numJog = 51 where numJog = 39
Delete from Resultados where ano = 2010
delete from Jogadores where numJog = 56
Update Jogadores set numJog = 5 where numJog = 12
Insert into Torneios values (550,'Obras de arte')

SELECT * FROM Resultados ORDER BY ano