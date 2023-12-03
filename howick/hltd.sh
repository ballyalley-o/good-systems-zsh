source ~/mac-zshrc/utilities/aliases.sh
source ~/mac-zshrc/utilities/colors.sh
source ~/mac-zshrc/utilities/functions.sh

hltd() {
    case "$1" in
	    this)
	    howick && cd ~/howick/hcs/hp_dev-new
	    ;;
        client)
            log hltd Client
            gitn
            echo
            echo -n -e "${BLUE} Start the Client? (yes/no):${RESET}\c"
            read start_client
            if [ "$start_client" = "yes" ] || [ "$start_client" = "y" ]; then
                echo -e "${BLUE} Starting the client...${RESET}"
                npm start
            else
                echo -e "${YELLOWBG} Client not started.${RESET}"
            fi
            ;;
        server)
            log hp Server
            gitn
            echo
            echo -n -e "${ORANGE} Start the Server? (yes/no):${RESET}\c"
            read start_server
            if [ "$start_server" = "yes" ] || [ "$start_server" = "y" ]; then
                echo -e "${ORANGE} Starting the server...${RESET}"
                npm start
            else
                echo -e "${YELLOWBG} Server not started.${RESET}"
            fi
            ;;
        *)
        echo "Usage: hltd [ this | client | server ]"
	    echo
	    echo "${DARKGRAY}hltd${RESET} this     Navigate to the howick portal UI local"
	    echo "${DARKGRAY}hltd${RESET} client   Navigate to the howick portal UI local and open VS Code (optional: start client)"
	    echo "${DARKGRAY}hltd${RESET} server   Navigate to the howick portal SERVER local and open VS Code (optional: start server)"
        ;;
    esac
}
