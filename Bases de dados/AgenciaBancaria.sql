Create database AgenciaBancaria
use AgenciaBancaria
 
Create table Clientes(
	IDCliente int not null Primary key,
	Nome varchar (30) not null,
	Idade int not null,
	Bairro varchar(30) not null,
	Profissao varchar(30) not null
)

Create table Contas(
	Numero int not null Primary key,
	Agencia char(6) not null,
	Tipo varchar(15) not null,
	Saldo numeric(6,2) not null,
	IDCliente int not null,

	Foreign key(IDCliente) References Clientes
)

Create table Investimentos(
	IDInvest int not null Primary key,
	Descricao varchar(30) not null,
	Rendimento varchar(6) not null
)

Create table Movimentacoes(
	IDMov int not null Primary Key,
	Numero int not null,
	Data date not null,
	Valor numeric(6,2) not null,
	Tipo varchar(20) not null,

	Foreign key(Numero) References Contas
)

Create table Aplicacoes(
	IDInvest int not null,
	IDCliente int not null,
	Data date not null,
	Valor numeric(6,2) not null,

	Foreign Key(IDInvest) References Investimentos,
	Foreign key(IDCliente) References Clientes
)

Insert into Clientes values(22,'Guilhermina',18,'Cruzeiro do Sul','Estudante')
Insert into Clientes values(55,'Théo',64,'Memorial','Psicólogo') 
Insert into Clientes values(80,'Kiara',37,'Luzes da cidade','Atriz')
Insert into Clientes values(94,'João',42,'Redenção','Advogado')

Insert into Contas values(1435, '3331-5','Corrente', 407.80, 80)
Insert into Contas values(3687, '1991-2','Poupança', 223.45, 55)
Insert into Contas values(7149, '3120-0','Corrente', 72.00, 22)
Insert into Contas values(2206, '3331-5', 'Poupança', 300.00, 94)
Insert into Contas Values(5555, '1111-1','Poupança', 10.00, 22)

Insert into Investimentos values(133, 'CDB', '8%')
Insert into Investimentos values(145, 'Renda Fixa', '9%')
insert into Investimentos values(152, 'Ações', '11%')

Insert into Movimentacoes values(01, 1435, '01/08/2017', 150.00, 'Saque')
insert into Movimentacoes values(02, 7149, '12/10/2018', 80.00, 'Pagamento')
Insert into Movimentacoes values(03, 3687, '20/08/2018', 120.00, 'Transferencia')
Insert into Movimentacoes values(04, 1435, '31/03/2019', 300.00, 'Pagamento')
Insert into Movimentacoes values(05, 3687, '09/06/2019', 760.00, 'Saque')
Insert into Movimentacoes values(06, 7149, '05/09/2019', 14.00, 'Saque')

Insert into Aplicacoes values(133, 80, '18/03/2017', 500.00)
Insert into Aplicacoes values(152, 22, '14/11/2017', 690.00)
Insert into Aplicacoes values(145, 80, '07/02/2018', 350.00)
insert into Aplicacoes values(133, 55, '20/08/2018', 180.00)
Insert into aplicacoes values(152, 94, '02/06/2019', 220.00)
Insert into aplicacoes values(145, 55, '09/09/2019', 1000.00)

Drop table clientes
Drop table contas
Drop table Investimentos
Drop table Aplicacoes
Drop table Movimentacoes

Select * FRom Contas
Select * From Clientes
Select * From Investimentos
Select * FRom Aplicacoes
Select * From Movimentacoes

Drop view K
Drop view W
Drop view Z
Drop view T
drop view X 

Create view K AS 
select Data, M.Tipo
From Movimentacoes M INNER JOIN Contas C ON M.Numero = C.Numero
where Valor Between 200 and 500
 
Select * From K  
Insert into K values (10, 1435, '01-01-1900', 'Saque')
Update Movimentacoes set 


Create view Z As 
Select Nome, Agencia, Data
From Clientes CL INNER JOIN Contas CT ON CL.IDCliente = CT.IDCliente INNER JOIN Aplicacoes A ON CL.IDCliente = A.IDCliente
Select*From Z 


Create view W AS select Nome, Profissao 
From Clientes Where IDCliente Not in(Select IDCliente fROM Aplicacoes)

Select*From W 

Create view V1 AS Select Bairro, Tipo, Saldo
From Clientes CL INNER JOIN Contas CT 
ON CL.IDCliente = CT.IDCliente
Where Idade>40

Create view V2 AS Select Bairro, Descricao, Valor
From Clientes CL INNER JOIN Aplicacoes A
ON CL.IDCliente = A.IDCliente
INNER JOIN Investimentos l 
On A.IDInvest = l.IDInvest
where Valor>300
Drop view V1

Select Count(*)From V1
Select Count(*)From V2
Select Count(*)From V1
where Bairro IN(Select Bairro From V2) 

	Escreva uma visão para Exibir NOME de cada cliente, QUANTAS contas ele tem no banco, 
	seu SALDO total nelas, e o VALOR MEDIO de suas aplicacoes em investimentos


Create view Relatario AS
Select C.Nome, Count(Q.Numero)'QuantDeContas',Sum(S.Saldo) 'SaldoTotal', AVG(M.Valor)'MediaInvestido'
from Clientes C INNER JOIN Contas Q ON C.IDCliente = Q.IDCliente
INNER JOIN Contas S ON S.IDCliente = C.IDCliente
INNER JOIN Aplicacoes M ON C.IDCliente = M.IDCliente
Group by C.Nome  

Select * From Relatario

Select Nome, Count(*), Sum(S.saldo)
From Clientes C Left Join Contas Q ON C.IDCliente = Q.IDCliente
Left Join Contas S ON C.IDCliente = S.IDCliente 
Group by Nome 