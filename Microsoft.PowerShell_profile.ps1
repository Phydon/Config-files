# Import-Module oh-my-posh

# oh-my-posh --init --shell pwsh --config $env:POSH_THEMES_PATH/jandedobbeleer.omp.json | Invoke-Expression

# minimal (without username):
# Set-PoshPrompt -Theme material
# Set-PoshPrompt -Theme pararussel
# Set-PoshPrompt -Theme lambda

# almost minimal (with username):
# Set-PoshPrompt -Theme zash

# less minimal:
# Set-PoshPrompt -Theme xtoys
# Set-PoshPrompt -Theme huvix
# Set-PoshPrompt -Theme pure
# GOOD ONE: nordtron
# Set-PoshPrompt -Theme nordtron
# Set-PoshPrompt -Theme darkblood
# Set-PoshPrompt -Theme emodipt
# Set-PoshPrompt -Theme negligible
# Set-PoshPrompt -Theme ys
# Set-PoshPrompt -Theme sorin

# not minimal:
# Set-PoshPrompt -Theme atomicBit
# Set-PoshPrompt -Theme powerlevel10k_lean
# Set-PoshPrompt -Theme peru
# Set-PoshPrompt -Theme stelbent.minimal
# Set-PoshPrompt -Theme blue-owl
# Set-PoshPrompt -Theme night-owl
# Set-PoshPrompt -Theme slimfat
# Set-PoshPrompt -Theme jv_sitecorian


# generate new aliases for specific programs
New-Alias -Name sf -Value C:/Aliases/Programs/sf.exe 
New-Alias -Name fzf -Value C:/Aliases/Programs/fzf.exe 
New-Alias -Name bat -Value C:/Aliases/Programs/bat.exe 
New-Alias -Name delta -Value C:/Aliases/Programs/delta.exe 
New-Alias -Name rg -Value C:/Aliases/Programs/rg.exe 

Function Find {gci -r -erroraction 'silentlycontinue' | where Name -match $args[0] | select FullName}
New-Alias -Name fd -Value Find

Function cdback {cd ..}
New-Alias -Name .. -Value cdback


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
