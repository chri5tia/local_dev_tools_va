#!/bin/bash

# Exit script if any command fails
set -e

# Check these variables
# Name of remotes
UPSTREAM=vagovcms
MYFORK=chri5tia

# Name of main branch
MAIN_BRANCH=main

# Decoration
DECO=⋆⊹₊☆⋆｡°‧★☆⋆‧⋆⊹₊☆⋆｡‧★☆⋆‧
#DECO= -------------

# Decoration function
echo_deco() {
  local prefix="$DECO"
  local suffix="$DECO"
  echo "${prefix} ${1} ${suffix}"
}

echo_deco "Fetching upstream stuff."
git fetch --all

echo_deco "Rebasing with the main branch."
git rebase $UPSTREAM/$MAIN_BRANCH

echo_deco "Running composer install."
ddev composer install

devel_status=$(ddev drush pml | grep devel)
if [[ $devel_status == *enabled ]]; then
  echo_deco "Uninstalling devel"
  ddev drush pm-uninstall devel
else
  echo_deco "Devel is already not enabled. Moving on."
fi

echo_deco "Importing config."
ddev drush cim -y

echo_deco "Database updates."
ddev drush updb -y

read -p "Do I need to compile the theme?" theme
if [[ $theme == "y" || $theme == "Y" ]]; then
  echo_deco "Fine. Compiling the theme. This will take awhile."
  ddev composer run va:theme:compile
fi

echo_deco "Clearing Drupal caches."
ddev drush cr

echo_deco "Reinstalling devel."
ddev drush en devel

echo_deco "Opening local project in browser."
ddev drush launch

read -p "Do you want to do some additional clean up?" clean
if [[ $clean == 'y' || $clean == "Y" ]]; then
  echo_deco "Great. Doing some maintenance. Baiii."
  npx update-browserslist-db@latest

echo_deco "Done."
