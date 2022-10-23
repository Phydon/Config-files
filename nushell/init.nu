# Gets the name of the running operating system.
export def "get os" [] {
	sys | get host.name
}

# Exiting the shell, the "VIM way".
export def ":q" [] {
	exit
}

# Gets all active aliases.
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

# Creates a backup of your nushell command history.
export def "history backup" [] {
	mkdir ~/backup
	open $nu.history-path | 
	save ~/backup/history.txt
}

# Creates a backup of your nushell command history and removes all duplicates in the $nu.history-path.
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

# Get input by words as a table.
# Returns the words stored in a table seperated into rows by default.
def get-words [
	--list (-l)		# Return a list of words seperated into rows
	--column (-c)	# Return the words stored in a table seperated into columns
] {
	if ($in | is-empty) {
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

# Get input by words.
# Returns the words stored in a table seperated into rows by default.
# Only works with raw input.
export def words [
	--list (-l)		# Return a list of words from each line seperated into rows
	--column (-c)	# Return the words from each line stored in a table seperated into columns
] {
	let input = $in
	# sum up if input is not raw input
	# panics if input is list of strings
	let line_size = ($input | size | get lines | math sum) 
	if ($input | is-empty) {
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

# Combine git add .; git commit -m "message"; git push.
export def "git all" [
	commit_txt: string	# your commit message
] {
	git add . |
	git commit -m $commit_txt |
	git push origin master
}

# Run 'cargo check' or 'cargo test' on every file change.
export def "watch cargo" [
	--check (-c)	# run 'cargo check' whenever a rust file changes
	--test (-t)		# run 'cargo test' whenever a rust file changes
] {
	if $check {
		watch . --glob=**/*.rs {(
			echo "(char nl)" |
			cargo check
		)}
	} else if $test {
		watch . --glob=**/*.rs {
			echo "(char nl)" |
			cargo test -- --show-output
		}
	}
}

# Log all changes in any file in the given path to 'watched_changes.log'.
export def "watch log" [
	path: string = "~/main"		# path to folder to watch for file changes; default is '~/main'	
] {
	watch $path {
		|op, path| $"($op) - ($path)(char nl)" |
		save --append watched_changes.log
	}
}

# Get the current date and time.
export def now [
	--time (-t)		# only show time
	--date (-d)		# only show date
	--short (-s)	# show the short version
	--long (-l)		# show the long version
] {
	let dt = (
		if ($time and $short) {
			date format "%H:%M"
		} else if ($time and $long) {
			date format "%H:%M:%S%.3f"
		} else if $time {
			date format "%H:%M:%S"
		} else if ($date and $short) {
			date format "%d.%m.%y"
		} else if ($date and $long) {
			date format "%A, %d.%B.%Y"
		} else if $date {
			date format "%d.%m.%Y"
		} else if $short {
			date format "%d.%m.%y, %H:%M"
		} else if $long {
			date format "%A, %d.%B.%Y, %H:%M:%S%.3f"
		} else {
			date format "%d.%m.%Y, %H:%M:%S"
		}
	)

	date now |
	$dt
}

# Create a backup of a given file.
# If no file is given, a backup of all files in the current folder is created.
# Hidden files included.
export def backup [
	--verbose (-v)		# print verbose output
	...files: path		# the files to backup
] {
	if $verbose {
		echo "::: Create backup folder ..."
		mkdir -s nubackup

		echo "::: Make backup ..."

		if ($files | is-empty) {
			ls -a |
			where type == file | 
			par-each {
				|it| cp --verbose $it.name nubackup/
			}
		} else {
			for $file in $files {
				cp --verbose $file nubackup/ 
			} |
			flatten
		}
	} else {
		mkdir nubackup

		if ($files | is-empty) {
			ls -a |
			where type == file | 
			par-each {
				|it| cp $it.name nubackup/
			}
		} else {
			for $file in $files {
				cp $file nubackup/ 
			} |
			flatten
		}
	}
}

# Simplified find and replace implementation.
# Works with multiple files or input from pipeline.
# By default it only replaces the first occurrence of the find pattern.
# Warning: backup non plaintext files
export def "fdrpl" [
	--all (-a)			# replace all occurrences of the pattern
	find: string		# the pattern to find
	replace: string		# the pattern to replace
	...files: path		# the file or files to work with
] {
	if $all {
		if ($in | is-empty) {
			for $file in $files {
				open --raw $file | 
				str replace --all $find $replace |
				save $file
			}
		} else {
			if ($files | is-empty) {
				$in |
				str replace --all $find $replace
			} else {
				echo $"ERROR: Cannot combine input from pipeline and files. Too much arguments: [($in)] + ($files)"
			}
		}
	} else {
		if ($in | is-empty) {
			for $file in $files {
				open --raw $file | 
				str replace $find $replace |
				save $file
			}	
		} else {
			if ($files | is-empty) {
				$in |
				str replace $find $replace
			} else {
				echo $"ERROR: Cannot combine input from pipeline and files. Too much arguments: [($in)] + ($files)"
			}
		}
	}
}

# Get user input in a while loop using recursive function
export def userinput [
	match: string	# the matching string to escape the loop
	msg?: string	# prompt the user a message
] {
	if ($msg != null) {
		echo $"::: ($msg):"
	}
	
	let inp = (input)

	if ($inp == $match) {
		echo $inp
	} else {
		userinput $match $msg
	}
}

# Update tools, languages and more
export def "up" [
	--list (-l)		# show everything that gets updated
] {
	let os = (get os)

	if ($os == "Windows") {
		let tools = [scoop rustup vim nvim ghcup]

		if $list {
			for tool in $tools {
				echo $tool
			}
		} else {
			let inp = (userinput "update" "Enter \"update\" to update")

			if $inp == "update" {
				echo "::: Updating scoop ..."
				scoop update

				echo (char nl)
				echo  "::: Updating rust ..."
				rustup --verbose update

				echo (char nl)
				echo  "::: Updating vim ..."
				vim -c PlugUpdate -c qa

				echo (char nl)
				echo  "::: Updating nvim ..."
				nvim -c PlugUpdate -c qa

				echo (char nl)
				echo  "::: Updating ghcup ..."
				ghcup --verbose upgrade
			} else {
				$nothing
			}
		}
	} else {
		echo "Not implemented yet"
	}
}

# Mini grep
# Search for a pattern in files from input stream or given files
# If no input stream or files are given, it searches in all files recursively from the current directory
# 
# Examples: 
# 	> search the word "wasd" in all files from the current directory recursively
# 	> mg wasd
#
# 	> search the word "wasd" in files from input stream
# 	> ls | where type == file | where size > 10Mb | get name | mg wasd
# 
# 	> search the word "wasd" in the given files
# 	> mg wasd test1.txt test2.json test3.md
export def mg [
    pattern: string     # the pattern to search for
    ...files: path	    # the files to search in
] {
    let input = $in
    
    if ($input != $nothing) {
        $input |
        par-each {|it|
            open --raw $it |
            find $pattern
        }
    } else if ($files | is-empty) {
		ls **/* |
		where type == file | 
		get name |
        par-each {|it|
            open --raw $it |
            find $pattern
        }
    } else {
        $files | 
        par-each {|it|
            open --raw $it |
            find $pattern
        }
	}
}
