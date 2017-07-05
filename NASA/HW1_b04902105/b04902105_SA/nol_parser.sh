#!/usr/bin/env bash

IFS=$'\n'

tmp=$(mktemp)
exclude=0
[ ! -f $2 ] && echo "Input file not found" && exit 0
[ $# -lt 2 ] && echo "Missing input file" && exit 0
if [ $# -eq 3 ] && [ $3 == "-g" ]; then
	exclude=1
fi
cat $2 | sed '917, 934d' | sed '1, 781d' >> $tmp

for line in $( cat $tmp ); do
	name=$(echo $line | cut -d '>' -f 12 | cut -d '<' -f 1)
	if [ -z "$name" ]; then
		continue;
	fi
	if [ $exclude -eq 1 ]; then
		if [[ $name == *"Seminar"* ]] || \
			[[ $name == *"Special"*"Project"* ]] || \
			[[ $name == *"Thesis"* ]]; then
			continue;
		fi
	fi
	professor=$(echo $line | cut -d '>' -f 23 | cut -d';' -f 1)
	if [[ $professor == "<"* ]]; then
		professor=$(echo $line | cut -d '>' -f 24 \
			| cut -d '<' -f 1)
	fi
	[[ $professor == "&nbsp"* ]] && professor=N/A
	time=$(echo $line | cut -d '>' -f 27 | cut -d ';' -f 1)
	if [[ $time == [0-9]* ]]; then
		time=$(echo $line | cut -d '>' -f 29 \
			| cut -d '<' -f 1 | cut -d' ' -f 2)
		#time=${time%(* }
	fi
	time=${time%(*}
	time=${time# }
	[[ $time == "&nbsp"* ]] && time=N/A
	#echo $time
	printf "%-50s\t%-20s\t%-10s\n" "$name" "$professor" "$time"
done

rm -f $tmp

