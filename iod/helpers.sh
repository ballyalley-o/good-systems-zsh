source ~/mac-zshrc/utilities/colors.sh

STUDENTS_DETAILS=~/mac-zshrc/iod/students.sh

if [[ -f "$STUDENTS_DETAILS" ]]; then
    source "$STUDENTS_DETAILS"
else
    echo "Warning: students file not found at $STUDENTS_DETAILS"
fi


add_student() {
    student="$1"
    lastname="$2"
    email="$3"
    username="$4"

    students+=("$student")
    students_lastname+=("$lastname")
    students_email+=("$email")
    students_usernames+=("$username")
}

get_student() {
    student_name="$1"

    if [ -z "$1" ]; then
        echo "Usage: get_student <student_name>"
        return 1
    fi

    for ((i = 0; i < ${#students[@]}; i++)); do
        if [[ "${students[$i]}" == "$student_name" ]]; then
            echo -e "${INVERTED}Student:${RESET} ${students_lastname[$i]} | ${INVERTED}Email:${RESET} ${students_email[$i]} | ${INVERTED}Username:${RESET} ${students_usernames[$i]}"
            return
        fi
    done

    echo "Student not found: $student_name"
}

check() {
    attempts=0
    while [ "$attempts" -lt 3 ]; do
        echo -n -e "${BLUEBG}Enter the correct module number: ${RESET}"
        read module_number
        if [[ "$module_number" =~ ^[0-9]+$ ]]; then
             ((attempts++))
            echo "$attempts attempts"
            break
        else
            echo -e "${REDBG}Invalid input. Please enter a valid module number.${RESET}"
            ((attempts++))
            echo "$attempts attempts"
        fi
    done

    if [ "$attempts" -eq 3 ]; then
        echo "Too many invalid attempts. Returning to home directory."
        cd
        return
    fi
}