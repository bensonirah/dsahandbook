#!/bin/bash

CYAN='\033[0;36m'
NC='\033[0m'

if [[ -f urls.txt ]]; then
    rm urls.txt
fi

rm -fv public/images/*

while IFS= read -r link;
do
    curl -s http://localhost:8000/$link | htmlq -a data-src img | uniq >> urls.txt
done < link.txt


while IFS= read -r url;
do
    printf "${CYAN}${url}${NC}\n"
    wget $url -o public/images/`basename $url`
done < urls.txt



filenames=( $(find . -type f -name '*.html') )

for filename in "${filenames[@]}"; do
    printf "Processing the file ${CYAN}${filename}${NC} for substitution\n"
    while IFS= read -r url;
    do
        base_name=`basename $url`
        printf "${CYAN}Substitute ${url} into public/images/${base_name} in the file ${filename} ${NC}\n"
        sed -i "s,${url},public/images/${base_name},g" $filename
    done < urls.txt
done


