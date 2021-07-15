#!/usr/bin/env bash
fd --extension md --print0 |
    while IFS= read -r -d '' line; do 
        wc -m "$line"
    done
