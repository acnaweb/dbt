### study_bigquery

>> project_name = study_bigquery

```
export DBT_PROFILE_DIR=$(pwd)/profiles
cd projects
dbt init study_bigquery --profiles-dir=$DBT_PROFILE_DIR
cd ..
export DBT_PROJECT_DIR=$(pwd)/projects/study_bigquery
```

- edit profiles.yml

```file
study_bigquery:
  outputs:
    dev:
      dataset: stagging
      job_execution_timeout_seconds: 300
      job_retries: 1
      keyfile: /shared/credentials/study-bigquery.json
      location: us-west1
      method: service-account
      priority: interactive
      project: study-gcp-398200
      threads: 1
      type: bigquery
  target: dev   
```

- GCP/Bigquery - Load data

```
python src/load_data_bigquery.py

```

```
dbt debug --profiles-dir=$DBT_PROFILE_DIR
dbt run --profiles-dir=$DBT_PROFILE_DIR
```
