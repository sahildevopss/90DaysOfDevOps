#!/bin/bash

check_disk(){
	echo "The disk Usage of / is:"

	df -h /
}


check_memory(){
	
	echo "The free memory is:"
	
	free -h
}

echo "===== System Resource Check ====="

check_disk

echo

check_memory
