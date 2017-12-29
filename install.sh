#!/usr/bin/env bash

create_symlink()
{
    source=$1
    target=$2
    if [ ! -L ${target} ]; then
        ln -s ${source} ${target}
        echo "Created symlink from ${source} to ${target}."
    fi
}

baseDir=$(pwd)

create_symlink "${baseDir}/hammerspoon" "${HOME}/.hammerspoon"
