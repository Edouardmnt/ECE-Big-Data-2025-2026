#!/usr/bin/env bash
# Lancement des deux jobs Hadoop Streaming sur le cluster (depuis le nœud edge).
# Variables à adapter : GROUP, USER (espace HDFS de l'utilisateur) et INPUT (texte à analyser sur HDFS).
set -euo pipefail

BASE=/education/${GROUP}/${USER}/lab3
INPUT=${INPUT:?chemin HDFS du texte à analyser}

# Job 1 : comptage des mots d'un texte (Moby Dick)
mapred streaming \
  -files word_count/mapper.py,word_count/reducer.py \
  -input ${INPUT} \
  -output ${BASE}/word-count \
  -mapper "python3 mapper.py" -reducer "python3 reducer.py"

# Job 2 : mot le plus fréquent, à partir de la sortie du job 1
mapred streaming \
  -files most_frequent/mapper.py,most_frequent/reducer.py \
  -input ${BASE}/word-count \
  -output ${BASE}/most-frequent \
  -mapper "python3 mapper.py" -reducer "python3 reducer.py"

hdfs dfs -cat ${BASE}/most-frequent/*
