#!/bin/sh

alias flushdns="sudo killall -HUP mDNSResponder"
alias reloadcli="echo 'Re-sourcing bash profile'; source $HOME/.bash_profile"
alias today="echo `date +%Y-%m-%d` | pbcopy"
alias vi="$(which  vim)"

dirsize() {
    local target="${1:-*}"

    du -sh $target | sort -h
}

commit() {
    local comment;
    
    comment="${@}"

    while [ -z "$comment" ]; do
        echo -n "Leave a comment for this commit: ";
        read comment;
    done

    git commit -am "$comment"
}

dif() {
    local match=${1:-1}

    git diff $(git diff --name-only | sed -n "${match}p");
}

wip() {
    local has_changes=$(git status -s)

    if [[ -z $has_changes ]]; then echo "There are no changes to stash." && return 0; fi

    local comment;
    
    comment="${@}"

    while [ -z "$comment" ]; do
        echo -n "Leave a comment for this WIP: ";
        read comment;
    done

    git stash save --include-untracked "$comment"
}

pop() {
    git stash pop "${@}"
}

nah() {
    # unstage staged changes
    git reset --quiet HEAD .

    # undo unstaged changes
    git checkout .

    # discard any untracked files
    git clean -df
}

push() {
    git push "${@}"
}

sync() {
    git status &> /dev/null 

    local git_status="${?}"

    if [[ "$git_status" -ne 0 ]]; then
       printf "Not a git repository.\n"
       
       return 128
    fi

    local branch_name=${1:-development}
    local current_branch=$(git branch | grep \* | awk '{print $2}')

    if [[ $branch_name == $current_branch ]]; then
        printf "The target branch ($branch_name) is the same as the sync source branch ($current_branch).\n"
        printf "Pulling instead.\n"

        git pull

        return 0
    fi

    printf "Merging '$branch_name' into '$current_branch'\n"

    git fetch origin "$branch_name:$branch_name"
    git merge $branch_name
}

# Deletes stale Git branches
dsb() {
    echo "Deleting stale Git branches..."
    git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d
}

nah() {
    git reset --hard && git clean -df
}

psysh() {
    local_app="$PWD/vendor/bin/psysh"
    args="$@"

    if [ -f $local_app ]; then
        echo "Loading local version of PsySH."
        $local_app $args
    fi

    which psysh &> /dev/null
    psysh_exists="$?"

    if [ $psysh_exists -gt 0 ]; then
        echo "PsySH does not exist."
        return $psysh_exists
    fi

    echo "Loading global version of PsySH."
    $(which psysh) $args
}

today() {
    echo `date +%Y-%m-%d` | pbcopy
}

now() {
    echo `date +%Y-%m-%d-%H%.%M.%S` | pbcopy
}
