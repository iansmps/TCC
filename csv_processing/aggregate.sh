#!/bin/bash

qtdFiles=$(ls | grep csv$ | wc -l);

echo "timestamp,"$(ls | grep csv$ | sed s/\.csv//g) | sed s/\ /,/g;

#escolhe um arquivo para comecar
file_name=$(ls | grep csv$ | head -1);


#percorre as linhas do arquivo escolhido, vendo quais timestamps presentes neste arquivo também estão em todos os outros
#os timestamps que nao pertencerem a este arquivo ou que nao estiverem presentes em todos os demais serão excluidos
for t in $(tail -n +2 $file_name); do
	#pega o timestamp
	timestamp=$(echo $t | cut -d ',' -f 1);

	qtd=0;
	line="";
	for file in $(ls | grep csv$); do
		hasTimestamp=$(cat $file | grep -m 1 $timestamp | sed s/\\r//g);
		if [ "$hasTimestamp" != "" ]; then
			qtd=$((qtd+1));
			OLDIFS="$IFS";
			IFS=",";
			brokenLine=($hasTimestamp);
			IFS="$OLDIFS";

			if [ "$line" == "" ]; then
				line=${brokenLine[1]};
			else
				line="$line,${brokenLine[1]}";
			fi
		fi
	done

	if [ $qtd -eq $qtdFiles ]; then
		echo $timestamp,$line;
	fi
done;