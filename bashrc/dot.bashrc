. /etc/bash_completion.d/git-prompt
. /etc/bash_completion.d/git-completion.sh

export PS1='\[\033[01;32m\]\u@`/bin/hostname -f`\[\033[01;34m\] \w $(__git_ps1 "(%s)") \$\[\033[00m\] ';

export EDITOR=vim;

# GIT: disable (some of) the branch completion
export GIT_COMPLETION_CHECKOUT_NO_GUESS=1

#alias phpunit='phpunit --stop-on-failure'

export GOPATH=$HOME/gocode;
export PATH=$PATH:$GOPATH/bin:$HOME/.config/composer/vendor/bin:/opt/maven/bin;

export PHPCS=$HOME/projects/coding-standard/bin/phpcs
export PHPCBF=$HOME/projects/coding-standard/bin/phpcbf


if [[ -x "$PHPCS" ]]; then
    alias phpcs="$PHPCS"
fi
if [[ -x "$PHPCBF" ]]; then
    alias phpcbf="$PHPCBF"
fi

shopt -s checkwinsize


. ~/.bash_aliases


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
