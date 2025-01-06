# Local development
install:
	python -m venv venv; \
	. venv/bin/activate; \
	pip install --upgrade pip; \
	pip install -r requirements.txt; \

dbt:
	docker build -t dbt .
	docker run --name dbt -it --rm -v ./projects:/shared dbt /bin/bash

