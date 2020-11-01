#!/usr/bin/env bash

## File Header comments ##
# Script name: update_kali.sh
# Script description: Performs a Kali Linux dist-upgrade using apt
# from all configured sources in the /etc/apt/sources.list file.
# Creator: prdcybersec
# License: BSD 2-Clause "Simplified" License
# Version: 1.1
# Date: 10/25/2020
# Last modified: 11/01/2020

# Clear screen
clear

## Debugging ##
# ShellCheck
# An open source static analysis tool that automatically finds bugs in your shell scripts.
# Usage: u53r@kali:~ shellcheck update_kali.sh

# Redirects bash script output to syslog.
# echo "# Redirecting stout and stder error to /var/log/syslog."
# exec 1> >(logger -s -t "$(basename "$0")") 2>&1

# Write custom message to syslog.
echo "# Writing custom message to /var/log/syslog:"
echo "# update_kali.sh started."
logger -p local0.notice -t "${0##*/}[$$]" kali_update.sh started.

# Verbose mode function
# Turn verbose mode on or off.
# The shell will echo each command line before it executes it.
# set -v

# Tracing mode function
# Turn tracing mode (more technically xtrace) on and off
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

# Safe shell script best practices
# set -euo pipefail
# -e option will cause the script to exit immediately when a command fails.
# -u option causes the bash shell to treat unset variables as an error and exit
# -o option sets the exit code of a pipeline to that of the rightmost command
# to exit with a non-zero status, or to zero if all commands of the pipeline
# exit successfully.
# set -euo pipefail

# trap command to intercept a fatal signal, perform cleanup, then exit.
trap SIGHUP SIGINT SIGTERM

## Script ##
# Create a backup copy of the /etc/apt/sources.list file.
echo "# Backing up /etc/apt/sources.list to /etc/apt/sources.list.bak"
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak

# Download package information from all configured sources.list file.
echo "# Running 'apt-get update -y'"
sudo apt-get update -y;

# Upgrade all installed packages and installing or remove packages as needed.
echo "# Running 'apt-get dist-upgrade -y'"
sudo apt-get dist-upgrade -y;

# Remove packages that are now no longer needed.
echo "# Running 'apt-get autoremove -y'"
sudo apt-get autoremove -y;

# Clear the local repository of retrieved package files left in /var/cache.
echo "# Running 'apt-get clean'"
sudo apt-get clean

# Write custom message to syslog.
echo "# Writing custom message to /var/log/syslog:"
echo "# update_kali.sh finished."
echo "# See /var/log/apt/history.log for details."
logger -p local0.notice -t "${0##*/}[$$]" kali_update.sh finished.
