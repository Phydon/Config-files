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
	command fortune | cowsay -f $(exa ~/Documents/cows/|shuf -n 1) | lolcat
end


alias sf="~/Aliases/sf"
alias rep="~/Aliases/rep"
alias cat="bat"
alias mv="mv -i"
alias rm="rm -i"
alias gs="git status"
alias ls="exa -h --long --icons --time-style=long-iso"
alias fd="fd -H"
alias du="dust"
alias ps="procs --sortd cpu"

function skrg
    command sk -e --preview "rg -i -p $argv {}"
end


starship init fish | source
