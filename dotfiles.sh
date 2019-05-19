#/bin/sh

DIR=$(dirname "$0")

# Load aliases
for f in ${DIR}/aliases/*.sh; do
    . $f
done

