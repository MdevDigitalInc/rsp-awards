#!/usr/bin/env bash
clear
# [ Black Mesa - Vue.js Dependencies ]
# ------------------------------------------------------------------
# Lucas Moreira - l.moreira@live.ca
# ------------------------------------------------------------------
#
# Setup Bash Script for installing Node dependencies and running dev server
# with support for Windows | Mac | Linux architectures.

# Program Variables
BLACKMESA="[ Black Mesa ] | Setup Script"

# Error Handling Function
error_handle() {
  echo
  echo "${RED}[ ERROR ] || ${BLACKMESA}: $1${NC}"
  echo
  exit 1
}

# Color Variables
ORANGE=`tput setaf 5`
GREEN=`tput setaf 2`
RED=`tput setaf 1`
YELLOW=`tput setaf 3`
NC=`tput sgr0`

# Intro / Continue
echo "__________________________________________________________________________________________"
echo
echo "[ ${YELLOW}Moreira Development - LEMP Local Dev Stack${NC} ]"
echo
echo "__________________________________________________________________________________________"

sleep 2s
echo
echo "This script will setup a new Virtual Host inside of Nginx to host your project"
echo
echo "------------------------------------------------------------------------------------------"
echo
read -p "${RED} Please make sure you are running this from the root folder of your website" answer
sleep 2s

echo "${RED}[ SUDO! ]${NC} - This application requires ${YELLOW}SUDO priviledges${NC} to install ${GREEN}Node${NC}."

sleep 1s
echo
echo "${YELLOW} Please enter a name for your project. Only use Lowercase names
separated by dashes${NC}"
echo
read -p "${YELLOW}Project Name: " rsp-awards

# Save Current Path
MY_PATH="`dirname \"$0\"`"              # relative
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"  # absolutized and normalized
if [ -z "$MY_PATH" ] ; then
  # error; for some reason, the path is not accessible
  # to the script (e.g. permissions re-evaled after suid)
    exit 1  # fail
fi

# Save Current Dir
MY_DIRECTORY="`basename $MY_PATH`"

echo "${GREEN} Adding Nginx Configuration ${NC}"

# Linux
if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]
then
  # Creates a sample Dev domain for Nginx to serve in the same port
  sudo cp /etc/nginx/sites-available/dev.mdev-theme /etc/nginx/sites-available/dev.$PROJ_NAME
  # Modify file to point to proper root folder
  sudo sed -i "s/.*root.*/root \/var\/www\/$MY_DIRECTORY;/" /etc/nginx/sites-available/dev.$PROJ_NAME
  sudo sed -i "s/.*server_name.*/server_name dev.$PROJ_NAME;/" /etc/nginx/sites-available/dev.$PROJ_NAME
  sudo sed -i "s/.*error_log.*/error_log \/var\/log\/nginx\/$PROJ_NAME-err.log;/" /etc/nginx/sites-available/dev.$PROJ_NAME
  sudo sed -i "s/.*access_log.*/access_log \/var\/log\/nginx\/$PROJ_NAME-acc.log;/" /etc/nginx/sites-available/dev.$PROJ_NAME
  # Create symlink so dev domain can be served by local Nginx
  sudo ln -s /etc/nginx/sites-available/dev.$PROJ_NAME /etc/nginx/sites-enabled/dev.$PROJ_NAME
  # Create symlink between current directory and the server
  sudo ln -s $MY_PATH /var/www/$MY_DIRECTORY
  # Add entry to ETC hosts

  #Set Permission
  echo "${GREEN} Setting Permissions ${NC}"
fi

# OSx
if [ "$(uname)" == "Darwin" ]
then
  # Creates a sample Dev domain for Nginx to serve in the same port
  sudo cp /usr/local/etc/nginx/sites-available/dev.mdev-theme /usr/local/etc/nginx/sites-available/dev.$PROJ_NAME
  # Modify file to point to proper root folder
  sudo sed -i "s/.*root.*/root \/usr\/local\/var\/www\/$MY_DIRECTORY;/" /etc/nginx/sites-available/dev.$PROJ_NAME
  sudo sed -i "s/.*server_name.*/server_name dev.$PROJ_NAME;/" /etc/nginx/sites-available/dev.$PROJ_NAME
  sudo sed -i "s/.*error_log.*/error_log \/usr\/local\/var\/log\/nginx\/$PROJ_NAME-err.log;/" /etc/nginx/sites-available/dev.$PROJ_NAME
  sudo sed -i "s/.*access_log.*/access_log \/usr\/local\/var\/log\/nginx\/$PROJ_NAME-acc.log;/" /etc/nginx/sites-available/dev.$PROJ_NAME
  # Create symlink so dev domain can be served by local Nginx
  sudo ln -s /usr/local/etc/nginx/sites-available/dev.$PROJ_NAME /usr/local/etc/nginx/sites-enabled/dev.$PROJ_NAME
  # Create symlink between current directory and the server
  sudo ln -s $MY_PATH /usr/local/var/www/$MY_DIRECTORY
  # Add entry to ETC hosts

  #Set Permission
  echo "${GREEN} Setting Permissions ${NC}"
  sudo chmod 755 /User
  sudo chmod 755 /usr
  sudo chmod 755 /User -R
fi

sudo echo "127.0.0.1 dev.$PROJ_NAME" >> /etc/hosts

echo "${GREEN} Restarting Nginx ${NC}"
echo

if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]
then
  sudo systemctl reload nginx.service
fi

if [ "$(uname)" == "Darwin" ]
then
  sudo nginx -s stop && sudo nginx
fi

clear
echo "${GREEN} Nginx is available on localhost ${NC}"
echo
echo "${GREEN} You can find your project at http://dev.$PROJ_NAME:9090${NC}"
sleep 3s

exit 1