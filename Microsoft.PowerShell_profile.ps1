Import-Module oh-my-posh

oh-my-posh --init --shell pwsh --config $env:POSH_THEMES_PATH/jandedobbeleer.omp.json | Invoke-Expression

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
Set-PoshPrompt -Theme nordtron
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

Function Find {gci -r | where Name -match $args[0] | select FullName}
New-Alias -Name fd -Value Find


# greeting function
$Hour = (Get-Date).Hour
If ($Hour -lt 9) {"Good Morning $($Env:UserName)"}
ElseIf ($Hour -gt 17) {"Good Evening $($Env:UserName)"}
Else {"Welcome $($Env:UserName)"}
