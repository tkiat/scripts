#!/usr/bin/env bash
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color
echo '----------------------------------------'
script_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
helper_path=$script_path"/helper"
# insertion order matters here
declare -a options; declare -a commands
options+=('File name -- Remove from index x to y'); commands+=('
read -p "Enter x: " x ;
read -p "Enter y: " y ;
python3 $helper_path/helper-rename-remove_from_index_x_to_y.py $x $y ;
')
options+=('Input text -- Add at specific index'); commands+=('
read -p "Enter text: " text ;
read -p "Enter index: " index ;
python3 $helper_path/helper-rename-add_text.py $text $index ;
')
options+=('Number -- Make first number x digits'); commands+=('
read -p "Enter x: " x ;
python3 $helper_path/helper-rename-first_number_make_x_digit.py $x ;
')
options+=('Number -- Subtract first number by x'); commands+=('
read -p "Enter x: " x ;
python3 $helper_path/helper-rename-first_number_subtract_by_x.py $x ;
')
options+=('Word -- Capitalize first letter of each word'); commands+=('
python3 $helper_path/helper-rename_capitalize_first_letter_each_word.py ;
')
options+=('Word -- Remove first match'); commands+=('
read -p "Enter word: " word ;
python3 $helper_path/helper-rename-remove_word.py $word ;
')
options+=('Word -- Replace words up to n matches'); commands+=('
read -p "Old word: " x ;
read -p "New word: " y ;
read -p "Enter n: " n ;
python3 $helper_path/helper-rename-replace_word.py $x $y $n ;
')

while true; do
	echo "List Files:"
	ls -N -1
	echo -e "${RED}0123456789${GREEN}0123456789${BLUE}0123456789${NC}"
	echo '========================================'
	echo '          ⭐⭐Rename Menu ⭐⭐          '
	echo '========================================'
	PS3='Please enter your choice: '
	COLUMNS=1
	select opt in "${options[@]}" "Quit"; do
	echo '----------------------------------------'
		if (( 1<=$REPLY && $REPLY<${#options[@]}+1 )); then
			eval ${commands[$REPLY-1]}
			break
		elif (( $REPLY==${#options[@]}+1 )); then
			break 2
		else
			echo "Invalid Choice!"
			break
		fi
	done
done
