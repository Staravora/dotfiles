# Enable colors and change prompt
autoload -U colors && colors
PS1="%{$fg[red]%}[%{$fg[white]%}%n%{$fg[red]%}@%{$fg[white]%}%m %{$fg[red]%}%~%{$fg[white]%}]%{$reset_color%}$ "

# History
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Open with a Fetch
  nitch

# Basic auto/tab completion
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)   # Include hidden files

# Load plugins
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Customize zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#ff3333"

# Custom aliases
alias ls='ls --color=auto'
alias ll='ls -la'
alias grep='grep --color=auto'

# Keybindings
bindkey "^[[3~" delete-char
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[5~" beginning-of-buffer-or-history
bindkey "^[[6~" end-of-buffer-or-history
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Custom vi mode
bindkey -v
export KEYTIMEOUT=1

# Custom colored man pages
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;31m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# Terminal title
autoload -Uz add-zsh-hook

function xterm_title_precmd () {
	print -Pn -- '\e]2;%n@%m %~\a'
	[[ "$TERM" == 'screen'* ]] && print -Pn -- '\e]0;%n@%m %~\a'
}

function xterm_title_preexec () {
	print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
	[[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e]0;%n@%m %~ %# ' && print -n -- "${(q)1}\a" }
}

if [[ "$TERM" == (alacritty*|gnome*|konsole*|putty*|rxvt*|screen*|tmux*|xterm*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi
