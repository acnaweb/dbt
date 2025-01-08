# dbt

## Layers

![](out/diagrams/modeling/modeling.svg)


## Basics

```sh
export DBT_PROFILE_DIR=$(pwd)/profiles
dbt init <project_name> --profiles-dir=$DBT_PROFILE_DIR
export DBT_PROJECT_DIR=$(pwd)/projects/<project_name>
dbt debug --profiles-dir=$DBT_PROFILE_DIR
dbt run --profiles-dir=$DBT_PROFILE_DIR --target dev
dbt seed --profiles-dir=$DBT_PROFILE_DIR
dbt test --profiles-dir=$DBT_PROFILE_DIR
dbt docs generate --profiles-dir=$DBT_PROFILE_DIR
dbt docs serve --profiles-dir=$DBT_PROFILE_DIR
```

## Demos

* [Demo 1 - Postgres](chapters/demo1.md)
* [Demo 2 - Sqlite](chapters/demo2.md)
* [Demo 3 - Mart](chapters/demo3.md)
* [Demo 4 - Macro](chapters/demo4.md)
* [Demo 5 - Dagster](chapters/demo5.md)

## References

- https://www.getdbt.com/