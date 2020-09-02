#!/usr/bin/env bash
script_path="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
helper_script=$script_path"/helper"
# insertion order matters here
declare -a options; declare -a commands
options+=('git add .'); commands+=('git add .')
options+=('git commit -m <message>'); commands+=('read -p "Enter commit message: " msg; git commit -m "$msg"')
options+=('git push origin master'); commands+=('git push origin master')
options+=('git status'); commands+=('git status')
options+=('git log'); commands+=('git log')
#options+=('BitBucket API v2'); commands+=('source $helper_script/helper-menu-bitbucketapi_v2.sh')
#options+=('GitHub API v3'); commands+=('source $helper_script/helper-menu-githubapi_v3.sh')
#options+=('GitLab API v4'); commands+=('source $helper_script/helper-menu-gitlabapi_v4.sh')

while true; do
	echo '========================================'
	echo '            ⭐⭐Git Menu ⭐⭐           '
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
