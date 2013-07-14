# to be on the safe side
export EDITOR=vim

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# aliases
alias rpi="ssh -Y pi@192.168.1.110"

#PATH
#echo PATH=~/.cabal/bin:$PATH

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
zstyle :compinstall filename '/home/fibonacci/.zshrc'
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


#PROMPT
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

# old left prompt without oh-my-zsh
#PROMPT="%{$fg[yellow]%}%B%n@%m>%b $(git_prompt_info)\ %{$reset_color%}"

# multi-line prompt 
PROMPT='%{$reset_color%}
%{$reset_color%}
%{$fg[green]%}%n%{$fg_bold[yellow]%}@%{$reset_color%}%{$fg[green]%}%m %{$reset_color%} %{$fg[cyan]%}%D{[%I:%M:%S]} %{$fg_bold[yellow]%}%~ %{$reset_color%} $(git_prompt_info) 
%{$reset_color%}%{$fg[blue]%}->%{$fg_bold[blue]%} %#%{$reset_color%} '

# single line version
#PROMPT='%{$fg_bold[yellow]%}%n%{$fg[magenta]%}@%{$fg_bold[yellow]%}%m %{$reset_color%} %{$fg[cyan]%}%D{[%I:%M:%S]} $(git_prompt_info) \
#%{$reset_color%}%{$fg[blue]%}->%{$fg_bold[blue]%} %#%{$reset_color%} '

#RPROMPT="%{$fg[red]%}%B%~%b"
RPROMPT='${vim_mode}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[magenta]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

#%{$FG[237]%}------------------------------------------------------------%{$reset_color%}

#END PROMPT
