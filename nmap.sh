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

function spanw {
echo -e "${colorVerde}
 _____  _            _   _  _      _      _               _____         _____              _                    
|_   _|| |          | | | |(_)    | |    | |             |  _  |       /  ___|            | |                   
  | |  | |__    ___ | |_| | _   __| |  __| |  ___  _ __  | | | | _ __  \ `--.  _   _  ___ | |_   ___  _ __ ___  
  | |  | '_ \  / _ \|  _  || | / _` | / _` | / _ \| '_ \ | | | || '_ \  `--. \| | | |/ __|| __| / _ \| '_ ` _ \ 
  | |  | | | ||  __/| | | || || (_| || (_| ||  __/| | | |\ \_/ /| | | |/\__/ /| |_| |\__ \| |_ |  __/| | | | | |
  \_/  |_| |_| \___|\_| |_/|_| \__,_| \__,_| \___||_| |_| \___/ |_| |_|\____/  \__, ||___/ \__| \___||_| |_| |_|
                                                                                __/ |                           
                                                                               |___/                            
${finalColor}"
}

function nmap {
  #Añadir portada
  #Remodelar la seccion completa
  echo -e "-----------NMAP-----------"
  echo -e "--------------------------"
  echo -e "1.-Escanear puertos abierto"# nmap -Pn
  echo -e "2.-Escanear puertos y S.O"
}
spanw
