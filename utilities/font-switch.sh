source ~/mac-zshrc/utilities/colors.sh

fontsw() {
    settings_file="$HOME/Library/Application Support/Code/User/settings.json"

    if grep -q '"editor.fontFamily": "JetBrainsMono-Bold"' "$settings_file"; then
        loading_bar 0.01 ${BLUE} "SWITCHING FONT":
        tput cuu1
        sed -i '' 's/"editor.fontFamily": "JetBrainsMono-Bold"/"editor.fontFamily": "JetBrains Mono"/' "$settings_file"
        echo -e "${INVERTED} ☡ FONT Changed to JetBrains Mono ${RESET}"
    else
        sed -i '' 's/"editor.fontFamily": "JetBrains Mono"/"editor.fontFamily": "JetBrainsMono-Bold"/' "$settings_file"
        loading_bar 0.01 ${MAGENTA} "SWITCHING FONT":
        tput cuu1
        echo -e "${MAGENTABG} ☡ FONT Changed to JetBrainsMono-Bold ${RESET}"
    fi
}