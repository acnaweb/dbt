# dbt

Project to study dbt

### Info

Snow Flake Account - https://jt76835.us-east-2.aws.snowflakecomputing.com

### Generic Tests

* unique
* not_null
* accepted_values
* Relationships

```
./models/schema.yml
```


### Setup

```
mkdir ~/.dbt
```

``` 
dbt init <project_name> --profiles-dir=profiles
```



``` 
cd ./<project_name>
dbt debug
```

#### profiles.yml

``` 
study_dbt:
  outputs:
    dev:
      account: jt76835.us-east-2.aws
      database: AIRBNB
      password: dbtPassword123
      role: transform
      schema: RAW
      threads: 1
      type: snowflake
      user: dbt
      warehouse: COMPUTE_WH
  target: dev
``` 

## References

- https://www.getdbt.com/
- https://medium.com/@dipan.saha/dbt-on-snowflake-a-comprehensive-guide-a849e893a2e
- https://www.datafold.com/blog/dbt-expectations
- https://docs.getdbt.com/reference/resource-configs/store_failures
- https://github.com/dbt-labs/dbt-core/issues/2593
- https://docs.getdbt.com/best-practices/writing-custom-generic-tests
- https://docs.getdbt.com/docs/build/incremental-models
- https://pushmetrics.io/learn/jinja/why-jinja-and-sql/
- [Packages dbt](https://hub.getdbt.com/)


