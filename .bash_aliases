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

composer() {
    $(which php) -n -d memory_limit=-1 $(which composer) ${@}
}

cmp() {
    composer ${@}
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
    mkdir -p ${@} && cd ${@}
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