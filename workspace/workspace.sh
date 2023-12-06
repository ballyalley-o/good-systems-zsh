source ~/win-bashrc/mac-zshrc/utilities/logging.sh
source ~/win-bashrc/mac-zshrc/utilities/colors.sh
source ~/win-bashrc/mac-zshrc/utilities/functions.sh
source ~/win-bashrc/mac-zshrc/utilities/read-doc.sh -h

workspace_doc=$HOME/mac-zshrc/workspace/docs/workspace.help

workspace() {
    case "$1" in
        .|open)
            if [ -z "$2" ]; then
                read_doc $workspace_doc "NR>=18 && NR<=29"
                return 1
            fi

            folder_name=""
            open_utils_flag=""
            open_finder_flag=""
            open_project_flag=""
            open_zshrc_flag=""
            open_helper=""
            open_finder_helper=""
            open_project_helper=""
            open_zshrc_helper=""

            while [ "$#" -gt 0 ]; do
                case "$1" in
                    -o|--open-finder)
                        open_finder_flag=true
                        shift
                        open_finder_helper="open"
                        ;;
                    -u|--open-utils)
                        open_utils_flag=true
                        shift
                        open_helper="open"
                        ;;
                    -z|--open-zshrc)
                        open_zshrc_flag=true
                        shift
                        open_zshrc_helper="open"
                        ;;
                    -p|--open-project)
                        if [ -z "$2" ]; then
                            echo -e "${GREEN}Please provide a project folder with -p option${RESET}"
                            return 1
                        fi
                        open_project_flag=true
                        folder_name="$2"
                        log . Workspace "$folder_name"
                        work

                        if [ ! -d "$folder_name" ]; then
                            echo -e "${RED}${folder_name} folder doesn't exist${RESET}"
                            return 0
                        fi

                        shift 2
                        open_project_helper="open"
                        ;;
                    *)
                        shift
                        ;;
                esac
            done

            folder_path="~/workspace/$folder_name"

            if [ -n "$open_finder_helper" ]; then
                echo -e "${BLUE} Opening finder... ${RESET}"
                work && open .
            fi

            if [ -n "$open_zshrc_helper" ]; then
                cd $HOME/mac-zshrc
                log . .zshrc
                code .
                gitn
            fi

            if [ -n "$open_helper" ]; then
                cd $HOME/workspace/utils
                log . "Workspace Utils" "sandbox&snippets"
                code .
            fi

            if [ -n "$open_project_helper" ]; then
                if [ ! -d "$folder_name" ]; then
                    echo -e "${RED} ${folder_name} folder doesn't exist${RESET}"
                    return 1
                fi

                cd "$folder_name"
                gitn
            fi
            ;;

        c|create)
            if [ -z "$2" ]; then
                read_doc $workspace_doc "NR==12"
                return 1
            fi

            workspace_path=~/workspace
            new_folder_path="$workspace_path/$2"
            open_vscode_flag=""
            open_helper=""

            if [ -d "$new_folder_path" ]; then
                echo "Error: Folder '$2' already exists in the workspace."
                return 1
            fi

            mkdir "$new_folder_path"

            while [ "$#" -gt 0 ]; do
                case "$1" in
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

            if [ -n "$open_helper" ]; then
                code .
            fi
            ;;

        g|git)
            case "$2" in
                -c)
                    if [ -z "$3" ]; then
                        read_doc $workspace_doc "NR=13"
                        return 1
                    fi

                    git_repo_url="$3"
                    clones_folder=~/workspace/clones
                    new_folder_path="$clones_folder/$(basename $git_repo_url .git)"

                    if [ -d "$new_folder_path" ]; then
                        echo "Error: Repository '$git_repo_url' already cloned in the 'clones' folder."
                        return 1
                    fi

                    mkdir "$new_folder_path"
                    git clone "$git_repo_url"
                    ;;

                *)
                    if [ -z "$2" ] || [ -z "$3" ]; then
                        echo "Usage: workspace git <repo_url> <folder_name>"
                        return 1
                    fi

                    git_repo_url="$2"
                    folder_name="$3"
                    workspace_path=~/workspace
                    new_folder_path="$workspace_path/$folder_name"

                    if [ -d "$new_folder_path" ]; then
                        echo "Error: Folder '$folder_name' already exists in the workspace."
                        return 1
                    fi

                    mkdir "$new_folder_path"
                    git clone "$git_repo_url" .
                    ;;
            esac
            ;;

        i|invoice)
            if [ -z "$1" ]; then
                echo "Usage: workspace invoice"
                echo -e "${DARKGRAY}workspace${RESET} invoice           Navigates to workspace/IOD_personal and Open IOD Invoice document"
                return 1
            fi

            cd "$HOME/workspace/IOD personal/2023-10-10-se-pt-nz-rem"
            log . Navigating: "IOD Invoice" "$BLUE" template-iod-invoice.pages
            open template-iod-invoice.pages
            ;;
        *)
            read_doc $workspace_doc "NR<=16"
            ;;
    esac
}
