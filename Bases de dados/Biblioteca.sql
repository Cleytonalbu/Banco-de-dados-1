Create database Biblioteca
use Biblioteca

Create table Usuarios(
	IDUsuario int not null Primary Key,
	nome varchar(30) not null,
	RG char(7) not null,
	sexo varchar(9) not null,
	tipo varchar(15) not null,

	check (sexo in('Masculino', 'Feminino')),
	check (tipo in('Discente', 'Docente', 'Funcionario'))
)
Create table Livros(
	IDLivro int not null Primary key,
	titulo varchar(30) not null,
	genero varchar(30) not null,
	ano date not null,
	situacao varchar(30) not null,
	precoCusto numeric(8,2) not null,
	
	check(situacao in('Emprestado', 'Disponivel'))
)
Create table Emprestimos(
	IDEmprestimo int not null Primary key,
	IDUsuario int not null,
	IDLivro int not null,
	dataSaida date not null,
	dataDevolucao date not null,

	Foreign Key (IDUsuario) References Usuarios,
	Foreign Key (IDLivro) References Livros
)

Insert into Usuarios values(01,'Cleyton','4192193', 'Masculino','Discente')
Insert into Usuarios values(02,'Zezinho','9198197', 'Masculino','Funcionario')
Insert into Usuarios values(03,'Joao','1273465', 'Masculino','Discente')
Insert into Usuarios values(04,'Gaby','8976754', 'Feminino','Docente')
Insert into Usuarios values(05,'Maria','4567843', 'Feminino','Docente')
Insert into Usuarios values(06,'Isabela de Lima','8765345', 'Feminino','Docente')

Insert into Livros values(101,'Harry Potter', 'Ficçao', '2010', 'Disponivel',50.00)
Insert into Livros values(102,'Java Iniciante', 'Programacao', '2000', 'Disponivel',45.00)
Insert into Livros values(103,'SQL Avançado', 'Estudos', '2011', 'Disponivel',70.00)
Insert into Livros values(104,'Diario de um banana', 'Conto', '2003', 'Emprestado',25.00)
Insert into Livros values(105,'Alice no Pais das Maravilhas', 'Conto', '2008', 'Emprestado',26.00)
Insert into Livros values(106,'Thor', 'Conto', '1996', 'Disponivel',15.00)
Insert into Livros values(107,'Ataque zumbi', 'Conto', '1980', 'Disponivel',18.00)
--Crie um gatilho chamado RealizaEmprestimo para atualizar a situação
--de um livro a cada empréstimo cadastrado. um gatilho chamado RealizaEmprestimo para atualizar a situação
--de um livro a cada empréstimo cadastrado.
Create trigger RealizaEmprestimo ON Emprestimos for Insert AS
BEGIN
	Declare 
	@livro int

	set @livro = (Select IDLivro From inserted)
	Update Livros
	Set situacao = 'Emprestado'
	where IDLivro = @livro

END
--Inserindo um emprestimos na tabela para testar o Trigger ReazliaEmprestimo
Insert into Emprestimos values(10,01,101,'04-07-2021','20-10-2021')

--Altere o gatilho RealizaEmprestimo para verificar a situação de um livro a cada 
--empréstimo cadastrado. Caso o empréstimo seja possível, as ações anteriores devem 
--ser mantidas. Caso contrário, deve ser exibida uma mensagem de erro adequada 
--e a transação deve ser desfeita.
Alter Trigger RealizaEmprestimo ON Emprestimos For Insert AS
Begin
	Declare 
	@livro int,
	@sit varchar(30)

	Set @livro = (Select IDLivro From inserted)
	Set @sit = (Select situacao From Livros Where IDLivro = @livro)

	IF(@sit = 'Disponivel')
	Begin
		Update Livros
		Set situacao = 'Emprestado'
		where IDLivro = @livro
	END

	ELSE
	BEGIN
		Print'Livro nao está Disponivel'
		ROLLBACK
	END
END
--testando gatilho atualizado----
Insert into Emprestimos values(20,02,102,'05-07-2021','21-07-2021')

--Crie um gatilho chamado DefinePrazo para atualizar a data de
--devolução, de acordo com o tipo de usuário, a cada empréstimo cadastrado. (Dica: a
--função DateAdd ( ) pode ser usada para adicionar dias, meses ou anos a uma
--determinada data)
Create trigger DefinePrazo ON Emprestimos for insert AS
Begin
	Declare
	@usuario int,
	@livro int,
	@tipoU char(12),
	@dias int,
	@dataEmprestimo date

	Set @dataEmprestimo = (select dataSaida From inserted)
	Set @livro = (Select IDLivro From inserted)
	Set @usuario = (Select IdUsuario From inserted)
	Set @tipoU = (select tipo From Usuarios where IDUsuario = @usuario)

	IF(@tipoU = 'Discente')
		Set @dias = 20
	Else
		Set @Dias = 30
	Update Emprestimos
	Set dataDevolucao = DATEADD(day, @dias, @dataEmprestimo)
	Where IDLivro = @livro and IDUsuario = @usuario And dataSaida = @dataEmprestimo
End
--Funcionando

Select*from Livros
 

Insert into Emprestimos values(30,1,103,'01-07-2021', '10-08-2021')
Insert into Emprestimos values(40,6,107,'10-08-2021', '30-08-2021')
Insert into Emprestimos values(50,6,106,'15-08-2021', '10-09-2021')
 Select*from Livros
 Select*from Usuarios 
Select*from Emprestimos 
