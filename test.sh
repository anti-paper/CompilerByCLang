#!/bin/bash

assert() {
    expected=$1
    input=$2
    inputFile=$fileName.txt
    compiledFile=$fileName.s
    assembledFile=$fileName
    echo $input > src/$inputFile

    docker compose exec clang ./main $inputFile $compiledFile
    docker compose exec clang gcc $compiledFile -o $assembledFile
    docker compose exec clang ./$assembledFile
    actual=$?

    if [[ $actual = $expected ]]; then
        echo "$input => $actual"
    else
        echo "$input => $expected expected, but got $actual"
        exit 1
    fi
}

fileName=tmp

if [[ $1 == 'test' ]]; then
    assert 0 0
    assert 255 -1
    assert 255 255
    assert 0 256

    echo OK
elif [[ $1 == 'clean' ]]; then
    if [[ -n $(ls src | grep -e "^$fileName.txt\$") ]];then
        rm src/$fileName.txt
    fi

    if [[ -n $(ls src | grep -e "^$fileName.s\$") ]];then
        rm src/$fileName.s
    fi

    if [[ -n $(ls src | grep -e "^$fileName\$") ]];then
        rm src/$fileName
    fi

else
    echo 'first argument is required.'
fi
