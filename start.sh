#!/bin/bash
#-------------------------------------------------------------------------------------------
#fgc0109 2015.11.15                                                                          
#-------------------------------------------------------------------------------------------
dividing="================================================================================" 
commandPath="steamcmd"
commandFile="./steamcmd.sh"

gamesPath="Steam/steamapps/common/Don't Starve Together Dedicated Server/bin"
gamesFile="./dontstarve_dedicated_server_nullrenderer"
#-------------------------------------------------------------------------------------------
function FilesDelete()
{
	echo -e "\033[32m[info] Choose File To Delete [1-5]\033[0m"
	read input_filedelete

	if [ -d ".klei" ]; then
		cd ".klei"
		if [ -d "DoNotStarveServer_$input_filedelete" ]; then
			sudo rm -r DoNotStarveServer_$input_filedelete/save
			echo -e "\033[33m[info] File DoNotStarveServer_$input_filedelete Is Deleted\033[0m"
		fi
		if [ -d "DoNotStarveCaves_$input_filedelete" ]; then
			sudo rm -r DoNotStarveCaves_$input_filedelete/save
			echo -e "\033[33m[info] File DoNotStarveCaves_$input_filedelete Is Deleted\033[0m"
		fi
		cd "../"
	fi
}
#-------------------------------------------------------------------------------------------
function FilesBackup()
{
	echo -e "\033[32m[info] Choose File To Backup [1-5]\033[0m"
	read input_filebackup

	if [ -d ".klei" ]; then
		cd ".klei"
		if [ -d "DoNotStarveServer_$input_filebackup" ]; then
			sudo tar -zcf DoNotStarveServer_$input_filebackup.tar.gz DoNotStarveServer_$input_filebackup
			echo -e "\033[33m[info] File DoNotStarveServer_$input_filebackup Is Backuped\033[0m"
		fi
		if [ -d "DoNotStarveCaves_$input_filebackup" ]; then
			sudo tar -zcf DoNotStarveCaves_$input_filebackup.tar.gz DoNotStarveCaves_$input_filebackup
			echo -e "\033[33m[info] File DoNotStarveCaves_$input_filebackup Is Backuped\033[0m"
		fi
		cd "../"
	fi
}
#-------------------------------------------------------------------------------------------
function FilesRecovery()
{
	echo -e "\033[32m[info] Choose File To Recovery [1-5]\033[0m"
	read input_filerecovery

	if [ -d ".klei" ]; then
		cd ".klei"
		if [ -f "DoNotStarveServer_$input_filerecovery.tar.gz" ]; then
			if [ -d "DoNotStarveServer_$input_filerecovery" ]; then
				sudo rm -r DoNotStarveServer_$input_filerecovery
			fi
			sudo tar -zxf DoNotStarveServer_$input_filerecovery.tar.gz DoNotStarveServer_$input_filerecovery
			echo -e "\033[33m[info] File DoNotStarveServer_$input_filerecovery Is Recovered\033[0m"
		else
			echo -e "\033[31m[warn] Backup File For DoNotStarveServer_$input_filerecovery Not Found\033[0m"
		fi
		
		if [ -f "DoNotStarveCaves_$input_filerecovery.tar.gz" ]; then
			if [ -d "DoNotStarveCaves_$input_filerecovery" ]; then
				sudo rm -r DoNotStarveCaves_$input_filerecovery
			fi
			sudo tar -zxf DoNotStarveCaves_$input_filerecovery.tar.gz DoNotStarveCaves_$input_filerecovery
			echo -e "\033[33m[info] File DoNotStarveCaves_$input_filerecovery Is Recovered\033[0m"
		else
			echo -e "\033[31m[warn] Backup File For DoNotStarveCaves_$input_filerecovery Not Found\033[0m"
		fi
		cd "../"
	else
		echo -e "\033[31m[warn] Main Archive Folder Not Found\033[0m"
	fi
}
#-------------------------------------------------------------------------------------------
function SystemPrepsDetail()
{
	echo -e "\033[33m[info] System Library Install\033[0m"                                
	sudo apt-get update
	sudo apt-get install screen
	sudo apt-get install lib32gcc1
	sudo apt-get install lib32stdc++6
	sudo apt-get install libcurl4-gnutls-dev:i386
	echo -e "\033[33m[info] System Library Install Finished\033[0m"
	echo "$dividing"
}
#-------------------------------------------------------------------------------------------
function SystemPreps()
{
	echo -e "\033[33m[info] System Library Preparing\033[0m"                                
	sudo apt-get update 																							1>/dev/null
	sudo apt-get install screen 																					1>/dev/null
	sudo apt-get install lib32gcc1 																					1>/dev/null
	sudo apt-get install lib32stdc++6 																				1>/dev/null
	sudo apt-get install libcurl4-gnutls-dev:i386 																	1>/dev/null
	echo -e "\033[33m[info] System Library Prepare Finished\033[0m"
	echo "$dividing"
}
#-------------------------------------------------------------------------------------------
function CommandPreps()
{
	echo -e "\033[33m[info] Steam Command Line Files Preparing\033[0m"
	
	if [ ! -d "$commandPath" ]; then
		mkdir "$commandPath"
	fi
	cd "$commandPath"
	
	wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz	   									1>/dev/null
	tar -xvzf steamcmd_linux.tar.gz                                                									1>/dev/null
	rm -f steamcmd_linux.tar.gz                                                    									1>/dev/null

	echo -e "\033[33m[info] Steam Command Line Files Prepare Finished\033[0m"
	echo "$dividing"
}                                                                                           
#-------------------------------------------------------------------------------------------
function ServerStart()
{  
	echo -e "\033[32m[info] Choose Game Mode [1.noraml] [2.caves]\033[0m"
	read input_mode 
	echo -e "\033[32m[info] Choose Save File [1-5]\033[0m"
	read input_save 
	
	cd "$gamesPath"
	case $input_mode in  
		1)
			sudo screen -S "world" "$gamesFile" -conf_dir DoNotStarveServer_"$input_save";;
		2)
			sudo screen -S "caves" "$gamesFile" -conf_dir DoNotStarveCaves_"$input_save";;
		*)
			echo -e "\033[31m[warn] Illegal Command,Please Check\033[0m" ;;
	esac
	
	echo "$dividing"
	#"$gamesFile"
}
#-------------------------------------------------------------------------------------------
function ServerStartQuick()
{  
	echo -e "\033[32m[info] Choose Save File [1-5]\033[0m"
	read input_save 
	
	cd "$gamesPath"

	if [ -d "temp_world.sh" ]; then
		sudo rm -r temp_world.sh	
	fi
	if [ -d "temp_cave.sh" ]; then
		sudo rm -r temp_cave.sh	
	fi

	echo -e "\033[33m[info] Starting Cave Server, Please Wait\033[0m"
	echo sudo screen -d -m -S "caves" "$gamesFile" -conf_dir DoNotStarveCaves_"$input_save" > "temp_cave.sh"
	. ./temp_cave.sh
	sleep 30
	
	echo -e "\033[33m[info] Starting World Server, Please Wait\033[0m"
	echo sudo screen -d -m -S "world" "$gamesFile" -conf_dir DoNotStarveServer_"$input_save" > "temp_world.sh"
	. ./temp_world.sh
	sleep 30
	
	if [ -d "temp_world.sh" ]; then
		sudo rm -r temp_world.sh	
	fi
	if [ -d "temp_cave.sh" ]; then
		sudo rm -r temp_cave.sh	
	fi
	
	echo -e "\033[33m[info] Current Screen Infomation\033[0m"
	sudo screen -ls
	echo "$dividing"
	
	top
	#"$gamesFile"
}
#-------------------------------------------------------------------------------------------
function ServerPreps()                                                                      
{                                                                                           
	echo -e "\033[33m[info] Preparing Server Files\033[0m"                                  
	if [ ! -d "$commandPath" ]; then                                                        
		echo -e "\033[31m[warn] Steam Command Line Not Found\033[0m"
		CommandPreps
	else
		echo -e "\033[33m[info] Steam Command Line Found\033[0m"
		cd "$commandPath"
	fi
	
	echo -e "\033[32m[info] Choose Game Update Mode [1.noraml] [2.caves]\033[0m"
	read input_game
  
	case $input_game in  
		1)
			"$commandFile" +login anonymous +app_update 343050 validate +quit;;
		2)
			"$commandFile" +login anonymous +app_update 343050 -beta cavesbeta validate +quit;;
		*)
			echo -e "\033[31m[warn] Illegal Command,Please Check\033[0m" ;;
	esac
	
	cd "../"
	echo "$dividing"
	ServerStart
}
#-------------------------------------------------------------------------------------------
clear
echo "$dividing"

if [ ! -d "$gamesPath" ]; then
	echo -e "\033[31m[warn] Server Files Not Found\033[0m" 
	echo "$dividing"
	SystemPrepsDetail
	ServerPreps                                                                             
else                                                                                        
	echo -e "\033[32m[info] Server Files Found\033[0m"
	echo "$dividing"
	echo -e "\033[33m[info] Choose An Action To Perform\033[0m"
	
	echo -e "\033[32m[info] System Library Files [0.Prepare]\033[0m"
	echo -e "\033[32m[info] Game Server [1.start]  [2.update]  [3.quick]\033[0m"
	echo -e "\033[32m[info] Unix Screen [4.info]   [5.attach]  [6.kill]\033[0m"
	echo -e "\033[32m[info] Save Files  [7.backup] [8.recovery][9.delete]\033[0m"
	read input_update 
  
	case $input_update in
		0)
			SystemPreps;;
			#SystemPrepsDetail;;
		1)
			ServerStart;;
		2)
			ServerPreps;;
		3)
			ServerStartQuick;;
		4)
			sudo screen -ls;;
		5)
			sudo screen -r world;;
		6)
			sudo killall screen;;
		7)
			FilesBackup;;
		8)
			FilesRecovery;;
		9)
			FilesDelete;;
	esac	                                                                   
fi                                                                                          

