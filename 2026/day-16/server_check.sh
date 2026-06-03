#!/bin/bash

read -p "Enter the service name:" SERVICE

read -p "Do you want to check the $SERVICE status?y/n):" CHOICE

if [ "$CHOICE" = "y" ]; then
	systemctl status $SERVICE

else
	echo "skipped"

fi
