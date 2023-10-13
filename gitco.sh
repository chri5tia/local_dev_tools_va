#!/bin/bash

# Handy git checkout shortcut
read -p "Ticket ID? " ticket
target=$(git branch | grep "$ticket")
git checkout $target