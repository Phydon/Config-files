if status is-interactive
    and not set -q TMUX
    exec tmux
end

set -g fish_greeting ""
# commented out --> use function 'fish_prompt.fish'
# fish_config prompt choose simple
fish_config theme choose 'Mono Smoke'

fish_add_path /usr/local/bin /usr/bin /bin /usr/local/games /usr/games
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.cargo/bin"
set -gx HELIX_RUNTIME /usr/lib/hx/runtime
set -gx VISUAL hx
set -gx EDITOR hx

alias ..="cd .."
alias :q="exit"
alias cat="bat --style=plain"
alias cls="clear"
alias fzf="fzf --height 50% --layout reverse --border"
alias gd="git diff"
alias gs="git status"
alias la="ls -lA --smart-group --time-style long-iso"
alias ll="ls -l --smart-group --time-style long-iso"
alias ls="eza"
alias py="python3"
alias start="open"

# Set up fzf key bindings
fzf --fish | source

# fzf always start from home directory 
set -x FZF_DEFAULT_COMMAND 'fd --hidden --no-ignore --absolute-path --search-path ~'
set -x FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

# fzf live preview: directories -> eza tree, files -> bat (first 200 lines)
# uses bat/eza directly because aliases are not available inside fzf's preview shell
set -g fzf_preview 'test -d {} && eza --tree --level=2 --color=always {} || bat --color=always --style=plain --line-range=:200 {}'
set -x FZF_CTRL_T_OPTS "--preview '$fzf_preview' --preview-window 'right,60%,wrap'"

# open a file from fzf in helix, with preview (does nothing if fzf is cancelled)
function hf
    set -l file (fzf --preview $fzf_preview --preview-window 'right,60%,wrap')
    and hx $file
end

# setting default permissions for files and directories
# for high security or work: 'umask 077' := permissions (file/dir): 600/700
# for standard or home use: 'umask 022' := permissions (file/dir): 644/755
# for collaboration: 'umask 002' := permissions (file/dir): 644/775
umask 022
