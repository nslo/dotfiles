# to be on the safe side
export EDITOR=vim

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# aliases
alias rpi="ssh -Y pi@192.168.1.110"
alias sshx='ssh -c arcfour,blowfish-cbc -XC' 

#PATH
export PATH=~/.cabal/bin:$PATH

# Plugins. Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

# git settings
source $ZSH/oh-my-zsh.sh

# fix autocorrection
unsetopt correct_all
setopt nocorrect_all

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall

# colors, keys, tetris
autoload -U colors && colors
autoload -U tetris
zle -N tetris
bindkey ^T tetris
bindkey "\e[1~" beginning-of-line # Home
bindkey "\e[4~" end-of-line # End
bindkey "\e[5~" beginning-of-history # PageUp
bindkey "\e[6~" end-of-history # PageDown
bindkey "\e[2~" quoted-insert # Ins
bindkey "\e[3~" delete-char # Del
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "\e[Z" reverse-menu-complete # Shift+Tab
# for rxvt
bindkey "\e[7~" beginning-of-line # Home
bindkey "\e[8~" end-of-line # End

# Colorized man pages in less
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

#####PROMPT#####
# show vi mode
vim_ins_mode="%{$fg[blue]%}[INSERT]%{$reset_color%}"
vim_cmd_mode="%{$fg[red]%}[COMMAND]%{$reset_color%}"
vim_mode=$vim_ins_mode

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
  vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

# multi-line prompt 
PROMPT='%{$reset_color%}
%{$reset_color%}
%{$fg[green]%}%n%{$fg_bold[yellow]%}@%{$reset_color%}%{$fg[green]%}%m %{$reset_color%} %{$fg[cyan]%}%D{[%I:%M:%S]} %{$fg_bold[yellow]%}%~ %{$reset_color%} $(git_prompt_info) 
%{$reset_color%}%{$fg[blue]%}->%{$fg_bold[blue]%} %#%{$reset_color%} '

RPROMPT='${vim_mode}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[magenta]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

#####END PROMPT#####
