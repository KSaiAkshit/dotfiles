source ~/.config/nushell/default_config.nu

let carapace_completer = {|spans| 
  carapace $spans.0 nushell $spans | from json
}

$env.config = {
    show_banner: false # true or false to enable or disable the welcome banner at startup


    history: {
        file_format: "sqlite" # "sqlite" or "plaintext"
    }

    completions: {
        partial: true    # set this to false to prevent partial filling of the prompt
        external: {
            # completer: $carapace_completer
        }
    }

    cursor_shape: {
        emacs: line # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (line is the default)
        vi_insert: line # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (block is the default)
        vi_normal: block # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (underscore is the default)
    }

    color_config: $dark_theme # if you want a more interesting theme, you can replace the empty record with `$dark_theme`, `$light_theme` or another custom record
    edit_mode: vi # emacs, vi
    shell_integration: true # enables terminal shell integration. Off by default, as some terminals have issues with this.
    highlight_resolved_externals: true
    
    menus: [
        {
            name: completion_menu
            only_buffer_difference: false
            marker: "| "
            type: {
                layout: columnar
                columns: 4
                col_width: 20     # Optional value. If missing all the screen width is used to calculate column width
                col_padding: 2
            }
            style: {
                text: white
                selected_text: { fg: yellow, attr: u }
                description_text: yellow
                match_text: { attr: u }
                selected_match_text: { attr: ur }
            }
        }
    ]

    keybindings: [
        {
            name: move_right_or_take_history_hint
            modifier: control
            keycode: char_f
            mode: [emacs, vi_insert]
            event: {
                until: [
                    {send: historyhintcomplete}
                    {send: menuright}
                    {send: right}
                ]
            }
        }
    ]
}
source ~/.config/nushell/conf/starship.nu
source ~/.config/nushell/conf/alias.nu
source ~/.config/nushell/conf/zoxide.nu
source ~/.config/nushell/conf/carapace.nu
source ~/.local/share/atuin/init.nu
use ~/.config/nushell/themes/rose-pine.nu
$env.config = ($env.config | merge {color_config: (rose-pine)})
