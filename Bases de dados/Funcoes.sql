Use Biblioteca

SELECT * FROM Usuarios
SELECT * FROM Livros
SELECT * FROM Emprestimos

-- Funções escalares: retornam valores

-- Criar uma função para calcular a soma dos precos de custo de um gênero de livro
Create Function somPrecos (@gen char(20))
returns numeric(10,2) AS
Begin
	Declare
	@soma numeric(10,2)
	Set @soma = (Select Sum(precoCusto) From livros where genero = @gen)
	
	return @soma
END
Select dbo.somPrecos('Ficçao')'Soma total por Genero'


-- Criar uma função para calcular a quantidade de usuários de um determinado tipo
Create function quantFuncionarios(@tipo char(15))
returns int As
BEGIN
	Declare
	@quant int 
	set @quant = (Select count(*) From Usuarios where tipo = @tipo)
	return @quant
END


Select dbo.QuantFuncionarios('Docente') 'Total'

-- Criar uma função para calcular a quantidade de empréstimos feitos por um determinado usuário
Create or Alter Function QuantEmprestimos (@nome varchar(50))
returns int AS
Begin
	declare 
	@Quant int,
	@usuario int
	set @usuario = (select idUsuario From Usuarios where nome LIKE '%' +@nome+ '%')
	Set @Quant = (select Count(*) From Emprestimos where IDUsuario = @usuario)
	return @Quant 
End

Select dbo.QuantEmprestimos('Isabela')'Quantidade de emprestimos'

-- Funções com valor de tabela: retornam tabelas
Create function nomeFuncao(@paramentro tipoparametro)
Returns Table AS
	return select...
Select*from nomeFuncao

-- Criar uma função para exibir todos os dados de um livro
Create or Alter Function DadosLivro(@titulo varchar(30))
returns table AS
	return select *from Livros where titulo LIKE '%' + @titulo+ '%'

select * from DadosLivro('SQL')
-- Criar uma função para exibir todos os empréstimos de um usuário
Create function dadosEmprestimos(@usuario varchar(30))
returns table AS
	return 
	select*from Emprestimos where IDUsuario In
	(Select IDUsuario From Usuarios where nome LIKE '%'+ @usuario+ '%')

Select IDLivro, dataSaida, dataDevolucao From dadosEmprestimos('isabela') 

-- Criar uma função para exibir os dados de todos os livros emprestados a um usuário
Create Function dadosLivros(@usuario varchar(40))
returns table AS
	return 
	select* From Livros where IDLivro IN
	(Select IDLivro From emprestimos where IDUsuario IN
	(Select IDUsuario From Usuarios where nome LIKE '%'+ @usuario+ '%'))

Select * From dadosLivros('Isabela')
Select * From dadosLivros('Cleyton')