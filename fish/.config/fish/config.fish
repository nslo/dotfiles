alias vim "nvim"
alias pacaur "env PACMAN=pacman pacaur"
set -x EDITOR vim
set -x BROWSER firefox
set -x PACMAN pacmatic
set -x XDG_CONFIG_HOME $HOME/.config

set -x PATH $PATH ~/.cabal/bin /usr/bin/core_perl

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
