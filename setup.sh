#!/bin/bash

# Usage and help
USAGE="Usage: $0 [owca-name] [base directory for starter kit and credentials file (optional)]"

if [[ $# -eq 0 ]]; then
  echo -e $USAGE
  exit 1
fi

if [[ $# -eq 1 ]]; then
  BASE_DIR=~/Downloads
fi

if [[ $# -eq 2 ]]; then
  BASE_DIR=$2
fi

# Variables
OWCA_NAME=$1

# Unzip the starter kit
cp "$BASE_DIR"/"$OWCA_NAME"_starter_kit.zip .
echo "unzipping \"$OWCA_NAME\"_starter_kit.zip..."
unzip -q "$OWCA_NAME"_starter_kit.zip 
mv "$OWCA_NAME"_starter_kit.zip "$BASE_DIR"

# Move the files in place
cp -rf $OWCA_NAME*/.chef/ ./.chef/

echo "updating the userdata scripts..."
CHEF_SERVER_NAME=$(grep '^CHEF_SERVER_NAME' $OWCA_NAME*/userdata.sh)
sed -i '' "s/CHEF_SERVER_NAME=.*/$CHEF_SERVER_NAME/g" userdata.sh
sed -i '' "s/CHEF_SERVER_NAME=.*/$CHEF_SERVER_NAME/g" userdata-rhel.sh
sed -i '' "s/CHEF_SERVER_NAME=.*/$CHEF_SERVER_NAME/g" userdata-ubuntu.sh

CHEF_SERVER_ENDPOINT=$(grep '^CHEF_SERVER_ENDPOINT' $OWCA_NAME*/userdata.sh)
sed -i '' "s/CHEF_SERVER_ENDPOINT=.*/$CHEF_SERVER_ENDPOINT/g" userdata.sh
sed -i '' "s/CHEF_SERVER_ENDPOINT=.*/$CHEF_SERVER_ENDPOINT/g" userdata-rhel.sh
sed -i '' "s/CHEF_SERVER_ENDPOINT=.*/$CHEF_SERVER_ENDPOINT/g" userdata-ubuntu.sh

REGION=$(grep '^REGION' $OWCA_NAME*/userdata.sh)
sed -i '' "s/REGION=.*/$REGION/g" userdata.sh
sed -i '' "s/REGION=.*/$REGION/g" userdata-rhel.sh
sed -i '' "s/REGION=.*/$REGION/g" userdata-ubuntu.sh

# Remove the unzipped files
echo "cleaning up..."
rm -rf $OWCA_NAME-*/

echo "done!"
echo "The Admin password is `cat "$BASE_DIR"/\"$OWCA_NAME\"_credentials.csv | cut -d ',' -f2`"
