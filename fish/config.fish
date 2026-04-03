if status is-interactive
    and not set -q TMUX
    exec tmux
end

set -g fish_greeting ""

fish_add_path /usr/local/bin /usr/bin /bin /usr/local/games /usr/games
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.cargo/bin"
set -gx HELIX_RUNTIME /usr/lib/hx/runtime
set -gx EDITOR hx

alias ..="cd .."
alias :q="exit"
alias cls="clear"
alias ls="eza"
alias ll="ls -l --smart-group --time-style long-iso"
alias la="ls -lA --smart-group --time-style long-iso"
alias py="python3"
alias cat="bat --style=plain"
alias gs="git status"
alias gd="git diff"
alias fzf="fzf --height 50% --layout reverse --border"
alias hf="hx (fzf)"
alias up="sudo apt update && sudo apt upgrade -y"

# # zellij autostart
# if set -q ZELLIJ
# else
#     zellij
# end

# Set up fzf key bindings
fzf --fish | source

# fzf always start from home directory 
set -x FZF_DEFAULT_COMMAND 'fd --hidden --no-ignore --absolute-path --search-path ~'
set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

# setting default permissions for files and directories
# for high security or work: 'umask 077' := permissions (file/dir): 600/700
# for standard or home use: 'umask 022' := permissions (file/dir): 644/755
# for collaboration: 'umask 002' := permissions (file/dir): 644/775
umask 022
