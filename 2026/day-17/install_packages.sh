#!/bin/bash

if [ $EUID -ne 0 ]; then
	
	echo "Run as a ROOT "
	
	exit 1
fi

packages="nginx curl wget"

for package in $packages

do 
	if dpkg -s "$package" >/dev/null 2>&1
	then
		echo "$package already is installed"
	else
		echo "Installing $package"
		apt update -y
		apt install -y "$package"
		echo "$package installed successfully."
	fi
done
