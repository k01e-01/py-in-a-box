#!/bin/bash

logger_minlevel=0

function setlevel {
    minlevel=$1
}

function log {
    declare -a levels=( 
        "\033[0;30m[TRACE]" 
        "\033[0;37m[DEBUG]" 
        "\033[0;97m[INFO] " 
        "\033[0;33m[WARN] " 
        "\033[0;31m[ERROR]" 
        "\033[0;91m[FATAL]" 
    )
    now=$(date +"%T")
    echo -e "${levels[$1]} [$now] $2" | sed -e 's/\x1b\[[0-9;]*m//g' >> ./logs/scripts.log
    if [[ $1 -lt $minlevel ]] 
    then 
        return
    fi
    echo -e "${levels[$1]} [$now] $2"
}

if [[ $0 = ${BASH_SOURCE[0]} ]] 
then
    log 0 test
    log 1 test
    log 2 test
    log 3 test
    log 4 test
    log 5 test
fi