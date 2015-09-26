# The fish_mode_prompt function is prepended to the prompt
function fish_mode_prompt --description "Displays the current mode"
  # Do nothing if not in vi mode
  if set -q __fish_vi_mode
    switch $fish_bind_mode
      case default
        #set_color --bold --background red white
        set_color --bold red
        echo '[N]'
      case insert
        #set_color --bold --background green white
        set_color --bold 888
        echo '[I]'
      case visual
        #set_color --bold --background magenta white
        set_color --bold magenta
        echo '[V]'
    end
    set_color normal
    echo -n ' '
  end
end
