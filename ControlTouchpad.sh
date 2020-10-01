#!/bin/bash

#Esta herramienta solo requiere xinput
help()
{
	echo -e "\n\n\tHelp"
	echo -e "\n\n\t\tYou have two options :"
	echo -e "\n\t\t\ton --- Enable TouchPad"
	echo -e "\n\t\t\toff - Disabled Touchpad\n\n\n"
}
opcion()
{
	if [ $1 == 'on' ]
	then
		xinput enable $id
	elif [ $1 == 'off' ]
	then
		xinput disable $id
	else
		help
	fi
	
}

modo=$1
#Mas adelante se podria ajustar el awk
touchPadId=$(xinput|grep TouchPad | awk -F ' ' '{print $6}')
id=$(echo $touchPadId|cut -d '=' -f 2)
if [[ $modo != '' ]]
then
	opcion $modo
else
	help
fi
