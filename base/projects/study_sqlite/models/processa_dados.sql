WITH source AS (
    SELECT * 
    FROM pessoas
)

SELECT
    id,
    nome,
    salario,
    salario * 0.10 AS bonus
FROM source
