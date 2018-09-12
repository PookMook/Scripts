#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os, sys, bibtexparser




folder=sys.argv[1] if len(sys.argv) > 1 else "bib"

if not os.path.exists(folder+'-clean'):
    os.makedirs(folder+'-clean')


for file in os.listdir(folder):
    if file.endswith(".bib"):
        print(os.path.join(folder, file))
        with open(os.path.join(folder, file)) as bibtex_file:
            bib_database = bibtexparser.load(bibtex_file)
            for entry in bib_database.entries:
                # For some reason, keywords => keyword in bibtexparser
                entry['keywords'] = entry.get('keywords', '')
                entry['keyword'] = entry.get('keyword', '')
                if(entry['keyword'] != ''):
                    entry['keywords'] = 'cleBib/' + entry['ID'] + ', article/' + os.path.splitext(file)[0] + ', ' + entry['keyword']
                else:
                    entry['keywords'] = 'cleBib/' + entry['ID'] + ', article/' + os.path.splitext(file)[0]
                del entry['keyword']
            with open(os.path.join(folder+'-clean', file), 'w') as bibtex_export:
                bibtex_export_str = bibtexparser.dumps(bib_database)
                bibtex_export.write(bibtex_export_str.encode('utf8'))
