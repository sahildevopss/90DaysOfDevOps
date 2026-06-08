#!/bin/bash

set -euo pipefail

echo "Starting script "

grep "test" sample.txt | wc -l

echo "complete"
