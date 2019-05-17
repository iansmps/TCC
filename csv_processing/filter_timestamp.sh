#!/bin/bash

if [ $# -ne 2 ]; then
	echo "Usage: filter_timestamp y_file x_file";
else
	y_name="$1";
	unified_csv="$2";

	echo $(head -n 1 $y_name) > y_csv_file.csv;
	echo $(head -n 1 $unified_csv) > x_csv_file.csv;

	for t in $(tail -n +2 $unified_csv); do
		timestamp=$(echo $t | cut -d ',' -f 1);
		search=$(cat $y_name | grep -m 1 $timestamp);
		if [ "$search" != "" ]; then
			echo "$t" >> x_csv_file.csv;
			echo "$search" >> y_csv_file.csv;
		fi
	done
	qtdLinhasX=$(cat x_csv_file.csv | wc -l);
	qtdLinhasY=$(cat y_csv_file.csv | wc -l);
	if [ $qtdLinhasX -ne $qtdLinhasY ]; then
		echo "Arquivos com quantidades diferentes de linhas!!!!";
	else
		erros=0;
		echo "Arquivos csvs gerados com sucesso. Iniciando verificacao dos timestamps...";
		readarray xArray < x_csv_file.csv;
		readarray yArray < y_csv_file.csv;
		for i in $(seq 2 $qtdLinhasX); do
			xTimestamp=$(echo ${xArray[i]} | cut -d ',' -f 1);
			yTimestamp=$(echo ${yArray[i]} | cut -d ',' -f 1);
			if [ "$xTimestamp" != "$yTimestamp" ]; then
				echo "Linha $i tem diferenca de timestamp: $xTimestamp $yTimestamp" >> ./log.txt;
				erros=$((erros + 1));
			fi
		 done
		echo "Verificacao finalizada. Foram encontrados $erros erros.";
		if [ $erros -ge 1 ]; then
			echo "Verifique o arquivo log.txt";
		fi
	fi
fi
