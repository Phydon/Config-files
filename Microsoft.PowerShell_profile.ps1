# ALIASES

function cdback {cd ..}
New-Alias -Name .. -Value cdback

function vimquit {exit}
New-Alias -Name :q -Value vimquit

del alias:sl -Force
New-Alias -Name 'sl' -Value ~/.local/bin/sl.exe
# function sllong { sl -l $args[0] }
# New-Alias -Name 'll' -Value sllong
# function sllonga { sl -la $args[0] }
# New-Alias -Name 'la' -Value sllonga
New-Alias -Name 'sf' -Value ~/.local/bin/sf.exe
New-Alias -Name 'mg' -Value ~/.local/bin/mg.exe
New-Alias -Name 'cx' -Value ~/.local/bin/cx.exe
New-Alias -Name 'gib' -Value ~/.local/bin/gib.exe
New-Alias -Name 'map' -Value ~/.local/bin/map.exe
New-Alias -Name 'file' -Value ~/.local/bin/witchfile.exe
New-Alias -Name 'up' -Value ~/.local/bin/up.exe
New-Alias -Name 'pf' -Value ~/.local/bin/pf.exe
New-Alias -Name 'ms' -Value ~/.local/bin/ms.exe
New-Alias -Name 'xa' -Value ~/.local/bin/xa.exe
New-Alias -Name 'gerf' -Value ~/.local/bin/gerf.exe
New-Alias -Name 'lc' -Value ~/.local/bin/leanncore.ps1
del alias:sp -Force
New-Alias -Name 'sp' -Value ~/.local/bin/sp.exe
New-Alias -Name 'sg' -Value ~/.local/bin/sg.exe

del alias:ii -Force
function startcurrent { start . }
New-Alias -Name 'ii' -Value startcurrent

function hf { hx (fzf) }

# function create_new_file { [void](New-Item -Path . -ItemType "file" -Name $args[0])}
# New-Alias -Name 'touch' -Value create_new_file

# function Find {gci -r -erroraction 'silentlycontinue' | where Name -match $args[0] | select FullName}
# New-Alias -Name fd -Value Find

New-Alias -Name 'help' -Value Get-Help
New-Alias -Name 'py' -Value python

function pypackages { py -m pip list }
New-Alias -Name 'pypkg' -Value pypackages

function gitstatus { git status }
New-Alias -Name 'gs' -Value gitstatus
del alias:gl -Force
function gitlog { git log --oneline }
New-Alias -Name 'gl' -Value gitlog
function gitall { git add .; git commit -m $args[0]; git push }
New-Alias -Name 'ga' -Value gitall
function gitdiff { git diff }
New-Alias -Name 'gd' -Value gitdiff

del alias:cd -Force
New-Alias -Name 'cd' -Value z
New-Alias -Name 'cdi' -Value zi

function cd_and_ls {
    cd $args[0] | ll
}
New-Alias -Name 'cdl' -Value cd_and_ls

New-Alias -Name 'libreoffice' -Value "C:\Program Files\LibreOffice\program\soffice.exe"





# UUTILS 
New-Alias -Name 'uu' -Value uutils.exe

del alias:cat -Force
function cat_func {
    ~/scoop/apps/uutils-coreutils-lean/current/coreutils.exe cat $args
}
New-Alias -Name "cat" -Value cat_func

del alias:cp -Force
function cp_func {
    ~/scoop/apps/uutils-coreutils-lean/current/coreutils.exe cp $args
}
New-Alias -Name "cp" -Value cp_func

del alias:dir -Force
function dir_func {
    ~/scoop/apps/uutils-coreutils-lean/current/coreutils.exe dir $args
}
New-Alias -Name "dir" -Value dir_func

del alias:echo -Force
function echo_func {
    ~/scoop/apps/uutils-coreutils-lean/current/coreutils.exe echo $args
}
New-Alias -Name "echo" -Value echo_func

del alias:ls -Force
function ls_func {
    ~/scoop/apps/uutils-coreutils-lean/current/coreutils.exe ls --color=always $args
}
New-Alias -Name "ls" -Value ls_func
function sllong { ls -lhG --time-style=long-iso $args[0] }
New-Alias -Name 'll' -Value sllong
function sllonga { ls -lAhG --time-style=long-iso $args[0] }
New-Alias -Name 'la' -Value sllonga

del alias:mv -Force
function mv_func {
    ~/scoop/apps/uutils-coreutils-lean/current/coreutils.exe mv $args
}
New-Alias -Name "mv" -Value mv_func

del alias:pwd -Force
function pwd_func {
    ~/scoop/apps/uutils-coreutils-lean/current/coreutils.exe pwd $args
}
New-Alias -Name "pwd" -Value pwd_func

del alias:rm -Force
function rm_func {
    ~/scoop/apps/uutils-coreutils-lean/current/coreutils.exe rm $args
}
New-Alias -Name "rm" -Value rm_func

del alias:rmdir -Force
function rmdir_func {
    ~/scoop/apps/uutils-coreutils-lean/current/coreutils.exe rmdir $args
}
New-Alias -Name "rmdir" -Value rmdir_func

del alias:sleep -Force
function sleep_func {
    ~/scoop/apps/uutils-coreutils-lean/current/coreutils.exe sleep $args
}
New-Alias -Name "sleep" -Value sleep_func

del alias:sort -Force
function sort_func {
    ~/scoop/apps/uutils-coreutils-lean/current/coreutils.exe sort $args
}
New-Alias -Name "sort" -Value sort_func

del alias:tee -Force
function tee_func {
    ~/scoop/apps/uutils-coreutils-lean/current/coreutils.exe tee $args
}
New-Alias -Name "tee" -Value tee_func






# # Always remove to recycle bin
# function recycle {
#     param(
#         [Parameter(ValueFromPipeline, Mandatory=$true)]
#         [string[]]$Path
#     )

#     begin {
#         $shell = New-Object -ComObject 'Shell.Application'
#     }

#     process {
#         foreach ($p in $Path) {
#             # Resolve the full path, which handles aliases like '.' and '~'
#             $fullPath = Resolve-Path -Path $p -ErrorAction SilentlyContinue

#             if ($null -eq $fullPath) {
#                 Write-Warning "Cannot find path '$p' because it does not exist."
#                 continue
#             }

#             try {
#                 # Get the folder and item references from the shell
#                 $folder = $shell.Namespace((Get-Item -Path $fullPath).DirectoryName)
#                 $item = $folder.ParseName((Get-Item -Path $fullPath).Name)

#                 # Invoke the verb "Delete" on the item, which sends it to the Recycle Bin
#                 $item.InvokeVerb('Delete')
#             } catch {
#                 Write-Error "Could not move '$p' to the Recycle Bin. Original error: $_"
#             }
#         }
#     }
# }
# del alias:rm -Force
# New-Alias -Name 'rm' -Value recycle

# PAGER
# function less {
#     param ()
#     $input | Out-Host -Paging
# }

# EDIT LAST COMMAND
function Edit-LastCommand {
    # Get the last command from history
    $lastCommand = (Get-History -Count 1).CommandLine
    if (-not $lastCommand) {
        Write-Host "No command history found" -ForegroundColor Red
        return
    }

    # Write to a temporary .txt file
    $tempFile = "$env:TEMP\elc.txt"
    $lastCommand | Set-Content -Encoding UTF8 $tempFile

    # Start editing with the default text editor (use process information)
    $editorProcess = Start-Process $tempFile -PassThru
    
    if (-not $editorProcess) {
        Write-Host "Failed to start the default text editor." -ForegroundColor Red
        return
    }

    # Wait for the editor process to close
    while ($true) {
        Start-Sleep -Milliseconds 200
        # Check if the editor process has exited
        if ($editorProcess.HasExited) { break }
    }

    # Read the edited command from the file, removing any carriage return characters
    $edited = (Get-Content $tempFile -Raw).Replace("`r", "").Trim()
   
    # Clear the current line in the terminal input
    [Microsoft.PowerShell.PSConsoleReadLine]::DeleteLine()

    # Insert the edited command
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert($edited)
   
}

# Bind Ctrl+E to the function
Set-PSReadLineKeyHandler -Chord 'Ctrl+e' -ScriptBlock { Edit-LastCommand }

function knb {
    param(
        [Parameter(Mandatory=$false, Position=0)]
        [string]$Pattern
    )

    # --- CONFIGURATION ---
    $knb_dir = "$HOME\Nextcloud\Obsidian"
    # ---------------------

    if ([string]::IsNullOrWhiteSpace($Pattern)) {
        Write-Host "Usage: knb <pattern>" -ForegroundColor Yellow
        return
    }

    # Use -0 (null-terminated) and -Split to handle paths safely
    # This prevents PowerShell from adding extra characters to the path string
    $matches = (fd -i -t f -e md --absolute-path -- "$Pattern" "$knb_dir").Trim()

    # Check if we have an array or a single string
    $count = 0
    if ($matches) {
        $count = $matches.Count
    }

    if ($count -eq 0) {
        Write-Host "No direct match for '$Pattern'. Opening full directory search..." -ForegroundColor Cyan
        
        # In the fallback, we pipe directly to fzf
        $selection = fd -i -t f -e md --absolute-path . "$knb_dir" | 
                     fzf --query "$Pattern" --header "Fuzzy Search: $knb_dir" --height 40% --reverse --border
        
        if ($selection) {
            bat --style="plain" -- $selection.Trim()
        }

    } elseif ($count -eq 1) {
        # Ensure we pass a clean string to bat
        bat --style="plain" -- $matches.Trim()

    } else {
        $selection = $matches | fzf --header "Multiple matches found" --height 40% --reverse --border
        
        if ($selection) {
            bat --style="plain" -- $selection.Trim()
        }
    }
}


# DISABLE TELEMETRY 
$POWERSHELL_TELEMETRY_OPTOUT = 1
 

# CUSTOME PROMT
function shorten-path([string] $path) {
   $loc = $path.Replace($HOME, '~')
   # remove prefix for UNC paths
   $loc = $loc -replace '^[^:]+::', ''
   # make path shorter like tabs in Vim,
   # handle paths starting with \\ and . correctly
   return ($loc -replace '\\(\.?)([^\\])[^\\]*(?=\\)','\$1$2')
}

function prompt {
   # our theme
   $cdelim = [ConsoleColor]::DarkCyan
   $chost = [ConsoleColor]::Green
   $cloc = [ConsoleColor]::Cyan
   $cadm = [ConsoleColor]::Red
   $IsAdmin = (New-Object Security.Principal.WindowsPrincipal ([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

   # write-host ([net.dns]::GetHostName()) -n -f $chost
   write-Host ($(if ($IsAdmin) { 'admin ' } else { '' })) -n -f $cadm
   write-host '[' -n -f $cdelim
   write-host (shorten-path (Get-Location).Path) -n -f $cloc
   write-host '] ' -n -f $cdelim
   write-host "$([char]0x24)" -n -f $chost
   return ' ' 
}

Set-PSReadLineOption -Colors @{ "Command"=[ConsoleColor]::Magenta }

# USE STARSHIP PROMPT
# Invoke-Expression (&starship init powershell)

# ZOXIDE V0.9.4
Invoke-Expression (& { (zoxide init powershell | Out-String) })
