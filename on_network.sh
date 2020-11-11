#!/bin/bash

rojo="\e[31;1m"
verde="\e[32;1m"
amarillo="\e[33;1m"
azul="\e[34;1m"
magenta="\e[35;1m"
reset="\e[0m"
banner()
{

	echo -e "${magenta}\n\n\t\t╔═╗┌┐┌╔═╗┬ ┬┌─┐┌┬┐┌─┐┌┬┐"
	echo -e "\t\t║ ║│││╚═╗└┬┘└─┐ │ ├┤ │││"
	echo -e "\t\t╚═╝┘└┘╚═╝ ┴ └─┘ ┴ └─┘┴ ┴"
	echo -e "\t\t${azul}╦ ╦┌─┐┌─┐┌┬┐┌─┐┌─┐┌┬┐   "
	echo -e "\t\t╠═╣│ │└─┐ │ ├─┘│ │ ││   "
	echo -e "\t\t╩ ╩└─┘└─┘ ┴ ┴  └─┘─┴┘   ${reset}"
	echo -en "\n\n\t"
	for i in $rojo $verde $amarillo $verde $magenta
	do
		for a in {1..8}
		do
			echo -ne "${i}.";sleep 0.15
		done
	done
	echo -e $reset
	sleep 0.5
}
showNICs()
{

	echo -e "\n\n\t${verde}Estas son las tarjetas de red elegidas${reset}\n"
	#ip addr | grep '<' | awk -F ':' '{print $1 $2}'
	#Esto seleccionara la interfaz de red, en este caso (2 es ethernet y 3 es la wireless)
	for line in $(ip addr | grep '<'| cut -d ':' -f 2)
	do
		case $line in
			enp* | eth0)
				echo -e "\t\t[${amarillo}*${reset}]${magenta}$line${reset}"
				EthernetLan=$line;;
			w*)
				echo -e "\t\t[${amarillo}*${reset}]${magenta}$line${reset}"
				WirelessNic=$line;;
		esac
	done
	
}
dependences()
{
	#Hostapd /usr/sbin/hostapd
	#Dnsmasq /usr/sbin/dnsmasq
	#Deteccion
	for i in {0..1}
	do
		clear
		echo -e "${verde}\n\n\tExaminando dependencias${reset}"
		#Hostapd
		echo -en "\n\t\t[${amarillo}*${reset}]\t Hostapd"
		if [ -e /usr/sbin/hostapd ]
		then
			echo -e "\t[${verde}V${reset}]"
		
		else
			echo -e "\t[${rojo}X${reset}]"
			apt install hostapd -y >/dev/null 2>&1
		fi
		
		#dnsmasq
		echo -ne "\n\t\t[${amarillo}*${reset}]\t Dnsmasq"
		if [ -e /usr/sbin/dnsmasq ]
		then
			echo -e "\t[${verde}V${reset}]"
		else
			echo -e "\t[${rojo}X${reset}]"
			apt install dnsmasq -y >/dev/null 2>&1
		fi
		
		sleep 1.5
	done
	sleep 1;clear

}
filesConfig()
{
	clear
	#hostapd
	echo -e "\n\n\t${verde}Configuracion Hostapd${reset}"
	if [ -e $hostapd ]
	then
		echo -e "\n\t${azul}Una configuracion encontrada\n\n${reset}"
		while read line; do echo -e "\t\t${rojo}$line${reset}";done< $hostapd
		SSID=$(cat $hostapd | grep ssid |head -n 1| cut -d '=' -f 2)
		PASS=$(cat $hostapd | grep wpa_passphrase | cut -d '=' -f 2) 
		echo -ne "\n\n\t";read -p '[Pulsa una tecla para continuar]'
	else
		tput cnorm
		echo -ne "\n\t\t${azul}Dime el nombre que le quieres poner a la red${reset}: ";read ssid
		echo -ne "\n\t\t${azul}Dime la contraseña que le vas a poner${reset}: ";read -s passwd
		tput civis
		#Interface
		echo "interface=$WirelessNic">> $hostapd
		#Driver
		echo "driver=nl80211">> $hostapd
		#SSID
		echo "ssid=$ssid">> $hostapd
		#hw_mode
		echo "hw_mode=g">> $hostapd
		#Channel
		echo "channel=8">> $hostapd
		#Macaddr_acl
		echo "macaddr_acl=0">> $hostapd
		#Auth_algs
		echo "auth_algs=1">> $hostapd
		#Ignore_broadcast_ssid
		echo "ignore_broadcast_ssid=0">> $hostapd
		#wpa
		echo "wpa=3">> $hostapd
		#wpa_passwd
		echo "wpa_passphrase=$passwd">> $hostapd
		echo "wpa_key_mgmt=WPA-PSK">> $hostapd
		echo "wpa_pairwise=TKIP">> $hostapd
		echo "rsn_pairwise=CCMP">> $hostapd
		SSID=$ssid
		PASS=$passwd
	fi

	#dnsmasq
	clear
	echo -e "\n\n\t${verde}Configuracion Dnsmasq${reset}"
	if [ -e $dnsmasq ]
	then
		echo -e "\n\t${azul}Una configuracion encontrada\n\n${reset}"
		while read line; do echo -e "\t\t${rojo}$line${reset}";done < $dnsmasq
		echo -ne "\n\n\t";read -p '[Pulsa una tecla para continuar]'
	else
		echo "interface=$WirelessNic">>$dnsmasq
		echo "port=5555">>$dnsmasq
		echo "dhcp-range=192.168.1.2,192.168.1.40,255.255.255.0,12h">>$dnsmasq
		echo "dhcp-option=3,192.168.1.1">>$dnsmasq
		echo "dhcp-option=6,192.168.1.1">>$dnsmasq
		echo "server=8.8.8.8">>$dnsmasq
		echo "log-queries">>$dnsmasq
		echo "log-dhcp">>$dnsmasq
		echo "listen-address=127.0.0.1">>$dnsmasq
	fi

	
}
upNetwork()
{
	clear
	#Asiganacion de ip
	echo -e "\n\n\t[${amarillo}*${reset}]${azul}Configurando interfaz de red${reset}"
	ip link set $WirelessNic down
	ip add flush dev $WirelessNic
	ip addr add 192.168.1.1/24 dev $WirelessNic
	ip link set $WirelessNic up
	sleep 0.5
	#Iptables
	echo 1 > /proc/sys/net/ipv4/ip_forward
	iptables -t nat -A POSTROUTING -o $WirelessNic -j MASQUERADE
	iptables -A FORWARD -i $WirelessNic -o $EthernetLan -m state --state RELATED,ESTABLISHED -j ACCEPT
	iptables -A FORWARD -i $EthernetLan -o $WirelessNic -j ACCEPT
	echo -e "\n\t[${amarillo}*${reset}]${azul}Iniciando dnsmasq${reset}"
	#Levantar red
	dnsmasq -C $dnsmasq >/dev/null 2>&1 &
	echo -e "\n\t[${amarillo}*${reset}]${azul}Iniciando hostapd${reset}\n"
	hostapd $hostapd >/dev/null 2>&1 &
	PID_hostapd=$!
}
ctrl_c()
{
	clear; sleep 0.80
	echo -en "\n\n\t${rojo}Saliendo, espera a que limpie los procesos${reset}"
	for i in {1..6}
	do
		echo -ne "${verde}.${reset}"; sleep 0.5
	done
	echo -e "\n\n"
	#Clear ip nic
	ip add flush dev $WirelessNic
	#Clear iptables
	iptables -t nat -F
	iptables -F
	echo 0 > /proc/sys/net/ipv4/ip_forward
	#Kill process dnsmasq
	if [ -z $(ps -e | grep dnsmasq | cut -d ' ' -f 1) ]
	then
		kill $(ps -e | grep dnsmasq | cut -d ' ' -f 1)
	fi

	#Borrar ficheros de conf
	if [ -e $hostpad ]
	then
		rm -f $hostpad
	fi
	if [ -e $dnsmasq ]
	then
		rm -f $dnsmasq
	fi
	tput cnorm
	exit 0
	
	#Añadir borrar ficheros de configuracion
}
showInfo()
{
	echo -e "\n\n\t[${amarillo}*${reset}]${rojo}Red Iniciada :"
	echo -e "\n\t\t${verde}-->${reset}SSID: ${magenta} $SSID"
	echo -e "\n\t\t${verde}-->${reset}PASS: ${magenta} $PASS ${reset}"
	
}
#Main
if [ $(id -u) != 0 ]
then
	echo -e "\n\n\t${rojo}Vuelve como Root\n\n"
else
	trap ctrl_c INT
	PID_hostapd=''
	EthernetLan=''
	WirelessNic=''
	SSID=''
	PASS=''
	hostapd='.hostapd.conf'
	dnsmasq='.dnsmasq.conf'
	clear;sleep 0.5;tput civis
	banner
	dependences
	showNICs
	filesConfig
	upNetwork;clear
	banner
	showInfo
	wait $PID_hostapd
	
fi
