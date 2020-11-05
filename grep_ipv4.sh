#!/usr/bin/env bash

## File Header comments ##

# Script name: grep_ipv4.sh
# Script description: greps IPv4s from a file and saves output to a file.
# Dependencies: /usr/bin/grep
# Creator: prdcybersec
# License: BSD 2-Clause "Simplified" License
# Version: 1.1
# Date: 11/04/2020
# Last modified: 11/04/2020

## Variables ##

filename=grep_ipv4.sh
program="grep"
out_path=$PWD
now=$(date +"%Y%m%d_%H%M%S")
output_dir=$PWD/output

# Clear screen
clear

## Usage ##

if [ "$#" -ne 2 ]; then
echo "ABOUT: greps ipv4 addresses from a file and saves the output to a file."
echo "USAGE: ./${filename} [file] [output_filename]"
echo "EXAMPLE: ./${filename} file.txt ip_addresses"
echo "OUTPUT DIR: ${output_dir}/"
exit
fi

## Debugging ##

# ShellCheck
# An open source static analysis tool that automatically finds bugs in your shell scripts.
# Usage: u53r@kali:~ shellcheck update_kali.sh

# Redirects bash script output to syslog.
# echo "# Redirecting stout and stder error to /var/log/syslog."

# exec 1> >(logger -s -t "$(basename "$0")") 2>&1

# Verbose mode function
# Turn verbose mode on or off.
# The shell will echo each command line before it executes it.

# set -v

# Tracing mode function
# Turn tracing mode (i.e. xtrace) on and off.
# The shell will echo each command line before it executes it but after Expansion has been applied.
# The PS4 shell variable defines the prompt that gets displayed, when you
# execute a shell script in debug mode.
# $0 – indicates the name of script.
# $LINENO – displays the current line number within the script.

# set -x

# Define prompt
# The PS4 shell variable defines the prompt that gets displayed, when you
# execute a shell script in debug mode.
# $0 – indicates the name of script.
# $LINENO – displays the current line number within the script.

# export PS4='$0.$LINENO+ '

# Sets pipefail function
# set -euo pipefail
# -e option will cause the script to exit immediately when a command fails.
# -u option causes the bash shell to treat unset variables as an error and exit
# -o option sets the exit code of a pipeline to that of the rightmost command
# to exit with a non-zero status, or to zero if all commands of the pipeline
# exit successfully.
set -euo pipefail

# Trap command function
# Intercepts a fatal signal, performs cleanup, then exits.
trap SIGHUP SIGINT SIGTERM

## Script Commands ##

echo ""
echo "# Running" "${program}:"
echo ""

# Run progam and tee output to file
grep -E -o "(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)" < "${1}" | tee -a "${out_path}"/"${2}"_"${now}".txt

echo ""








