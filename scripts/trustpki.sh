#!/bin/bash
wget -O /usr/local/share/ca-certificates/Securafi_Root_CA.crt "http://issuingca1.lab.securafi.net/pki/Securafi Root CA.pem"

wget -O /usr/local/share/ca-certificates/Securafi_Issuing_CA1.crt "http://issuingca1.lab.securafi.net/pki/Securafi Issuing CA1.pem"

update-ca-certificates
