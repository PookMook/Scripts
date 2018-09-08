#!/bin/sh
# Loop all files

if [ -z "$1" ]
  then
    echo "No path to bibtex folder supplied"
    exit 1
fi

for filename in ${1}/*.bib; do
# remove previous keywords
    #sed -Ei 's/keywords = \{[a-zA-Z0-9\,\ ]*\},?//g' $filename

# Generate new keywords
    echo "path : $filename"
    FILE=${filename##*/}
    cat $filename | gawk -v filename=${FILE%%.bib} '{ print gensub(/@([a-zA-Z0-9]+)\{([a-zA-Z0-9]+),/, "@\\1{\\2,\nkeywords = {cleBib/\\2, article/"filename"},\n", "g") }' > ${1}-clean/${FILE}

done
