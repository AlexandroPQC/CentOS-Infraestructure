#!/bin/bash

# Desplegar archivo de configuracion

function config_file(){
	cat $1
	echo "Archivo $2"
	read -m "Desea editar? (s/n)" answer
	if [$answer != "s" ]
	then
		echo "Reemplazando archivo..."
		$1 > $2
	else
		vim $2
		config_file $1 $2
	fi
}

