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
options_helper+=('Add Remote'); commands_helper+=('
read -p "Enter username: " username ;
read -p "Enter repository name: " reponame ;
git remote add origin git@bitbucket.org:$username/$reponame.git
')
options_helper+=('Create new repo'); commands_helper+=('
read -p "Enter username: " username ;
read -sp "Enter password: " password ;
echo "" ;
read -p "Enter repository name: " reponame ;
if yes_or_no "Is it private?" ;then private="true" ;else private="false"; fi ;
curl -X POST -u $username:$password -H "Content-Type: application/json" -d '"'"'{"scm": "git", "is_private": "'$private'"}'"'"' https://api.bitbucket.org/2.0/repositories/$username/$reponame
')

while true; do
	echo '========================================'
	echo '        ⭐⭐Bitbucket API v2 ⭐⭐       '
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
