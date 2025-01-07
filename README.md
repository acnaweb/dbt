# dbt

## Layers

![](out/diagrams/modeling/modeling.svg)


## Basics

```sh
export DBT_PROFILE_DIR=$(pwd)/profiles
dbt init <project_name> --profiles-dir=$DBT_PROFILE_DIR
export DBT_PROJECT_DIR=$(pwd)/projects/<project_name>
dbt debug --profiles-dir=$DBT_PROFILE_DIR
dbt run --profiles-dir=$DBT_PROFILE_DIR
dbt seed --profiles-dir=$DBT_PROFILE_DIR
dbt test --profiles-dir=$DBT_PROFILE_DIR
dbt docs generate --profiles-dir=$DBT_PROFILE_DIR
dbt docs serve --profiles-dir=$DBT_PROFILE_DIR
```

## Demos

### Demo 1 - Postgres

>> project_name = study_postgres

- edit .env

```
DATABASE_NAME=
DATABASE_PWD=
DATABASE_SCHEMA=
DATABASE_URL=
DATABASE_USER=
```

- Carregar variáveis de ambiente

```sh
export $(cat .env | xargs)
```

### Demo 2 - SQLite

>> project_name = study_sqlite

```
export DBT_PROFILE_DIR=$(pwd)/profiles
cd projects
dbt init study_sqlite --profiles-dir=$DBT_PROFILE_DIR
cd ..
export DBT_PROJECT_DIR=$(pwd)/projects/study_sqlite
```

- edit profiles.yml

```file
study_sqlite:
  outputs:
    dev:
      type: sqlite
      threads: 1
      database: etl.db
      schema: 'main'
      schemas_and_paths:
        main: '/shared/data/study_sqlite.db'
      schema_directory: '/shared/data'
```

```sh
sqlite3 /shared/data/study_sqlite.db
```

```sql
CREATE TABLE pessoas (
    id INTEGER,
    nome TEXT,
    salario INTEGER
);
```

```
.mode csv
.import /shared/data/pessoas.csv pessoas
.quit
```


- edit models/processa_dados.sql

```sql
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
```

- edit models/schema.sql

```
version: 2

models:
  - name: processa_dados
    description: "Este modelo processa os dados para análise."
    columns:
      - name: id
        description: "O identificador único para cada registro."
      - name: nome
        description: "O nome da pessoa."
      - name: salario
        description: "O salário da pessoa."
      - name: bonus
        description: "O bônus calculado como 10% do salário."
```

### Demo 3 - SQLite Mart

>> project_name = study_mart

```
export DBT_PROFILE_DIR=$(pwd)/profiles
cd projects
dbt init study_mart --profiles-dir=$DBT_PROFILE_DIR
cd ..
export DBT_PROJECT_DIR=$(pwd)/projects/study_mart
```

- edit profiles.yml

```file
study_mart:
  outputs:

    dev:
      type: sqlite
      threads: 1
      database: study_mart.db
      schema: 'main'
      schemas_and_paths:
        main: '/shared/data/study_mart.db'
      schema_directory: '/shared/data'
```

```sh
sqlite3 /shared/data/study_mart.db
```

```sql
CREATE TABLE tb_clientes (
    id INTEGER PRIMARY KEY,
    nome TEXT,
    sobrenome TEXT,
    email TEXT,
    status TEXT,
    data_cadastro TEXT
);

INSERT INTO tb_clientes (id, nome, sobrenome, email, status, data_cadastro) VALUES
(1000, 'John', 'Doe', 'john.doe@example.com', 'ativo', '2024-01-11'),
(1001, 'Jane', 'Smith', 'jane.smith@example.com', 'inativo', '2024-02-14'),
(1002, 'Alice', 'Johnson', 'alice.johnson@example.com', 'ativo', '2024-03-21'),
(1003, 'Bob', 'Brown', 'bob.brown@example.com', 'ativo', '2024-04-15');


CREATE TABLE tb_pedidos (
    id_pedido INTEGER PRIMARY KEY,
    id_cliente TEXT,
    data_pedido TEXT,
    valor_total DECIMAL(10, 2)
);

INSERT INTO tb_pedidos (id_pedido, id_cliente, data_pedido, valor_total) VALUES
(001, 1003, '2024-08-01', 150.50),
(002, 1000, '2024-08-02', 200.75),
(003, 1003, '2024-08-03', 300.20),
(004, 1001, '2024-08-04', 450.00),
(005, 1001, '2024-08-05', 125.99),
(006, 1002, '2024-08-06', 220.40),
(007, 1002, '2024-08-07', 330.10),
(008, 1000, '2024-08-08', 400.00),
(009, 1002, '2024-08-09', 550.75),
(010, 1001, '2024-08-10', 275.25);


select * from tb_clientes;
select * from tb_pedidos;
.quit
```

```sh
dbt run --profiles-dir=$DBT_PROFILE_DIR --models clientes
dbt run --profiles-dir=$DBT_PROFILE_DIR --models pedidos
dbt run --profiles-dir=$DBT_PROFILE_DIR
dbt run --profiles-dir=$DBT_PROFILE_DIR --full-refresh
```

## References

- https://www.getdbt.com/