# Source all *.zsh files in `zlogin.d`, honoring local overrides.
if [ -d "$ZDOTDIR/zlogin.d" ]; then
  for file ("$ZDOTDIR/zlogin.d"/*.zsh(N)); do
    local_override="$ZDOTDIR/zlogin.d/${file:t:r}.local.zsh"
    [[ -f "$local_override" ]] && file="$local_override"
    #echo "Sourcing $file..."
    source "$file"
  done
  unset file
  unset local_override
fi
