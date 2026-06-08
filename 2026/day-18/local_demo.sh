#!/bin/bash

demo_local() {
	local NAME="SAHIL"
	echo "Inside function local variable gets output $NAME"
}

demo_global() {
	city="PUNE"
	echo "Inside function global variable $city"
}

demo_local

echo "Outside function local varaiable $NAME : no output"

demo_global

echo "outside function global variable $city"


