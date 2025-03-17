# Z shell initialization.
# https://github.com/owl4ce/dotfiles

# GENERAL
# ---
# System path.
export PATH="${HOME}/.cargo/bin:${HOME}/.local/bin:${PATH}"

# (OH-MY-)ZSH
# ---
# Installation directory path.
export ZSH="${HOME}/.oh-my-zsh"
# Theme to load.
#ZSH_THEME='ar-round'
# Highlight styling for zsh-autosuggestions.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS='true'
# Disable marking untracked files under VCS as dirty.
DISABLE_UNTRACKED_FILES_DIRTY='true'
# Disable automatic updates.
zstyle ':omz:update' mode disabled
# Plugins to load.
plugins=(bgnotify zsh-autosuggestions zsh-completions fast-syntax-highlighting)
# Always append history.
setopt INC_APPEND_HISTORY
# Execute OMZ.
source "${ZSH}/oh-my-zsh.sh"
# Speeds up pasting when using zsh-autosuggestions.
# See "https://github.com/zsh-users/zsh-autosuggestions/issues/238".
paste_init()
{
    OLD_SELF_INSERT="${${(s.:.)widgets[self-insert]}[2,3]}"
    zle -N self-insert url-quote-magic # I wonder if you'd need ".url-quote-magic"?
}
paste_done()
{
    zle -N self-insert "$OLD_SELF_INSERT"
}
zstyle :bracketed-paste-magic paste-init paste_init
zstyle :bracketed-paste-magic paste-finish paste_done

# Starship prompt
export STARSHIP_CONFIG=~/.oh-my-zsh/custom/themes/.starship.toml
eval "$(starship init zsh)"

# ALIASES
# ---
# Ping aliases.
alias ping_google='ping 8.8.8.8'
alias ping_cloudflare='ping 1.1.1.1'

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion"

# Git shortcut
function lazygit() {
  #Check Branch
  current_branch=$(git branch --show-current)
  echo "Currently on branch: $current_branch"
  
  #Optionally allow branch switching
  if [ ! -z "$2" ]; then
    echo "Switching to branch: $2"
    git checkout "$2"
  fi

  # add, commit, and push
  git add .
  git commit -a -m "$1"
  git push
}
