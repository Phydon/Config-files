function ga --description "Git - stage all, commit, and push in one shot"
    if test (count $argv) -ne 1
        echo 'Usage: ga "commit message"'
        return 1
    end

    git add . &&
        git commit -m "$argv[1]" &&
        git push
end
