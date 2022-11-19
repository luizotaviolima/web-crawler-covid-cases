#!/bin/bash

#site para realizar o download
siteDownload='http://www.saude.pr.gov.br/sites/default/arquivos_restritos/files/documento'

#Variáveis
diaIni=$1
diaFim=$2
mes=$3
ano=$4
cidade=$5
TipoInfo=$6

# Diretórios 
dataDir="./dados"
tmpDir="./dados_tmp"

# cria diretórios
mkdir $dataDir
mkdir $tmpDir

# Loop para baixar e mover os arquivos
for periodo in $(seq -f "%02g" $diaIni $diaFim); do
	
	arquivo=informe_epidemiologico_$periodo"_"$mes"_"$ano"_obitos_casos_municipio.csv"	
				
	# O comando wget vai baixar o csv
	echo -n "Baixando arquivo $arquivo ..."
	wget $siteDownload/$ano-$mes/$arquivo 2> log.txt	
	echo OK
	
	# Aqui os dados são movidos para a pasta temporária
	echo -n "movendo o arquivo $arquivo ..."
	mv $arquivo $tmpDir 2> log.txt	
	echo OK	

done

# Move o arquivo log para a pasta temporária
mv log.txt $tmpDir

# Acesso a pasta temporária
cd $tmpDir 

# Loop para concatenar os arquivos
for periodo in $(seq -f "%02g" $diaIni $diaFim); do

	arquivo=informe_epidemiologico_$periodo"_"$mes"_"$ano"_obitos_casos_municipio.csv"
	
	if (($((${periodo#0})) == $diaIni));then
	
		# Cria o arquivo base para a concatenação baseado no primeiro arquivo baixado
		cp $arquivo concat$periodo.csv 2> log.txt
	else
		# gera um arquivo novo concatenando com a data anterior
		old=$((${periodo#0}-1))
		old=$(printf "%02d" $old)				
		cat concat$old.csv <(tail +2 $arquivo) > concat$periodo.csv 2> log.txt		
		# Remove todos os arquivos concatenados antigos
		rm concat$old.csv 2> log.txt		
	fi
done

# Filtrando por Cidade
sed "1p;/$cidade/!d" concat$periodo.csv > cidade.csv 2> log.txt 

# Removendo os espaços para as cidades com nomes compostos
str=$cidade
str=${str// /_}

# Condição de acordo com o Tipo de informação. Também já cria o arquivo final.
if (($TipoInfo == 1));then

	cut -f 3,5 -d ';' cidade.csv > $ano$mes$diaIni-$diaFim'_'$str'_'$TipoInfo.csv
	
elif (($TipoInfo == 2)); then

	cut -f 3,6 -d ';' cidade.csv > $ano$mes$diaIni-$diaFim'_'$str'_'$TipoInfo.csv
	
elif (($TipoInfo == 3)); then

	cut -f 3,5,6 -d ';' cidade.csv > $ano$mes$diaIni-$diaFim'_'$str'_'$TipoInfo.csv	
fi	

#Movendo para a pasta Dados o arquivo final
mv $ano$mes$diaIni-$diaFim'_'$str'_'$TipoInfo.csv "../$dataDir"

# Diretório temporário é apagado
rm -f ../$tmpDir/*.csv


