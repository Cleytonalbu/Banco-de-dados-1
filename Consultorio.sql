Create database Consultorio

use Consultorio

Create table Especialidade (
	Code int not null,
	Nome varchar(20) not null,
	Primary Key(Code)
)

Create table Medicos(
	Codm varchar(5) not null,
	Nome varchar(20) not null,
	code int not null,
	Salario numeric not null,

	Primary Key(Codm),
	Foreign Key(code) References Especialidade
)

Create table Consultas(
	Codm varchar(5) not null,
	data datetime not null,
	paciente varchar(30) not null,
	Foreign key(codm) References Medicos
)

INSERT INTO Especialidade VALUES ('100', 'Pediatria')
INSERT INTO Especialidade VALUES ('200', 'Cardiologia')
INSERT INTO Especialidade VALUES ('300', 'Neurologia')
INSERT INTO Especialidade VALUES ('400', 'Oftalmologia')
INSERT INTO Especialidade VALUES ('500', 'Cirurgia')

INSERT INTO Medicos VALUES ('m1', 'antenor', 400 , 5000)
INSERT INTO Medicos VALUES ('m2', 'beatriz', 400 , 6000)
INSERT INTO Medicos VALUES ('m3', 'catarina', 300 , 15000)
INSERT INTO Medicos VALUES ('m4', 'luisa', 100 , 20000)
INSERT INTO Medicos VALUES ('m5', 'denilson', 300 , 17000)
INSERT INTO Medicos VALUES ('m6', 'jocasta', 200 , 3000)
INSERT INTO Medicos VALUES ('m7', 'inacio', 200 , 5000)

INSERT INTO Consultas VALUES ('m1', '01/12/2018 08:00:00', 'joao')
INSERT INTO Consultas VALUES ('m1', '01-12-2018 08:10:00', 'pedro')
INSERT INTO Consultas VALUES ('m2', '01-12-2018 08:00:00', 'carla')
INSERT INTO Consultas VALUES ('m3', '01-12-2018 08:00:00', 'paulo')
INSERT INTO Consultas VALUES ('m3', '01-12-2018 08:10:00', 'jose')
INSERT INTO Consultas VALUES ('m4', '01-12-2018 08:00:00', 'maria')
INSERT INTO Consultas VALUES ('m5', '01-12-2018 08:00:00', 'Cleyton')
INSERT INTO Consultas VALUES ('m5', '01-05-2018 08:00:00', 'Cleyton')

Select * From Especialidade 
Select * From Consultas
Select * From Medicos

Select AVG(Medicos.Salario) From Medicos, Especialidade where Especialidade.Nome = 'pediatria' or Especialidade.Nome = 'cardiogia'

SELECT Medicos.nome, Consultas.paciente From Medicos Medicos, Consultas Consultas Where Medicos.codm = Consultas.codm and data BETWEEN '01-05-2018' AND '31-05-2018' order by Medicos.nome

SELECT E.Nome, MAX(salario) FROM Medicos M, Especialidade E WHERE M.code = E.code GROUP BY  E.nome