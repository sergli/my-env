#!/bin/bash

alias branch='basename $(git symbolic-ref HEAD)'
alias pull='GIT_TRACE=2 GIT_SSH=~/ssh git pull origin $(branch)'
alias push='GIT_TRACE=2 GIT_SSH=~/ssh git push origin $(branch)'
alias plush='GIT_TRACE=2 GIT_SSH=~/ssh git pull --no-edit origin $(branch) && push'
alias a='git add'
alias s='git status'
alias d='git diff'

alias phpcf-apply-git="git status --porcelain | awk '/M / {print \$2}' | xargs -n1 phpcf apply-git"
alias ls='ls --color=auto'
#alias mysql='rlwrap -a mysql'
alias psysh='rlwrap -a psysh'

function fmt()
{
	for file in "$@"; do
		xmllint --format "$file" --output "$file"
	done
}

function title_new() {
	echo -ne '\033]0;'
	echo -ne "$@"
	echo -ne '\007'
}

function p() 
{
    local testFile="$1"
    local testMethod="$2"
    local testDataset="$3"
    local testFilter=""
    local example="$FUNCNAME $HOME/badoo/Unit/_packages/ScreenStory/WizardTest.php testCheckRegistrationStatus fully_reg"
    local PHPUNIT=$(which phpunit)

    declare -a phpUnitArguments=('--stop-on-failure' '--filter')

    [[ "x$PHPUNIT" == x ]] && { echo "phpunit not found" 1>&2; return 1; }
    [[ "x$testFile" == x ]] && { echo "Example: $example" 1>&2; return 1; }

    if [[ "x$testMethod" != x ]]; then
        testMethod="${testMethod#test}"
        testMethod="test${testMethod~}"
    fi

    if [[ "x$testMethod" == x ]]; then
        echo "Run: $PHPUNIT --stop-on-failure "$testFile""
        $PHPUNIT --stop-on-failure "$testFile"
        return 0;
    fi

    if [[ "x$testDataset" == "x" ]]; then
        testFilter="/${testMethod}/"
    else 
        testFilter="/${testMethod}.* with data set .*${testDataset}/"
    fi

    phpUnitArguments=("${phpUnitArguments[@]}" "$testFilter" "$testFile")

    echo "Run: $PHPUNIT ${phpUnitArguments[*]}"
    $PHPUNIT "${phpUnitArguments[@]}"

    return 0
}

