# Gets the name of the running operating system
export def getos [] {
	sys | get host.name
}

export def ":q" [] {
	exit
}

# Gets all active aliases
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
		last
	} | 
	sort-by Alias
}

# Creates a backup of your nushell command history
export def "history backup" [] {
	mkdir ~/backup

	open $nu.history-path | 
	save ~/backup/history.txt
}

# Creates a backup of your nushell command history and removes all duplicates in the $nu.history-path
export def "history remove_duplicates" [] {
	history backup

	open $nu.history-path | 
	lines | 
	into df | 
	drop-duplicates | 
	into nu | 
	get "0" | 
	save $nu.history-path
}

# Get input by words as a table
# Returns the words stored in a table seperated into rows by default
def get-words [
	--list (-l)		# Return a list of words seperated into rows
	--column (-c)	# Return the words stored in a table seperated into columns
] {
	if ($in | empty?) {
		# Do nothing
	} else if $column {
		$in |
		split column --collapse-empty " " | 
		str trim
	} else if $list {
		$in |
		split row " " | 
		str trim
	} else {
		$in |
		split row " " |
		str trim | 
		parse "{word}"
	}
}

# Get input by words
# Returns the words stored in a table seperated into rows by default
# Only works with raw input 
export def words [
	--list (-l)		# Return a list of words from each line seperated into rows
	--column (-c)	# Return the words from each line stored in a table seperated into columns
] {
	let input = $in
	# sum up if input is not raw input
	# panics if input is list of strings
	let line_size = ($input | size | get lines | math sum) 

	if ($input | empty?) {
		# Do nothing
	} else if ($line_size <= 1) {
		if $column {
			$input | 
			get-words --column
		} else if $list {
			$input | 
			get-words --list
		} else {
			$input | 
			get-words
		}
	} else {
		if $column {
			$input |
			lines --skip-empty | 
			each {|it| $it | get-words --column} | 
			flatten
		} else if $list {
			$input |
			lines --skip-empty | 
			each {|it| $it | get-words --list} | 
			flatten
		} else {
			$input |
			lines --skip-empty | 
			each {|it| $it | get-words} | 
			flatten
		}
	}
}
