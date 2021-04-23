# Make zsh look in the user's config directory instead of $HOME.
[[ -z "$ZDOTDIR" ]] && export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

# Source the .zshenv from the config directory as well.
[[ -f "$ZDOTDIR/.zshenv" ]] && source "$ZDOTDIR/.zshenv"
