#!/bin/bash
#drop_cache.sh
#Usage: ./drop_cache.sh

# This script drops cache from memory and increase amount of free memory.
# Must be logged in as root

# @author: Md. Nabid Imteaj
# @date  : January 26th, 2015
# @email : mail.prome@gmail.com

# initializing variables ---------------------------
fileName="/usr/local/bin/drop_cache"
user=$USER
root="root"
currentDir=$PWD
# /-------------------------------------------------

# define colors -------------------------------------
red=`tput setaf 1`
green=`tput setaf 2`
NC=`tput sgr0` # No Color
bold=`tput bold`
dim=`tput dim`
# /--------------------------------------------------

# prompt current user -------------------------------
echo "Logged in as: $user"
# /--------------------------------------------------

# check if user is root or not ----------------------
if [[ "$user" != "$root" ]] 
then
	echo -e "${red}MUST BE LOGGED IN AS ROOT... ABORTING${NC}"
else
	# check soft link
	if [ ! -f $fileName ]
	then
		# file not found
		# create symbolic link
		echo "Creating soft link to this script..."
		ln -s "$currentDir/drop_cache.sh" $fileName
		echo "Soft link created successfully. From now on just type ${bold}drop_cache${NC} as root to drop cache."
	fi

	# drop cache
	#echo "=============================================================="
	echo "Current cache:"
	echo "--------------------------------------------------------------------------"
	free -h | egrep "Mem|cached"
	echo "                                                                    ======"

	# basically this is the command used to drop  memory cache
	# JEALOUS !!!
	sudo sync; sudo echo 3 > /proc/sys/vm/drop_caches

	echo "After executing drop_caches:"
	echo "--------------------------------------------------------------------------"
	free -h | egrep "Mem|cached"
	echo "                                                                    ${green}======${NC}"

	echo -e "${bold}${green}Cache cleared${NC}"
fi
# /---------------------------------------------------
