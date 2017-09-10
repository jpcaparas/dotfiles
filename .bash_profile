if [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
fi

if [ -f "$HOME/.bash_aliases" ]; then
    source "$HOME/.bash_aliases"
fi

if [ -d "$HOME/bash_completion" ]; then
    for f in "$HOME/bash_completion/*"; do
        source $f
    done
fi

