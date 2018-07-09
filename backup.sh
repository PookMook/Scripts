#!/bin/sh

#You need to configure your ssh key to work with your server

#Rsync /home/backup into backup folder
rsync -r -a -v --delete -e ssh root@juchereau.com:/home/backup/ /backup/juchereau.com/

#Tar.gz to archive
cd /backup
tar -zcvf "juchereau.com-old/$(date '+%Y-%m-%d').tar.gz" juchereau.com

#Cleanup files
cd /backup/juchereau-old
echo "to be removed :"
find ./* -name '????-??-01.*' -prune -o -mtime +7 -exec rm {} \;
