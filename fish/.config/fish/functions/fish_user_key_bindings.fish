# Get ctrl-f completion back in vi mode after fish 2.4
# See https://github.com/fish-shell/fish-shell/issues/3541#issuecomment-260001906

function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
end

