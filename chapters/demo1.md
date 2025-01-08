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