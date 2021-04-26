# Source all *.zsh files in `zprofile.d`, honoring local overrides.
if [ -d "$ZDOTDIR/zprofile.d" ]; then
  for file ("$ZDOTDIR/zprofile.d"/*.zsh(N)); do
    local_override="$ZDOTDIR/zprofile.d/${file:t:r}.local.zsh"
    [[ -f "$local_override" ]] && file="$local_override"
    # Source all *.zsh files in `zlogout.d`, honoring local overrides.
    #echo "Sourcing $file..."
    source "$file"
  done
  unset file
  unset local_override
fi
