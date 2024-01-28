#!/bin/bash

lsmod | grep -q nouveau

# $? gives the exit status of the last command
if [ $? -ne 0 ]; then
    echo "Script ran successfully (nouveau is not loaded)"
    exit 0
else
    echo "Script failed (nouveau is loaded)"
    exit 1
fi