# dbt

Project to study dbt

### Info

Snow Flake Account - https://jt76835.us-east-2.aws.snowflakecomputing.com

### Setup

```
mkdir ~/.dbt
```

``` 
dbt init <project_name>
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
