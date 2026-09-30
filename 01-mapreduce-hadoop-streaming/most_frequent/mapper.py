"""Mapper « mot le plus fréquent ».

Entrée : la sortie du job word_count, une ligne `mot<TAB>nombre` par mot.
Sortie : chaque couple est émis sous une clé constante `most`, pour que Hadoop
envoie tous les couples au même reducer, qui peut alors calculer le maximum global.
"""
import sys

for line in sys.stdin:
    line = line.strip()
    if not line:
        continue
    word, count = line.split("\t")
    print(f"most\t{word},{count}")
