#!/bin/bash
#You need install lm-sensors
#You can install with next command:
#sudo apt-get install lm-sensors
function ctrl_c
{
	clear
	echo -e "\n\n\tSaliendo\n\n"
	sleep 2
	tput cnorm
	exit 0
}

trap ctrl_c INT
tput civis
while $true ; do
	clear
	sensors
	sleep 1
done
