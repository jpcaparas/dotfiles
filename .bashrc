# Add custom binaries to $PATH
if [ -d "$HOME/bin" ]; then
    PATH=$HOME/bin:$PATH
fi

# Add composer to $PATH
if [ -d "$HOME/.composer/vendor/bin" ]; then
    PATH="$HOME/.composer/vendor/bin:$PATH"
fi

# Ruby environment manager
eval "$(rbenv init -)"
