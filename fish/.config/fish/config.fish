# LANG doesn't get set properly if fish is default shell
if status -l; and test -r /etc/locale.conf
    while read -l kv
        set -gx (string split "=" -- $kv)
    end </etc/locale.conf
end

alias vim "nvim"
alias pacaur "env PACMAN=pacman pacaur"
alias vpn "/opt/cisco/anyconnect/bin/vpn"
set -x EDITOR vim
set -x TERMCMD urxvt
set -x BROWSER firefox
set -x PACMAN pacmatic
set -x XDG_CONFIG_HOME $HOME/.config

set -x PATH $PATH ~/.local/bin /usr/bin/core_perl
#set -x PATH $PATH /usr/bin/core_perl

#fish_vi_mode
fish_vi_key_bindings

# fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_show_informative_status 1
set __fish_git_prompt_showupstream 'informative'

# Status Chars
set __fish_git_prompt_char_dirtystate '+'
set __fish_git_prompt_char_stagedstate '>'
set __fish_git_prompt_char_stashstate '<'
set __fish_git_prompt_char_upstream_ahead '^'
set __fish_git_prompt_char_upstream_behind '_'
set __fish_git_prompt_char_untrackedfiles '*'
