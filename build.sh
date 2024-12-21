#!/bin/bash
# To build, either place the IPA file in the project's root directory, or get the path to the IPA, then run `./build.sh`

# read -p $'\e[34m==> \e[1;39mPath to the decrypted YouTube.ipa or YouTube.app. If nothing is provied, any ipa/app in the project\'s root directory will be used: ' PATHTOYT
read -p $https://armconverter.com/decryptedappstore/download/544007664/com.google.ios.youtube/19.49.7?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjExNjk0ODU5LCJpYXQiOjE3MzQ3NzY3NzAsImV4cCI6MTczNDc4NzU3MCwiYXBwaWQiOjU0NDAwNzY2NCwiYXBwdmVyIjoiMTkuNDkuNyJ9._ShosJsT9rXfGiHQjKGx6D4inMcYiAJsWSc60yIeqxk
# Check if PATHTOYT is empty
if [ -z "$PATHTOYT" ]; then
    # Look for ipa/app files in the current directory
    IPAS=$(find . -maxdepth 1 -type f \( -name "*.ipa" -o -name "*.app" \))
    
    # Check if there are two or more ipa/app files
    COUNT=$(echo "$IPAS" | wc -l)
    
    if [ "$COUNT" -ge 2 ]; then
        echo "❌ Error: Multiple IPA/app files found in the project's root directory directory. Make sure there is only one ipa."
        exit 1
        
    elif [ -n "$IPAS" ]; then
        PATHTOYT=$(echo "$IPAS" | head -n 1)
        
    else
        echo "❌ Error: No IPA/app file found in the project's root directory directory."
        exit 1
    fi
fi

make package THEOS_PACKAGE_SCHEME=rootless IPA="$PATHTOYT" FINALPACKAGE=1

# SHASUM
if [[ $? -eq 0 ]]; then
  open packages
  echo "SHASUM256: $(shasum -a 256 packages/*.ipa)"

else
  echo "Failed building YTLitePlus"

fi
