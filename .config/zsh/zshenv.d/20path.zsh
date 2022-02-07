# Include ~/.local/bin in $PATH.
if [[ -d "$HOME/.local/bin" ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# Add Cargo binary path to $PATH.
if [[ -d "$CARGO_HOME/bin" ]]; then
  export PATH="$CARGO_HOME/bin:$PATH"
fi

# Add Go binary path to $PATH.
if [[ -d "$GOPATH/bin" ]]; then
  export PATH="$GOPATH/bin:$PATH"
fi

# Remove duplicates from $PATH.
typeset -U PATH
