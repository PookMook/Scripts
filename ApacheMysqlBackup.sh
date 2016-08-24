#!/bin/sh
find /home/backup/ -type f -mtime +30 -exec sh -c 'test $(date +%u -r "$1") = 1 || rm "$1"' -- {} \;
cd /var/www/
TIMESTAMP=$(date +"%F")
BACKUP_DIR="/home/backup"
MYSQL_USER="__USER__"
MYSQL=/usr/bin/mysql
MYSQL_PASSWORD="__PASSWORD__"
MYSQLDUMP=/usr/bin/mysqldump
for f in */; do 
  mkdir -p $BACKUP_DIR/$f
  tar -chzf "$BACKUP_DIR/${f%/}/$TIMESTAMP.tar.gz" "$f"
done
databases=`$MYSQL --user=$MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)"`
for db in $databases; do
  mkdir -p $BACKUP_DIR/$db
  $MYSQLDUMP --force --opt --user=$MYSQL_USER -p$MYSQL_PASSWORD --databases $db | gzip > "$BACKUP_DIR/$db/$TIMESTAMP.sql.gz"
done
