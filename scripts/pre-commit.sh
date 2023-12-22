#!/bin/bash
COLOR_YELLOW='\e[1;33m'
COLOR_NC='\e[0m' # No Color

IFS=$'\n' read -r -d '' -a changed_files < <( git diff --cached --name-only | grep -E "\.js|\.ts|\.tsx|\.jsx" && printf '\0' )

for file_path in "${changed_files[@]}"
do
    if [ "$file_path" = "package-lock.json" ]; then
        printf "[Check] package-lock.json ignored.\n"
    elif [[ $(grep -o "<div" $file_path | wc -l) -gt 1 ]]; then
        printf "[Check] Warning: please refactor file: "
        printf $COLOR_YELLOW 
        printf $file_path 
        printf $COLOR_NC
        printf "\n"
        cat $file_path | grep "<div"
        printf "\n"
    fi
done
