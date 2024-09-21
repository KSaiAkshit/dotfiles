function pomodoro
  switch $argv[1]
    case 'work'
      set val $argv[1]
      echo $val | lolcat
      timer 45m
      notify-send 'Work Done'
      # spd-say "'$val' session done"
    case 'break'
      set val $argv[1]
      echo $val | lolcat
      timer 10m
      notify-send 'Break Done'
      # spd-say "'$val' session done"
    case '*'
      echo "Invalid session type"
  end
end

