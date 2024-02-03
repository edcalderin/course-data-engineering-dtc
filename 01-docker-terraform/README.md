Docker command:
Create Network:

```bash
docker network create pg-network
```

```bash
docker run -it \
-e POSTGRES_USER=root \
-e POSTGRES_PASSWORD=root \
-e POSTGRES_DB=ny_taxi \
-p 5432:5432 \
--network=pg-network \
--name pg-database \
postgres:latest
```

PGCLI: 

```bash
pgcli -u root -h localhost -p 5432 -d ny_taxi
```

List tables: `$ \dt`  
Columns: `$ SELECT 1;`
\d yellow_taxi_data

## PgAdmin

```bash
docker run -it \
-e PGADMIN_DEFAULT_EMAIL=admin@admin.com \
-e PGADMIN_DEFAULT_PASSWORD=root \
-p 8080:80 \
--network=pg-network \
dpage/pgadmin4
```

## Upload data script:

```bash
poetry run python upload-data.py \
--user=root \
--password=root \
--host=localhost \
--port=5432 \
--db=ny_taxi \
--table_name=yellow_taxi_trips \
--url=https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2023-01.parquet
```
## Build Dockerfile
```bash
docker build -t ingest-data:v001 .
```

## Run Dockerfile
```bash
docker run -it --rm \
--network=pg-network \
ingest-data:v001 \
--user=root \
--password=root \
--host=pg-database \
--port=5432 \
--db=ny_taxi \
--table_name=yellow_taxi_trips \
--url=https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2023-01.parquet
```
