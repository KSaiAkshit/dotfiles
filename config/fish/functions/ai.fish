function ai
set query (string join " " '"'$argv'"')
tgpt -q $query | glow -p -
end
