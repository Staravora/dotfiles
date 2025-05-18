#!/bin/bash

# Cyberpunk i3wm Setup Installation Script
# Description: Installs a complete cyberpunk-themed i3wm environment on Debian/Ubuntu or Arch-based systems

# Set colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${RED}
 ██████╗██╗   ██╗██████╗ ███████╗██████╗ ██████╗ ██╗   ██╗███╗   ██╗██╗  ██╗
██╔════╝╚██╗ ██╔╝██╔══██╗██╔════╝██╔══██╗██╔══██╗██║   ██║████╗  ██║██║ ██╔╝
██║      ╚████╔╝ ██████╔╝█████╗  ██████╔╝██████╔╝██║   ██║██╔██╗ ██║█████╔╝ 
██║       ╚██╔╝  ██╔══██╗██╔══╝  ██╔══██╗██╔═══╝ ██║   ██║██║╚██╗██║██╔═██╗ 
╚██████╗   ██║   ██████╔╝███████╗██║  ██║██║     ╚██████╔╝██║ ╚████║██║  ██╗
 ╚═════╝   ╚═╝   ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝
                                                                            
██╗██████╗ ██╗    ██╗███╗   ███╗    ███████╗███████╗████████╗██╗   ██╗██████╗ 
██║╚════██╗██║    ██║████╗ ████║    ██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗
██║ █████╔╝██║ █╗ ██║██╔████╔██║    ███████╗█████╗     ██║   ██║   ██║██████╔╝
██║ ╚═══██╗██║███╗██║██║╚██╔╝██║    ╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝ 
██║██████╔╝╚███╔███╔╝██║ ╚═╝ ██║    ███████║███████╗   ██║   ╚██████╔╝██║     
╚═╝╚═════╝  ╚══╝╚══╝ ╚═╝     ╚═╝    ╚══════╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝     
${NC}"

echo -e "${YELLOW}This script will install a complete cyberpunk-themed i3wm environment.${NC}"
read -p "Do you want to continue? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

# Detect distribution type
if [ -f /etc/debian_version ]; then
    DISTRO="debian"
    echo -e "${GREEN}Detected Debian/Ubuntu-based distribution${NC}"
elif [ -f /etc/arch-release ]; then
    DISTRO="arch"
    echo -e "${GREEN}Detected Arch-based distribution${NC}"
else
    echo -e "${YELLOW}Could not determine distribution type. Assuming Debian/Ubuntu.${NC}"
    DISTRO="debian"
fi

# Create backup directory
mkdir -p ~/.config-backup
BACKUP_DATE=$(date +%Y%m%d-%H%M%S)

# Function to backup existing configs
backup_config() {
    if [ -d "$1" ] || [ -f "$1" ]; then
        echo -e "${YELLOW}Backing up $1 to ~/.config-backup/$2-$BACKUP_DATE${NC}"
        cp -r "
