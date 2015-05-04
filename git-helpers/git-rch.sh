#!/bin/bash

function git-rch()
{
    local branch="$1"
    if [[ x"$branch" == x ]];
    then
        echo 'No branch'
        exit
    fi

    git fetch origin "$branch":"$branch" && git checkout "$branch"
}

git-rch "$@"
