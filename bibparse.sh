#!/bin/sh
# Loop all files

if [ -z "$1" ]
  then
    echo "No path to bibtex folder supplied"
    exit 1
fi

for filename in ${1}/*.bib; do
# remove previous keywords
    sed -E 's/keywords = \{[a-zA-Z0-9\,\ ]*\},?//g' $filename

# Generate new keywords
    echo "path : $filename"
    FILE=${filename##*/}
    gawk -v filename="${FILE%%.bib}" 'match($0, /@([a-zA-Z0-9]+){([a-zA-Z0-9]+),/, m){ print "@"m[1]"{"m[2]",\nkeywords = {article/"filename",cleBib/"m[2]"},\n"}' $filename

done
