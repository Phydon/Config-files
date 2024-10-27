Function Find {gci -r -erroraction 'silentlycontinue' | where Name -match $args[0] | select FullName}
New-Alias -Name fd -Value Find

Function cdback {cd ..}
New-Alias -Name .. -Value cdback

Function vimquit {exit}
New-Alias -Name :q -Value vimquit

del alias:sl -Force
New-Alias -Name 'sl' -Value ~/.local/bin/sl.exe
Function sllong { sl -l $args[0] }
New-Alias -Name 'll' -Value sllong
Function sllonga { sl -la $args[0] }
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
Function startcurrent { start . }
New-Alias -Name 'ii' -Value startcurrent

Function create_new_file { [void](New-Item -Path . -ItemType "file" -Name $args[0])}
New-Alias -Name 'touch' -Value create_new_file

New-Alias -Name 'help' -Value Get-Help
New-Alias -Name 'py' -Value python

Function hxquicknotes { hx 'G:\Meine Ablage\Obsidian\Main\Quicknotes.md' }
New-Alias -Name 'hxy' -Value hxquicknotes

Function pypackages { py -m pip list }
New-Alias -Name 'pypkg' -Value pypackages

Function gitstatus { git status }
New-Alias -Name 'gs' -Value gitstatus
Function gitall { git add .; git commit -m $args[0]; git push }
New-Alias -Name 'ga' -Value gitall

del alias:cd -Force
New-Alias -Name 'cd' -Value z
New-Alias -Name 'cdi' -Value zi

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

# use starship prompt
# Invoke-Expression (&starship init powershell)

# For zoxide v0.8.0+
# Invoke-Expression (& {
#     $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
#     (zoxide init --hook $hook powershell | Out-String)
# })
# For zoxide v0.9.4
Invoke-Expression (& { (zoxide init powershell | Out-String) })
