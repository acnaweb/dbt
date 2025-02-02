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