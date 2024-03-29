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

# import custom themes
use ~/Appdata/Roaming/nushell/themes/themes.nu *
use ~/Appdata/Roaming/nushell/themes/catppucin-mocha.nu *
use ~/Appdata/Roaming/nushell/themes/gooey.nu *
use ~/Appdata/Roaming/nushell/themes/greyscale-dark.nu *
use ~/Appdata/Roaming/nushell/themes/gruvbit.nu *
use ~/Appdata/Roaming/nushell/themes/heetch.nu *
use ~/Appdata/Roaming/nushell/themes/substrata.nu *

# for menu and completion selection 
let selection = "#290019" 
let highlight = "#ff2e5f" 
let description = "#61586f"

# The default config record. This is where much of your global configuration is setup.
$env.config = {
  show_banner: false
  color_config: (heetch) # $default_theme, $dark_theme, $light_theme, $ocean_theme, $minimal_theme, env.lavendel, or imported themes (catppucin-mocha, heetch, etc.)
  use_grid_icons: true
  footer_mode: "25" # always, never, number_of_rows, auto
  float_precision: 2
  buffer_editor: "helix" # command that will be used to edit the current line buffer with ctrl+o, if unset fallback to $env.EDITOR and $env.VISUAL
  use_ansi_coloring: true
  edit_mode: vi # emacs, vi
  shell_integration: true # enables terminal markers and a workaround to arrow keys stop working issue
  render_right_prompt_on_last_line: false # true or false to enable or disable right prompt to be rendered on last line of the prompt.

  ls: {
      use_ls_colors: true # use the LS_COLORS environment variable to colorize output
      clickable_links: false # enable or disable clickable links. Your terminal has to support links.
    }
  rm: {
    always_trash: true # always act as if -t was given. Can be overridden with -p
  }
  table: {
    mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
    index_mode: always # "always" show indexes, "never" show indexes, "auto" = show indexes when a table has "index" column
    show_empty: true # show 'empty list' and 'empty record' placeholders for command output
    trim: {
      methodology: wrapping # wrapping or truncating
      wrapping_try_keep_words: true # A strategy used by the 'wrapping' methodology
      truncating_suffix: "..." # A suffix used by the 'truncating' methodology
    }
    header_on_separator: false # show header text on separator/border line
  }
  datetime_format: {
          # normal: '%a, %d %b %Y %H:%M:%S %z'    # shows up in displays of variables or other datetime's outside of tables
          table: '%d.%m.%y %I:%M:%S%p'          # generally shows up in tabular outputs such as ls. commenting this out will change it to the default human readable datetime format
      }
  explore: {
          status_bar_background: {fg: "#1D1F21", bg: "#C4C9C6"},
          command_bar_text: {fg: "#C4C9C6"},
          highlight: {fg: "black", bg: "yellow"},
          status: {
              error: {fg: "white", bg: "red"},
              warn: {}
              info: {}
          },
          table: {
              split_line: {fg: "#404040"},
              selected_cell: {bg: light_blue},
              selected_row: {},
              selected_column: {},
          },
      }
  history: {
    max_size: 100000 # Session has to be reloaded for this to take effect
    sync_on_enter: true # Enable to share history between multiple sessions, else you have to close the session to write history to file
    file_format: "plaintext" # "sqlite" or "plaintext"
  }
  completions: {
    case_sensitive: false # set to true to enable case-sensitive completions
    quick: true  # set this to false to prevent auto-selecting completions when only one remains
    partial: true  # set this to false to prevent partial filling of the prompt
    algorithm: "prefix"  # prefix or fuzzy
    external: {
      enable: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up my be very slow
      max_results: 100 # setting it lower can improve completion performance at the cost of omitting some options
      completer: null # check 'carapace_completer' above as an example
    }
  }
  filesize: {
    metric: true # true => KB, MB, GB (ISO standard), false => KiB, MiB, GiB (Windows standard)
    format: "auto" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, zb, zib, auto
  }
  cursor_shape: {
          emacs: block # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (line is the default)
          vi_insert: block # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (block is the default)
          vi_normal: block # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (underscore is the default)
      }


  hooks: {
    pre_prompt: [{||
      null  # replace with source code to run before the prompt is shown
    }]
    pre_execution: [{||
      null  # replace with source code to run before the repl input is run
    }]
    env_change: {
      PWD: [{|before, after|
        null  # replace with source code to run if the PWD environment is different since the last repl input
      }]
    }
    display_output: {||
          if (term size).columns >= 100 { table -e } else { table }
        }
        command_not_found: {||
          null  # replace with source code to return an error message when a command is not found
        }
      }

  menus: [
      # Configuration for default nushell menus
      # Note the lack of souce parameter
      {
        name: completion_menu
        only_buffer_difference: false
        marker: " | "
        type: {
            layout: columnar
            columns: 4
            col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
            col_padding: 2
        }
        style: {
            text: { fg: $description }
            selected_text: { fg: $highlight bg: $selection }
            description_text: { fg: $description } 
        }
      }
      {
        name: history_menu
        only_buffer_difference: true
        marker: " ? "
        type: {
            layout: list
            page_size: 25
        }
        style: {
            text: { fg: $description }
            selected_text: { fg: $highlight bg: $selection }
            description_text: { fg: $description } 
        }
      }
      {
        name: help_menu
        only_buffer_difference: true
        marker: " ? "
        type: {
            layout: description
            columns: 4
            col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
            col_padding: 2
            selection_rows: 4
            description_rows: 10
        }
        style: {
            text: { fg: $description }
            selected_text: { fg: $highlight bg: $selection }
            description_text: { fg: $description } 
        }
      }
      # Example of extra menus created using a nushell source
      # Use the source field to create a list of records that populates
      # the menu
      {
        name: commands_menu
        only_buffer_difference: false
        marker: " # "
        type: {
            layout: columnar
            columns: 4
            col_width: 20
            col_padding: 2
        }
        style: {
            text: { fg: $description }
            selected_text: { fg: $highlight bg: $selection }
            description_text: { fg: $description } 
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
        marker: " # "
        type: {
            layout: list
            page_size: 20
        }
        style: {
            text: { fg: $description }
            selected_text: { fg: $highlight bg: $selection }
            description_text: { fg: $description } 
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
        marker: " # "
        type: {
            layout: description
            columns: 4
            col_width: 20
            col_padding: 2
            selection_rows: 4
            description_rows: 10
        }
        style: {
            text: { fg: $description }
            selected_text: { fg: $highlight bg: $selection }
            description_text: { fg: $description } 
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
      mode: [emacs, vi_normal, vi_insert] # Options: emacs vi_normal vi_insert
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


# FIXME TODO
# import init.nu
use ~/Appdata/Roaming/nushell/init.nu *


# ENVIRONMENT VARIABLES
# -- WINDOWS --
# set path to init.nu -> available via "$env.init-path"
$env.init-path = "~/AppData/Roaming/nushell/init.nu"
# path to nushells themes.nu
$env.themes-path = "~/AppData/Roaming/nushell/themes.nu"
# path to nvim`s init.vim
$env.nvim-path = "~/AppData/Local/nvim/init.vim"
# path to vim`s vimrc
$env.vim-path = "C:/Program Files (x86)/Vim/_vimrc"
# LS_Colors 
$env.LS_COLORS = (vivid generate iceberg-dark | str trim)
# -- LINUX --
# # set path to init.nu -> available via "$env.init-path"
# $env.init-path = ""
# # path to nvim`s init.vim
# $env.nvim-path = ""
# # path to vim`s vimrc
# $env.vim-path = ""


# ALIASES
# if ((getos) == Windows) {
alias fzf = fzf --multi --preview 'bat --theme "1337" --style=numbers --color=always --line-range :500 {}'
alias cat = bat --theme "1337" --color=always --style=plain
alias rg = rg --stats --no-messages --with-filename --context 1 --smart-case --pretty
alias gs = git status
alias ga = git all
alias gd = git diff
alias cal = cal --week-start monday --month-names --year
alias diff = delta
alias cd = z
alias cdi  = zi
# alias mv = mv --verbose
# alias cp = cp --verbose
# alias rm = rm --verbose
# alias mkdir = mkdir --verbose
alias tldr = tldr --pager
alias ob = ^start obsidian
alias firefox = ^start firefox
alias pwd = echo $env.PWD
alias emacs = runemacs --maximized
alias aml = overlay use ~\main\Machine_Learning\mlenv\Scripts\activate.nu as mlenv
alias dml = overlay hide mlenv
alias time = timeit
alias ii = start .
alias py = python
alias rga = rga --rga-adapters="poppler,zip"
alias pwsh = powershell /nologo
alias hyp = hyperfine --warmup 2 --style full 
alias du = dust
# alias fd = fd --color never
alias up = ~/main/Rust/up/target/release/up.exe
alias rech = ~/main/Rust/rechifina/target/release/rechifina.exe
alias bkp = ~/main/Rust/bkp/target/release/bkp.exe
alias sl = ~/main/Rust/sl/target/release/sl.exe
alias sf = ~/main/Rust/sf/target/release/sf.exe
alias mg = ~/main/Rust/mg/target/release/mg.exe
# alias ls = sl -c
alias ll = sl -lc
alias la = sl -lac
alias john = ~/main/johntheripper/run/john.exe
alias hxy = hx ~/dailytodo.md
alias file = ~/main/Rust/witchfile/target/release/witchfile.exe
alias gib = ~/main/Rust/gib/target/release/gib.exe
alias map = ~/main/Rust/map/target/release/map.exe
alias btm = btm --battery --color gruvbox --tree --rate 750
alias cx = ~/main/Rust/cx/target/release/cx.exe
alias pf = ~/main/Rust/pf/target/release/pf.exe

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
