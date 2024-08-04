#!/bin/bash

target=$1
object=$2

if [[ -n $target ]] && [[ -n $object ]]; then
    docker compose exec clang gcc $target -o $object
    exit 0
fi

echo invalid arguments
