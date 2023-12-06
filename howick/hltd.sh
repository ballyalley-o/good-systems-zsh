source ~/win-bashrc/mac-zshrc/utilities/aliases.sh
source ~/win-bashrc/mac-zshrc/utilities/colors.sh
source ~/win-bashrc/mac-zshrc/utilities/functions.sh
source ~/win-bashrc/mac-zshrc/howick/gen5.sh
source ~/win-bashrc/mac-zshrc/utilities/read-doc.sh -h

# command documentation
htld_doc=$HOME/win-bashrc/mac-zshrc/howick/hltd.help

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
            -i|-ini)
                cd ~/desktop/sync-machine/howick-sync-machine/data && start Howick.ini
                echo -e "${MAGENTABG} 🤡 Mock ini Opened ${RESET}"

            # TODO: add a command that adds a profile

                #!/bin/bash

                # ini_file="example.ini"
                # search_key="key2"
                # new_key="key5"
                # new_value="new_value5"

                # awk -v search_key="$search_key" -v new_key="$new_key" -v new_value="$new_value" '
                # BEGIN {
                #     FS=" *= *"        # Set the field separator to handle spaces around the equal sign
                #     OFS=" = "         # Set the output field separator
                #     section_found=0   # Flag to track if the section has been found
                # }
                # {
                #     if ($0 ~ /^\[/) {   # Check if the line starts with '[' indicating a section
                #         section_found=0
                #     }
                #     if (section_found && $1 == search_key) {
                #         print $0           # Print the original line
                #         print new_key, new_value   # Append the new key-value pair
                #         section_found=0     # Reset the flag as we have processed the section
                #     } else {
                #         print $0           # Print the original line
                #     }
                # }
                # $1 == "[" section_name "]" {
                #     section_found=1   # Set the flag when the desired section is found
                # }
                # ' "$ini_file" > temp_ini && mv temp_ini "$ini_file"

            ;;
            *)
                echo "Usage: hltd sync [ -c | -code | -s | -start | -i | -ini ]"
                return 1
                ;;
            esac
            ;;
        gen5)
            case "$2" in
                main)
                gen5 main .
                ;;
                ini)
                gen5 main -i
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
                    echo "Usage: hltd gen5 [ main | logis | repos | soft ] [-1 | -2]"
                    return 1
                    ;;
                esac
                ;;
        *)
        read_doc $htld_doc
        ;;
    esac
}
