#!/bin/bash

# Name of upstream remote
UPSTREAM=origin

# Name of main branch
MAIN_BRANCH=main

echo "Fetching upstream stuff..."
git fetch --all
echo "Rebasing with the main branch..."
git rebase $UPSTREAM/$MAIN_BRANCH
echo "Running composer install..."
ddev composer install
echo "Running database updates..."
ddev drush updb -y
echo "Importing config"
ddev drush cim -y
