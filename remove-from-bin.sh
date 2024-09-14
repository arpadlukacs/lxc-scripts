#!/bin/bash

source ./list_of_scripts

for SCRIPT in ${SCRIPTS[@]}; do
  rm -f $HOME/bin/$SCRIPT
done
