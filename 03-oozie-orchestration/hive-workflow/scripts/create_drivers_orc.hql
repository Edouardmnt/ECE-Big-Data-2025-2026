-- Table ORC cible : types corrects et colonnes métier
CREATE TABLE IF NOT EXISTS ${group}.${hiveUsername}_nyc_drivers (
  driver_id   INT,
  first_name  STRING,
  last_name   STRING,
  ssn         STRING,
  address     STRING,
  certified   BOOLEAN,
  wage_plan   STRING
)
STORED AS ORC
LOCATION '/user/${user}/nyc_drivers_orc';
