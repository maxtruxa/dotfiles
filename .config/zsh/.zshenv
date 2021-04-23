# Careful: .zshenv is sourced *every single time* zsh is started.

# Source all *.zsh files in `zshenv.d`, honoring local overrides.
for file ("$ZDOTDIR/zshenv.d"/*.zsh(N)); do
  local_override="$ZDOTDIR/zshenv.d/${file:t}.local.zsh"
  [[ -f "$local_override" ]] && file="$local_override"
  #echo "Sourcing $file..."
  source "$file"
done
unset file
unset local_override
