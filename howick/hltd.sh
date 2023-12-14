source ~/mac-zshrc/utilities/aliases.sh
source ~/mac-zshrc/utilities/colors.sh
source ~/mac-zshrc/utilities/functions.sh
source ~/mac-zshrc/utilities/read-doc.sh -h

# command documentation
htld_doc=$HOME/mac-zshrc/howick/hltd.help

hltd() {
    case "$1" in
	    this)
	    howick && cd ~/howick/hcs/hp_dev-new
	    ;;
        repo)
            log hltd Repositories
            gitn
            echo
            echo -n -e "${BLUE} Select a folder: ${RESET}\c"
            read repo_name
            if [ -z "$repo_name" ]; then
               break
            else
                echo -e "${YELLOWBG} Launching ${repo_name} 🚀${RESET}"
                tput cuu1
                echo -e "${YELLOWBG} Launching ${repo_name}  🚀${RESET}"
                tput cuu1
                echo -e "${YELLOWBG} Launching ${repo_name}   🚀${RESET}"
                cd $repo_name
                code .
            fi
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
        read_doc $htld_doc
        ;;
    esac
}
