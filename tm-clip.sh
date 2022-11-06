#!/bin/bash

green_color="\e[32;1m"
red_color="\e[31;1m"
reset_color="\e[0m"


if [[ $1 == "-c" ]]
then
	tmux save-buffer - | xclip -i

elif [[ $1 == "-p" ]]
then
	xclip -o 2>/dev/null | tmux load-buffer -
else
	echo -ne "\n\t${red_color}Not Action Selected\n\n"
	echo -ne "\t${green_color} -c copy tmux buffer in xclip \n"
	echo -ne "\t -p paste xclip in tmux buffer"
	echo -ne "${reset_color}\n\n"
fi
