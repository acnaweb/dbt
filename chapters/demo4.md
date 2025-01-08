### Demo 4 - Macros

>> project_name = study_macro

```
export DBT_PROFILE_DIR=$(pwd)/profiles
cd projects
dbt init study_macro --profiles-dir=$DBT_PROFILE_DIR
cd ..
export DBT_PROJECT_DIR=$(pwd)/projects/study_macro
```

- edit profiles.yml

```file
study_macro:
  outputs:

    dev:
      type: sqlite
      threads: 1
      database: study_macro-dev.db
      schema: 'main'
      schemas_and_paths:
        main: '/shared/data/study_macro-dev.db'
      schema_directory: '/shared/data'
    prd:
      type: sqlite
      threads: 1
      database: study_macro-prd.db
      schema: 'main'
      schemas_and_paths:
        main: '/shared/data/study_macro-prd.db'
      schema_directory: '/shared/data'      
```

```sh
sqlite3 /shared/data/study_macro-prd.db
```

```sql

-- Criando a tabela tb_clientes
CREATE TABLE tb_clientes (
    cliente_id INTEGER PRIMARY KEY,
    nome TEXT NOT NULL,
    cidade TEXT NOT NULL,
    estado TEXT NOT NULL
);

-- Inserindo dados na tabela tb_clientes
INSERT INTO tb_clientes (cliente_id, nome, cidade, estado) VALUES
(1, 'João Silva', 'São Paulo', 'SP'),
(2, 'Maria Souza', 'Rio de Janeiro', 'RJ'),
(3, 'Pedro Santos', 'Belo Horizonte', 'MG'),
(4, 'Matias Teixeira', 'Vila Velha', 'ES'),
(5, 'Carolina Tavares', 'Campos', 'RJ'),
(6, 'Otávio Moreira', 'Curitiba', 'PR');

SELECT * FROM tb_clientes;

-- Criando a tabela tb_vendas
CREATE TABLE tb_vendas (
    venda_id INTEGER PRIMARY KEY,
    cliente_id INTEGER,
    data_venda DATE,
    valor REAL,
    FOREIGN KEY (cliente_id) REFERENCES tb_clientes(cliente_id)
);

-- Inserindo dados na tabela tb_vendas
INSERT INTO tb_vendas (venda_id, cliente_id, data_venda, valor) VALUES
(1, 1, '2025-09-01', 100.50),
(2, 1, '2025-09-10', 250.00),
(3, 2, '2025-09-12', 300.00),
(4, 3, '2025-09-15', 150.00),
(5, 4, '2025-09-16', 435.00),
(6, 4, '2025-09-16', 78.00),
(7, 5, '2025-09-16', 168.00),
(8, 6, '2025-10-14', 179.00),
(9, 4, '2025-10-22', 290.00),
(10, 2, '2025-10-27', 110.00);

SELECT * FROM tb_vendas;

.quit
```

```sh
dbt run --profiles-dir=$DBT_PROFILE_DIR
dbt run --profiles-dir=$DBT_PROFILE_DIR --full-refresh
dbt run --profiles-dir=$DBT_PROFILE_DIR --target dev
dbt run --profiles-dir=$DBT_PROFILE_DIR --select clientes --target dev

```