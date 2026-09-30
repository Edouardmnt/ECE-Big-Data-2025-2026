-- Entrepôt Hive : table externe CSV -> table ORC typée et transformée
-- Exécution : beeline -u "$JDBC_URL" --hivevar user=<user_hdfs> --hivevar group=<base_hive> \
--             --hivevar hiveUsername=<prefixe_tables> -f nyc_drivers.hql

-- 1. Table externe : Hive lit directement les CSV déposés sur HDFS, sans les copier
CREATE EXTERNAL TABLE IF NOT EXISTS ${group}.${hiveUsername}_nyc_drivers_ext (
  driver_id  INT,
  name       STRING,
  ssn        STRING,
  location   STRING,
  certified  STRING,
  wage_plan  STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
STORED AS TEXTFILE
LOCATION '/user/${user}/nyc_drivers'
TBLPROPERTIES ('skip.header.line.count'='1');

-- 2. Table ORC : format colonnaire compressé, types corrects, colonnes renommées
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

-- 3. Chargement transformé : nom découpé en prénom / nom, certified 'Y'/'N' -> booléen
--    INSERT OVERWRITE rend le chargement rejouable sans créer de doublons
INSERT OVERWRITE TABLE ${group}.${hiveUsername}_nyc_drivers
SELECT
  driver_id,
  split(name, ' ')[0]  AS first_name,
  split(name, ' ')[1]  AS last_name,
  ssn,
  location             AS address,
  certified = 'Y'      AS certified,
  wage_plan
FROM ${group}.${hiveUsername}_nyc_drivers_ext;

-- 4. Contrôle
SELECT * FROM ${group}.${hiveUsername}_nyc_drivers LIMIT 10;
