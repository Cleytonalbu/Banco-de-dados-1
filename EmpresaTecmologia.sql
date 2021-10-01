Create database EmpresaTecnologia
use EmpresaTecnologia

Create table Departamento(
	NOMED varchar(30) not null,
	DEPNR int not null,
	CPFGerente varchar(11) not null,
	DTINIGerente varchar(10)not null

	Primary key(DEPNR) 
)
Drop table Departamento
Drop table Projeto
Drop table Funcionario
Drop table Atribuicao

Create table Projeto(
	NOMEP varchar(20) not null,
	NRPRO int not null,
	NUMDEP int not null,

	Primary key (NRPRO),
	Foreign key (NUMDEP) References Departamento(DEPNR)
) 

Create table Funcionario(
	PNOME varchar(30) not null,
	NOMEM char(1) not null,
	UNOMe varchar(30) not null,
	CPF char(9) not null,
	DataNasc date not null,
	Salario int not null,

	Primary key(CPF)
)

Create table Atribuicao(
	ACPF char(9) not null,
	NRP int not null,
	HORAS numeric(3,1) not null

	Foreign Key(ACPF) References Funcionario(CPF),
	Foreign Key(NRP) References Projeto(NRPRO)
)

Insert into Departamento values('Pesquisa','5','333445555','22-05-88')
Insert into Departamento values('Administração','4','987654321','01-01-95')
Insert into Departamento values('Gestão','1','888665555','19-06-81')

Insert into Projeto values('ProjetoX','1','5')
Insert into Projeto values('ProjetoY','2','5')
Insert into Projeto values('ProjetoZ','3','5')
Insert into Projeto values('Comput Info','10','4')
Insert into Projeto values('Reestruturação','20','1')
Insert into Projeto values('Beneficios','30','4')

Insert into Funcionario values('John','B','Smith','123456789','01-09-65','30000')
Insert into Funcionario values('Franklin','T','Wong','333445555','12-08-55','40000')
Insert into Funcionario values('Alicia','J','Zelaya','999887777','19-07-68','25000')
Insert into Funcionario values('Jeniffer','S','Wallace','987654321','20-06-11','43000')
Insert into Funcionario values('Ramesh','K','Narayan','666884444','15-09-62','38000')
Insert into Funcionario values('Joyce','A','Englise','453453453','31-07-72','25000')
Insert into Funcionario values('Ahmad','V','Jabbar','987987987','29-03-69','25000')
Insert into Funcionario values('James','E','Borg','888665555','10-11-37','55000')

Insert into Atribuicao values('123456789','1','32.5')
Insert into Atribuicao values('123456789','2','7.5')
Insert into Atribuicao values('666884444','3','40')
Insert into Atribuicao values('453453453','1','20')
Insert into Atribuicao values('453453453','2','20')
Insert into Atribuicao values('333445555','1','10')
Insert into Atribuicao values('453453453','2','10')
Insert into Atribuicao values('453453453','3','10')
Insert into Atribuicao values('453453453','20','10')
Insert into Atribuicao values('999887777','30','30')

Select NRPRO, NOMEP, count(*) 
From PROJETO, ATRIBUICAO 
Where NRPRO = NRP 
Group by NRPRO, NOMEP 
Having count (*) > 3

SELECT SUM (HORAS) FROM FUNCIONARIO, ATRIBUICAO, PROJETO, DEPARTAMENTO WHERE CPF = ACPF AND NRP = NRPRO AND NUMDEP = DEPNR AND NOMED = 'PESQUISA' AND SALARIO > 30000

--Utilizando subconsultas, escreva um comando SQL para exibir, 
--em ordem alfabética, o primeiro nome de todos os funcionários que 
--trabalharam em projetos de Gestão por mais de 10 horas

Select PNOME AS Funcionarios from Funcionario where CPF In(Select ACPF from Atribuicao where NRP = '1' and HORAS > 10) 

Select * From Projeto
Select * From Departamento
Select * From Atribuicao
select * From Funcionario