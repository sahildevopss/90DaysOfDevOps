#!/bin/bash

read -p "Enter the filename to search: " file

if [ -f "$file"  ]; then
	echo "File exists"

else
	echo "File does not exist"

fi
