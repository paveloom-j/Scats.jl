#!/bin/bash

# A script to install plots dependencies

# Set auxiliary variables
# for ANSI escape codes
cyan="\e[1;36m" # Bold cyan
reset="\e[0m"   # Reset colors

echo -e "\n${cyan}Loading cache...${reset}\n"

exist() {
     [ -e "$1" ]
}

if exist ~/apt-get-packages/*.deb; then
     sudo mv ~/apt-get-packages/*.deb /var/cache/apt/archives/
     ls /var/cache/apt/archives
fi

echo -e "\n${cyan}Installing python3...${reset}\n"
sudo apt-get install python3-dev

echo -e "\n${cyan}Installing pip3...${reset}\n"
sudo apt-get install python3-pip

echo -e "\n${cyan}Upgrading pip3...${reset}\n"
python3 -m pip install --upgrade pip

echo -e "\n${cyan}Installing dvipng...${reset}\n"
sudo apt-get install dvipng

echo -e "\n${cyan}Installing matplotlib...${reset}\n"
pip3 install matplotlib

echo -e "\n${cyan}Installing texlive-latex-extra...${reset}\n"
sudo apt-get install texlive-latex-extra

echo -e "\n${cyan}Installing cm-super...${reset}\n"
sudo apt-get install cm-super

echo -e "\n${cyan}Updating cache...${reset}"
cp /var/cache/apt/archives/*deb ~/apt-get-packages