#!/bin/bash

# Usage and help
USAGE="Usage: $0 [owca-name]"

if [[ $# -ne 1 ]]; then
  echo -e $USAGE
  exit 1
fi

# Variables
OWCA_NAME=$1

# Unzip the starter kit
unzip "$OWCA_NAME"_starter_kit.zip 
mv "$OWCA_NAME"_starter_kit.zip ~/Downloads

# Move the files in place
cp -rf $OWCA_NAME*/.chef/ ./.chef/

CHEF_SERVER_NAME=$(grep '^CHEF_SERVER_NAME' $OWCA_NAME*/userdata.sh)
sed -i '' "s/CHEF_SERVER_NAME=.*/$CHEF_SERVER_NAME/g" userdata.sh
sed -i '' "s/CHEF_SERVER_NAME=.*/$CHEF_SERVER_NAME/g" userdata-rhel.sh
sed -i '' "s/CHEF_SERVER_NAME=.*/$CHEF_SERVER_NAME/g" userdata-ubuntu.sh

CHEF_SERVER_ENDPOINT=$(grep '^CHEF_SERVER_ENDPOINT' $OWCA_NAME*/userdata.sh)
sed -i '' "s/CHEF_SERVER_ENDPOINT=.*/$CHEF_SERVER_ENDPOINT/g" userdata.sh
sed -i '' "s/CHEF_SERVER_ENDPOINT=.*/$CHEF_SERVER_ENDPOINT/g" userdata-rhel.sh
sed -i '' "s/CHEF_SERVER_ENDPOINT=.*/$CHEF_SERVER_ENDPOINT/g" userdata-ubuntu.sh

# Remove the unzipped files
rm -rf $OWCA_NAME*/
