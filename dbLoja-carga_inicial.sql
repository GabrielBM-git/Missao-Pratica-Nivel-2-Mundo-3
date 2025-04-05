USE [Loja]
GO

INSERT INTO [dbo].[Usuario]
           ([username]
           ,[senha])
     VALUES
           ('op1'
           ,'op1')
GO

INSERT INTO [dbo].[Usuario]
           ([username]
           ,[senha])
     VALUES
           ('op2'
           ,'op2')
GO

---------------------------------------------------------------

INSERT INTO [dbo].[Produto]
           ([nome]
           ,[quantidade]
           ,[precoVenda])
     VALUES
           ('Banana'
           ,100
           ,5.00)
GO

INSERT INTO [dbo].[Produto]
           ([nome]
           ,[quantidade]
           ,[precoVenda])
     VALUES
           ('Laranja'
           ,500
           ,2.00)
GO

INSERT INTO [dbo].[Produto]
           ([nome]
           ,[quantidade]
           ,[precoVenda])
     VALUES
           ('Manga'
           ,800
           ,4.00)
GO

---------------------------------------------------------------

DECLARE @PessoaFisicaId INT = NEXT VALUE FOR pessoa_seq;

INSERT INTO [dbo].[Pessoa]
           ([id]
		   ,[nome]
           ,[endereco]
		   ,[cidade]
		   ,[estado]
           ,[telefone]
           ,[email]
           ,[tipo])
     VALUES
           (@PessoaFisicaId
		   ,'Joao'
           ,'Rua 12, casa 3, Quitanda'
		   ,'Riacho do Sul'
		   ,'PA'
           ,'1111-1111'
           ,'joao@riacho.com'
           ,'F') -- 'F' para Pessoa Física

INSERT INTO [dbo].[PessoaFisica]
           ([id]
           ,[cpf])
     VALUES
           (@PessoaFisicaId
           ,'111.111.111-11') 
GO

---------------------------------------------------------------

DECLARE @PessoaJuridicaId INT = NEXT VALUE FOR pessoa_seq;

INSERT INTO [dbo].[Pessoa]
           ([id]
		   ,[nome]
           ,[endereco]
           ,[cidade]
		   ,[estado]
           ,[telefone]
           ,[email]
           ,[tipo])
     VALUES
           (@PessoaJuridicaId
		   ,'JJC'
           ,'Rua 11, Centro'
           ,'Riacho do Norte'
		   ,'PA'
           ,'1212-1212'
           ,'jjc@riacho.com'
           ,'J') -- 'J' para Jurídica

INSERT INTO [dbo].[PessoaJuridica]
           ([id]
           ,[cnpj])
     VALUES
           (@PessoaJuridicaId
           ,'22.222.222/2222-22')
GO

---------------------------------------------------------------

INSERT INTO [dbo].[Compra]
           ([usuario_id]
           ,[produto_id]
           ,[fornecedor_id]
           ,[quantidade]
           ,[precoUnitario]
           ,[dataCompra])
     VALUES
           (1
           ,1
           ,2
           ,100
           ,2.00
           ,GETDATE())
GO

INSERT INTO [dbo].[Compra]
           ([usuario_id]
           ,[produto_id]
           ,[fornecedor_id]
           ,[quantidade]
           ,[precoUnitario]
           ,[dataCompra])
     VALUES
           (1
           ,2
           ,2
           ,500
           ,1.00
           ,GETDATE())
GO

INSERT INTO [dbo].[Compra]
           ([usuario_id]
           ,[produto_id]
           ,[fornecedor_id]
           ,[quantidade]
           ,[precoUnitario]
           ,[dataCompra])
     VALUES
           (1
           ,3
           ,2
           ,800
           ,2.00
           ,GETDATE())
GO

---------------------------------------------------------------

INSERT INTO [dbo].[Venda]
           ([usuario_id]
           ,[produto_id]
           ,[cliente_id]
           ,[quantidade]
           ,[precoUnitario]
           ,[dataVenda])
     VALUES
           (2
           ,1
           ,1
           ,10
           ,5.00
           ,GETDATE())
GO

INSERT INTO [dbo].[Venda]
           ([usuario_id]
           ,[produto_id]
           ,[cliente_id]
           ,[quantidade]
           ,[precoUnitario]
           ,[dataVenda])
     VALUES
           (2
           ,2
           ,1
           ,10
           ,2.00
           ,GETDATE())
GO

INSERT INTO [dbo].[Venda]
           ([usuario_id]
           ,[produto_id]
           ,[cliente_id]
           ,[quantidade]
           ,[precoUnitario]
           ,[dataVenda])
     VALUES
           (2
           ,3
           ,1
           ,10
           ,4.00
           ,GETDATE())
GO