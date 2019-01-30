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
echo "[ ${YELLOW}Moreira Development - Vue.js App Installation${NC} ]"
echo
echo "__________________________________________________________________________________________"

sleep 2s
echo
echo "This Script will install and configure all the necessary Software & Dependencies to run the project."
echo
echo "${YELLOW}[ Including ]"
echo
echo "- Node & NPM"
echo "- Vue"
echo "- NPM Dependencies${NC}"
echo
echo
echo "For more information and useful documentation please refer "
echo "to the [${GREEN} ~/docs ${NC}] folder inside of this repository."
echo
echo "It includes information on Linting, Testing and styleguides. "
echo
echo "------------------------------------------------------------------------------------------"

sleep 2s

echo
echo "${YELLOW}[ NOTICE! ]${NC} - This application depends on ${GREEN}Node.js${NC} and ${GREEN}Vue.js being installed globally."
echo
echo "${YELLOW}[ NOTICE! ]${NC} - This Installation Script will check to make sure Node.js install and install it for you if necessary."
echo
echo "${RED}[ SUDO! ]${NC} - This application requires ${YELLOW}SUDO priviledges${NC} to install ${GREEN}Node${NC}."

sleep 1s
echo
read -p "${YELLOW}|   Continue with installation?   ${NC}|${NC}  " answer

# [ Black Mesa ] Setup Script RUN
clear
echo "${GREEN}Initiating Install...${NC}"
echo
sleep 2s

# [ BASE SYSTEM CHECKS ]
# Check and install system dependencies based on OS

# [[ NODE JS ]].
if node -v
  then
    echo
    echo "${GREEN}Node is already installed. Proceeding with Dependencies...${NC}"
    sleep 5s
  else
    clear
    echo
    echo "${RED}Node installation is missing.${NC}"
    echo
    echo "${GREEN}Preparing to Install Node..."
    sleep 3s

    #[ OS BASED NODE INSTALLATION ]
    if [ "$(uname)" == "Darwin" ]
    then
      # OSX Install Script
      clear
      echo
      echo "${YELLOW}[ Operating System Detected as: ${GREEN}Darwin / OSX${NC} ${YELLOW}]${NC}"
      echo
      sleep 2s
      # Install Node
      echo "${YELLOW}[ Checking for Software Updates ]${NC}"
      if gcc --version
        then
          echo "${GREEN}[ XCode Already Installed ]{$NC}"
        else
          sudo softwareupdate -iva
          xcode-select --install
      echo
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]
    then
      # Linux Node Install Script
      clear
      echo
      echo "${YELLOW}[ Operating System Detected as: ${GREEN}Linux / GNU${NC}${YELLOW}]${NC}"
      sleep 2s
      # Prepare Install
      sudo apt-get update
      sudo apt-get install build-essential libssl-dev
    elif *
    then
      error_handle "Could Not Find Your OS. Please Install Node Manually And Try Again."
   fi
   # Download NVM
   curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash

   if nvm --version
   then
     nvm install node
   elif
     echo "${RED}[ NVM Did not install properly. ]${NC}"
   fi
fi
# NODE INSTALL FINISH.

if [ "$(uname)" == "Darwin" ]
then
  #install brew
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  #install image libraries
  brew install libpng-dev mozjpeg
  # Install compilers
  brew install libtool automake autoconf nasm
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]
  then
    sudo apt-get install libpng-dev mozjpeg
    sudo apt-get install libtool automake autoconf nasm
  else
    clear
    echo "${RED}[ OS Not Found...]${NC}"
fi
# Fetch latest master branch
echo "${GREEN}Fetching latest codebase from Master...${NC}"
if git fetch && git checkout master && git pull origin master
  then
    sleep 2s
else
  error_handle "Please clear your Git workspace by commiting or stashings your changes and try again."
fi
echo
echo
echo "${GREEN}Installing Vue.js Globally...${NC}"
echo
echo
sleep 2s

# Check for existing Vue Install
if vue
then
  echo "${GREEN}Vue.JS is already installed!${NC}"
  sleep 5s
else
  if npm install -g vue
  then
    sleep 1s
    clear
    echo
    echo
    echo "${GREEN}Vue.JS Installed successfully!${NC}"
  else
    error_handle "There was a problem installing Vue.js - Visit http://vuejs.org for Manual Installation steps"
  fi
fi

# Install NPM dependencies
sleep 1s
clear
echo
echo "${GREEN}Installing Node dependencies...${NC}"
echo
echo
sleep 2s
if cd vue-app-base/
  then
    npm install
else
  error_handle "Seems there was a problem here. Contact an Admin."
fi
echo

# Run Test Server
clear
echo
echo "${GREEN}SUCCESS! All dependencies installed...${NC}"
echo
echo "${GREEN}[ Welcome Aboard The ${ORANGE}Black Mesa${GREEN} ]${NC}"
echo
echo "${GREEN}------------------------------------------------------------------------------------------${NC}"
echo
echo "Please refer to the ${GREEN}[ ~/docs ]${NC} folder or the GitHub Wiki for guides on"
echo
echo "${YELLOW}- Dependencies"
echo "${YELLOW}- Naming Convention"
echo "${YELLOW}- Code Styleguide"
echo "${YELLOW}- Linting"
echo "${YELLOW}- Best Practices"
echo "${YELLOW}- Code Recepies"
echo "${YELLOW}- Routes [vue-router]"
echo "${YELLOW}- VueX [State Management]"
echo "${YELLOW}- Vue Resource [Ajax Wrapper]"
echo "${YELLOW}- Firebase [OODB]"
echo "${YELLOW}- Templating Structure"
echo "${YELLOW}- Responsive Breakpoints"
echo "${YELLOW}- SCSS Structure"
echo "${YELLOW}- SCSS Styleguide"
echo "${YELLOW}- And More...${NC}"
sleep 3s
echo
echo "${YELLOW}Booting Up Test Server on [ ${GREEN}localhost:8080${NC} ]"
echo
sleep 1s
npm run dev;
