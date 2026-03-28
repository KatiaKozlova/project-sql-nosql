# Project Structure (SQL & noSQL DB)

by *Kate Kozlova*

## Directory Tree

```text
project/
|-- data/
|   |-- albums.csv
|   |-- playlists.csv
|   |-- track_characteristics.csv
|   |-- track_to_album.csv
|   |-- track_to_playlist.csv
|   `-- tracks.csv
|-- init/
|   `-- init.sql
|-- scripts/
|   |-- 0_creating.sql
|   |-- 1_crud.sql
|   |-- 2_where_without_join.sql
|   |-- 3_1_nested_select_some.sql
|   |-- 3_2_irrewritable_nested_select.sql
|   |-- 3_3_nested_select_with.sql
|   |-- 4_meaningful_leftjoin.sql
|   |-- 5_1_groupby.sql
|   |-- 5_4_groupby_having.sql
|   |-- 6_1_trigger.sql
|   |-- 6_1_trigger_check.sql
|   |-- 6_2_procedure.sql
|   |-- 6_3_procedure_call.sql
|   `-- 11_window_functions.sql
|-- docker-compose.yml
|-- orm_python_script.py
|-- db_eerdiagram.png
|-- .env.sample
|-- .gitignore
|-- README.md
```

## Notes

- `data/` stores CSV source data for the DB.
- `init/init.sql` contains initialization SQL for Docker.
- `scripts/` contains separate SQL tasks.
- `docker-compose.yml` defines the local container setup.
- `orm_python_script.py` contains the Python script for task #9.
- `db_eerdiagram.png` illustrates the DB.
- `.env.sample` contains sample of `.env`-file.

