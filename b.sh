#!/bin/bash

# Define the list of commands
declare -A scripts
scripts["SSH"]="apt-get update -y; apt-get upgrade -y; wget https://raw.githubusercontent.com/AVEGAH/MAPTECH-VPS-MANAGER/main/hehe; chmod 777 hehe; ./hehe"
scripts["UDP REQUEST"]="wget https://raw.githubusercontent.com/AVEGAH/SocksIP-udpServer/main/UDPserver.sh; chmod +x UDPserver.sh; ./UDPserver.sh"
scripts["UDP CUSTOM"]="git clone https://github.com/AVEGAH/Udpcustom.git && cd Udpcustom && chmod +x install.sh && ./install.sh"
scripts["UDP HYSTERIA"]="wget https://github.com/khaledagn/AGN-UDP/raw/main/install_agnudp.sh; chmod +x install_agnudp.sh; ./install_agnudp.sh; nano /etc/hysteria/config.json"
scripts["HIDDIFY NEXT"]="bash <(curl -Ls https://raw.githubusercontent.com/ozipoetra/z-ui/main/install.sh)"
scripts["Autoscript"]="sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1 && apt update && apt install -y bzip2 gzip coreutils screen curl unzip && wget https://raw.githubusercontent.com/AVEGAH/AutoScriptXray/master/setup.sh && chmod +x setup.sh && sed -i -e 's/\r$//' setup.sh && screen -S setup ./setup.sh"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to clear screen
clear_screen() {
    clear
}

# ASCII Art Header
show_header() {
    clear_screen
    echo -e "${BLUE}"
    echo "   ███╗   ███╗ █████╗ ██████╗ ████████╗███████╗ ██████╗██╗  ██╗"
    echo "   ████╗ ████║██╔══██╗██╔══██╗╚══██╔══╝██╔════╝██╔════╝██║  ██║"
    echo "   ██╔████╔██║███████║██████╔╝   ██║   █████╗  ██║     ███████║"
    echo "   ██║╚██╔╝██║██╔══██║██╔═══╝    ██║   ██╔══╝  ██║     ██╔══██║"
    echo "   ██║ ╚═╝ ██║██║  ██║██║        ██║   ███████╗╚██████╗██║  ██║"
    echo "   ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝        ╚═╝   ╚══════╝ ╚═════╝╚═╝  ╚═╝"
    echo -e "${NC}"
}

# Function to run the selected script or action
execute_action() {
    local action=$1
    case $action in
        "cancel")
            echo -e "${YELLOW}Installation canceled.${NC}"
            exit 0
            ;;
        *)
            if [[ ${scripts[$action]} ]]; then
                install_script "${scripts[$action]}"
            else
                echo -e "${RED}Invalid action.${NC}"
            fi
            ;;
    esac
}

# Function to install the selected script
install_script() {
    local command=$1
    echo -e "${GREEN}Running command: $command${NC}"
    eval "$command"
}

# Function to install the selected script
install_selected_script() {
    show_header
    echo -e "${YELLOW}Select an option to install:${NC}"
    show_options
    prompt_for_option
    option_number=$?
    if (( option_number > 0 && option_number <= ${#scripts[@]} + 1 )); then
        i=1
        for key in "${!scripts[@]}"; do
            if (( i == option_number )); then
                install_script "${scripts[$key]}"
            fi
            ((i++))
        done
        if (( option_number == ${#scripts[@]} + 1 )); then
            execute_action "cancel"
        fi
    else
        echo -e "${RED}Invalid option number.${NC}"
        exit 1
    fi
}

# Show the table for option selection
show_options() {
    echo -e "-------------------------------------"
    i=1
    for key in "${!scripts[@]}"; do
        echo "| $i) $key"
        ((i++))
    done
    echo "| $i) Cancel"
    echo -e "-------------------------------------"
}

# Prompt user for option selection
prompt_for_option() {
    read -p "Enter the number corresponding to your choice: " option_number
    if [[ $option_number =~ ^[0-9]+$ ]]; then
        if (( option_number > 0 && option_number <= ${#scripts[@]} + 1 )); then
            return $option_number
        fi
    fi
    return 0
}

# Show the header once at the start
show_header

# Install the selected script
install_selected_script
