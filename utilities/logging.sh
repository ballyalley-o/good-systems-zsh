# Function: log
# Description: This function is used for logging and displaying messages with different styles and colors.
# Parameters:
#   - $1: The log type. It can be one of the following:
#       - ".": Used for general logging.
#       - "bg" or "bgood": Used for logging in the bgood workspace.
#       - "hp" or "hltd": Used for logging in the Howick Portal.
#   - $2: The project name or function name, depending on the log type.
#   - $3: The directory name. Default is "root".
#   - $4: The function name. Default is empty.
#   - $5: The loadbar title. Default is "Navigating:".
#   - $6: The text color. Default is "$BLUE".
#   - $7: The background color. Default is "$BLUEBG".
#   - $8: The work name. Default is the project name.
# Returns: None

source ~/mac-zshrc/utilities/colors.sh

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

            if [ "$dir" = Repositories ]; then
                color="$GREEN"
                colorbg="$INVERTED"
                repo_dir='.'
            fi

            if [ "$dir" = Client ]; then
                color="$BLUE"
                colorbg="$BLUEBG"
                repo_dir=hp_dev-new
            fi

            if [ "$dir" = ClientC ]; then
                color="$NEONGREENBG"
                colorbg="$INVERTED"
                repo_dir=howick-customer-portal/howick-customer-portal
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

            if [ "$dir" = "Repositories" ]; then
                tput cuu1
                echo -e "❖ ${colorbg} Welcome to Howick Portal ${RESET} 〉 ${DARKGRAY} ${dir} ${RESET}"
                cd $HOME/howick/hcs
                echo
                return 0
            fi

            if [ $dir = "Client" ] || [ $dir = "Server" ] || [ $dir = "ClientC" ]; then
                code .
                tput cuu1
                echo -e "❖ ${colorbg} Welcome to Howick Portal ${RESET} 〉 ${DARKGRAY} ${dir} ${RESET}"
                echo
                return 0
            fi

            echo -e "${color} 🚀 ${RESET}"
            ;;
        *)
            echo "Invalid log type"
            return 1
        ;;
    esac
}
