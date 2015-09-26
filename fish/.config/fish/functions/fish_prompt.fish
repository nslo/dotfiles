function fish_prompt --description 'Write out the prompt'
    #Save the return status of the previous command
    set stat $status

# Don't need this anymore since fish 2.2.0 has it build in
function fish_vi_prompt_cm --description "Displays the current mode"
  switch $fish_bind_mode
    case default
      #set_color --bold --background red white
      set_color --bold red
      echo "[N]"
    case insert
      #set_color --bold --background green white
      set_color --bold 888
      echo "[I]"
    case visual
      #set_color --bold --background magenta white
      set_color --bold magenta
      echo "[V]"
  end
  set_color normal
end

function prompt_pwd --description 'Print the current working directory, NOT shortened to fit the prompt'
    printf "%s" (echo $PWD|sed -e 's|/private||' -e "s|^$HOME|~|")
end

# Just calculate these once, to save a few cycles when displaying the prompt
if not set -q __fish_prompt_hostname
    set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
end
if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
end

# Draw the prompt.
set_color yellow
echo -n -s '['(date "+%y/%m/%d %H:%M:%S")'] '
set_color -o blue
echo -n -s $USER '@' $__fish_prompt_hostname ' '
set_color -o green
echo -n -s (prompt_pwd) ' '
set_color 888
#echo -n -s '(' $stat ') '
#echo -n -s $__fish_prompt_normal
echo -n -s (__fish_git_prompt)
printf '\f\r'
#echo -n -s (fish_vi_prompt_cm) ' '
echo "-> "

end
