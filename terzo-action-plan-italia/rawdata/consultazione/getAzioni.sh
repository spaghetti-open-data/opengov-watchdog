#!/bin/bash

### requirements ###
# pandoc
# scrape https://github.com/jeroenjanssens/data-science-at-the-command-line/blob/master/tools/scrape
### requirements ###

set -xv

# imposto cartella di output
cartella="/var/evvivaBrunati"

# imposto il file che contiene gli URL cone le pagine delle azioni
filename='/var/evvivaBrunati/lista.txt'

# per ogni pagina listata nel file, creo un file markdown per ogni azione
## la query regex estrae tutti gli elementi contenuti nel div[@class='entry-content'], 
## con l'esclusione dell'oggetto table, e del primo e ultimo elemento di questo insieme
echo Start
i=1
echo $i
while read p; do 
    #echo $p
    curl -s "$p" | scrape -be "//div[@class='entry-content']/*[not(name()='table')][position()>1 and position()<last()]" | pandoc -s -r html -o "$cartella/$i.md"
	let i=$i+1
	# echo $i
done < $filename

