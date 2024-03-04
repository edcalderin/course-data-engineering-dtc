-- Creating external table referring to gcs path
CREATE OR REPLACE EXTERNAL TABLE `ny_taxi.external_green_tripdata`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://mage-zoomcamp-bucket-erick/green_taxi_2022.parquet']
);

SELECT * FROM `ny_taxi.external_green_tripdata` LIMIT 1;

SELECT COUNT(*) FROM `ny_taxi.external_green_tripdata`;
-- 840402

CREATE OR REPLACE TABLE `ny_taxi.green_nonpartitioned_tripdata`
AS SELECT * FROM `ny_taxi.external_green_tripdata`;

SELECT * FROM `ny_taxi.green_nonpartitioned_tripdata` LIMIT 1;

SELECT COUNT(DISTINCT(PULocationID)) FROM `ny_taxi.external_green_tripdata`;
SELECT COUNT(DISTINCT(PULocationID)) FROM `ny_taxi.green_nonpartitioned_tripdata`;

SELECT COUNT(*) FROM `ny_taxi.green_nonpartitioned_tripdata` WHERE fare_amount=0;
--1622

CREATE OR REPLACE TABLE `ny_taxi.green_partitioned_tripdata`
PARTITION BY lpep_pickup_datetime
PARTITION BY PUlocationID
AS SELECT * FROM `ny_taxi.external_green_tripdata`;

SELECT DISTINCT(PULocationID) FROM `ny_taxi.green_nonpartitioned_tripdata` WHERE lpep_pickup_datetime BETWEEN '2022-01-06' AND '2022-06-30';
--12.82 mb

SELECT DISTINCT(PULocationID) FROM `ny_taxi.green_partitioned_tripdata` WHERE lpep_pickup_datetime BETWEEN '2022-01-06' AND '2022-06-30';
--6.53 mb

SELECT COUNT(*) FROM `ny_taxi.green_nonpartitioned_tripdata`;
-- 0 bytes, probally because there are no filters or where clause.
