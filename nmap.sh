#!/bin/bash

#Esta es una script que esta en proceso en la que se utilizara el software nmap.
#
#
#

#Colores normales
colorVerde="\e[0;32m\033[1m"
colorRojo="\e[0;31m\033[1m"
colorAzul="\e[0;31m\033[1m"

#Colores animados

#Quitar color
finalColor="\033[0m\e[0m"

function spawn {
  #Añadir portada
  #Remodelar la seccion completa
  echo -e "-----------NMAP-----------"
  echo -e "--------------------------"
  echo -e "1.-Escanear puertos abierto"# nmap -Pn
  echo -e "2.-Escanear puertos y S.O"
}
