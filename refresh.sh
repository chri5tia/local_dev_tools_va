#!/bin/bash

echo "Fetching upstream stuff..."
git fetch --all
echo "Rebasing with upstream/main..."
git rebase upstream/main
echo "Running composer install..."
ddev composer install
echo "Running database updates..."
ddev drush updb -y
