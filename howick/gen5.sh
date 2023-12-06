gen5() {
     case "$1" in
	 main)
	     cd ~/Documents/HOWICK-repos/hmi-gen-5-official/HLCv3 && code .
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
		return 1
		;;
            esac
	    ;;
	 *)
	    echo "Usage: gen5 [main | logis | repos] [-1 | -2]"
	    return 1
	    ;;
     esac
}
