source ~/win-bashrc/mac-zshrc/utilities/aliases.sh
source ~/win-bashrc/mac-zshrc/utilities/colors.sh
source ~/win-bashrc/mac-zshrc/utilities/functions.sh
source ~/win-bashrc/mac-zshrc/utilities/read-doc.sh -h

# command documentation
htld_doc=$HOME/mac-zshrc/howick/hltd.help

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
	    sync)
            case $2 in
            -c|-code)
                cd ~/desktop/sync-machine/howick-sync-machine && code .
            ;;
            -s|-start)
                cd ~/desktop/sync-machine/howick-sync-machine && start .
                gitn
            ;;
            *)
                echo "Usage: hltd sync [-c | -code | -s | -start]"
                return 1
                ;;
            esac
            ;;
        gen5)
            case "$2" in
                main)
                gen5 main
                ;;
                logis)
                gen5 logis
                ;;
                repos)
                    case "$2" in
                                -1)
                                gen5 repos -1
                                ;;
                                -2)
                                gen5 repos -2
                                ;;
                                *)
                                echo "Usage: gen5 repos [-1 | -2]"
                                return 1
                                ;;
                            esac
                            ;;
                soft)
                    cd "~/Documents/Support/Software/HowickHLCv3-SoftRelease"
                    ;;
                *)
                    echo "Usage: hltd gen5 [main | logis | repos] [-1 | -2]"
                    return 1
                    ;;
                esac
                ;;
        *)
        read_doc $htld_doc
        ;;
    esac
}
