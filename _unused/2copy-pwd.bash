#!/usr/bin/env bash
#pwd | echo -n "$(xargs -0 echo)" | xclip -selection clipboard
pwd_escaped=$(echo $(pwd) | sed 's/"/\\"/g; s/\x27/\\\x27/g; s/ /\\ /g')
echo -n "$pwd_escaped" | xclip -selection clipboard
