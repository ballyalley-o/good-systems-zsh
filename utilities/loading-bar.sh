source ~/mac-zshrc/utilities/colors.sh

# loading_bar
# Usage: loading_bar <duration: 0.2> <color: YELLOW> <message: Searching:>
# This function displays a loading bar animation on the terminal.
# Parameters:
#   - duration: The duration between each animation frame in seconds. Default is 0.2 seconds.
#   - color: The color of the loading bar. Default is YELLOW.
#   - message: The message to display before the loading bar. Default is "Searching:".
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