#!/bin/bash

greet() {
	echo "Hello $1"
}

add() {
	echo "$(($1 + $2))"
}

greet "sahil"

add 10 20

echo "The sume is: $(add 10 20) " 
