Create database lista03Consultas
use lista03Consultas

Create table Usuarios(
	IDUsuario int not null,
	Nome varchar(30) not null,
	RG char(11) not null,
	sexo varchar(11) not null,
	tipo varchar(10)

	Primary key(IDUsuario),
	Check(sexo IN('Masculino','Feminino')),
	Check(tipo IN('Estudante','Professor'))
)

Create table Livros(
	IDLivro int not null,
	genero varchar(30) not null,
	ano date not null,
	situacao varchar(20) not null,
	precoCusto numeric(3,2) not null,

	Primary key(IDLivro),
	Check(situacao IN('Emprestado','Disponivel'))
)
Create table Emprestimos(
	IDEmprestimo int not null,
	IDUsuario int not null,
	IDLivro int not null,
	dataSaida date not null,
	dataDevolucao date not null,

	Primary key(IDEmprestimo),
	Foreign key(IDUsuario) References Usuarios,
	Foreign key(IDLivro) References Livros
)

Insert into Usuarios values ('0001','Cleyton','11111111111','Masculino','Estudante')
Insert into Usuarios values ('0002','João','22222222222','Masculino','Professor')
Insert into Usuarios values ('0003','Maria','33333333333','Feminino','Estudante')
Insert into Usuarios values ('0004','diego','44444444444','Masculino','Estudante')
Insert into Usuarios values ('0005','Daluz','55555555555','feminino','Professor')
Insert into Usuarios values ('0006','Manel','66666666666','Masculino','Estudante')
Insert into Usuarios values ('0007','Gaby','77777777777','Feminino','Professor')

Insert into Livros values ('100','Harry Potter','Ficção','2010','Disponivel','25.00')
Insert into Livros values ('200','Dora Aventureira','Desenho','2000','Disponivel','15.00')
Insert into Livros values ('300','Mitologia Nordica','Mitologia','2012','Disponivel','35.00')
Insert into Livros values ('400','Programação em Java','Estudos','2010','Disponivel','55.00')
Insert into Livros values ('500','Os segredos da fortuna','Finanças','2017','Disponivel','25.00')
Insert into Livros values ('600','Mil ao milhão','Finanças','2010','Disponivel','37.00')

Insert into Emprestimos values ('1','0001','300','01-02-2020','30-02-2020')
Insert into Emprestimos values ('2','0002','200','02-03-2020','15-03-2020')
Insert into Emprestimos values ('3','0004','100','05-06-2020','03-07-2020')

