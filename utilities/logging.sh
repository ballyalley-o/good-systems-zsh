source ~/win-bashrc/mac-zshrc/utilities/colors.sh

# logging
log() {
    case "$1" in
        .)
            local project_name="$2"
            local dir=${3:-root}
            local func1=${4:-""}
            local loadbar_title=${5:-Navigating:}
            local color=${6:-"$BLUE"}
            local colorbg=${7:-"$BLUEBG"}
            local work_name=${8:-"$project_name"}

            if [ "$project_name" = Workspace ]; then
                func1=""
                color="$MAGENTA"
                colorbg="$MAGENTABG"
                work_name=Workspace
                loadbar_title=Navigating:
            fi

            if [ "$project_name" = .zshrc ]; then
                dir=.zshrc
                color="$MAGENTA"
                colorbg="$MAGENTABG"
                work_name="Workspace shell config"
            fi

            echo -e "${color} Opening... ${RESET}"
            tput cuu1
            loading_bar 0.01 ${color} "$loadbar_title"
            tput cuu1
            echo -e "${color}🔍 googling.. ${RESET}"
            tput cuu1
            echo -e "${color} 🔍googling... ${RESET}"
            tput cuu1
            echo -e "${color} Launching "$project_name" ${RESET}"
            tput cuu1
            echo -e "❖ ${colorbg} ${work_name} ${RESET} 〉${DARKGRAY} ${dir} ${RESET}"
            echo
            ;;
        bg|bgood)
            if [ -z "$2" ]; then
                echo "log bgood <function>"
                echo
                echo "Usage:"
                echo "  Logging formatted for bgood workspace"
                return 1
            fi

            local work_function="$2"

            loading_bar 0.01 ${BLUE} Navigating
            tput cuu1
            echo -e "${MAGENTA} Opening Workspace ${RESET}"
            tput cuu1
            "$work_function"
            echo
            tput cuu1
            echo -e "❖ ${BLUEBG} Workspace ${RESET} 〉${DARKGRAY} root ${RESET}"
            echo
            ;;
        hp|hltd)
            if [ -z "$2" ]; then
                echo "log hltd <repo>"
                echo
                echo "Usage:"
                echo "  Logging formatted for howick portal "
                return 1
            fi

            local dir="$2"
            local repo_dir="$3"

            # color
            local color=""
            local olorbg=""

            if [ "$dir" = Client ]; then
                color="$BLUE"
                colorbg="$BLUEBG"
                repo_dir=hp_dev-new
            fi

            if [ "$dir" = Server ]; then
                color="$ORANGE"
                colorbg="$ORANGEBG"
                repo_dir=hp_server
            fi

            loading_bar 0.01 ${color} Navigating:
            howick
            tput cuu1
            echo -e "${color} Opening ${dir} in VS Code ${RESET}"
            cd $HOME/howick/hcs/"$repo_dir"
            tput cuu1
            echo -e "${color} Launching Howick Portal ${RESET}"
            code .
            tput cuu1
            echo -e "❖ ${colorbg} Welcome to Howick Portal ${RESET} 〉 ${DARKGRAY} ${dir} ${RESET}"
            echo
            ;;
        *)
            echo "Invalid log type"
            return 1
        ;;
    esac
}
