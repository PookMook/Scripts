#!/bin/sh
# Loop all files

if [ -z "$1" ]
  then
    echo "No path to bibtex folder supplied"
    exit 1
fi

for filename in ${1}/*.bib; do
# remove previous keywords
    cat $filename | sed -E 's/^\s*keywords = \{.*\}(,)?\s?[\r]?[\n]?$//g'

# Generate new keywords
    echo "path : $filename"
    FILE=${filename##*/}
    cat $filename | gawk -v filename="${FILE%%.bib}" 'match($0, /@(.+){(.+),/, m){ print "@"m[1]"{"m[2]",\nkeywords = {article/"filename",cleBib/"m[2]"},\n"}'

done
