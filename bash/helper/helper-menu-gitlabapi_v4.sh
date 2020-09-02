#!/usr/bin/env bash
function yes_or_no {
	while true; do
		read -p "$* [y/n]: " yn
		case $yn in
			[Yy]*) return 0 ;;
			[Nn]*) return 1 ;;
		esac
	done
}
script_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
# insertion order matters here
declare -a options_helper=(); declare -a commands_helper=()
options_helper+=('List user public projects (no password)'); commands_helper+=('
read -p "Enter username: " username ;
curl "https://gitlab.com/api/v4/users/"$username"/projects" | python -m json.tool
')
options_helper+=('List user projects'); commands_helper+=('
read -p "Enter username: " username ;
read -sp "Enter password: " password ;
curl -u $username:$password "https://gitlab.com/api/v4/users/"$username"/projects" | python -m json.tool
')

while true; do
	echo '========================================'
	echo '         ⭐⭐GitLab API v4 ⭐⭐         '
	echo '========================================'
	PS3='Please enter your choice: '
	COLUMNS=1
	select opt in "${options_helper[@]}" "Quit"; do
	echo '----------------------------------------'
		if (( 1<=$REPLY && $REPLY<${#options_helper[@]}+1 )); then
			eval ${commands_helper[$REPLY-1]}
			break
		elif (( $REPLY==${#options_helper[@]}+1 )); then
			break 2
		else
			echo "Invalid Choice!"
			break
		fi
	done
done
