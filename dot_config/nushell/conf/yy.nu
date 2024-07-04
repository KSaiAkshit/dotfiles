def --env yy [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}



$env.config = (
    $env.config | upsert keybindings (
        $env.config.keybindings
        | append {
            name: open_yazi_cwd
            modifier: control
            keycode: char_o
            mode: [emacs, vi_normal, vi_insert]
            event: {
							send: executehostcommand,
							cmd: "yy"
						 }
        }
    )
)

