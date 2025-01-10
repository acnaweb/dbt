with
    dim_produtos as (
        select
            produto_id AS id_produto,
            nome_produto AS nome_produto,
            categoria AS categoria_produto,
            preco AS preco_produto
        from
            {{ source('source_raw', 'stg_produtos') }}
    )

select * from dim_produtos
