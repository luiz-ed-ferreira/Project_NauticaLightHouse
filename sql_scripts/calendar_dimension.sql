--Premissas:
--O período de análise deve considerar todas as datas entre a menor e a data atual da venda presentes no arquivo.
--A loja esteve aberta em todos os dias do período (inclusive fins de semana).
--Considere apenas as lojas fisicas (= pos)
--Dias sem registro na tabela de vendas devem ser considerados como valor da venda = 0.
--“Vendas diárias” correspondem à soma de valor da venda por dia.
--A média de vendas por dia da semana deve considerar todos os dias do calendário, inclusive os dias sem venda.
--O nome do dia da semana deve ser apresentado em português (Segunda-feira, Terça-feira, etc.).
--Calendário -> Lojas físicas -> Vendas diárias -> Média por dia da semana

--Dimensão de datas em PT-BR
--Notas: 
 -- * ISODOW -> Significa ISO Day of Week. Retorna o dia como um número de 1 (segunda-feira) a 7 (domingo).
 -- * generate_series(inicio, fim, intervalo) -> É uma função que gera uma sequência de valores.
WITH dimensao_datas AS (
    SELECT
        data::DATE AS data,
        EXTRACT(ISODOW FROM data) AS numero_dia_semana,
        CASE EXTRACT(ISODOW FROM data)
            WHEN 1 THEN 'Segunda-feira'
            WHEN 2 THEN 'Terça-feira'
            WHEN 3 THEN 'Quarta-feira'
            WHEN 4 THEN 'Quinta-feira'
            WHEN 5 THEN 'Sexta-feira'
            WHEN 6 THEN 'Sábado'
            WHEN 7 THEN 'Domingo'
        END AS dia_semana
    FROM generate_series(
        (SELECT MIN(created_at::DATE) FROM orders),
        (SELECT MAX(created_at::DATE) FROM orders),
        INTERVAL '1 day'
    ) AS data
),

--Vendas por dia apenas em loja fisicas (=pos)
vendas_diarias AS (
    SELECT
        created_at::DATE AS data,
        SUM(total) AS venda_dia
    FROM orders
	WHERE channel = 'pos'
    GROUP BY created_at::DATE
),

--Dimensão de datas em PT-BR x Vendas por dia
calendario_vendas AS (
    SELECT
        d.data,
        d.dia_semana,
		d.numero_dia_semana,
        COALESCE(v.venda_dia, 0) AS venda_dia
    FROM dimensao_datas AS d
    LEFT JOIN vendas_diarias AS v
        ON d.data = v.data
)

--Select final
SELECT
    cv.dia_semana,
    ROUND(AVG(venda_dia), 2) AS media_vendas
FROM calendario_vendas AS cv
GROUP BY
    cv.numero_dia_semana,
    cv.dia_semana
ORDER BY
    AVG(cv.venda_dia);

--1. A tabela de datas é necessária porque a tabela de vendas só registra os dias em que houve alguma venda. Com um calendário contendo todas as datas do período e um LEFT JOIN, conseguimos incluir também os dias sem vendas, considerando-os como R$ 0,00 no cálculo da média.

--2. Se um dia da semana tiver muitos dias sem nenhuma venda, a média será menor, pois esses dias serão considerados como R$ 0,00. Dessa forma, o resultado representa melhor o desempenho real daquele dia da semana, evitando uma média inflada pela exclusão dos dias sem vendas.