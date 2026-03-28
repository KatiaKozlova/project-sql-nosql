# Project Structure (SQL & noSQL DB)

by *Kate Kozlova*

## Directory Tree

```text
project/
|-- data/
|   |-- albums.csv
|   |-- ...
|   `-- tracks.csv
|-- init/
|   `-- init.sql
|-- scripts/
|   |-- 0_creating.sql
|   |-- ...
|   `-- 11_window_functions.sql
|-- docker-compose.yml
|-- orm_python_script.py
|-- db_eerdiagram.png
|-- .env.sample
|-- .gitignore
`-- README.md
```

## Notes

- `data/` stores CSV source data for the DB (parsed from [Kaggle](https://www.kaggle.com/datasets/joebeachcapital/30000-spotify-songs)).
- `init/init.sql` contains initialization SQL for Docker.
- `scripts/` contains separate SQL tasks.
- `docker-compose.yml` defines the local container setup.
- `orm_python_script.py` contains the Python script for task #9.
- `db_eerdiagram.png` illustrates the DB.
- `.env.sample` contains sample of `.env`-file.

