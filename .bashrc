# Add custom binaries to $PATH
if [ -d "$HOME/bin" ]; then
    export PATH="$HOME/bin:$PATH";
fi

# Add composer to $PATH
if [ -d "$HOME/.composer/vendor/bin" ]; then
    export PATH="$HOME/.composer/vendor/bin:$PATH";
fi

# Ruby environment manager
which rbenv &> /dev/null
rbenv_exists=$?
if [ "$rbenv_exists" -eq 0 ]; then
    eval "$(rbenv init -)";
fi

