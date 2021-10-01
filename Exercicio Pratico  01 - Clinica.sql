Create Table Pacientes(
	IDPaciente int not null,
	Nome varchar(30) not null,
	CPF char(11) not null,
	Sexo char(1) not null,
	Idade int not null,
	Convenio varchar(6),

	Primary Key (IDPaciente),
	unique (CPF),
	Check(Idade > 0 ),
	Check(Convenio IN ('Unimed','GEAP')),
	Check(Sexo IN ('M','F'))
)

Select * from Pacientes

Create table Medicos(
	IDMedico int not null,
	Nome varchar(30) not null,
	Especialidade varchar (40) not null,
	Turno varchar(5) not null,
	Salario numeric not null,

	Primary key (IDMedico),
	Check(Turno IN ('Manhã','Tarde', 'Noite')),
	Check(Salario > 0)

)
Select * From Medicos

Create Table Consultas(
	IDConsulta int not null,
	IDPaciente int not null,
	IDMedico int not null,
	Data datetime not null,
	Diagnostico varchar(40) not null,
	Preco numeric not null,

	Primary Key (IDConsulta),
	Foreign Key (IDPaciente) REFERENCES Pacientes,
	Foreign Key (IDMedico) REFERENCES Medicos,
	Check (Preco > 0)
)
Select * From Consultas 

Insert into Pacientes values ('1001','Marcus', '10101010101','M', '28', 'Unimed')
Insert into Pacientes values ('1002','Denise', '12355122121','F', '26', 'Unimed')
Insert into Pacientes values ('1003','João', '11335215686','M', '38', 'GEAP')

Insert into Medicos values ('001','Claudio', 'Geriátrica','Manhã', '5000')
Insert into Medicos values ('003','Ana', 'Pediatria','Tarde', '5500')
Insert into Medicos values ('004', 'Gaby', 'Anestesista', 'Noite', '6000')

Insert into Consultas values ('01','1001','001','01/01/2021','Cancer', '1200')
Insert into Consultas values ('02','1002','004','05/03/2020','Pé doendo', '100')
Insert into Consultas Values ('03', '1003','001','02/02/2021', 'Pedra nos rins', '230')

Select * From Pacientes
Select * From Medicos
Select * From Consultas

Update medicos
