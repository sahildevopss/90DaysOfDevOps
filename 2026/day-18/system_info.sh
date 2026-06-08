#!/bin/bash

set -euo pipefail

print_header(){
	echo 
	echo "======================================="
	echo "$1"
	echo "======================================="
}

system_info(){
	hostnamectl | head -10
}

uptime_info(){
	uptime
}

disk_usage(){
	df -h | sort -hrk5 | head -5
}

mem_usage(){
	free -h
}

cpu_processes() {
	ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -6
}

main() {
	print_header "HOSTNAME & OS INFO"
	system_info

	print_header "UPTIME" 
	uptime_info
	
	print_header "TOP 5 DISK USAGE" 
	disk_usage 
	
	print_header "MEMORY USAGE"
       	mem_usage 
	
	print_header "TOP CPU PROCESSES"
       	cpu_processes
}
main
