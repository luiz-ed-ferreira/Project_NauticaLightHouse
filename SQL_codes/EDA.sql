--Quantidade total de linhas em SQL
SELECT COUNT(*) FROM orders

--Quantidade total de colunas em SQL
SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'orders'

--Intervalo de datas analisado (data mínima e máxima) da coluna created_at em SQL
SELECT MIN(created_at) FROM orders
SELECT MAX(created_at) FROM orders

--Valor mínimo da coluna "total" em SQL
SELECT MIN(total) FROM orders

--Valor máximo da coluna "total" em SQL
SELECT MAX(total) FROM orders

--Valor médio da coluna "total" em SQL
SELECT AVG(total) FROM orders