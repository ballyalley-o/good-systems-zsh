source ~/mac-zshrc/utilities/aliases.sh
source ~/mac-zshrc/utilities/colors.sh
source ~/mac-zshrc/utilities/functions.sh
source ~/mac-zshrc/utilities/read-doc.sh -h

# command documentation
htld_doc=$HOME/mac-zshrc/howick/hltd.help

hltd() {
    case "$1" in
	    this)
	    howick && cd ~/howick/hcs/howick-admin-portal
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
            case "$2" in
                -a | -admin)
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
                -c| -customer)
                    log hltd ClientC
                    gitn
                    code .
                    echo
                    echo -n -e "${BLUE} Start the Client? (yes/no):${RESET}\c"
                    read start_client
                    if [ "$start_client" = "yes" ] || [ "$start_client" = "y" ] || [ "$start_client" = "YES" ] || [ "$start_client" = "Y" ]; then
                        echo -e "${BLUE} Starting the client...${RESET}"
                        npm run dev
                    else
                        echo -e "${YELLOWBG} Client not started.${RESET}"
                    fi
                    ;;
                *)
                log hltd Repositories
                cd ~/howick/hcs
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
                    gitn
                    ls
                    code .

                fi
                ;;
            esac


            # if [ -z "$2" ]; then
            #     echo "log hltd client"
            #     echo
            #     echo "Usage:"
            #     echo "  Logging formatted for howick portal "
            #     return 1
            # fi
            # log hltd Client
            # gitn
            # echo
            # echo -n -e "${BLUE} Start the Client? (yes/no):${RESET}\c"
            # read start_client
            # if [ "$start_client" = "yes" ] || [ "$start_client" = "y" ]; then
            #     echo -e "${BLUE} Starting the client...${RESET}"
            #     npm start
            # else
            #     echo -e "${YELLOWBG} Client not started.${RESET}"
            # fi
            ;;
        server)
            log hp Server
            gitn
            echo
            echo -n -e "${ORANGE} Start the Server? (yes/no): ${RESET} \n"
            echo -n -e "${BLUE} ➜ ${RESET}\c"
            counter=30
            trap 'kill $bg_pid 2>/dev/null; exit' SIGINT
            (
                while [ $counter -gt 0 ]; do
                    echo -e "${DARKGRAY} Starting server in $counter seconds... ${RESET}"
                    sleep 1
                    counter=$((counter-1))
                done
                echo -e "${ORANGE} No response received. Starting the server...${RESET}"
                echo -e "${YELLOWBG} Server not started.${RESET}"
            ) &

            bg_pid=$!

            read -t $((counter+1)) start_server

            if [ "$start_server" = "yes" ] || [ "$start_server" = "y" ]; then
                kill $bg_pid 2>/dev/null
                echo -e "${ORANGE} Starting the server...${RESET}"
                npm start
            elif [ -z "$start_server" ]; then
                wait $bg_pid
            else
                kill $bg_pid 2>/dev/null
                echo -e "${YELLOWBG} Server not started.${RESET}"
            fi
            # if [ "$start_server" = "yes" ] || [ "$start_server" = "y" ]; then
            #     echo -e "${ORANGE} Starting the server...${RESET}"
            #     npm start
            # else
            #     echo -e "${YELLOWBG} Server not started.${RESET}"
            # fi
            ;;
        logo)
            log . "Howick Branding" Logos

            echo

            cd ~/howick/branding/Logos
            open .
            ;;
        branding)
            log . "Howick Branding" "Branding Guidelines"

            echo

            cd ~/howick/branding
            open Howick-Brand_Guidelines_2020.pdf
            ;;
        hmi)
            log . "Howick HLCv3" "Generation 5"

            echo

            cd ~/howick/hmi/gen5/hlc
            code .
            ;;
        *)
        read_doc $htld_doc
        ;;
    esac
}
