#!/bin/bash

## Script Header ##

# Script name: traceroute_ipv4
# Script description: Performs an IPv4 traceroute and saves output to a file.
# Creator: prdcybersec
# License: BSD 2-Clause "Simplified" License
# Version: 1.0
# Date: 10/26/2020

## Variables ##
FILE_NAME=traceroute_ipv4
NOW=$(date +"%Y%m%d_%H%M%S")
OUTPUT=$PWD/output

# Clear screen
clear

## Usage ##
if [ "$#" -ne 2 ]; then
echo "ABOUT: Performs an IPv4 traceroute and saves the output to a file."
echo "USAGE: ./traceroute_ipv4 [IP addr] [output_filename]"
echo "EXAMPLE: ./traceroute_ipv4 8.8.8.8 google"
echo "OUTPUT DIR: ${OUTPUT}/"
exit
fi

## Debugging ##

# Display commands and their arguments as they are executed.
#set -x

# Display shell input lines as they are read.
#set -v

## Best Practices ##

# set -euo pipefail
# -e option will cause the script to exit immediately when a command fails.
# -u option causes the bash shell to treat unset variables as an error and exit
# -o option sets the exit code of a pipeline to that of the rightmost command
# to exit with a non-zero status, or to zero if all commands of the pipeline
# exit successfully.
# immediately.
set -euo pipefail

# trap command to intercept a fatal signal, perform cleanup, then exit.
trap SIGHUP SIGINT SIGTERM

## Script ##

echo $FILE_NAME

# Create file output directory
mkdir -p "$OUTPUT"

echo ""

# Run traceroute
traceroute "${1}" | tee -a "${OUTPUT}"/"${1}"_"${2}"_"${FILE_NAME}"_"${NOW}".txt

echo ""

# Grep traceroute output and publish to sdout and file
echo "grepped ip addresses:"
echo ""
traceroute "${1}" | grep -E -o "([0-9]{1,3}[\\.]){3}[0-9]{1,3}" | sort -u | tee -a "${OUTPUT}"/"${1}"_"${2}"_"${FILE_NAME}"_"${NOW}".txt

echo ""
echo "OUTPUT FILE:" "${OUTPUT}"/"${1}"_"${2}"_"${FILE_NAME}"_"${NOW}".txt
echo ""
