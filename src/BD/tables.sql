CREATE DATABASE Bloomify;
GO

USE Bloomify;
GO

CREATE TABLE Utilizador (
	UserId INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Nome VARCHAR(40) NOT NULL,
	Email VARCHAR(50) NOT NULL UNIQUE,
	PasswordHash VARCHAR(200) NOT NULL,
	Telefone CHAR(9) NOT NULL,
	Tipo VARCHAR(11) NOT NULL CHECK (Tipo IN ('Admin', 'Cliente', 'Funcionario'))
);

CREATE TABLE Administrador (
	AdminId INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	UserId INT NOT NULL,
	FOREIGN KEY(UserId) REFERENCES Utilizador(UserId) ON DELETE CASCADE
);

CREATE TABLE Cliente (
	NIF VARCHAR(9) PRIMARY KEY NOT NULL,
	BirthDate DATE NOT NULL,
	UserId INT NOT NULL,
	FOREIGN KEY(UserId) REFERENCES Utilizador(UserId) ON DELETE CASCADE
);

CREATE TABLE Funcionario (
	Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	UserId INT NOT NULL,
	FOREIGN KEY(UserId) REFERENCES Utilizador(UserId) ON DELETE CASCADE
);


CREATE TABLE EstadoEncomenda (
	Id INT PRIMARY KEY NOT NULL,
	Estado VARCHAR(20) NOT NULL
);

CREATE TABLE Encomenda (
	Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Data_Entrega DATE,
	Rua VARCHAR(45),
	CodigoPostal CHAR(8) NOT NULL,
	Porta INT NOT NULL,
	Cliente_Id VARCHAR(9),
	Estado_Id INT,
	Funcionario_Id INT,
	FOREIGN KEY(Cliente_Id) REFERENCES Cliente(NIF),
	FOREIGN KEY(Estado_Id) REFERENCES EstadoEncomenda(Id),
	FOREIGN KEY(Funcionario_Id) REFERENCES Funcionario(Id)
);

CREATE TABLE ProdutoDisplay (
	Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Nome VARCHAR(30) NOT NULL,
	Titulo NVARCHAR(100) NOT NULL,
	Descricao TEXT NOT NULL,
	Preco DECIMAL NOT NULL,
	Imagem VARCHAR(100)
)

CREATE TABLE Produto (
	Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Display_ID INT,
	Encomenda_ID INT,
	FOREIGN KEY(Display_ID) REFERENCES ProdutoDisplay(Id),
	FOREIGN KEY(Encomenda_Id) REFERENCES Encomenda(Id)
);

CREATE TABLE Componente (
	Id INT PRIMARY KEY NOT NULL,
	Nome VARCHAR(45) NOT NULL,
	Quantidade INT NOT NULL,
	Cor VARCHAR(25)
);

CREATE TABLE Componente_Produto (
	Componente_Id INT,
	Produto_Id INT,
	Quantidade INT,
	FOREIGN KEY(Produto_Id) REFERENCES Produto(Id),
	FOREIGN KEY(Componente_Id) REFERENCES Componente(Id),
	PRIMARY KEY(Componente_Id, Produto_Id)
)

CREATE TABLE EstadoMontagem (
	Id INT PRIMARY KEY NOT NULL,
	Estado VARCHAR(20) NOT NULL
);

CREATE TABLE LinhaDeMontagem (
	Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	TempoEstimado TIME NOT NULL,
	Nome VARCHAR(40) NOT NULL
);

CREATE TABLE Linha_Produto (
	Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	TempoDeMontagem TIME NOT NULL,
	Percentagem_Conclusao INT NOT NULL,
	Produto_Id INT,
	Estado_Montagem_Id INT,
	Linha_Id INT,
	FOREIGN KEY(Produto_Id) REFERENCES Produto(Id),
	FOREIGN KEY(Estado_Montagem_Id) REFERENCES EstadoMontagem(Id),
	FOREIGN KEY(Linha_Id) REFERENCES LinhaDeMontagem(Id)
)

CREATE TABLE Etapa (
	Id INT PRIMARY KEY NOT NULL,
	NumeroEtapa INT NOT NULL,
	Instrucao VARCHAR(100) NOT NULL,
	Descricao VARCHAR(255) NOT NULL,
	Imagem VARCHAR(100),
	LinhaDeMontagem_ID INT,
	FOREIGN KEY(LinhaDeMontagem_Id) REFERENCES LinhaDeMontagem(Id)
);

CREATE TABLE Notificacao (
    Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    Titulo VARCHAR(45) NOT NULL,
    Descricao TEXT NOT NULL,
    UserId INT,
    FOREIGN KEY(UserId) REFERENCES Utilizador(UserId)
);

