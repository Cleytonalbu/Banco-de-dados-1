Create database FuncaoBiblioteca
use FuncaoBiblioteca

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
Insert into Livros values(104,'Diario de um banana', 'Conto', '2003', 'Disponivel',25.00)
Insert into Livros values(105,'Alice no Pais das Maravilhas', 'Conto', '2008', 'Disponivel',26.00)
Insert into Livros values(106,'Thor', 'Conto', '1996', 'Disponivel',15.00)
Insert into Livros values(107,'Ataque zumbi', 'Conto', '1980', 'Disponivel',18.00)

Insert into Emprestimos values(10,1,101,'04-07-2021','20-10-2021')
Insert into Emprestimos values(20,2,102,'05-07-2021','21-07-2021')
Insert into Emprestimos values(30,1,103,'01-07-2021', '10-08-2021')
Insert into Emprestimos values(40,6,107,'10-08-2021', '30-08-2021')
Insert into Emprestimos values(50,6,106,'15-08-2021', '10-09-2021')
Insert into Emprestimos values(60,2,101,'15-10-2021', '29-10-2021')


--Crie uma função chamada QuantLivrosGenero que receba por parâmetro o nome de um
--gênero e retorne a quantidade de livros daquele gênero existentes na biblioteca. (Obs:
--Nesse caso, o gênero do livro tem que ser exato para garantir que haja apenas um
--resultado)
Create function QuantLivrosGenero(@gen char(20))
Returns int AS
BEGIN
	declare
	@quant int
	Set @quant = (select Count(genero) From Livros where genero = @gen)
	return @quant
END

Select dbo.QuantLivrosGenero('Estudos') 'Total'

--Utilize a função QuantLivrosGenero para descobrir quantos livros de Ficção existem na
--biblioteca.
Select dbo.QuantLivrosGenero('Ficçao') 'Total'

--Crie uma função chamada QuantEmprestimosLivro que receba por parâmetro o título
--de um livro e retorne a quantidade de vezes que ele já foi emprestado. (Obs: Nesse caso,
--o título do livro tem que ser exato para garantir que haja apenas um resultado)
Create Function QuantEmprestimosLivro (@titulo varchar(20))
returns int AS
BEGIN
	Declare 
	@Quant int,
	@cod int
	Set @cod = (Select idLivro From Livros where titulo = @titulo)
	set @Quant = (Select Count(*) From Emprestimos where IDLivro = @cod)

	return @Quant
END

--Utilize a função QuantEmprestimosLivro para descobrir a quantidade de empréstimos
--do livro Harry Potter.
Select dbo.QuantEmprestimosLivro('Harry Potter')'Quantidade'


--Crie uma função chamada EmprestimosMesAno que receba por parâmetro o nome de
--um mês e um ano e retorne os dados (nome do usuário, título do livro, dataSaída) de
--todos os empréstimos realizados naquele mês e ano. (Dica: a função DATENAME pode
--ser usada para descobrir o nome do mês de uma determinada data, e a função YEAR
--pode ser usada para descobrir o ano de uma determinada data.)
Create function EmprestimosMesAno (@nomeMes varchar(20), @nomeAno int)
Returns table AS
	return 
	Select U.nome, T.titulo, D.dataSaida
	From Usuarios U INNER JOIN Emprestimos D ON U.IDUsuario = D.IDUsuario
	INNER JOIN Livros T ON D.IDLivro = T.IDLivro
	where DATENAME(month, dataSaida) = @nomeMes AND YEAR(dataSaida) = @nomeAno

--Utilize a função EmprestimosMesAno para visualizar os empréstimos realizados em
--novembro de 2019.
Select*From EmprestimosMesAno('Julho',2021)
Select*From Emprestimos

--Crie uma função chamada GeneroPreferido que receba por parâmetro o nome de um
--usuário e retorne o gênero de livros que o usuário mais pegou emprestado, com a
--respectiva quantidade de empréstimos feitos. (Dica: Calcule a quantidade de
--empréstimos por gênero, depois ordene os resultados e utilize a função TOP para obter
--apenas o dado que interessa)
Create function GeneroPreferido (@usuario varchar(30))
Returns Table AS
Return 
	Select TOP 1 L.genero, COUNT(IDEmprestimo) AS Quant
	FROM Usuarios U Inner JOIN Emprestimos E ON U.IDUsuario = E.IDUsuario
	INNER JOIN Livros L ON E.IDlivro = L.IDlivro
	where U.nome = @usuario
	Group by L.genero
	Order by Count(IDEmprestimo) DESC 
--Utilize a função GeneroPreferido para descobrir o gênero preferido de Roberta.
Select*from GeneroPreferido('Isabela de lima') 

