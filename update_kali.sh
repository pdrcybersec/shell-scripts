#!/bin/bash

## Script Header ##

# Script name: update_kali
# Script description: Performs a Kali Linux dist-upgrade using apt
# from all configured sources in /etc/apt/sources.list
# Creator: prdcybersec
# License: BSD 2-Clause "Simplified" License
# Version: 1.0
# Date: 10/25/2020

# Clear screen
clear

## Debugging ##

# Redirects bash script output to syslog.
echo "# Redirecting stout and stder error to /var/log/syslog."
exec 1> >(logger -s -t "$(basename "$0")") 2>&1

# Write custom message to syslog.
echo "# Writing custom message to /var/log/syslog:"
echo "# kali_update.sh started."
logger -p local0.notice -t "${0##*/}[$$]" kali_update.sh started.

# Display commands and their arguments as they are executed.
# set -x

# Display shell input lines as they are read.
# set -v

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
echo "# kali_update.sh ran. See /var/log/apt/history.log for details."
logger -p local0.notice -t "${0##*/}[$$]" kali_update.sh ran. See /var/log/apt/history.log for details.
