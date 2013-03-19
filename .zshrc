export EDITOR=vim
#alias ls="ls --color=always"



# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh


# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="juanghurtado" #check this out for more git info
#ZSH_THEME="pygmalion" #decent colors

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
#COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

# git settings
source $ZSH/oh-my-zsh.sh


unsetopt correct_all
setopt nocorrect_all
# Customize to your needs...



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
