-- Premissas:
-- Faturamento Total: Soma da coluna total por cliente.
-- Frequência: Contagem total de transações (IDs de venda) por cliente.
-- Ticket Médio: Faturamento Total / Frequência.
-- Diversidade de Categorias: Quantidade de categorias distintas (category_id) que o cliente comprou.
-- Filtro de Elite: Apenas clientes que compraram produtos de 13 ou mais categorias distintas devem ser considerados no ranking.
-- Desempate: Em caso de empate no Ticket Médio, utilize o customer_id em ordem crescente. 


--Ticket médio (relacionar orders -> customers)
WITH indicadores_clientes AS (
    SELECT
        o.customer_id, c.legal_name,
        SUM(o.total) AS faturamento_total,
        COUNT(o.id) AS frequencia,
        SUM(o.total) / COUNT(o.id)::NUMERIC AS ticket_medio
    FROM orders AS o INNER JOIN customers AS c ON c.id = o.customer_id
    GROUP BY o.customer_id, c.legal_name
),

--Diversidade da categoria (relacionar: orders -> order_items -> product_variants -> products)
diversidade_clientes AS (
    SELECT
        o.customer_id,
        COUNT(DISTINCT p.category_id) AS diversidade_categorias
    FROM orders AS o
    INNER JOIN order_items AS oi
        ON oi.order_id = o.id
    INNER JOIN product_variants AS pv
        ON pv.id = oi.product_variant_id
    INNER JOIN products AS p
        ON p.id = pv.product_id
    GROUP BY o.customer_id
),

--Filtrar os 10 clientes elites com o maior Ticket Médio que atendam ao critério de diversidade (13 ou + categorias).
clientes_elite AS (
    SELECT
        i.customer_id,
		i.legal_name,
        i.faturamento_total,
        i.frequencia,
        i.ticket_medio,
        d.diversidade_categorias
    FROM indicadores_clientes AS i
    INNER JOIN diversidade_clientes AS d
        ON d.customer_id = i.customer_id
    WHERE d.diversidade_categorias >= 13
    ORDER BY
        i.ticket_medio DESC,
        i.customer_id ASC
    LIMIT 10
),

--Para este grupo específico de 10 clientes, identifique qual categoria de produto concentra a maior 
--quantidade total de itens comprados (sum(quantity)).
--(relacionar orders -> clintes_elites -> order_itens -> product_variants -> products -> categories)
categorias_consumidas AS (
    SELECT
        p.category_id,
        c.name AS categoria,
        SUM(oi.quantity) AS quantidade_total
    FROM orders AS o
    INNER JOIN clientes_elite AS ce
        ON ce.customer_id = o.customer_id
    INNER JOIN order_items AS oi
        ON oi.order_id = o.id
    INNER JOIN product_variants AS pv
        ON pv.id = oi.product_variant_id
    INNER JOIN products AS p
        ON p.id = pv.product_id
    INNER JOIN categories AS c
        ON c.id = p.category_id
    GROUP BY
        p.category_id,
        c.name
)

--Select clientes elite
--SELECT *
--FROM clientes_elite;

--Select categoria de produto mais comprado dos clientes elite
SELECT
    category_id,
    categoria,
    quantidade_total
FROM categorias_consumidas
ORDER BY quantidade_total DESC
LIMIT 1;