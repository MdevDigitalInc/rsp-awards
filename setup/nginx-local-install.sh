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

SCRIPT_SRC=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
# Intro / Continue
echo "__________________________________________________________________________________________"
echo
echo "[ ${YELLOW}Moreira Development - NGINX Local Server Setup${NC} ]"
echo
echo "__________________________________________________________________________________________"
sleep 3s

cd $SCRIPT_SRC
git clone git@github.com:MoreiraDevelopment/nginx-tools.git

(./nginx-tools/nginx-local/setup-lemp-local.sh)

sudo cp nginx-tools/nginx-local/setup-virtual-server.sh setup-virtual-server.sh
sudo cp nginx-tools/nginx-local/README.md SETUP-SERVER.md
sudo rm -r nginx-tools/

exit 1
