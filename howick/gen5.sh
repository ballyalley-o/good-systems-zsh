source ~/win-bashrc/mac-zshrc/utilities/colors.sh
source ~/win-bashrc/mac-zshrc/utilities/loading-bar.sh

ini_path=$HOME/AppData/Roaming/HowickHLCv3
ini_file=Howick.ini
ini_abs_path=$HOME/AppData/Roaming/HowickHLCv3/Howick.ini

gen5() {
     case "$1" in
	 main)
		case "$2" in

	       	.)
		 		cd ~/Documents/HOWICK-repos/hmi-gen-5-official/HLCv3 && code .
				;;
			-i)
				cd $ini_path && start $ini_file && cat $ini_file | awk "NR==3"
				echo -e "${INVERTED} $ini_file from $ini_path Opened ${RESET}"
				;;
	       *)
				echo "Usage: gen5 main [ . | -i ]"
				echo
				echo "gen5 main . 		Navigate to the howick gen5 main local and open VS Code"
				echo "gen5 main -i		Navigate to the HowickHLCv3 & Open the machine configuration (ini)"
				return 1
				;;
            esac
	     ;;
	 logis)
	    cd ~/Documents/HOWICK-repos/finish_profiles/HLCv3 && code  .
	    ;;
	config)
		cd $ini_path && start .
		;;
	 repos)
	    case "$2" in
	       -1)
		 		cd ~/Documents/HOWICK-repos
				;;
	       -2)
				cd ~/Documents/HOWICK-repos && start .
				;;
	       *)
		echo "Usage: gen5 repos [-1 | -2]"
		echo
		echo "gen5 repos -1 	Open the terminal in howick local repositories"
		echo "gen5 repos -2		Open the terminal in howick local repositories and Show the folder"
		return 1
		;;
            esac
	    ;;
		-p|-profile)
			ini_file=$ini_abs_path
			echo "ini_file: $ini_file"
			prefix="Profile_"

			# TODO: Duplicate check

			last_profile_line_number=$(awk -F= -v prefix="$prefix" '
				/^\['"$prefix"'/ {
					gsub(/[^0-9]/, "", $1)
					profile_number = $1
					if (profile_number > max) max = profile_number
				}
				END {
					print max
				}
			' "$ini_file")


			if [ -z "$last_profile_line_number" ]; then
				last_profile_line_number=0
			fi

			new_profile_key="${prefix}$(($last_profile_line_number + 1))"

			read -p "FLANGE: " flange_size
			read -p "WEB: " web_size

			size="${flange_size}X${web_size}"

			temp_file=$(mktemp)

			echo -e "[${new_profile_key}]\nSize=${size}\n" > "$temp_file"

			sed -i "/^\[LLCSocketData\]/ {e cat $temp_file
			}" "$ini_file"

			trap 'rm -f "$temp_file"' EXIT

			echo
			loading_bar 0.005 ${YELLOW} "Adding Profile:"
			tput cuu1
			echo -e "${INVERTED}PROFILE ADDED to $ini_file${RESET}"
			echo
			echo -e "${YELLOW} New Profile: ${RESET}"
			echo "[$new_profile_key]"
			echo "Size=$size"
			;;
	 *)
	    echo "Usage: gen5 [main | logis | repos] [-1 | -2]"
	    return 1
	    ;;
     esac
}
