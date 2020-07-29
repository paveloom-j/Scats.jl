#!/bin/bash

# A script to install plots dependencies

# Set auxiliary variables
# for ANSI escape codes
cyan="\e[1;36m" # Bold cyan
reset="\e[0m"   # Reset colors

echo -e "\n${cyan}Installing dvipng...${reset}\n"
sudo apt-get install dvipng

echo -e "\n${cyan}Installing matplotlib...${reset}\n"
pip3 install matplotlib

echo -e "\n${cyan}Installing texlive-latex-extra...${reset}\n"
sudo apt-get install texlive-latex-extra

echo -e "\n${cyan}Installing cm-super...${reset}\n"
sudo apt-get install cm-super