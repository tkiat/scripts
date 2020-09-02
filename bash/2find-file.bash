#!/usr/bin/env bash
# argument(s): <file name>
if [[ "$#" -eq 0 ]]
then
	echo "argument(s): <file name>"
else
	find / -name "$1" 2>/dev/null
fi
