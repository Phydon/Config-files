# ALIASES

function Find {gci -r -erroraction 'silentlycontinue' | where Name -match $args[0] | select FullName}
New-Alias -Name fd -Value Find

function cdback {cd ..}
New-Alias -Name .. -Value cdback

function vimquit {exit}
New-Alias -Name :q -Value vimquit

del alias:sl -Force
New-Alias -Name 'sl' -Value ~/.local/bin/sl.exe
function sllong { sl -l $args[0] }
New-Alias -Name 'll' -Value sllong
function sllonga { sl -la $args[0] }
New-Alias -Name 'la' -Value sllonga
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

function create_new_file { [void](New-Item -Path . -ItemType "file" -Name $args[0])}
New-Alias -Name 'touch' -Value create_new_file

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

del alias:cat -Force
function batcat {
    bat --theme="Nord" $args[0]
}
New-Alias -Name 'cat' -Value batcat

New-Alias -Name 'uu' -Value uutils.exe

# Always remove to recycle bin
function recycle {
    param(
        [Parameter(ValueFromPipeline, Mandatory=$true)]
        [string[]]$Path
    )

    begin {
        $shell = New-Object -ComObject 'Shell.Application'
    }

    process {
        foreach ($p in $Path) {
            # Resolve the full path, which handles aliases like '.' and '~'
            $fullPath = Resolve-Path -Path $p -ErrorAction SilentlyContinue

            if ($null -eq $fullPath) {
                Write-Warning "Cannot find path '$p' because it does not exist."
                continue
            }

            try {
                # Get the folder and item references from the shell
                $folder = $shell.Namespace((Get-Item -Path $fullPath).DirectoryName)
                $item = $folder.ParseName((Get-Item -Path $fullPath).Name)

                # Invoke the verb "Delete" on the item, which sends it to the Recycle Bin
                $item.InvokeVerb('Delete')
            } catch {
                Write-Error "Could not move '$p' to the Recycle Bin. Original error: $_"
            }
        }
    }
}
del alias:rm -Force
New-Alias -Name 'rm' -Value recycle

# PAGER
function less {
    param ()
    $input | Out-Host -Paging
}

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
   write-host (shorten-path (pwd).Path) -n -f $cloc
   write-host '] ' -n -f $cdelim
   write-host "$([char]0x24)" -n -f $chost
   return ' ' 
}

Set-PSReadLineOption -Colors @{ "Command"=[ConsoleColor]::Magenta }

# USE STARSHIP PROMPT
# Invoke-Expression (&starship init powershell)

# For zoxide v0.8.0+
# Invoke-Expression (& {
#     $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
#     (zoxide init --hook $hook powershell | Out-String)
# })
# FOR ZOXIDE V0.9.4
Invoke-Expression (& { (zoxide init powershell | Out-String) })
