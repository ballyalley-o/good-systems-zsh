source ~/win-bashrc/mac-zshrc/utilities/colors.sh

# loading bar
# Usage: loading_bar <duration: 0.2> <color: YELLOW> <message: Searching:>
loading_bar() {
    local width=20
    local duration=${1:-0.2}
    local i

    color=${2:-"$YELLOW"}
    msg=${3:-Searching:}

    echo -n -e "$msg"

    while true; do
        sleep "$duration"
        echo -n -e "${color}█${RESET}"
        ((width--))

        if [ "$width" -eq 0 ]; then
            break
        fi
    done

    tput cuu1

    echo
    echo "Loading complete                      "
}