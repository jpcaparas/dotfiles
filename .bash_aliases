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

    ret_git_status="$?"

    if [ ! "$ret_git_status" -eq 0 ]; then
        echo "Not a Git repository."
        return "$ret_git_status"
    fi

    default_author_name="jp"
    echo "Your name? (Default: $default_author_name)"
    read author_name
    author_name=${author_name:=$default_author_name}

    issue_summary=""
    while [ ${#issue_summary} -le 0 ]; do
        echo "Enter the issue summary:"
        read issue_summary
    done

    issue_key=""
    while [ ${#issue_key} -le 0 ]; do
        echo "Enter the issue key:"
        read issue_key
    done
    issue_key=$(echo $issue_key | awk '{print toupper($0)}')

    git checkout -b "$author_name-$issue_summary-$issue_key"
    
}

composer() {
    $(which php) -n -d memory_limit=-1 $(which composer) ${@}
}

cmp() {
    composer ${@}
}

dotf() {
    if [ -d "$HOME/Repos/jpcaparas/dotfiles" ]; then
        cd "$HOME/Repos/jpcaparas/dotfiles"
    fi
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

gulp() {
    if [ -f "$PWD/node_modules/.bin/gulp" ]; then
        "$PWD/node_modules/.bin/gulp" ${@}
    else
        echo "No local version of gulp installed."
        return 1
    fi
}

h() {
    $(which heroku)
}

jira() {
    app="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
    arg=${@}
    url="https://pixelfusion.atlassian.net"
    url_ticket="$url/browse"
    url_kanban="$url/projects"

    re='^[a-zA-Z]+-[0-9]+$'
	
    if [[ $arg =~ $re ]]; then
        ticket="$url_ticket/$arg"
    else
        ticket="$url_kanban/$arg"
    fi

    open -a ${app} ${ticket}
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
