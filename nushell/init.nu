export def getos [] {
	sys | get host.name
}

export def ":q" [] {
	exit
}

export def "get aliases" [] {
	open $nu.config-path | 
	lines | 
	find alias | 
	find -v "#" | 
	split column "=" | 
	select column1 column2 | 
	rename Alias Command | 
	update Alias {
		|f| $f.Alias | 
		split row " " | 
		last} | 
	sort-by Alias
}

export def "backup history" [] {
	mkdir ~/backup

	open $nu.history-path | 
	save ~/backup/history.txt
}

export def "history remove dups" [] {
	backup history

	open $nu.history-path | 
	lines | 
	into df | 
	drop-duplicates | 
	into nu | 
	get "0" | 
	save $nu.history-path
}
