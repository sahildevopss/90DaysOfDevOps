#!/bin/bash

LOG_DIR=$1

if [ $# -ne 1 ]; then
	echo "Usage: $0 < Path to Log Directory > "

	exit 1
fi

if [ ! -d "$LOG_DIR" ]; then
	echo " Error : Directory does not exist "
	
	exit 1

fi

COMPRESSED=0
DELETED=0

while read -r file
do
	gzip "$file"
	((COMPRESSED++))

done < <(find "LOG_DIR" -type f -name "*.log" -mtime +7)

while read  -r file
do
	rm -f "$file"
	((DELETED++))

done < <(find "LOG_DIR" -type f -name "*.gz" -mtime +30)

echo "Files compressed : $COMPRESSED"

echo "Files deleted: $DELETED"
