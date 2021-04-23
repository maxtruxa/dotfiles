# Include ~/.local/bin in $PATH.
if [[ -d "$HOME/.local/bin" ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# Add Go binary path to $PATH.
if [[ -d "$HOME/.local/share/go/bin" ]]; then
  export PATH="$HOME/.local/share/go/bin:$PATH"
fi

# Remove duplicates from $PATH.
typeset -U PATH
