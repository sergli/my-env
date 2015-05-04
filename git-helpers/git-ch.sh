#!/bin/bash

function git-ch() {
    local ifs="$IFS"
    local branch
    local branches
    declare -i count

    case "$#" in
        0)
            branches="$(git branch --no-color --list)"
            if [[ "x$branches" == x ]]; then
                echo "There is no branches in this repo" 2>&1
                return 2
            fi
            ;;
        1)
            branches="$(git branch --no-color --list | fgrep -i "$1")"
            if [[ "x$branches" == x ]]; then
                echo "There is no branch like '$1'" 2>&1
                return 2
            fi
            ;;
        *)
            echo "Usage: $0 [filter]"
            echo "Filter local git branches and checkout to it"
            exit 1
    esac

    count="$(echo "$branches" | wc -l)"
    case "$count" in
        0)
            return 2
            ;;
        1)
            branch="$branches"
            ;;
        *)
            IFS=$'\n'
            select branch in $branches; do
                IFS="$ifs"
                break;
            done
            ;;
    esac

	branch="${branch##* }"
    if [[ x"$branch" == x ]]; then
        echo "No branch" >&2
        return 3
    fi

    echo -n "Switch to '$branch'? [y/n]: "
    read -n1 ok
    echo
    case "$ok" in
        y)  ;;
        *)  return 4 ;;
    esac

    git checkout "$branch"
    return 0
}

git-ch "$@"
