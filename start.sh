#!/bin/bash
# Init


############################################
################# CHANGE ###################
ver=0.3
dat=19.05.2020
file=start.sh
link=https://raw.githubusercontent.com/Mobulos/reformcloud-start-file/master/start.sh
################# CHANGE ###################
############################################



# ROOT CHECK
FILE="/tmp/out.$$"
GREP="/bin/grep"
if [ "$(id -u)" != "0" ]; then
	log_warning "Das Script muss als root gestartet werden."
	exit 1
fi

# SETZE FARBCODES
red=($(tput setaf 1))
green=($(tput setaf 2))
yellow=($(tput setaf 3))
reset=($(tput sgr0))
tput1=($(tput setaf 1))
tput2=($(tput setaf 2))
tput3=($(tput setaf 3))
tput4=($(tput setaf 4))
tput5=($(tput setaf 5))
tput6=($(tput setaf 6))
tput7=($(tput setaf 7))
tput8=($(tput setaf 8))
tput9=($(tput setaf 9))

# LADE DAS LOG FEATURE
rm .log4bash.sh
clear
curl --progress-bar https://raw.githubusercontent.com/Mobulos/multi-install/master/log4bash.sh -o .log4bash.sh
chmod +x .log4bash.sh
source .log4bash.sh
clear

#   ____    ____    _____ 
#  |  _ \  |  _ \  | ____|
#  | |_) | | |_) | |  _|  
#  |  __/  |  _ <  | |___ 
#  |_|     |_| \_\ |_____|

function pre () {
    echo -n "$yellow"
	echo "##########################################"
	sleep .3
	echo "## Reformcloud Start Script by Mobulos  ##"
	sleep .3
	echo "##########################################"
	sleep .3
	echo
	echo "$reset""Version $ver"
	#echo "$red""[DEVELOPER] "$reset"Version $ver"
	echo "Update $dat"
	echo -n "$reset"
	echo
	#log_warning "Dies ist die PRE-RELEASE Version, das Script verfügt noch nicht über alle Funktionen!"
	echo

}

function update () {
	# CHECK, OB DAS SCRIPT HEUTE UPGEDATED WURDE
	if [ -f $(date +%Y-%m-%d) ]
	then
		# WENN HEUTE BEREITS UPGEDATED GEHE ZUM MENÜ
		menue
		./start.sh
	elif [ '*' ]
	then
		# WENN HEUTE NICHT UPGEDATED GEHE WEITER
		# LÖSCHE "ZULETZT UPGEDATED" DATEI
		touch "$(date +%Y-%m-%d)"
		rm 20* || :
		clear
		echo "$red Die neuste Version wird heruntergeladen"
		rm $file
		curl --progress-bar $link -o $file.1
		sleep 2
		echo "$reset"
		rm $file
		mv $file.1 $file
		clear
		log_success "Das Update wurde Erfolgreich heruntergeladen!"
		sleep 1
		chmod +x $file
		touch "$(date +%Y-%m-%d)"
        ./start.sh
	fi
	exit
}

function start () {
	pre
	sleep .5
	screen -S cloud java -XX:+UseG1GC -XX:MaxGCPauseMillis=50 -XX:CompileThreshold=100 -XX:+UseCompressedOops -Xmx512m -Xms256m -jar runner.jar
}

