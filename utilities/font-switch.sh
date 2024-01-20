# Function to switch the font in Visual Studio Code settings
# Arguments: None
# Returns: None
fontsw() {
    settings_file="$HOME/Library/Application Support/Code/User/settings.json"

    # Check if the current font is JetBrainsMono-Bold
    if grep -q '"editor.fontFamily": "JetBrainsMono-Bold"' "$settings_file"; then
        loading_bar 0.01 ${BLUE} "SWITCHING FONT":
        tput cuu1
        # Replace the font with JetBrains Mono
        sed -i '' 's/"editor.fontFamily": "JetBrainsMono-Bold"/"editor.fontFamily": "JetBrains Mono"/' "$settings_file"
        echo -e "${INVERTED} ☡ FONT Changed to JetBrains Mono ${RESET}"
    else
        # Replace the font with JetBrainsMono-Bold
        sed -i '' 's/"editor.fontFamily": "JetBrains Mono"/"editor.fontFamily": "JetBrainsMono-Bold"/' "$settings_file"
        loading_bar 0.01 ${MAGENTA} "SWITCHING FONT":
        tput cuu1
        echo -e "${MAGENTABG} ☡ FONT Changed to JetBrainsMono-Bold ${RESET}"
    fi
}