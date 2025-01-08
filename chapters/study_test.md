### study_test

>> project_name = study_test

```
export DBT_PROFILE_DIR=$(pwd)/profiles
cd projects
dbt init study_test --profiles-dir=$DBT_PROFILE_DIR
cd ..
export DBT_PROJECT_DIR=$(pwd)/projects/study_test
```

- edit profiles.yml

```file
study_test:
  outputs:

    dev:
      type: sqlite
      threads: 1
      database: study_test-dev.db
      schema: 'main'
      schemas_and_paths:
        main: '/shared/data/study_test-dev.db'
      schema_directory: '/shared/data'
    prd:
      type: sqlite
      threads: 1
      database: study_test-prd.db
      schema: 'main'
      schemas_and_paths:
        main: '/shared/data/study_test-prd.db'
      schema_directory: '/shared/data'      
```

```sh
sqlite3 /shared/data/study_test-prd.db
```

```sql
-- Tabela de Clientes
CREATE TABLE tb_clientes (
  cliente_id INTEGER PRIMARY KEY,
  nome TEXT NOT NULL,
  email TEXT UNIQUE,
  cidade TEXT
);

INSERT INTO tb_clientes (cliente_id, nome, email, cidade) VALUES
(1, 'Maria Silva', 'maria.silva@teste.com', 'Fortaleza'),
(2, 'Josias Santos', 'joao.santos@teste.com', 'Rio de Janeiro'),
(3, 'Ana Costa', 'ana.costa@teste.com', 'Porto Alegre');

SELECT * FROM tb_clientes;

-- Tabela de Produtos
CREATE TABLE tb_produtos (
  produto_id INTEGER PRIMARY KEY,
  nome TEXT NOT NULL,
  preco REAL NOT NULL CHECK(preco > 0)
);

INSERT INTO tb_produtos (produto_id, nome, preco) VALUES
(1, 'Notebook', 3500.00),
(2, 'Mouse', 50.00),
(3, 'Teclado', 100.00);

SELECT * FROM tb_produtos;

-- Tabela de Pedidos
CREATE TABLE tb_pedidos (
  pedido_id INTEGER PRIMARY KEY,
  cliente_id INTEGER,
  produto_id INTEGER,
  quantidade INTEGER CHECK(quantidade > 0),
  data_pedido DATE,
  FOREIGN KEY (cliente_id) REFERENCES tb_clientes(cliente_id),
  FOREIGN KEY (produto_id) REFERENCES tb_produtos(produto_id)
);

INSERT INTO tb_pedidos (pedido_id, cliente_id, produto_id, quantidade, data_pedido) VALUES
(100, 1, 1, 22, '2025-01-01'),
(101, 3, 2, 14, '2025-02-12'),
(102, 2, 3, 10, '2025-02-22'),
(103, 2, 3, 12, '2025-03-18'),
(104, 3, 3, 50, '2025-04-14'),
(105, 2, 1, 23, '2025-05-29'),
(106, 1, 1, 18, '2025-07-02'),
(107, 3, 2, 5, '2025-09-11'),
(108, 1, 1, 4, '2025-09-15'),
(109, 2, 3, 9, '2025-11-03');

SELECT * FROM tb_pedidos;

.quit
```

```sh
dbt debug --profiles-dir=$DBT_PROFILE_DIR --target dev
dbt run --profiles-dir=$DBT_PROFILE_DIR
dbt run --profiles-dir=$DBT_PROFILE_DIR --full-refresh
dbt run --profiles-dir=$DBT_PROFILE_DIR --target prd
dbt run --profiles-dir=$DBT_PROFILE_DIR --select clientes --target dev
dbt test --profiles-dir=$DBT_PROFILE_DIR
dbt docs generate --profiles-dir=$DBT_PROFILE_DIR
dbt docs serve --profiles-dir=$DBT_PROFILE_DIR

```