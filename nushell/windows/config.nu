# Nushell Config File

module completions {
  # Custom completions for external commands (those outside of Nushell)
  # Each completions has two parts: the form of the external command, including its flags and parameters
  # and a helper command that knows how to complete values for those flags and parameters
  #
  # This is a simplified version of completions for git branches and git remotes
  def "nu-complete git branches" [] {
    ^git branch | lines | each { |line| $line | str replace '[\*\+] ' '' | str trim }
  }

  def "nu-complete git remotes" [] {
    ^git remote | lines | each { |line| $line | str trim }
  }

  # Download objects and refs from another repository
  export extern "git fetch" [
    repository?: string@"nu-complete git remotes" # name of the branch to fetch
    --all                                         # Fetch all remotes
    --append(-a)                                  # Append ref names and object names to .git/FETCH_HEAD
    --atomic                                      # Use an atomic transaction to update local refs.
    --depth: int                                  # Limit fetching to n commits from the tip
    --deepen: int                                 # Limit fetching to n commits from the current shallow boundary
    --shallow-since: string                       # Deepen or shorten the history by date
    --shallow-exclude: string                     # Deepen or shorten the history by branch/tag
    --unshallow                                   # Fetch all available history
    --update-shallow                              # Update .git/shallow to accept new refs
    --negotiation-tip: string                     # Specify which commit/glob to report while fetching
    --negotiate-only                              # Do not fetch, only print common ancestors
    --dry-run                                     # Show what would be done
    --write-fetch-head                            # Write fetched refs in FETCH_HEAD (default)
    --no-write-fetch-head                         # Do not write FETCH_HEAD
    --force(-f)                                   # Always update the local branch
    --keep(-k)                                    # Keep dowloaded pack
    --multiple                                    # Allow several arguments to be specified
    --auto-maintenance                            # Run 'git maintenance run --auto' at the end (default)
    --no-auto-maintenance                         # Don't run 'git maintenance' at the end
    --auto-gc                                     # Run 'git maintenance run --auto' at the end (default)
    --no-auto-gc                                  # Don't run 'git maintenance' at the end
    --write-commit-graph                          # Write a commit-graph after fetching
    --no-write-commit-graph                       # Don't write a commit-graph after fetching
    --prefetch                                    # Place all refs into the refs/prefetch/ namespace
    --prune(-p)                                   # Remove obsolete remote-tracking references
    --prune-tags(-P)                              # Remove any local tags that do not exist on the remote
    --no-tags(-n)                                 # Disable automatic tag following
    --refmap: string                              # Use this refspec to map the refs to remote-tracking branches
    --tags(-t)                                    # Fetch all tags
    --recurse-submodules: string                  # Fetch new commits of populated submodules (yes/on-demand/no)
    --jobs(-j): int                               # Number of parallel children
    --no-recurse-submodules                       # Disable recursive fetching of submodules
    --set-upstream                                # Add upstream (tracking) reference
    --submodule-prefix: string                    # Prepend to paths printed in informative messages
    --upload-pack: string                         # Non-default path for remote command
    --quiet(-q)                                   # Silence internally used git commands
    --verbose(-v)                                 # Be verbose
    --progress                                    # Report progress on stderr
    --server-option(-o): string                   # Pass options for the server to handle
    --show-forced-updates                         # Check if a branch is force-updated
    --no-show-forced-updates                      # Don't check if a branch is force-updated
    -4                                            # Use IPv4 addresses, ignore IPv6 addresses
    -6                                            # Use IPv6 addresses, ignore IPv4 addresses
  ]

  # Check out git branches and files
  export extern "git checkout" [
    ...targets: string@"nu-complete git branches"   # name of the branch or files to checkout
    --conflict: string                              # conflict style (merge or diff3)
    --detach(-d)                                    # detach HEAD at named commit
    --force(-f)                                     # force checkout (throw away local modifications)
    --guess                                         # second guess 'git checkout <no-such-branch>' (default)
    --ignore-other-worktrees                        # do not check if another worktree is holding the given ref
    --ignore-skip-worktree-bits                     # do not limit pathspecs to sparse entries only
    --merge(-m)                                     # perform a 3-way merge with the new branch
    --orphan: string                                # new unparented branch
    --ours(-2)                                      # checkout our version for unmerged files
    --overlay                                       # use overlay mode (default)
    --overwrite-ignore                              # update ignored files (default)
    --patch(-p)                                     # select hunks interactively
    --pathspec-from-file: string                    # read pathspec from file
    --progress                                      # force progress reporting
    --quiet(-q)                                     # suppress progress reporting
    --recurse-submodules: string                    # control recursive updating of submodules
    --theirs(-3)                                    # checkout their version for unmerged files
    --track(-t)                                     # set upstream info for new branch
    -b: string                                      # create and checkout a new branch
    -B: string                                      # create/reset and checkout a branch
    -l                                              # create reflog for new branch
  ]

  # Push changes
  export extern "git push" [
    remote?: string@"nu-complete git remotes",      # the name of the remote
    ...refs: string@"nu-complete git branches"      # the branch / refspec
    --all                                           # push all refs
    --atomic                                        # request atomic transaction on remote side
    --delete(-d)                                    # delete refs
    --dry-run(-n)                                   # dry run
    --exec: string                                  # receive pack program
    --follow-tags                                   # push missing but relevant tags
    --force-with-lease: string                      # require old value of ref to be at this value
    --force(-f)                                     # force updates
    --ipv4(-4)                                      # use IPv4 addresses only
    --ipv6(-6)                                      # use IPv6 addresses only
    --mirror                                        # mirror all refs
    --no-verify                                     # bypass pre-push hook
    --porcelain                                     # machine-readable output
    --progress                                      # force progress reporting
    --prune                                         # prune locally removed refs
    --push-option(-o): string                       # option to transmit
    --quiet(-q)                                     # be more quiet
    --receive-pack: string                          # receive pack program
    --recurse-submodules: string                    # control recursive pushing of submodules
    --repo: string                                  # repository
    --set-upstream(-u)                              # set upstream for git pull/status
    --signed: string                                # GPG sign the push
    --tags                                          # push tags (can't be used with --all or --mirror)
    --thin                                          # use thin pack
    --verbose(-v)                                   # be more verbose
  ]
}

# Get just the extern definitions without the custom completion commands
use completions *

# for more information on themes see
# https://www.nushell.sh/book/coloring_and_theming.html
let default_theme = {
    # color for nushell primitives
    separator: white
    leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
    header: green_bold
    empty: white
    bool: light_red
    int: red
    filesize: light_yellow
    duration: yellow
    date: yellow_dimmed
    range: cyan_dimmed
    float: red
    string: light_green_dimmed
    nothing: white
    binary: purple
    cellpath: white
    row_index: green_bold
    record: cyan_dimmed
    list: cyan_dimmed
    block: blue_dimmed
    hints: dark_gray

    # shapes are used to change the cli syntax highlighting
    shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
    shape_binary: purple
    shape_bool: light_red
    shape_int: red
    shape_float: red
    shape_range: cyan_dimmed
    shape_internalcall: { fg: "#008080" attr: b }
    shape_external: { fg: "#194775" }
    shape_externalarg: { fg: "#6684a3" }
    shape_literal: blue
    shape_operator: yellow_dimmed
    shape_signature: green_bold
    shape_string: green_dimmed
    shape_string_interpolation: cyan_bold
    shape_datetime: yellow
    shape_list: cyan_dimmed
    shape_table: blue_dimmed
    shape_record: cyan_dimmed
    shape_block: blue_dimmed
    shape_filepath: blue_dimmed
    shape_globpattern: cyan
    shape_variable: purple
    shape_flag: blue
    shape_custom: green
    shape_nothing: light_cyan
}

let dark_theme = {
    # color for nushell primitives
    separator: white
    leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
    header: green_bold
    empty: blue
    bool: white
    int: white
    filesize: white
    duration: white
    date: white
    range: white
    float: white
    string: white
    nothing: white
    binary: white
    cellpath: white
    row_index: green_bold
    record: white
    list: white
    block: white
    hints: dark_gray

    # shapes are used to change the cli syntax highlighting
    shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
    shape_binary: purple_bold
    shape_bool: light_cyan
    shape_int: purple_bold
    shape_float: purple_bold
    shape_range: yellow_bold
    shape_internalcall: cyan_bold
    shape_external: cyan
    shape_externalarg: green_bold
    shape_literal: blue
    shape_operator: yellow
    shape_signature: green_bold
    shape_string: green
    shape_string_interpolation: cyan_bold
    shape_datetime: cyan_bold
    shape_list: cyan_bold
    shape_table: blue_bold
    shape_record: cyan_bold
    shape_block: blue_bold
    shape_filepath: cyan
    shape_globpattern: cyan_bold
    shape_variable: purple
    shape_flag: blue_bold
    shape_custom: green
    shape_nothing: light_cyan
}

let light_theme = {
    # color for nushell primitives
    separator: dark_gray
    leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
    header: green_bold
    empty: blue
    bool: dark_gray
    int: dark_gray
    filesize: dark_gray
    duration: dark_gray
    date: dark_gray
    range: dark_gray
    float: dark_gray
    string: dark_gray
    nothing: dark_gray
    binary: dark_gray
    cellpath: dark_gray
    row_index: green_bold
    record: white
    list: white
    block: white
    hints: dark_gray

    # shapes are used to change the cli syntax highlighting
    shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
    shape_binary: purple_bold
    shape_bool: light_cyan
    shape_int: purple_bold
    shape_float: purple_bold
    shape_range: yellow_bold
    shape_internalcall: cyan_bold
    shape_external: cyan
    shape_externalarg: green_bold
    shape_literal: blue
    shape_operator: yellow
    shape_signature: green_bold
    shape_string: green
    shape_string_interpolation: cyan_bold
    shape_datetime: cyan_bold
    shape_list: cyan_bold
    shape_table: blue_bold
    shape_record: cyan_bold
    shape_block: blue_bold
    shape_filepath: cyan
    shape_globpattern: cyan_bold
    shape_variable: purple
    shape_flag: blue_bold
    shape_custom: green
    shape_nothing: light_cyan
}

# Colors 
# signal colors:
    # shape_operator: { fg: "#fb7b42" }
    # shape_int: { fg: "#b93344" }
    # shape_float: { fg: "#b93344" }
	# https://www.schemecolor.com/apache-server-logo-colors.php
# ocean theme: 
	# https://www.schemecolor.com/ocean-gradient.php
	# https://www.schemecolor.com/endless-sea.php


let ocean_theme = {
    # color for nushell primitives
    separator: dark_gray
    leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
    header: { fg: "#48BF92" }
    empty: white
    bool: { fg: "#a22160" }
    # bool: { fg: "#4B8DA0" }
    int: { fg: "#b93344" }
    # int: { fg: "#4B8DA0" }
    filesize: { fg: "#4C74A6" }
    duration: { fg: "#4C74A6" }
    date: { fg: "#4E5BAD" }
    range: { fg: "#b93344" }
    # range: { fg: "#4B8DA0" }
    float: { fg: "#b93344" }
    # float: { fg: "#4B8DA0" }
    string: { fg: "#49A699" }
    # string: { fg: "#497a82" }
    nothing: white
    binary: { fg: "#9c1027" }
    # binary: dark_gray
    cellpath: dark_gray
    row_index: { fg: "#48BF92" }
    record: { fg: "#06a595" }
    list: { fg: "#06a595" }
    block: { fg: "#06a595" }
    hints: dark_gray

    # shapes are used to change the cli syntax highlighting
    shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
    shape_binary: { fg: "#9c1027" }
    shape_bool: { fg: "#a22160" }
    shape_int: { fg: "#b93344" }
    shape_float: { fg: "#b93344" }
    shape_range: { fg: "#731f46" }
    shape_internalcall: { fg: "#2952ac" attr: b }
    shape_external: { fg: "#194775" attr: b }
    shape_externalarg: { fg: "#6684a3" }
    shape_literal: { fg: "#1692c4" }
    shape_operator: { fg: "#731f46" }
    shape_signature: { fg: "#1692c4" }
	shape_string : { fg: "#007089" }
    shape_string_interpolation: { fg: "#1692c4" }
    shape_datetime: { fg: "#8F670B" }
    shape_list: { fg: "#06a595" }
    shape_table: { fg: "#06a595" }
    shape_record: { fg: "#06a595" }
    shape_block: { fg: "#06a595" }
    shape_filepath: { fg: "#1692c4" }
    shape_globpattern: { fg: "#1692c4" }
    shape_variable: { fg: "#236fc5" }
    shape_flag: { fg: "#137087" }
    shape_custom: { fg: "#1692c4" }
    shape_nothing: white
}

# minimal theme
let steel1      = "#5E6C85"
let steel2      = "#6F7D95"
let steel3      = "#808EA5"
let steel4      = "#909FB6"
let steel5      = "#A1B0C6"
let steel6      = "#B2C1D6"
let rred        = "#d32c5d"
let lred        = "#dc597f"
let dgrey       = "#565B61" 
let violetred   = "#8b2252"

let minimal_theme = {
    # color for nushell primitives
    separator: dgrey
    leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
    header: { fg: $violetred}
    empty: steel6
    bool: { fg: $steel4 }
    int: { fg: $steel5 }
    filesize: { fg: $steel5 }
    duration: { fg: $steel5 }
    date: { fg: $steel5 }
    range: { fg: $steel5 }
    float: { fg: $steel5 }
    string: { fg: $steel6 }
    nothing: steel6
    binary: { fg: $steel5 }
    cellpath: dgrey
    row_index: { fg: $steel1 }
    record: { fg: $steel3 }
    list: { fg: $steel3 }
    block: { fg: $steel3 }
    hints: dgrey

    # shapes are used to change the cli syntax highlighting
    shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
    shape_binary: { fg: $steel5 }
    shape_bool: { fg: $steel4 }
    shape_int: { fg: $steel5 }
    shape_float: { fg: $steel5 }
    shape_range: { fg: $steel5 }
    shape_internalcall: { fg: $rred attr: b }
    shape_external: { fg: $lred attr: b }
    shape_externalarg: { fg: $steel4 }
    shape_literal: { fg: $steel4 }
    shape_operator: { fg: $steel6 }
    shape_signature: { fg: $steel6 }
	shape_string : { fg: $steel6 }
    shape_string_interpolation: { fg: $steel6 }
    shape_datetime: { fg: $steel5 }
    shape_list: { fg: $steel3 }
    shape_table: { fg: $steel3 }
    shape_record: { fg: $steel3 }
    shape_block: { fg: $steel3 }
    shape_filepath: { fg: $steel3 }
    shape_globpattern: { fg: $steel4 }
    shape_variable: { fg: $steel2 }
    shape_flag: { fg: $steel1 }
    shape_custom: { fg: $rred }
    shape_nothing: white
}

# The default config record. This is where much of your global configuration is setup.
let-env config = {
  show_banner: false
  filesize_metric: false
  table_mode: light # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
  use_ls_colors: false
  rm_always_trash: true
  color_config: $minimal_theme # $default_theme, $dark_theme, $light_theme, $ocean_theme, $minimal_theme
  use_grid_icons: true
  footer_mode: "25" # always, never, number_of_rows, auto
  quick_completions: true  # set this to false to prevent auto-selecting completions when only one remains
  partial_completions: true  # set this to false to prevent partial filling of the prompt
  completion_algorithm: "prefix"  # prefix, fuzzy
  float_precision: 2
  buffer_editor: "helix" # command that will be used to edit the current line buffer with ctrl+o, if unset fallback to $env.EDITOR and $env.VISUAL
  use_ansi_coloring: true
  filesize_format: "auto" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, zb, zib, auto
  edit_mode: vi # emacs, vi
  max_history_size: 20000 # Session has to be reloaded for this to take effect
  sync_history_on_enter: true # Enable to share the history between multiple sessions, else you have to close the session to persist history to file
  history_file_format: "plaintext" # "sqlite" or "plaintext"
  shell_integration: true # enables terminal markers and a workaround to arrow keys stop working issue
  disable_table_indexes: false # set to true to remove the index column from tables
  cd_with_abbreviations: false # set to true to allow you to do things like cd s/o/f and nushell expand it to cd some/other/folder
  case_sensitive_completions: false # set to true to enable case-sensitive completions
  max_external_completion_results: 100 # setting it lower can improve completion performance at the cost of omitting some options

  # A strategy of managing table view in case of limited space 
  table_trim: {
	  methodology: wrapping, # wrapping, truncating
	  wrapping_try_keep_words: true, # A strategy which will be used by 'wrapping' methodology
	  # truncating_suffix: "..." # A suffix which will be used with 'truncating' methodology
  }

  hooks: {
    pre_prompt: [{
      $nothing  # replace with source code to run before the prompt is shown
    }]
    pre_execution: [{
      $nothing  # replace with source code to run before the repl input is run
    }]
    env_change: {
      PWD: [{|before, after|
        $nothing  # replace with source code to run if the PWD environment is different since the last repl input
      }]
    }
  }

  menus: [
      # Configuration for default nushell menus
      # Note the lack of souce parameter
      {
        name: completion_menu
        only_buffer_difference: false
        marker: "| "
        type: {
            layout: columnar
            columns: 4
            col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
            col_padding: 2
        }
        style: {
            text: { fg: $steel6 }
            selected_text: { fg: "#b93344" }
            description_text: { fg: $steel6 } 
        }
      }
      {
        name: history_menu
        only_buffer_difference: true
        marker: "? "
        type: {
            layout: list
            page_size: 25
        }
        style: {
            text: { fg: $steel6 }
            selected_text: { fg: "#b93344" }
            description_text: { fg: $steel6 } 
        }
      }
      {
        name: help_menu
        only_buffer_difference: true
        marker: "? "
        type: {
            layout: description
            columns: 4
            col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
            col_padding: 2
            selection_rows: 4
            description_rows: 10
        }
        style: {
            text: { fg: $steel6 }
            selected_text: { fg: "#b93344" }
            description_text: { fg: $steel6 } 
        }
      }
      # Example of extra menus created using a nushell source
      # Use the source field to create a list of records that populates
      # the menu
      {
        name: commands_menu
        only_buffer_difference: false
        marker: "# "
        type: {
            layout: columnar
            columns: 4
            col_width: 20
            col_padding: 2
        }
        style: {
            text: { fg: $steel6 }
            selected_text: { fg: "#b93344" }
            description_text: { fg: $steel6 } 
        }
        source: { |buffer, position|
            $nu.scope.commands
            | where command =~ $buffer
            | each { |it| {value: $it.command description: $it.usage} }
        }
      }
      {
        name: vars_menu
        only_buffer_difference: true
        marker: "# "
        type: {
            layout: list
            page_size: 20
        }
        style: {
            text: { fg: $steel6 }
            selected_text: { fg: "#b93344" }
            description_text: { fg: $steel6 } 
        }
        source: { |buffer, position|
            $nu.scope.vars
            | where name =~ $buffer
            | sort-by name
            | each { |it| {value: $it.name description: $it.type} }
        }
      }
      {
        name: commands_with_description
        only_buffer_difference: true
        marker: "# "
        type: {
            layout: description
            columns: 4
            col_width: 20
            col_padding: 2
            selection_rows: 4
            description_rows: 10
        }
        style: {
            text: { fg: $steel6 }
            selected_text: { fg: "#b93344" }
            description_text: { fg: $steel6 } 
        }
        source: { |buffer, position|
            $nu.scope.commands
            | where command =~ $buffer
            | each { |it| {value: $it.command description: $it.usage} }
        }
      }
  ]
  keybindings: [
    {
      name: completion_menu
      modifier: none
      keycode: tab
      mode: vi_normal # Options: emacs vi_normal vi_insert
      event: {
        until: [
          { send: menu name: completion_menu }
          { send: menunext }
        ]
      }
    }
    {
      name: completion_previous
      modifier: shift
      keycode: backtab
      mode: [emacs, vi_normal, vi_insert] # Note: You can add the same keybinding to all modes by using a list
      event: { send: menuprevious }
    }
    {
      name: history_menu
      modifier: control
      keycode: char_r
      mode: emacs
      event: { send: menu name: history_menu }
    }
    {
      name: next_page
      modifier: control
      keycode: char_x
      mode: emacs
      event: { send: menupagenext }
    }
    {
      name: undo_or_previous_page
      modifier: control
      keycode: char_z
      mode: emacs
      event: {
        until: [
          { send: menupageprevious }
          { edit: undo }
        ]
       }
    }
    {
      name: yank
      modifier: control
      keycode: char_y
      mode: emacs
      event: {
        until: [
          {edit: pastecutbufferafter}
        ]
      }
    }
    {
      name: unix-line-discard
      modifier: control
      keycode: char_u
      mode: [emacs, vi_normal, vi_insert]
      event: {
        until: [
          {edit: cutfromlinestart}
        ]
      }
    }
    {
      name: kill-line
      modifier: control
      keycode: char_k
      mode: [emacs, vi_normal, vi_insert]
      event: {
        until: [
          {edit: cuttolineend}
        ]
      }
    }
    # Keybindings used to trigger the user defined menus
    {
      name: commands_menu
      modifier: control
      keycode: char_t
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: commands_menu }
    }
    {
      name: vars_menu
      modifier: alt
      keycode: char_o
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: vars_menu }
    }
    {
      name: commands_with_description
      modifier: control
      keycode: char_s
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: commands_with_description }
    }
  ]
}


# STARSHIP PROMPT
source ~/.cache/starship/init.nu


# ZOXIDE
source ~/.zoxide.nu


# import init.nu
use ~/Appdata/Roaming/nushell/init.nu *


# ENVIRONMENT VARIABLES
# -- WINDOWS --
# set path to init.nu -> available via "$env.init-path"
let-env init-path = "~/AppData/Roaming/nushell/init.nu"
# path to nvim`s init.vim
let-env nvim-path = "~/AppData/Local/nvim/init.vim"
# path to vim`s vimrc
let-env vim-path = "C:/Program Files (x86)/Vim/_vimrc"
# -- LINUX --
# # set path to init.nu -> available via "$env.init-path"
# let-env init-path = ""
# # path to nvim`s init.vim
# let-env nvim-path = ""
# # path to vim`s vimrc
# let-env vim-path = ""


# ALIASES
# if ((getos) == Windows) {
alias sf = C:\Aliases\Programs\sf.exe
alias fd = C:\Aliases\Programs\fd.exe
alias fzf = C:\Aliases\Programs\fzf.exe --preview 'C:\Aliases\Programs\bat.exe --style=numbers --color=always --line-range :500 {}'
alias cat = C:\Aliases\Programs\bat.exe --theme "Sublime Snazzy" --style=numbers --color=always
alias rg = C:\Aliases\Programs\rg.exe --stats --no-messages --with-filename
alias gs = git status
alias ga = git all
alias cal = cal --week-start monday --month-names --year
alias diff = C:\Aliases\Programs\delta.exe
alias cd = z
alias cdi  = zi
alias mv = mv --verbose
alias cp = cp --verbose
alias rm = rm --verbose
alias mkdir = mkdir -s
alias bkp = backup
alias tldr = tldr --pager
# } else {
# alias sf = ~/Aliases/sf
# alias fzf = fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'
# alias cat = bat --theme "Sublime Snazzy" --style=numbers --color=always
# alias rg = rg --stats --no-messages --with-filename
# alias gs = git status
# alias ga = git all
# alias cal = cal --week-start monday --month-names --year
# alias diff = delta
# alias cd = z
# alias cdi  = zi
# alias sk = sk --preview 'bat --style=numbers --color=always --line-range :500 {}'
# alias rep = ~/Aliases/rep
# alias mv = mv --verbose
# alias cp = cp --verbose
# alias rm = rm --verbose
# alias mkdir = mkdir -s
# alias du = dust
# alias ps = procs --sortd cpu
# alias bkp = backup
# alias tldr = tldr --pager
# }
