#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os, sys, bibtexparser
from bibtexparser.bparser import BibTexParser
from bibtexparser.bwriter import BibTexWriter
import logging
logging.basicConfig()

folder=sys.argv[1] if len(sys.argv) > 1 else "bib"

if os.path.exists(folder+'-clean'):
    print 'cleaning '+folder+'-clean/'
    for file in os.listdir(folder+'-clean'):
        try:
            if os.path.isfile(folder+'-clean/'+file):
                os.unlink(folder+'-clean/'+file)
        except Exception as e:
            print(e)
else:
    os.makedirs(folder+'-clean')

#Writer customization
writer = BibTexWriter()
writer.contents = ['entries']
writer.indent = '  '
writer.order_entries_by = ('ENTRYTYPE', 'author', 'year')

#parser customization, need a new parser for each file
#parser = BibTexParser()
#parser.common_strings = True

#Bib dictionary for months
Months = """@STRING{ jan = "jan"}
@STRING{ feb = "feb"}
@STRING{ mar = "mar"}
@STRING{ apr = "apr"}
@STRING{ may = "may"}
@STRING{ jun = "jun"}
@STRING{ jul = "jul"}
@STRING{ aug = "aug"}
@STRING{ sep = "sep"}
@STRING{ oct = "oct"}
@STRING{ nov = "nov"}
@STRING{ dec = "dec"}
"""

print 'Parsing files in '+folder+'/'
for file in os.listdir(folder):
    if file.endswith(".bib"):
        print(os.path.join(folder, file))
        with open(os.path.join(folder, file)) as bibtex_file:
            content = Months + bibtex_file.read()
            parser = BibTexParser()
            parser.common_strings = True
            bib_database = bibtexparser.loads(content, parser)
            for entry in bib_database.entries:
                #print(entry['ID'])
                entry['keywords'] = entry.get('keywords', '')
                if(entry['keywords'] != ''):
                    entry['keywords'] = 'cleBib/' + entry['ID'] + ', article/' + os.path.splitext(file)[0] + ', ' + entry['keywords']
                else:
                    entry['keywords'] = 'cleBib/' + entry['ID'] + ', article/' + os.path.splitext(file)[0]
            with open(os.path.join(folder+'-clean', file), 'w') as bibtex_export:
                bibtex_export_str = bibtexparser.dumps(bib_database, writer)
                bibtex_export.write(bibtex_export_str.encode('utf8'))
