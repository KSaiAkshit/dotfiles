function paste
    set file $argv[1]
    if test -z $file
        set file /dev/stdin
    end
    set paste_url (curl --data-binary @$file https://paste.rs)
    echo $paste_url | wl-copy
    echo $paste_url
end
