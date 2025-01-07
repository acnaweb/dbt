# dbt

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
dbt init study_sqlite --profiles-dir=$DBT_PROFILE_DIR
export DBT_PROJECT_DIR=$(pwd)/projects/study_sqlite
```

- edit /root/.dbt/profiles.yml

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

## References

- https://www.getdbt.com/