#!/bin/sh
# k9s ignores XDG_CONFIG_HOME on macOS and only reads Application Support,
# so point that path at the config this repo actually manages.
[ "$(uname)" = "Darwin" ] || exit 0

target="$HOME/.config/k9s"
link="$HOME/Library/Application Support/k9s"

[ -d "$target" ] || exit 0
[ "$(readlink "$link" 2>/dev/null)" = "$target" ] && exit 0

if [ -e "$link" ] && [ ! -L "$link" ]; then
    mv "$link" "$link.bak.$(date +%Y%m%d-%H%M%S)"
fi
rm -f "$link"
ln -s "$target" "$link"
