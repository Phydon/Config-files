if status is-interactive
    # Commands to run in interactive sessions can go here
end


# function fish_greeting
# 	echo ...
# 	echo ">>" (set_color yellow) AYY AYY CAPTAIN (set_color normal)
# 	echo ..
# 	echo The time is (set_color red; date +%T; set_color normal) and this machine is called (set_color blue) $hostname
# 	echo .
# end

function fish_greeting
	command figlet WELCOME | lolcat
	command fortune | cowsay -f $(exa ~/Documents/cows/|shuf -n 1)
end


# ALIASES
alias sf="~/Aliases/sf"
alias rep="~/Aliases/rep"
alias cat="bat"
alias mv="mv -i"
alias cp="cp -i"
alias rm="rm -i"
alias gs="git status"
alias ls="exa -h --long --icons --time-style=long-iso"
alias fd="fd -H"
alias du="dust"
alias ps="procs --sortd cpu"

# SKIM and RIPGREP
function skrg
    command sk -e --preview "rg -i -p $argv {}"
end


# STARSHIP
starship init fish | source


# MCFLY
mcfly init fish | source
# vim keybindings
set -gx MCFLY_KEY_SCHEME vim
# fuzzy search
# set -gx MCFLY_FUZZY 2
# results count (default = 10)
set -gx MCFLY_RESULTS 30
# interface view default: TOP. Available options: TOP and BOTTOM
set -gx MCFLY_INTERFACE_VIEW BOTTOM
# disable menu interface
# set -gx MCFLY_DISABLE_MENU TRUE
# history limit if slow start up
# set -gx MCFLY_HISTORY_LIMIT 10000
