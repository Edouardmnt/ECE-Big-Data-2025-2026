"""Reducer « mot le plus fréquent » : garde le couple (mot, nombre) maximal."""
import sys

max_word = None
max_count = 0

for line in sys.stdin:
    line = line.strip()
    if not line:
        continue
    _, value = line.split("\t")
    word, count = value.rsplit(",", 1)
    count = int(count)

    if count > max_count:
        max_count = count
        max_word = word

if max_word is not None:
    print(f"{max_word}\t{max_count}")
