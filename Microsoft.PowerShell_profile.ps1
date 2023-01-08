# generate new aliases for specific programs
# New-Alias -Name sf -Value C:/Aliases/Programs/sf.exe 
# New-Alias -Name fzf -Value C:/Aliases/Programs/fzf.exe 
# New-Alias -Name bat -Value C:/Aliases/Programs/bat.exe 
# New-Alias -Name delta -Value C:/Aliases/Programs/delta.exe 
# New-Alias -Name rg -Value C:/Aliases/Programs/rg.exe 

Function Find {gci -r -erroraction 'silentlycontinue' | where Name -match $args[0] | select FullName}
New-Alias -Name fd -Value Find

Function cdback {cd ..}
New-Alias -Name .. -Value cdback

Function vimquit {exit}
New-Alias -Name :q -Value vimquit


# # greeting function
# $Hour = (Get-Date).Hour
# If ($Hour -lt 9) {"Good Morning $($Env:UserName)"}
# ElseIf ($Hour -gt 17) {"Good Evening $($Env:UserName)"}
# Else {"Welcome $($Env:UserName)"}

# use starship prompt
Invoke-Expression (&starship init powershell)

# For zoxide v0.8.0+
Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
})
