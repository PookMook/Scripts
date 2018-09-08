#!/bin/sh
# Usage : ./parsebib.sh [folder] => ./parsebib bib

if [ -z "$1" ]
  then
    echo "No path to bibtex folder supplied"
    exit 1
fi

mkdir ${1}-intermed
mkdir ${1}-clean

# Loop all files in $1 folder
for filename in ${1}/*.bib; do
  echo "path : $filename"
  FILE=${filename##*/}

# remove previous keywords
    sed -E 's/keywords = \{[a-zA-Z0-9\,\ ]*\},?//g' $filename > ${1}-intermed/${FILE}

# Generate new keywords
    cat ${1}-intermed/${FILE} | gawk -v filename=${FILE%%.bib} '{ print gensub(/@([a-zA-Z0-9]+)\{([a-zA-Z0-9:_-]+),/, "@\\1{\\2,\nkeywords = {cleBib/\\2, article/"filename"},", "g") }' > ${1}-clean/${FILE}

done

# remove intermediate files
rm -R ${1}-intermed
