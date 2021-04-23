# Source all *.zsh files in `zshrc.d`, honoring local overrides.
for file ("$ZDOTDIR/zshrc.d"/*.zsh(N)); do
  local_override="$ZDOTDIR/zshrc.d/${file:t:r}.local.zsh"
  [[ -f "$local_override" ]] && file="$local_override"
  #echo "Sourcing $file..."
  source "$file"
done
unset file
unset local_override
