# Function: iods
# Description: This function is used to perform various operations related to the IOD (Introduction to Open Development) project.
# Parameters:
#   - $1: The operation to perform. Possible values: "go", "l", "labs".
#   - $2: (Optional) The student name.
#   - $3: (Optional) The module number.
#   - $4: (Optional) The student repository.
# Usage: iods <operation> [<student_name> [<module_number> [<student_repository>]]]
iods() {
    # Function logic...
}
source ~/mac-zshrc/utilities/colors.sh
source ~/mac-zshrc/utilities/logging.sh
source ~/mac-zshrc/utilities/functions.sh

iods() {
    case "$1" in
        go)
            if [ -z "$2" ] || [ -z "$3" ]; then
                read_doc $doc "NR>=125 && NR<=134"
                return 1
            fi

            student_name="$2"
            module_number="$3"
            lab_folder="$HOME/iod/students/$student_name/Laboratory Exercises/Module $module_number"

            if [ "$module_number" = "-c" ]; then
                loading_bar 0.02
                echo -e "${YELLOWBG} Heading to the Capstone folder ${RESET}"

                capstone_folder="$HOME/iod/students/$student_name/Capstone"
                if [ ! -d "$capstone_folder" ]; then
                    echo "Capstone folder not found"
                    cd "$HOME/iod/students/$student_name"

                    echo "Creating Capstone folder"
                    loading_bar 0.04
                    mkdir Capstone
                    echo -e "${BLUE} Capstone folder Created ${RESET}"
                    log . "IOD main" Capstone
                    code .
                    return 0
                else
                    cd "$capstone_folder"
                    code .
                    return 0
                fi
            fi

            attempts_module=0
            while [ "$attempts_module" -lt 3 ]; do
                    if [ -d "$lab_folder" ]; then
                        loading_bar 0.03
                        tput cuu1
                        echo -e "${GREEN} MODULE FOUND. loading options ${RESET} "
                        cd "$lab_folder" || { echo -e "${RED}Failed to cd to $lab_folder${RESET}"; return 1; }

                        echo -e "${BLUEBG} Contents of the module folder: ${RESET}"
                        PS3="▶︎ ${PS3BLUE}Select a subfolder (or press Enter to continue):${PS3RESET}"

                        dir=""
                        subfolders=($(find . -maxdepth 1 -type d -exec basename {} \;))
                        num_subfolders=${#subfolders[@]}

                        select subfolder_input in "${subfolders[@]}"; do
                            if [ -z "$subfolder_input" ]; then
                                break
                            fi

                            selected_subfolder="./$subfolder_input"


                            if [ -d "$selected_subfolder" ]; then
                                cd "$selected_subfolder" || { echo -e "${RED}Failed to cd to $selected_subfolder${RESET}"; return 1; }
                                dir="$student_name $selected_subfolder"
                                log . "IOD main" $dir
                                code .
                                return 0
                            else
                                echo -e "${RED}Invalid selection. Please try again.${RESET}"
                            fi
                        done

                        echo -e "${YELLOWBG} No subfolder specified. Opening VS Code in the current folder ${RESET}"

                        log . "IOD main" $dir

                        code .
                        return 0
                    else
                        echo -e "${RED} lab folder not found for student: $student_name, module: $module_number ${RESET}"
                        if [ "$attempts_module" -eq 2 ]; then
                            echo -e "${RED} ⚠️ Too many invalid attempts. Performing ls instead. ${RESET}"
                            ls "$HOME/iod/students/$student_name/Laboratory Exercises/"
                            return 1
                        else
                            echo -n -e "  ▶︎ ${BLUEBG} Enter the correct module number: ${RESET}"
                            read module_number
                            lab_folder="$HOME/iod/students/$student_name/Laboratory Exercises/Module $module_number"
                            ((attempts_module++))
                        fi
                    fi
            done
            echo -e "${RED} ⚠️ Too many invalid attempts for student name. Returning to home directory. ${RESET}"
            cd ~
            return 1
            ;;
        l|labs)
            if [ -z "$2" ];  then
                read_doc $doc "NR>=113 && NR<=123"
                return 1
            fi

            student_name="$2"
            module_number="$3"
            student_repo="$4"
            lab_folder="$HOME/iod/students/$student_name/Laboratory Exercises/Module $module_number"
            repo_folder="$lab_folder/$(basename $student_repo .git)"

            cd "$lab_folder" || { echo -e "${RED}Failed to cd to $lab_folder${RESET}"; return 1; }

            folder_flag=""
            folder_name=""
            open_vscode_flag=""
            open_helper=""

            while [ "$#" -gt 0 ]; do
                case "$1" in
                    -f|--folder)
                        folder_flag=true
                        shift
                        folder_name="$1"
                        ;;
                    -o|--open-vscode)
                        open_vscode_flag=true
                        shift
                        open_helper="open"
                        ;;
                    *)
                        shift
                        ;;
                esac
            done

            if [ -n "$folder_name" ]; then
                mkdir "$folder_name"
                repo_folder="$lab_folder/$folder_name/$repo_folder"
            fi

            git clone "$student_repo" || { echo -e "${RED}Failed to clone repository${RESET}"; return 1 ; }

            if [ -n "$open_helper" ]; then
                code .
            fi
            ;;
        *)
            read_doc $doc "NR>=97 && NR<=111"
            return 1
            ;;
    esac
}
