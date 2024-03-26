set tabstop=4

" quickly ESCAPE to normal mode
imap qq <Esc>
vmap qq <Esc>

" Yank to system clipboard
set clipboard=unnamed

exmap svert obcommand workspace:split-vertical
nmap <C-A-l> :svert
exmap shor obcommand workspace:split-horizontal
nmap <C-A-j> :shor

exmap surround_wiki surround [[ ]]
exmap surround_double_quotes surround " "
exmap surround_single_quotes surround ' '
exmap surround_brackets surround ( )
exmap surround_square_brackets surround [ ]
exmap surround_curly_brackets surround { }
exmap surround_arrows surround < >

" NOTE: must use 'map' and not 'nmap'
map [[ :surround_wiki
unmap <Space>
map <Space>" :surround_double_quotes
map <Space>' :surround_single_quotes
map <Space>b :surround_brackets
map <Space>( :surround_brackets
map <Space>) :surround_brackets
map <Space>[ :surround_square_brackets
map <Space>[ :surround_square_brackets
map <Space>{ :surround_curly_brackets
map <Space>} :surround_curly_brackets
map <Space>< :surround_arrows
map <Space>> :surround_arrows
