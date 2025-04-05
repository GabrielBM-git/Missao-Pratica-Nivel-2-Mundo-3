-- Criando o banco de dados
CREATE DATABASE Loja;
GO

USE Loja;
GO

-- Criando a sequence para gerar IDs de Pessoa
CREATE SEQUENCE pessoa_seq START WITH 1 INCREMENT BY 1;
GO

-- Tabela de Usuários
CREATE TABLE Usuario (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) NOT NULL UNIQUE,
    senha NVARCHAR(255) NOT NULL
);
GO

-- Tabela de Pessoas (Base para PessoaFisica e PessoaJuridica)
CREATE TABLE Pessoa (
    id INT PRIMARY KEY DEFAULT NEXT VALUE FOR pessoa_seq,
    nome NVARCHAR(100) NOT NULL,
    endereco NVARCHAR(255) NOT NULL,
    cidade NVARCHAR(50) NOT NULL,
    estado CHAR(2) NOT NULL,
    telefone NVARCHAR(20) NULL,
    email NVARCHAR(100) NULL,
    tipo CHAR(1) NOT NULL CHECK (tipo IN ('F', 'J')) -- 'F' para Pessoa Física, 'J' para Jurídica
);
GO

-- Tabela de Pessoa Física
CREATE TABLE PessoaFisica (
    id INT PRIMARY KEY,
    cpf CHAR(20) UNIQUE NOT NULL,
    CONSTRAINT FK_PessoaFisica FOREIGN KEY (id) REFERENCES Pessoa(id) ON DELETE CASCADE
);
GO

-- Tabela de Pessoa Jurídica
CREATE TABLE PessoaJuridica (
    id INT PRIMARY KEY,
    cnpj CHAR(20) UNIQUE NOT NULL,
    CONSTRAINT FK_PessoaJuridica FOREIGN KEY (id) REFERENCES Pessoa(id) ON DELETE CASCADE
);
GO

-- Tabela de Produtos
CREATE TABLE Produto (
    id INT IDENTITY(1,1) PRIMARY KEY,
    nome NVARCHAR(100) NOT NULL UNIQUE,
    quantidade INT NOT NULL CHECK (quantidade >= 0),
    precoVenda DECIMAL(10,2) NOT NULL CHECK (precoVenda >= 0)
);
GO

-- Tabela de Compras (Movimentação de entrada)
CREATE TABLE Compra (
    id INT IDENTITY(1,1) PRIMARY KEY,
    usuario_id INT NOT NULL,
    produto_id INT NOT NULL,
    fornecedor_id INT NOT NULL, -- Sempre uma Pessoa Jurídica
    quantidade INT NOT NULL CHECK (quantidade > 0),
    precoUnitario DECIMAL(10,2) NOT NULL CHECK (precoUnitario >= 0),
    dataCompra DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_Compra_Usuario FOREIGN KEY (usuario_id) REFERENCES Usuario(id),
    CONSTRAINT FK_Compra_Produto FOREIGN KEY (produto_id) REFERENCES Produto(id),
    CONSTRAINT FK_Compra_Fornecedor FOREIGN KEY (fornecedor_id) REFERENCES PessoaJuridica(id)
);
GO

-- Tabela de Vendas (Movimentação de saída)
CREATE TABLE Venda (
    id INT IDENTITY(1,1) PRIMARY KEY,
    usuario_id INT NOT NULL,
    produto_id INT NOT NULL,
    cliente_id INT NOT NULL, -- Sempre uma Pessoa Física
    quantidade INT NOT NULL CHECK (quantidade > 0),
    precoUnitario DECIMAL(10,2) NOT NULL CHECK (precoUnitario >= 0),
    dataVenda DATETIME DEFAULT GETDATE(),

    CONSTRAINT FK_Venda_Usuario FOREIGN KEY (usuario_id) REFERENCES Usuario(id),
    CONSTRAINT FK_Venda_Produto FOREIGN KEY (produto_id) REFERENCES Produto(id),
    CONSTRAINT FK_Venda_Cliente FOREIGN KEY (cliente_id) REFERENCES PessoaFisica(id)
);
GO
