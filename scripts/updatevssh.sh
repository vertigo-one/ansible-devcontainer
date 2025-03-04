#!/bin/bash

# Download latest vssh from github
wget -O /tmp/vssh_latest.zip $(wget -q -O - 'https://api.github.com/repos/Venafi/vssh-cli/releases/latest' | jq -r '.assets[] | select(.name=="vssh_linux_amd64.zip").browser_download_url') 

# unzip file
unzip -o /tmp/vssh_latest.zip vssh -d /usr/local/bin/

# remove temp file
rm /tmp/vssh_latest.zip