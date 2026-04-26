# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="$HOME/.local/bin:$PATH"
export PS1='\[\e[0;90m\]\w \[\e[0m\]> '
export BASH_SILENCE_DEPRECATION_WARNING=1
export EDITOR="nvim"
export VISUAL="nvim"

# Aliases
alias ls='ls --color=auto'
alias nv='nvim'
alias ll='ls -lh'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
