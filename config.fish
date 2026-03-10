if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g fish_greeting ""

fish_add_path /usr/local/bin /usr/bin /bin /usr/local/games /usr/games
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.cargo/bin"
set -gx HELIX_RUNTIME /usr/lib/hx/runtime
set -gx EDITOR hx

alias ..="cd .."
alias :q="exit"
alias ls="eza"
alias ll="ls -l --smart-group --time-style long-iso"
alias la="ls -lA --smart-group --time-style long-iso"
alias py="python3"
alias cat="bat --theme=zenburn --style=plain"
alias gs="git status"
alias gd="git diff"
alias hf="hx (fzf)"

# ZELLIJ AUTOSTART
if set -q ZELLIJ
else
    zellij
end
