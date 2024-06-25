source ~/win-bashrc/mac-zshrc/utilities/aliases.sh
source ~/win-bashrc/mac-zshrc/utilities/colors.sh
source ~/win-bashrc/mac-zshrc/utilities/functions.sh
source ~/win-bashrc/mac-zshrc/howick/gen5.sh
source ~/win-bashrc/mac-zshrc/utilities/read-doc.sh -h


# command documentation
htld_doc=$HOME/win-bashrc/mac-zshrc/howick/hltd.help

USER_NAME=$(whoami)

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
                cd ~/howick/sync/sync-machine && code .
            ;;
            -s|-start)
                cd ~/howick/sync/sync-machine && start .
                gitn
            ;;
            -i|-ini)
                cd ~/desktop/sync-machine/data && start Howick.ini
                echo -e "${MAGENTABG} 🤡 Mock ini Opened ${RESET}"
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
                p|profile)
                gen5 -p
                ;;
                ini)
                gen5 main -i
                ;;
                config)
                gen5 config
                ;;
                logis)
                gen5 logis
                ;;
                rondo)
                gen5 rondo
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

                license)
                    echo -e "${BLUE} Loading Howick HMI Licensing Documentation, Please wait... .${RESET}"
                    start "https://howick.sharepoint.com/:w:/s/SoftwareDevelopmentTeam/EVLmusoWGxxJgZbTmk3FgicB45GtJ86k6r9U3knIltqHNg?e=HsxSFq"
                    ;;

                ini-doc)
                    echo -e "${DARKGRAY} Loading Howick Ini Configuration Documentation V8 (2023), Please wait... .${RESET}"
                    start "https://howick.sharepoint.com/:w:/s/SoftwareDevelopmentTeam/ERxj06ocIilEvJXCWKBPnXkBzPLpzhQaJgzTnmYYjxLt6Q?e=FifTl1"

                    # copy the file path to clipboard
                    echo "N:\Electrical and Control System\Archive Files and Programs\Technicians Manuals and Onsite Files\Howick Ini file configuration V8.docx" | clip
                    ;;
                mb)
                    echo -e "${NEONGREEN} Loading Howick HMI Modbus Addr Mapping Spreadsheet, Please wait... .${RESET}"
                    start "https://howick.sharepoint.com/:x:/s/SoftwareDevelopmentTeam/ESSgCfaf5nBLrYtoXMmKIzEBSCcjsgOwRzfyATV_d7XPQQ?e=8IuvKl"
                    ;;
                faults)
                    echo -e "${BLUE} Loading Fault Table, Please wait... .${RESET}"
                    start "https://howick.sharepoint.com/:w:/s/SoftwareDevelopmentTeam/EStYmIgPyPZCs_cwAufZmD4BrbP1FMHZSMxuSl32ToDgPQ?e=4WOahi&nav=eyJoIjoiMTgzNDkxOTY1NyJ9"
                    ;;
                *)
                    echo "Usage: hltd gen5 [ main | profile | logis | repos  [-1 | -2] | soft | license | mb | faults ]"
                    return 1
                    ;;
                esac
                ;;

        support)
            case "$2" in
                .)
                cd "$HOME/Howick/Support" && start .

                echo -e "${GREEN} 🚀 Howick Support started ${RESET}"
                ;;

                -bcs)
                cd "$HOME/Howick/Support/Software/bcs" && start .

                echo -e "${GREEN} 🚀 BCS Installation Tools started ${RESET}"
                ;;

                -csv)
                cd "$HOME/Howick/Support/CSV_collection" && start .

                echo -e "${GREEN} 🚀 CSV Collection started ${RESET}"
                ;;

                *)
                echo "Usage: hltd support [ . | -bcs | -csv]"
                return 1
                ;;
            esac
            ;;
        *)
        read_doc $htld_doc
        ;;
    esac
}
