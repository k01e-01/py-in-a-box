#!/bin/bash
set -e
source ./scripts/modules/scriptlogger.sh

if [[ '$1' = '-l' ]] 
then
    shift
    setlevel $1
    shift
else
    setlevel 2
fi