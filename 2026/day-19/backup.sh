#!/bin/bash

<< readme

this script is for takking backups and delete backups older than 14days

readme

SOURCE=$1

DEST=$2

if [ $# -ne 2 ]; then
	echo "Usage $0 : <Source Directory> <Dest Directory>"
	exit 1
fi

if [ ! -d "$SOURCE" ]; then
	echo "Source directory does not exist"
	exit 1
fi

mkdir -p $DEST

DATE=$(date +%y-%m-%d)

ARCHIVE="/$DEST/backup-$DATE.tar.gz"

tar -czf $ARCHIVE $SOURCE

if [ $? -ne 0 ];then
	echo "Backup failed"
	exit 1
fi

SIZE=$(du -h "$ARCHIVE" | cut -f1)

echo "Archive $ARCHIVE"

echo "SIZE $SIZE"

find "$DEST" -type f -name "*.tar.gz" -mtime +14 -delete
