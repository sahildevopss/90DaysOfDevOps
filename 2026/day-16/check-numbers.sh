#!/bin/bash

read -p "Enter the number:" Num

if [ $Num -gt 0 ]; then
    echo "Positive Number"

elif [ $Num -lt 0 ]; then
	echo "Negative Number"

else
	echo "zero"

fi

