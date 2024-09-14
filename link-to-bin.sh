#!/bin/bash

source ./list_of_scripts

for SCRIPT in ${SCRIPTS[@]}; do
  cp -sf $(realpath ./$SCRIPT) $HOME/bin/$SCRIPT
done
