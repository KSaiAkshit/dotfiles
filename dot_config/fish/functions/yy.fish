function yy
    set tmp (mktemp -t "yazi-cwd.XXXXX")
    yazi --cwd-file="$tmp"
    if test -n (cat -- "$tmp") -a (cat -- "$tmp") != $PWD
        cd (cat -- "$tmp")
    end
    rm -f -- "$tmp"
end
