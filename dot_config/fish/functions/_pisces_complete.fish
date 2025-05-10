function _pisces_complete -d "Invokes complete with modification for vars before a closing double quote"

    if commandline --paging-mode
        down-or-search
    else
        set token (commandline -t)
        # checking that the current token ends on a $var + '"'
        # if test [ (string match -r '\$.*"$' -- "$token") ]

        if test -n "$token"
            and test -n (string match -r '\$.*"$' -- "$token")
            commandline -f delete-char # which is '"'
        end
        commandline -f complete
    end
end
