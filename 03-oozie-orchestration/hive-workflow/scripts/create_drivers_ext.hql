-- Table externe pointant vers les CSV bruts sur HDFS
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
