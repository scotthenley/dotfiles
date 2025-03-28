setopt prompt_subst
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# asdf completions
fpath=(${ASDF_DIR}/completions $fpath)

autoload bashcompinit && bashcompinit
autoload -Uz compinit
compinit
complete -C '/usr/local/bin/aws_completer' aws

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^w' autosuggest-execute
bindkey '^e' autosuggest-accept
bindkey '^u' autosuggest-toggle
bindkey '^L' vi-forward-word
bindkey '^k' up-line-or-search
bindkey '^j' down-line-or-search

eval "$(starship init zsh)"
export STARSHIP_CONFIG=~/.config/starship/starship.toml

# language
export LANG=en_US.UTF-8

# editor
export EDITOR=nvim
export VISUAL="$EDITOR"

alias la=tree
alias cat=bat

# Lazygit
alias lg='lazygit'

# Git
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gst="git status"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gco="git checkout"
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gcoall='git checkout -- .'
alias gr='git remote'
alias gre='git reset'

# Docker
alias dco="docker compose"
alias dps="docker ps"
alias dpa="docker ps -a"
alias dl="docker ps -l -q"
alias dx="docker exec -it"

# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# GO
#export GOPATH='$HOME/go'
export GOPRIVATE='github.com/AgencyPMG/*'

# VIM
alias v="nvim"
alias vim="nvim"
# Nmap
alias nm="nmap -sC -sV -oN nmap"

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/go/bin:$HOME/.cargo/bin"

alias cl='clear'

alias lzd='lazydocker'

# HTTP requests with xh
alias http="xh"

# VI Mode
bindkey jj vi-cmd-mode

# Eza
alias l="eza -l --icons --git -a"
alias lt="eza --tree --level=2 --long --icons --git"

# FZF
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH=/opt/homebrew/bin:$PATH

# node
export PATH="/opt/homebrew/opt/node@22/bin:$PATH"

# Postgres.app
export  PATH=/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH

alias mat='osascript -e "tell application \"System Events\" to key code 126 using {command down}" && tmux neww "cmatrix"'

function ranger {
	local IFS=$'\t\n'
	local tempfile="$(mktemp -t tmp.XXXXXX)"
	local ranger_cmd=(
		command
		ranger
		--cmd="map Q chain shell echo %d > "$tempfile"; quitall"
	)

	${ranger_cmd[@]} "$@"
	if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
		cd -- "$(cat "$tempfile")" || return
	fi
	command rm -f -- "$tempfile" 2>/dev/null
}
alias rr='ranger'

# navigation
cx() { cd "$@" && l; }
fcd() { cd "$(find . -type d -not -path '*/.*' | fzf)" && l; }
f() { echo "$(find . -type f -not -path '*/.*' | fzf)" | pbcopy }
fv() { nvim "$(find . -type f -not -path '*/.*' | fzf)" }

# ASDF
# ASDF_DATA_DIR="/home/scotthenley/.asdf"
# export PATH="$ASDF_DATA_DIR/shims:$PATH"

# envrc python 
alias mkpyrc='cat > .envrc << EOF
test -d .venv || uv venv --python \$(cat .python-version)
source .venv/bin/activate
EOF
chmod +x .envrc && echo ".envrc file created in $(pwd)"'

#uv venv
alias av="source .venv/bin/activate"

# direnv
eval "$(direnv hook zsh)"

# zoxide
eval "$(zoxide init zsh)"

# uv
export PATH="$HOME/.local/bin:$PATH"

eval "$(uv generate-shell-completion zsh)"

. "$HOME/.local/bin/env"

