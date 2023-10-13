#!/bin/bash

# Set up instructions
# Add an alias to your shell profile
# Example: ~/.bash_profile, ~/.bashrc or ~/.zshrc
# 
# alias vafresh='/path/to/your/script.sh'

# Uncomment to exit script if any command fails
# set -e

# Set these local variables
# Name of remotes
UPSTREAM=origin
ORIGIN=origin
MYFORK=chri5tia
REPO=VA.gov-cms

# Name of main branch
MAIN=main

# Decoration
#DECO=⋆⊹₊☆⋆｡°‧★☆⋆‧⋆⊹₊☆⋆｡‧★☆⋆‧
DECO1=▐░▒▐░▒▐░▒▐░▒
DECO2=▐░▒▐░▒▐░▒▐░▒

# Decoration function
echo_deco() {
  local prefix="$DECO1 "
  local suffix=" $DECO2"
  echo "${prefix} ${1}${suffix}"
}

echo_deco "Pulling in the latest from $REPO."
git pull $ORIGIN $MAIN

echo_deco "Clearing Drupal caches"
ddev drush cr

# echo_deco "Fetching upstream stuff."
# git fetch --all

# echo_deco "Rebasing with the main branch."
# git rebase $UPSTREAM/$MAIN_BRANCH

echo_deco "Running composer install."
ddev composer install

# devel_status=$(ddev drush pml | grep devel)
# if [[ $devel_status == enabled ]]; then
#   echo_deco "Uninstalling devel"
#   ddev drush pm-uninstall devel
# else
#   echo_deco "Devel is already not enabled. Moving on."
# fi

echo_deco "Deploying the stuff."
ddev drush deploy

# echo_deco "Database updates."
# ddev drush updb -y

# echo_deco "Importing config."
# ddev drush cim -y

if read -t 30 -p "Do I need to compile the theme? (y/n): " theme; then
  if [[ "$theme" == "y" || "$theme" == "Y" ]]; then
    echo_deco "Fine. Compiling the theme. This will take a while."
    ddev composer run va:theme:compile
  else
    echo_deco "Skipping theme compilation."
  fi
else
  echo_deco "Skipping theme compilation since you're ignoring me."
fi

echo_deco "Clearing Drupal caches."
ddev drush cr

# echo_deco "Reinstalling devel."
# ddev drush en devel

echo_deco "Opening local project in browser."
ddev launch

if read -t 30 -p "Do you want to do some additional clean up? (y/n)" clean; then
  if [[ $clean == 'y' || $clean == "Y" ]]; then
    echo_deco "Great. Doing some maintenance. Baiii."
    npx update-browserslist-db@latest
  else
    echo_deco "Skipping the additional clean up and stuff."
  fi
else
  echo_deco "Skipping additional clean up since you're ignoring me again."
fi

echo_deco "Done. Get me a coffee."
