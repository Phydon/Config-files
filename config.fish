if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias sf="~/Aliases/sf"
alias rep="~/Aliases/rep"
alias cat="bat"
alias ls="exa -h --long --icons --time-style=long-iso"
alias fd="fd -H"
alias du="dust"
alias ps="procs --sortd cpu"

function skrg
    command sk -e --preview "rg -i -p $argv {}"
end
