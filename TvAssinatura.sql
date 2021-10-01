

CREATE DATABASE TVAssinatura

USE TVAssinatura

CREATE TABLE Canais(
idCanal INT NOT NULL,
Nome VARCHAR(40) NOT NULL,
Categoria VARCHAR(50) NOT NULL,
Tipo VARCHAR(12) NOT NULL,

PRIMARY KEY(idCanal)

)

CREATE TABLE ComposicaoPacotes(
idPacote INT NOT NULL,
idCanal INT NOT NULL,


FOREIGN KEY (idPacote) REFERENCES Pacotes,
FOREIGN KEY (idCanal) REFERENCES Canais,
PRIMARY KEY (idPacote, idCanal),

)

CREATE TABLE Pacotes(
IDPacote INT NOT NULL,
Nome VARCHAR(40) NOT NULL,
Mensalidade NUMERIC (5,2),
QuantAssinantes INT

PRIMARY KEY(idPacote),

)

SELECT * FROM Canais
SELECT * FROM ComposicaoPacotes
SELECT * FROM Pacotes

DROP TABLE Pacotes
DROP TABLE Canais
DROP TABLE ComposicaoPacotes

-----------------------------------------------------------------------------------------

INSERT INTO Canais VALUES (25, 'MTV', 'Musical', 'Aberto')
INSERT INTO Canais VALUES (07, 'Globo', 'Variedades', 'Aberto')
INSERT INTO Canais VALUES (47, 'Warner', 'Séries', 'Fechado')
INSERT INTO Canais VALUES (50, 'Fox', 'Séries', 'Fechado')
INSERT INTO Canais VALUES (48, 'TNT', 'Filmes', 'Fechado')
INSERT INTO Canais VALUES (10, 'Band', 'Variedades', 'Aberto')
INSERT INTO Canais VALUES (95, 'Discovery', 'Documentários', 'Fechado')
INSERT INTO Canais VALUES (38, 'Sport TV', 'Esportes', 'Fechado')
INSERT INTO Canais VALUES (64, 'Telecine Pipoca', 'Filmes', 'Pay-per-view')
INSERT INTO Canais VALUES (05, 'SBT', 'Variedades', 'Aberto')
INSERT INTO Canais VALUES (49, 'Sony', 'Séries', 'Fechado')
INSERT INTO Canais VALUES (43, 'Universal', 'Séries', 'Fechado')
INSERT INTO Canais VALUES (61, 'Telecine Premium', 'Filmes', 'Pay-per-view')
INSERT INTO Canais VALUES (84, 'E!', 'Variedades', 'Fechado')
INSERT INTO Canais VALUES (41, 'GNT', 'Variedades', 'Fechado')
INSERT INTO Canais VALUES (102, 'Campeonato Brasileiro', 'Esportes', 'Pay-per-view')
INSERT INTO Canais VALUES (42, 'Multishow', 'Musical', 'Fechado')
INSERT INTO Canais VALUES (105, 'Campeonato Carioca', 'Esportes', 'Pay-per-view')

------------------------------------------------------------------------------------------


INSERT INTO ComposicaoPacotes VALUES (101, 05)
INSERT INTO ComposicaoPacotes VALUES (212, 07)
INSERT INTO ComposicaoPacotes VALUES (415, 64)
INSERT INTO ComposicaoPacotes VALUES (415, 49)
INSERT INTO ComposicaoPacotes VALUES (340, 47)
INSERT INTO ComposicaoPacotes VALUES (340, 50)
INSERT INTO ComposicaoPacotes VALUES (212, 10)
INSERT INTO ComposicaoPacotes VALUES (340, 42)
INSERT INTO ComposicaoPacotes VALUES (212, 25)
INSERT INTO ComposicaoPacotes VALUES (340, 38)
INSERT INTO ComposicaoPacotes VALUES (415, 25)
INSERT INTO ComposicaoPacotes VALUES (101, 07)
INSERT INTO ComposicaoPacotes VALUES (340, 41)
INSERT INTO ComposicaoPacotes VALUES (415, 41)
INSERT INTO ComposicaoPacotes VALUES (415, 61)
INSERT INTO ComposicaoPacotes VALUES (101, 25)
INSERT INTO ComposicaoPacotes VALUES (415, 48)
INSERT INTO ComposicaoPacotes VALUES (340, 48)
INSERT INTO ComposicaoPacotes VALUES (415, 102)
INSERT INTO ComposicaoPacotes VALUES (415, 10)
INSERT INTO ComposicaoPacotes VALUES (101, 10)
INSERT INTO ComposicaoPacotes VALUES (415, 07)
INSERT INTO ComposicaoPacotes VALUES (415, 05)
INSERT INTO ComposicaoPacotes VALUES (340, 10)
INSERT INTO ComposicaoPacotes VALUES (340, 84)
INSERT INTO ComposicaoPacotes VALUES (415, 43)
INSERT INTO ComposicaoPacotes VALUES (212, 42)
INSERT INTO ComposicaoPacotes VALUES (415, 38)
INSERT INTO ComposicaoPacotes VALUES (212, 05)
INSERT INTO ComposicaoPacotes VALUES (415, 105)

------------------------------------------------------------------------------------------

INSERT INTO Pacotes VALUES (101, 'Básico', 55.20, 380)
INSERT INTO Pacotes VALUES (212, 'Avançado', 72.46, 510)
INSERT INTO Pacotes VALUES (340, 'Master', 89.00, 145)
INSERT INTO Pacotes VALUES (415, 'Premium', 106.15, 20)

Select*from Pacotes
Select*From ComposicaoPacotes
Select*from Canais

SELECT Tipo, COUNT(*) 'quant' 
FROM Canais C, ComposicaoPacotes CP, Pacotes P 
WHERE C.idCanal = CP.idCanal AND CP.idPacote = P.idPacote AND QuantAssinantes > 200 
GROUP BY Tipo

SELECT P.Nome, C.Nome 
FROM Canais C, ComposicaoPacotes CP, Pacotes P 
WHERE C.idCanal = CP.idCanal AND CP.idPacote = P.idPacote AND Categoria = 'Musical' AND Mensalidade BETWEEN 70 AND 100