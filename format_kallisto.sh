#!/bin/bash
for d in */ ; 
do

	mkdir -p $d/h5
	mkdir -p $d/plain
	mv $d/*.h5 $d/h5/ 2>/dev/null; true
	mv $d/*.* $d/plain/ 2>/dev/null; true



done

for tsv in $(find .  -mindepth 1 -name 'abundance.tsv');
do

	k1=$(dirname $tsv)
	echo "Number of genes expressed in $k1"
	awk '$5>1' $tsv | cut -f 1 | wc -l
	awk '$5>1' $tsv | cut -f 1 > "$k1/gene_expressed_id.txt"
	tail -n+2 $tsv  | awk '{if($5>1){print $1, 1} else{print $1, 0}}' OFS='\t' > "$k1/4upsetplot.txt"
done