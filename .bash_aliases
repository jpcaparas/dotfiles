alias copyssh="pbcopy < $HOME/.ssh/id_rsa.pub"
alias flushdns="sudo killall -HUP mDNSResponder"
alias now="echo $(date "+%Y-%m-%d-%H%.%M.%S") | pbcopy"
alias r="cd $HOME/Repos"
alias reloadcli="echo 'Re-sourcing bash profile'; source $HOME/.bash_profile"
alias today="echo `date +%Y-%m-%d` | pbcopy"
alias y="$(which yarn)"
alias cda="composer dump-autoload -o"
alias v="vagrant"
alias vu="v up"
alias vssh="v ssh"
alias vim="/usr/local/bin/vim"
alias vi="vim"

editaliases() {
    vi "$HOME/.bash_aliases"
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

    printf "Merging '$branch_name' into '$current_branch'\n"

    git fetch origin "$branch_name:$branch_name"

    git merge $branch_name
}

# Spawn a selenium server on local
selenium() {
    local port pids

    # Port to use. Defaults to 5555
    port="${1:-5555}"

    # Get pids to delete before spawning the selenium service
    pids=$(lsof -i "tcp:${port}" | grep 'LISTEN' | awk '{print $2}')

    if [ ! -z "$pids" ]; then
        printf "Killing existing processes that use port $port.\n"

        kill -9 $pids
    fi

    printf "Starting selenium server on port $port.\n"

    selenium-server -port $port
}

devmaster() {
    local link

    link="${1}"

    if [ -z $link ]; then
        echo "Enter a link!"

        return 1 
    fi

    echo "Hi @here, can I get a :approvamundo: dev->master :approvamundo: approval for this: $link" | pbcopy 
    echo "Copied to clipboard"

    return 0
}

_ssh() 
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=$(grep '^Host' ~/.ssh/config | grep -v '[?*]' | cut -d ' ' -f 2-)

    COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
    return 0
}
complete -F _ssh ssh


a() {
    app="$PWD/artisan"

    if [ ! -f ${app} ]; then
        echo "Not a Laravel project."
        return 1
    fi

    $(which php) ${app} ${@}
}

acc() {
    a clear-compiled ${@}
    cmp dump-autoload
}

acl() {
    file="${1:-$PWD}"

    ls -le $file
}

am() {
    a migrate ${@}
}

amr() {
    a migrate:refresh ${@}
}

arl() {
    a route:list ${@}
}

botman() {
    if [ -z "$(which botman)" ]; then
        echo "BotMan is not installed. Would you like to install it?"

        botman_install_pattern="^y(es)?$"
        read botman_install

        shopt -s nocasematch
        if [[ $botman_install =~ $botman_install_pattern ]]; then
            composer global require botman/installer
        else
            return 1
        fi
    fi

    $(which botman) ${@}
}

bot() {
    botman ${@}
}


branchout() {
    git status &> /dev/null

    ret_git_status=$?

    if [ ! $ret_git_status -eq 0 ]; then
        echo "Not a Git repository."
        return $ret_git_status
    fi

    echo ""

    default_start_branch="development"
    echo "Branch from? (Default: $default_start_branch)"
    read start_branch
    echo ""
    start_branch=${start_branch:=$default_start_branch}
    git rev-parse --verify $start_branch &> /dev/null
    ret_start_branch=$?

    if [ ! $ret_start_branch -eq 0 ]; then
        echo "Not a valid Git branch."
        return $ret_start_branch
    fi


    default_author_name="jc"
    echo "Your name? (Default: $default_author_name)"
    read author_name
    echo ""
    author_name=${author_name:=$default_author_name}

    issue_summary=""
    while [ ${#issue_summary} -le 0 ]; do
        echo "Enter the issue summary:"
        read issue_summary
        issue_summary="$(echo $issue_summary | sed -e 's/[^[:alnum:]]/-/g' | awk '{ print tolower($0) }')"
        echo ""
    done

    issue_key=""
    issue_key_pattern="[a-z]{3,}-[0-9]+"
    issue_key_pattern_match=false
    shopt -s nocasematch
    while [ $issue_key_pattern_match = false ]; do
        echo "Enter the issue key:"
        read issue_key
        echo ""
        if [[ $issue_key =~ $issue_key_pattern ]]; then
            issue_key_pattern_match=true
        fi
    done
    issue_key=$(echo $issue_key | awk '{print toupper($0)}')

    git checkout -b "$author_name-$issue_summary-$issue_key" "$start_branch"
    
}

changes() {
    git status ${@}
}

chrome() {
    /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome ${@}
}

cls() {
    clear ${@}
}

composer() {
    $(which php) -n -d memory_limit=-1 $(which composer) ${@}
}

cmp() {
    composer ${@}
}

d() {
    cd ~/Desktop ${@}
}

# Deletes stale Git branches
dsb() {
    echo "Deleting stale Git branches..."
    git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d
}

edit() {
    file="$1"
    app="TextEdit"

    if [ ! -f ${file} ]; then
        echo "$file is not a file."
        return 1
    fi

    /usr/bin/open -a ${app} ${file}
}


# "apply develop" on current branch
gad() {
    current_branch="$(git rev-parse --abbrev-ref HEAD)"
    dev_branch="development"
    repository="origin"

    $(which git) fetch --update-head-ok $repository $dev_branch:$current_branch
}

gb() {
    $(which git) branch ${@}
}

gc() {
    $(which git) checkout ${@}
}

gd() {
    $(which git) diff ${@}
}   

gp() {
    $(which git) push ${@}
}

gs() {
    $(which git) status ${@}
}

gulp() {
    if [ -f "$PWD/node_modules/.bin/gulp" ]; then
        "$PWD/node_modules/.bin/gulp" ${@}
    else
        echo "No local version of gulp installed."
        return 1
    fi
}

ll() {
    ls -la ${@}
}

mk() {
    dir="$1"

    if [ ! -d "$dir" ]; then
        pattern="^y(es)?$"

        echo "Directory '$dir' does not exist. Would you like to create it? (Y/N)"
        read createdir

        if [[ $createdir =~ $pattern ]]; then
            shopt -s nocasematch
            mkdir -p "$dir"
        else
            return 1
        fi
    fi

    cd "$dir"
}

nah() {
    git reset --hard && git clean -df
}

phpstorm() {
    path=${1}
    app="/Applications/PhpStorm.app"

    if [ -z ${loc} ] || [ ! -d ${path} ]; then
        path=${PWD}
    fi

    /usr/bin/open -a ${app} ${PWD}
}

phplinter() {
    linter="$PWD/bin/phpcs-fixer"

    if [ ! -f $linter ]; then
        echo "php-cs-fixer does not exist."
        return 1
    fi

	target_branch="${1:-development}"
	current_branch="${2:-$(git rev-parse --abbrev-ref HEAD)}"

	IFS=$'\n'
	changed_files="$(git diff --name-only $target_branch..$current_branch)"
	unset IFS

    $linter fix --config=.php_cs.dist -v --dry-run --using-cache=no --path-mode=intersection $changed_files
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


repo() {
    repo=${1}
    repo_path="$HOME/Repos/$repo"

    if [ ! -d ${repo_path} ]; then
        echo "Not a valid repo location."
        return 1
    fi

    echo "Switching to '$repo_path'..."
    echo ""

    cd ${repo_path}
}

t() {
    a tinker ${@}
}

today() {
    echo `date +%Y-%m-%d`
}

u() {
    app="$PWD/phpunit"

    if [ ! -f ${app} ]; then
        app="$PWD/vendor/bin/phpunit"
    fi


    $(which php) ${app} ${@}
}
