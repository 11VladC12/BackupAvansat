# #!/bin/bash
# Varianta 241 - Problema 2
# Scriptul va efectua prelucrări asupra unui fișier dat ca și argument (verificati numar corect argumente si existenta, cat si permisiunile!).
# Acesta va:
# 
# inlocui toate liniile care incep si se termina cu aceeasi litera cu șirul @@@
# sterge toate liniile care contin doar caractere numerice urmate de litere
# adauga, inaintea liniilor care contin doar spații, o linie mentionand timestamp-ul curent de pe sistem
# adauga, dupa liniile care contin cel puțin un cuvânt scris invers, o linie mentionand directorul curent al utilizatorului.
# De exemplu, pentru fisierul cu continutul urmator:
# 
# ana
# 123abc
# racecar
#       
# Continutul, dupa prelucrarile efectuate, va deveni:
# 
# @@@
# <output comanda date>
#       
# racecar
# current directory: <output comanda pwd>
# 
# Indicatie: nu e necesara parcurgerea linie cu linie a fisierului dat.

#-----------------------------------------------------------------------

# verificam daca numarul de argumente este corect, 1 singur argument
if [ "$#" -ne 1 ]; then
    echo "utilizare: $0 <cale_fisier>"
    exit 1
fi

# se verifica daca fisierul exista si este accesibil
if [ ! -f "$1" ]; then
    echo "err. fisierul $1 nu exista sau nu este accesibil"
    exit 1
fi

# se verifica daca fisierul are permisiuni de citire si scriere
if [ ! -r "$1" ] || [ ! -w "$1" ]; then
    echo "err. fisierul $1 nu are permisiuni de citire si scriere"
    exit 1
fi

# salvam calea intr-o variabila
fisier="$1"

#inlocuim toate liniile care incep si se termina cu aceeasi litera cu sirul @@@
sed -i -E 's/^(.).*\1$/@@@/' "$fisier"

# stergem liniile care contin doar caractere numerice urmate de litere
sed -i -E '/^[0-9]+[a-zA-Z]+$/d' "$fisier"

#adaugam inaintea liniilor care contin doar spatii o litera cu timestampul curent
sed -i -E '/^ *$/i\
date: '"$(date)" "$fisier"

#adaugam, dupa liniile care contin cel putin u cuvant scris invers , o linie cu directorul curent
sed -i -E '/\b([a-zA-Z])([a-zA-Z]*)\1\b/a\
current directory: '"$(pwd)" "$fisier"

echo "prelucrarile au fost efectuate cu succes pe fisierul $fisier"

