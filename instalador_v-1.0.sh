#!/bin/bash

#Paleta de colores letra
color_rojo="\e[31;1m"
color_verde="\e[32;1m"
color_amarillo="\e[33;1m"
color_azul="\e[34;1m"
color_magenta="\e[35;1m"
#Atributos del texto
negrita="\e[1m"
apagado="\e[2m"
coloreado="\e[3m"
subrayado="\e[4m"
intermitente="\e[5m"
#Reseteo de texto
color_reset="\e[0m"

#capturar "ctrl c" para mostrar una señal
trap ctrl_c INT

#ctrl_C
function ctrl_c {
	clear
    	echo -ne "\n\t${color_rojo}${subrayado}Saliendo${color_reset}"
	for ((i=0;i<4;i++))
	do
		echo -ne "${color_rojo}${subrayado}.${color_reset}"; sleep 0.5
	done
	echo -e "\n\n\t${color_azul}Un saludo de parte de OnSystem${color_reset}\n\n"
	exit 1
}
function presentacion {
	carga_lista=("${color_rojo}${intermitente}.${color_reset}" "${color_verde}${intermitente}.${color_reset}" "${color_azul}${intermitente}.${color_reset}")
	echo -e "\n\t${color_verde}Bienvenido${color_reset}"
	echo -e "\n\t${color_azul}${USER}${color_reset}"
	echo -e "\n\t${color_magenta}Esta script esta testeada con ${subrayado}Ubuntu 18.04${color_reset}"
	echo -ne "\n\tIniciando aplicacion${color_reset}"; sleep 0.3
	for((i=0;$i<5;i++))
	do
		echo -ne " ${color_rojo}.${color_reset}"; sleep 0.5
	done
}
function instalacion_apt {
	lista_apt=("git" "zsh" "tmux" "nmap" "macchanger" "openjdk-11-jdk" "openjdk-11-jre" "openjdk-8-jdk" "openjdk-8-jre" "libimage-exiftool-perl" "libreoffice")
	clear
	echo -e "\n\t${color_azul}Herramientas de instalacion por APT${color_reset}"
	#Tambien en un futuro seria buena idea poder implementar mas repositorios para añadir mas a la lista
	#Comprobacion
	for i in ${lista_apt[@]}
	do
		which $i >& /dev/null
		if [ $? == 0 ]
		then
			echo -ne "\n\t[${color_verde}V${color_reset}]"
		else
			echo -ne "\n\t[${color_rojo}X${color_reset}]"
		fi
		echo -e " $i"
	done
	echo -e "\n\t${color_verde}Pulsa cualquier tecla para instalar los paquetes que faltan${color_reset}"; read;
	#Instalacion
	echo -ne "\n\t${color_verde}Instalando ${color_reset}"
	for i in ${lista_apt[@]}
	do
		which $i >& /dev/null
		if [ $? != 0 ]
		then
			debconf -f non-interactive apt-get install -y $i >& /dev/null 2>&1
		fi
		echo -ne "${color_rojo}.${color_reset}"; sleep 0.2
	done
	echo -e "\n"
}
function instalacion_snap {
	lista_snap_classic=("code" "discord" "eclipse")
	lista_snap=("mc-installer")
	
	clear
	#Comprobacion
	echo -e "\n\t${color_azul}Instalacion de herramientas SNAP${color_reset}"
	for i in ${lista_snap_classic[@]}
	do
		test -e /snap/$i
		if [ $? == 0  ]
		then
			echo -ne "\n\t[${color_verde}V${color_reset}]"
		else
			echo -ne "\n\t[${color_rojo}X${color_reset}]"
		fi
		echo " $i"
	done
	for i in ${lista_snap[@]}
	do
		test -e /snap/$i
		if [ $? == 0 ]
		then
			echo -ne "\n\t[${color_verde}V${color_reset}]"
		else
			echo -en "\n\t[${color_rojo}X${color_reset}]"
		fi
		echo " $i"
	done
	echo -e "\n\t${color_verde}Pulsa cualquier tecla para instalar los paquetes que faltan${color_reset}"; read ;
	#Instalacion
	echo -ne "\n\t${color_verde}Instalando ${color_reset}"
	for i in ${lista_snap_classic[@]}
	do
		test -e /snap/$i
		if [ $? != 0 ]
		then
			snap install $i --classic >& /dev/null 2>1
		fi
		echo -ne "${color_rojo}.${color_reset}"; sleep 0.2
	done
	for i in ${lista_snap[@]}
	do
		test -e /snap/$i
		if [ $? != 0 ]
		then
			snap install $i >& /dev/null 2>1
		fi
		echo -ne "${color_rojo}.${color_reset}"; sleep 0.2
	done
	echo -e "\n"
}


#Main
clear
presentacion;
contador=0
if [ $(id -u) -eq 0 ]
then
	while [ $contador -lt 2 ]
	do
		case $contador in
			0) instalacion_apt; let contador++ ;;
			1) instalacion_snap; let contador++ ;;
			2) instalacion_extra;;
		esac
	done
else
	clear
	echo -e "\n\t${color_rojo}${subrayado}Vuelve a intentarlo como superusuario${color_reset}\n"
fi
