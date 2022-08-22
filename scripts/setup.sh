#!/bin/bash
set -e
source ./scripts/modules/scriptlogger.sh

if [[ '$1' = '-l' ]] 
then
    shift
    setlevel $1
    shift
else
    setlevel 4
fi

{ 
    sudo log 1 "gained root"
} || {
    log 4 "please allow access to root"
    exit
}


{
    sudo chmod -R u+x ./scripts/
} || {
    log 4 "failed to chmod scripts"
    exit
}

log 2 "successfully made scripts executable"


{
    echo > ./core/.env
    echo > ./app/.env
    mkdir -p ./docker/images ./docker/volumes
} || {
    log 4 "failed to create .env files or docker folders"
    exit
}

log 2 "sucessfully created env and docker files"


{
    sudo curl -sSL https://install.python-poetry.org | python -
} || {
    log 4 "failed to install poetry"
    exit
}

{ 
    sudo apt-get install docker 
} || {
    brew install docker 
    brew link docker
} || { 
    log 4 "failed to install docker"
    exit
}

log 2 "sucessfully installed deps"


{
    cd core
    yarn install
    cd ..
} || {
    log 4 "failed to install yarn packages"
    exit
}

{
    cd app
    poetry install
    cd ..
} || {
    log 4 "failed to install poetry packages"
    exit
}

log 2 "sucessully installed packages"

# TODO: information replacement