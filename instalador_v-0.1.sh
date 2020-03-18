#/bin/bash
clear
##Cabecera
echo -e "
\e[32m111100\e[31m10  11\e[34m 100011\e[32m 10  11 1001111\e[31m 01000  01011  \e[34m 1011010 0001   11
\e[32m  10 \e[31m 01  01\e[34m 01    \e[32m 00  01   010  \e[31m 10 000 10 011 \e[34m 10      11 11  01
\e[32m  10 \e[31m 010110\e[34m 1111  \e[32m 110111   101  \e[31m 11  11100  100\e[34m 1011    01  01 11
\e[32m  10 \e[31m 10  11\e[34m 00    \e[32m 01  00   110  \e[31m 11  10 01  11 \e[34m 11      11   1100
\e[32m  10 \e[31m 11  00\e[34m 111110\e[32m 10  10 1011100\e[31m 0101   00110  \e[34m 0001110 10    111"
echo -e "
\e[35m 0101011 1001   11\e[31m 01110001 010  101 0101010\e[32m 01011011 0101111 1011   1010
\e[35m 01   00 10 10  00\e[31m 010       101000  101    \e[32m    01    10      11 10 10 00
\e[35m 01   01 01  11 01\e[31m 01101001   0101   1011011\e[32m    11    1110    01  101  10
\e[35m 11   10 00   0111\e[31m      010    10        011\e[32m    10    00      11       11
\e[35m 1100011 11    100\e[31m 10011111    01    1101010\e[32m    01    1010011 01       01"
sleep 2

echo -e "\e[35mSe creara una carpeta llamada Programas, ejecutar sin superusuario" && sleep 1
##Funcion de instalacion y sus modulos ##
#########################################
function instalacion {
	while [ $opcion -le 5 ]; do
		clear
		echo -e "
		\e[35m+-------------Instalacion-----------+
		\e[31m-> 1.-Navegadores
		\e[31m-> 2.-Comunicacion
		\e[31m-> 3.-Juegos
		\e[31m-> 4.-Editores (Texto,Audio,Imagen)
		\e[31m-> 5.-Drivers
		\e[35m+-----------------------------------+"
		read opcion
		case $opcion in
			1)
				instalacion_navegadores;;
			2)
				instalacion_comunicacion;;
			3)
				instalacion_juegos;;
			4)
				instalacion_editores;;
			5)
				instalacion_drivers;;
			esac
	done
}
##Incompleto tor
function instalacion_navegadores {
	opcion=0
	while [ $opcion -le 2 ]; do
		clear
		echo -e "
		\e[35m+------------Navegadores-------------+
		\e[31m-> 1.-Firefox
		\e[31m-> 2.-Tor
		\e[35m+------------------------------------+"
		read opcion
		case $opcion in
			1)
			sudo apt-get install firefox -y;;
			2)
			wget -O $HOME/Programas/tor.tar.xz https://www.torproject.org/dist/torbrowser/8.5.3/tor-browser-linux64-8.5.3_en-US.tar.xz;
			cd $HOME/Programas
			tar -xf tor.tar.xz;;
		esac
	done
}
function instalacion_comunicacion {
	opcion=0
	while [ $opcion -le 4 ]; do
		clear
		echo -e "
		\e[35m+-----------Comunicacion-----------+
		\e[31m-> 1.-Discord
		\e[31m-> 2.-Skype
		\e[31m-> 3.-HexChat
		\e[31m-> 4.-Xchat
		\e[35m+----------------------------------+"
		read opcion
		case $opcion in
			1)
			sudo snap install discord;;
			2)
			wget -O Descargas/skype.deb https://go.skype.com/skypeforlinux-64.deb
			sudo dpkg -i Descargas/skype.deb && sudo apt-get --fix-broken install -y;;
			3)
			sudo apt-get install hexchat -y;;
			4)
			sudo apt-get install xchat -y;;
		esac
	done
}
function instalacion_juegos {
	opcion=0
	while [ $opcion -le 2 ]; do
		clear
		echo -e "
		\e[35m+---------------Juegos--------------+
		\e[31m-> 1.Steam
		\e[31m-> 2.WineHQ Staging (Ubuntu 18.04)
		\e[31m-> 3.Lutris
		\e[31m-> 4.PlayOnLinux
		\e[35m+-----------------------------------+"
		read opcion
		case $opcion in
			1)
			sudo apt-get install steam -y;;
			2)
			sudo dpkg --add-architecture i386
			wget -nc https://dl.winehq.org/wine-builds/winehq.key
			sudo apt-key add winehq.key
			sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ bionic main'
			sudo apt-get update && sudo apt install --install-recommends winehq-staging -y;;
			3)
			sudo add-apt-repository ppa:lutris-team/lutris
			sudo apt-get update -y
			sudo apt-get install lutris -y
			sudo apt-get update -y
			sudo apt install libvulkan1 libvulkan1:i386 -y
			sudo apt install mesa-vulkan-drivers mesa-vulkan-drivers:i386 -y;;
			4)
			cd $HOME
			wget -q "http://deb.playonlinux.com/public.gpg" -O- | sudo apt-key add -
			sudo wget http://deb.playonlinux.com/playonlinux_bionic.list -O /etc/apt/sources.list.d/playonlinux.list
			sudo apt-get update
			sudo apt-get install playonlinux;;
		esac
	done
}
function instalacion_editores {
	opcion=0
	while [ $opcion -le 6 ]; do
		clear
		echo -e "
		\e[35m+--------------Editores---------------+
		\e[31m-> 1.Sublime Text
		\e[31m-> 2.Eclipse (Java IDE)
		\e[31m-> 3.LibreOffice
		\e[31m-> 4.CodeBlocks (C++ IDE)
		\e[31m-> 5.GIMP
		\e[31m-> 6.Audacity
		\e[35m+-------------------------------------+"
		read opcion
		case $opcion in
			1)
			wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
			sudo apt-get install apt-transport-https -y
			echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
			sudo apt-get update && sudo apt-get install sublime-text;;
			2)
			sudo apt-get install default-jre default-jdk -y && sudo snap install eclipse --classic;;
			3)
			sudo apt-get install libreoffice -y;;
			4)
			sudo apt-get install codeblocks -y;;
			5)
			sudo apt-get install gimp -y;;
			6)
			sudo apt-get install audacity -y;;
		esac
	done
}
function instalacion_drivers {
	opcion=0
	while [ $opcion -le 2 ]; do
		clear
		echo -e "
		\e[35m+--------------Drivers---------------+
		\e[31m-> 1.Nvidia Grafica
		\e[31m-> 2.Razer
		\e[35m+------------------------------------+"
		read opcion
		case $opcion in
			1)
			sudo add-apt-repository ppa:graphics-drivers/ppa;;
			2)
			var_texto=""
			sudo add-apt-repository ppa:openrazer/stable
			sudo apt-get update && sudo apt-get install openrazer-meta
			echo -e "\e[35m Dime el nombre de tu usuario"
			read var_texto
			sudo gpasswd -a $var_texto plugdev
			sudo add-apt-repository ppa:polychromatic/stable
			sudo apt-get update && sudo apt-get install polychromatic;;
		esac
	done
}

######################Aqui empieza el bloque de descargas
function descarga {
	opcion=0
	while [ $opcion -le 5 ]; do
		clear
		echo -e "
		\e[35m+----------------Sistemas Operativos-----------------+
		\e[31m-> 1.-Debian 64 bits
		\e[31m-> 2.-Debian 32 bits
		\e[31m-> 3.-Ubuntu 18.04LTS 64 bits
		\e[31m-> 4.-BunsenLabs 64 bits
		\e[31m-> 5.-BunsenLabs 32 bits
		\e[31m-> 6.-Ubuntu Mate 18.04LTS 64 bits
		\e[31m-> 7.-Trisquel 64 bits
		\e[35m+-----------------------------------------------------+"
		read opcion
		case $opcion in
			1)
			wget -O Descargas/debian64.iso https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-9.9.0-amd64-netinst.iso;;
			2)
			wget -O Descargas/debian32.iso https://cdimage.debian.org/debian-cd/current/i386/iso-cd/debian-9.9.0-i386-netinst.iso;;
			3)
			wget -O Descargas/ubuntu64.iso https://ubuntu.com/download/desktop/thank-you?version=18.04.2&architecture=amd64;;
			4)
			wget -O Descargas/bunsenlabs64.iso https://ddl.bunsenlabs.org/ddl/bl-Helium-4-amd64.iso;;
			5)
			wget -O Descargas/bunsenlabs32.iso https://ddl.bunsenlabs.org/ddl/bl-Helium-4-i386.iso;;
			6)
			wget -O Descargas/ubuntuMate64.iso http://cdimage.ubuntu.com/ubuntu-mate/releases/18.04/release/ubuntu-mate-18.04.2-desktop-amd64.iso;;
			7)
			wget -O Descargas/trisquel.iso http://mirror.librelabucm.org/trisquel-images//trisquel_8.0_amd64.iso;;
		esac
	done
}
####Esta sera la funcion Main
let opcion
mkdir $HOME/Programas
while :
do
	echo -e "
	\e[35m+------------Menu-Principal-------------+
	\e[31m-> 1.-Instalacion
	\e[31m-> 2.-Descarga de S.O
	\e[35m-----------------------------------------"
	read opcion
	case $opcion in
		1)
			instalacion;;
		2)
			descarga;;
	esac
done
