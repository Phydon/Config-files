# Nushell Environment Config File

# def create_left_prompt [] {
#     let path_segment = ($env.PWD)

#     $path_segment
# }

# def create_right_prompt [] {
#     let time_segment = ([
#         (date now | date format '%m/%d/%Y %r')
#     ] | str collect)

#     $time_segment
# }

def create_left_prompt [] {
    let exit_code_segment = if ($env.LAST_EXIT_CODE == 0) {
            ""
        } else {
            $"(ansi red_bold)($env.LAST_EXIT_CODE) "
        }

    let os_name = (sys | get host.name)    
    let is_home_in_path = ($env.PWD | str starts-with $nu.home-path)
    let path = if $is_home_in_path {
        if ($os_name =~ "Windows") {
            let home = ($nu.home-path | str replace -a '\\' '/')
            let pwd = ($env.PWD | str replace -a '\\' '/')
            $pwd | str replace $home '~'
        } else {
            $env.PWD | str replace $nu.home-path '~'
        }
    } else {
        $env.PWD | str replace -a '\\' '/'
    }
    
    let path_segment = if (is-admin) {
        $"(ansi red_bold)($path)"
    } else {
        $"(ansi white_bold)($path)"
    }
    
    [$exit_code_segment, $path_segment] | str join
}

def create_right_prompt [] {
    $nothing
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = {|| create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| $"(ansi -e { fg: '#706EFF'})$ " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| $"(ansi -e { fg: '#706EFF'})$ " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| $"(ansi -e { fg: '#706EFF'}):: " }
$env.PROMPT_MULTILINE_INDICATOR = {|| $"(ansi -e { fg: '#706EFF'})::: " }
# $env.PROMPT_INDICATOR = { $"(ansi white_bold) $ " }
# $env.PROMPT_INDICATOR_VI_INSERT = { $"(ansi white_bold)$ " }
# $env.PROMPT_INDICATOR_VI_NORMAL = { $"(ansi white_bold):: " }
# $env.PROMPT_MULTILINE_INDICATOR = { $"(ansi white_bold)::: " }
# $env.PROMPT_INDICATOR = { "〉" }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
$env.NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
$env.NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')

# STARSHIP
starship init nu | save -f ~/.cache/starship/init.nu
# starship init nu | str replace --string "size -c" size | save -f ~/.cache/starship/init.nu
starship init nu | str replace --all --string "let-env " "$env." | save -f ~/.cache/starship/init.nu

# ZOXIDE
zoxide init nushell --hook prompt | save -f ~/.zoxide.nu
# zoxide init nushell | str replace --string "&&" "and" | save -f ~/.zoxide.nu
# zoxide init nushell | str replace --string "||" "or" | save -f ~/.zoxide.nu
zoxide init nushell | str replace --all --string "let-env " "$env." | str replace --all --string "length)" "str length).0" | save -f ~/.zoxide.nu
