with
    dim_localidades as (
        select
            localidade_id AS id_localidade,
            cidade AS cidade_localidade,
            estado AS estado_localidade,
            pais AS pais_localidade,
            cep AS cep_localidade
        from
            {{ source('source_raw', 'stg_localidades') }}
    )

select * from dim_localidades
