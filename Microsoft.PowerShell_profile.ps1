Function Find {gci -r -erroraction 'silentlycontinue' | where Name -match $args[0] | select FullName}
New-Alias -Name fd -Value Find

Function cdback {cd ..}
New-Alias -Name .. -Value cdback

Function vimquit {exit}
New-Alias -Name :q -Value vimquit

New-Alias -Name 'up' -Value ~/main/Rust/up/target/release/up.exe
New-Alias -Name 'bkp' -Value ~/main/Rust/bkp/target/release/bkp.exe
del alias:sl -Force
New-Alias -Name 'sl' -Value ~/main/Rust/sl/target/release/sl.exe
New-Alias -Name 'sf' -Value ~/main/Rust/sf/target/release/sf.exe
New-Alias -Name 'mg' -Value ~/main/Rust/mg/target/release/mg.exe

New-Alias -Name 'help' -Value Get-Help

Function pypackages {
	py -m pip list
}
New-Alias -Name 'pypkg' -Value pypackages

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

# # greeting function
# $Hour = (Get-Date).Hour
# If ($Hour -lt 9) {"Good Morning $($Env:UserName)"}
# ElseIf ($Hour -gt 17) {"Good Evening $($Env:UserName)"}
# Else {"Welcome $($Env:UserName)"}

Set-PSReadLineOption -Colors @{ "Command"=[ConsoleColor]::Magenta }

# use starship prompt
# Invoke-Expression (&starship init powershell)

# For zoxide v0.8.0+
Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
})
