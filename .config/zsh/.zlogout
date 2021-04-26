# Source all *.zsh files in `zlogout.d`, honoring local overrides.
if [ -d "$ZDOTDIR/zlogout.d" ]; then
  for file ("$ZDOTDIR/zlogout.d"/*.zsh(N)); do
    local_override="$ZDOTDIR/zlogout.d/${file:t:r}.local.zsh"
    [[ -f "$local_override" ]] && file="$local_override"
    #echo "Sourcing $file..."
    source "$file"
  done
  unset file
  unset local_override
fi
