source ~/win-bashrc/mac-zshrc/utilities/colors.sh

ini_path=$HOME/AppData/Roaming/HowickHLCv3
ini_file=Howick.ini

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

		 # TODO: add a command that adds a profile

                #!/bin/bash

                # ini_file="example.ini"
                # search_key="key2"
                # new_key="key5"
                # new_value="new_value5"

                # awk -v search_key="$search_key" -v new_key="$new_key" -v new_value="$new_value" '
                # BEGIN {
                #     FS=" *= *"        # Set the field separator to handle spaces around the equal sign
                #     OFS=" = "         # Set the output field separator
                #     section_found=0   # Flag to track if the section has been found
                # }
                # {
                #     if ($0 ~ /^\[/) {   # Check if the line starts with '[' indicating a section
                #         section_found=0
                #     }
                #     if (section_found && $1 == search_key) {
                #         print $0           # Print the original line
                #         print new_key, new_value   # Append the new key-value pair
                #         section_found=0     # Reset the flag as we have processed the section
                #     } else {
                #         print $0           # Print the original line
                #     }
                # }
                # $1 == "[" section_name "]" {
                #     section_found=1   # Set the flag when the desired section is found
                # }
                # ' "$ini_file" > temp_ini && mv temp_ini "$ini_file"

	 *)
	    echo "Usage: gen5 [main | logis | repos] [-1 | -2]"
	    return 1
	    ;;
     esac
}
