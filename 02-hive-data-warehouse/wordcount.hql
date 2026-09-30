-- Table Hive branchée sur la sortie du job MapReduce word_count
-- Exécution : beeline -u "$JDBC_URL" --hivevar group=<base_hive> --hivevar clusterUsername=<user_hdfs> \
--             --hivevar hiveUsername=<prefixe_tables> -f wordcount.hql
USE ${group};

-- Table EXTERNAL : Hive interroge les fichiers produits par MapReduce sans les déplacer
CREATE EXTERNAL TABLE IF NOT EXISTS ${hiveUsername}_wordcount (
  word   STRING,
  count  INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LOCATION '/education/${group}/${clusterUsername}/lab3/word-count/';

-- Mot le plus fréquent, à comparer avec le résultat du job MapReduce most_frequent
SELECT word, count
FROM ${hiveUsername}_wordcount
ORDER BY count DESC
LIMIT 1;
