#!/bin/bash

# Name of upstream remote
UPSTREAM=origin

# Name of main branch
MAIN_BRANCH=main

# Decoration
D=☆⋆｡𖦹°‧★☆⋆｡𖦹°‧★☆⋆｡𖦹°‧★

echo "$D Fetching upstream stuff. $D"
git fetch --all
echo "$D Rebasing with the main branch. $D"
git rebase $UPSTREAM/$MAIN_BRANCH
echo "$D Running composer install. $D"
ddev composer install
echo "$D Uninstalling devel $D"
ddev drush pm-uninstall devel
echo "$D Importing config. $D"
ddev drush cim -y
echo "$D Database updates. $D"
ddev drush updb -y
echo "$D Compiling the theme $D"
ddev composer run va:theme:compile
echo "$D Reinstalling devel $D"
ddev drush en devel
