#!/bin/bash

read -p "Enter the number for countdown:" NUM

while [ $NUM -gt 0 ]

do
	echo "$NUM"
	NUM=$((NUM - 1))

done
	echo "done"
