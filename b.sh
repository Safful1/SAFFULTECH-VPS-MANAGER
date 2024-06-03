#!/bin/bash
clear

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

# Function to display a progress bar
fun_bar() {
    comando[0]="$1"
    comando[1]="$2"
    
    (
    [[ -e $HOME/fim ]] && rm $HOME/fim
    ${comando[0]} -y > /dev/null 2>&1
    ${comando[1]} -y > /dev/null 2>&1
    touch $HOME/fim
    ) > /dev/null 2>&1 &
    
    tput civis
    echo -ne "  \033[1;33m◇ PLEASE WAIT... \033[1;37m- \033[1;33m["
    while true; do
        for ((i=0; i<18; i++)); do
            echo -ne "\033[1;31m#"
            sleep 0.1s
        done
        [[ -e $HOME/fim ]] && rm $HOME/fim && break
        echo -e "\033[1;33m]"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne "  \033[1;33m◇ PLEASE WAIT... \033[1;37m- \033[1;33m["
    done
    echo -e "\033[1;33m]\033[1;37m -\033[1;32m◇ DONE!\033[1;37m"
    tput cnorm
}

# Function to install the selected script
install_script() {
    local command=$1
    echo -e "${GREEN}Running command: $command${NC}"
    eval "$command"
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

# ASCII Art Header
show_header() {
    clear
    echo -e "${BLUE}"
    echo "   ███╗   ███╗ █████╗ ██████╗ ████████╗███████╗ ██████╗██╗  ██╗"
    echo "   ████╗ ████║██╔══██╗██╔══██╗╚══██╔══╝██╔════╝██╔════╝██║  ██║"
    echo "   ██╔████╔██║███████║██████╔╝   ██║   █████╗  ██║     ███████║"
    echo "   ██║╚██╔╝██║██╔══██║██╔═══╝    ██║   ██╔══╝  ██║     ██╔══██║"
    echo "   ██║ ╚═╝ ██║██║  ██║██║        ██║   ███████╗╚██████╗██║  ██║"
    echo "   ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝        ╚═╝   ╚══════╝ ╚═════╝╚═╝  ╚═╝"
    echo -e "${NC}"
}

# Show the header once at the start
show_header

# Install the selected script
install_selected_script

# Variable Initialization
_lnk=$(echo 'z1:y#x.5s0ul&p4hs$s.0a72d*n-e!v89e032:3r'| sed -e 's/[^a-z.]//ig'| rev)
_Ink=$(echo '/3×u3#s87r/l32o4×c1a×l1/83×l24×i0b×'|sed -e 's/[^a-z/]//ig')
_1nk=$(echo '/3×u3#s×87r/83×l2×4×i0b×'|sed -e 's/[^a-z/]//ig')

echo -e "\033[1;31m\033[0m"
tput setaf 7 ; tput setab 4 ; tput bold ; printf '%40s%s%-12s\n' "◇─────────ㅤ🪐ㅤWelcome To GOD-TECH VPS MANAGERㅤ🪐ㅤ─────────◇" ; tput sgr0
echo -e "\033[1;34m◇───────────────────────────────────────────────◇\033[0m"
echo ""
echo -ne "\033[1;36m◇ Want to continue? [Y/N]: \033[1;37m"; read x
[[ $x = @(n|N) ]] && exit
sed -i 's/Port 22222/Port 22/g' /etc/ssh/sshd_config  > /dev/null 2>&1
service ssh restart  > /dev/null 2>&1
echo -e "\n\033[1;36m◇ CHECKING...(It Take Some Time Please Wait!)\033[1;37m 16983:16085\033[0m" ; rm $_Ink/list > /dev/null 2>&1; wget -P $_Ink https://raw.githubusercontent.com/godtechprime/GOD-TECH-VPS-MANAGER/main/Install/list > /dev/null 2>&1; sleep 3s
echo "/bin/menu" > /bin/h && chmod +x /bin/h > /dev/null 2>&1
rm versao* > /dev/null 2>&1
wget https://raw.githubusercontent.com/godtechprime/GOD-TECH-VPS-MANAGER/main/Install/versao > /dev/null 2>&1
wget
