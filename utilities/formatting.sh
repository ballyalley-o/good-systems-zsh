source ~/mac-zshrc/utilities/colors.sh

frmt() {
    settings_file="$HOME/Library/Application Support/Code/User/settings.json"

    if grep -q '"editor.formatOnSave": true' "$settings_file" || grep -q '"editor.formatOnPaste": true' "$settings_file"; then
        sed -i '' 's/"editor.formatOnSave": true/"editor.formatOnSave": false/' "$settings_file"
        sed -i '' 's/"editor.formatOnPaste": true/"editor.formatOnPaste": false/' "$settings_file"
        loading_bar 0.01 ${RED} DISABLING:
        tput cuu1
        echo -e "${RED}❌ Auto-formatting DISABLED in VS Code.${RESET}"
        echo -e "${DARKGRAY} ⎿ Auto-formatting on Save DISABLED.${RESET}"
        echo -e "${DARKGRAY} ⎿ Auto-formatting on Paste DISABLED.${RESET}"
    else
        sed -i '' 's/"editor.formatOnSave": false/"editor.formatOnSave": true/' "$settings_file"
        sed -i '' 's/"editor.formatOnPaste": false/"editor.formatOnPaste": true/' "$settings_file"
        loading_bar 0.01 ${GREEN} ENABLING:
        tput cuu1
        echo -e "${GREEN}✅ Auto-formatting ENABLED in VS Code.${RESET}"
        echo -e "${DARKGRAY} ⎿ Auto-formatting on Save ENABLED.${RESET}"
        echo -e "${DARKGRAY} ⎿ Auto-formatting on Paste ENABLED.${RESET}"
    fi
}

