/* 
	Consultas sobre os dados inseridos 
*/

-- a.) Dados completos de pessoas físicas

SELECT 
    p.id,
    p.nome,
    p.endereco,
    p.cidade,
    p.estado,
    p.telefone,
    p.email,
    pf.cpf
FROM Pessoa p
JOIN PessoaFisica pf ON p.id = pf.id;

-- b.) Dados completos de pessoas jurídicas

SELECT 
    p.id,
    p.nome,
    p.endereco,
    p.cidade,
    p.estado,
    p.telefone,
    p.email,
    pj.cnpj
FROM Pessoa p
JOIN PessoaJuridica pj ON p.id = pj.id;

-- c.) Movimentações de entrada (compras)

SELECT 
    pr.nome AS Produto,
    p.nome AS Fornecedor,
    c.quantidade,
    c.precoUnitario,
    c.quantidade * c.precoUnitario AS ValorTotal
FROM Compra c
JOIN Produto pr ON pr.id = c.produto_id
JOIN PessoaJuridica pj ON pj.id = c.fornecedor_id
JOIN Pessoa p ON p.id = pj.id;

-- d.) Movimentações de saída (vendas)

SELECT 
    pr.nome AS Produto,
    p.nome AS Comprador,
    v.quantidade,
    v.precoUnitario,
    v.quantidade * v.precoUnitario AS ValorTotal
FROM Venda v
JOIN Produto pr ON pr.id = v.produto_id
JOIN PessoaFisica pf ON pf.id = v.cliente_id
JOIN Pessoa p ON p.id = pf.id;

-- e.) Valor total das entradas agrupadas por produto

SELECT 
    pr.nome AS Produto,
    SUM(c.quantidade * c.precoUnitario) AS ValorTotalEntradas
FROM Compra c
JOIN Produto pr ON pr.id = c.produto_id
GROUP BY pr.nome;

-- f.) Valor total das saídas agrupadas por produto

SELECT 
    pr.nome AS Produto,
    SUM(v.quantidade * v.precoUnitario) AS ValorTotalSaidas
FROM Venda v
JOIN Produto pr ON pr.id = v.produto_id
GROUP BY pr.nome;

-- g.) Operadores que não efetuaram movimentações de entrada (compra)

SELECT 
    u.id,
    u.username
FROM Usuario u
WHERE NOT EXISTS (
    SELECT 1 
    FROM Compra c 
    WHERE c.usuario_id = u.id
);

-- h.) Valor total de entrada, agrupado por operador

SELECT 
    u.username,
    SUM(c.quantidade * c.precoUnitario) AS TotalEntrada
FROM Compra c
JOIN Usuario u ON u.id = c.usuario_id
GROUP BY u.username;

-- i.) Valor total de saída, agrupado por operador

SELECT 
    u.username,
    SUM(v.quantidade * v.precoUnitario) AS TotalSaida
FROM Venda v
JOIN Usuario u ON u.id = v.usuario_id
GROUP BY u.username;

-- j.) Valor médio de venda por produto, utilizando média ponderada
       -- (Média ponderada = soma(qtd * preço) / soma(qtd))

SELECT 
    pr.nome AS Produto,
    CAST(SUM(v.quantidade * v.precoUnitario) AS DECIMAL(10,2)) / 
    NULLIF(SUM(v.quantidade), 0) AS MediaPonderadaVenda
FROM Venda v
JOIN Produto pr ON pr.id = v.produto_id
GROUP BY pr.nome;
