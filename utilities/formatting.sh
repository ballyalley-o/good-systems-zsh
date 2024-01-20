# Function to toggle auto-formatting settings in VS Code.
# This function checks the user's VS Code settings file and toggles the "editor.formatOnSave" and "editor.formatOnPaste" properties.
# If either of these properties is set to true, it will be changed to false, and vice versa.
# After toggling the settings, it displays a loading bar and prints the status of auto-formatting.
# If auto-formatting is disabled, it will display a red message indicating that auto-formatting is disabled on save and paste.
# If auto-formatting is enabled, it will display a green message indicating that auto-formatting is enabled on save and paste.
# This function depends on the "loading_bar" and "colors.sh" scripts.
frmt() {
    settings_file="$HOME/Library/Application Support/Code/User/settings.json"

    if grep -q '"editor.formatOnSave": true' "$settings_file" || grep -q '"editor.formatOnPaste": true' "$settings_file"; then
        sed -i '' 's/"editor.formatOnSave": true/"editor.formatOnSave": false/' "$settings_file"
        sed -i '' 's/"editor.formatOnPaste": true/"editor.formatOnPaste": false/' "$settings_file"
        loading_bar 0.01 ${RED} DISABLING:
        tput cuu1
        echo -e "${RED} 𝐱 Auto-formatting DISABLED in VS Code.${RESET}"
        echo -e "${DARKGRAY} ⎿ Auto-formatting on Save DISABLED.${RESET}"
        echo -e "${DARKGRAY} ⎿ Auto-formatting on Paste DISABLED.${RESET}"
    else
        sed -i '' 's/"editor.formatOnSave": false/"editor.formatOnSave": true/' "$settings_file"
        sed -i '' 's/"editor.formatOnPaste": false/"editor.formatOnPaste": true/' "$settings_file"
        loading_bar 0.01 ${GREEN} ENABLING:
        tput cuu1
        echo -e "${GREEN} ✔ Auto-formatting ENABLED in VS Code.${RESET}"
        echo -e "${DARKGRAY} ⎿ Auto-formatting on Save ENABLED.${RESET}"
        echo -e "${DARKGRAY} ⎿ Auto-formatting on Paste ENABLED.${RESET}"
    fi
}
