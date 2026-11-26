function zf --description 'Find a file with fd, preview it with bat, and open it in Zed'
    set -l file (fd --type f --hidden --exclude .git | fzf --preview 'bat --color=always --style=numbers --line-range=:100 {}')
    if test -n "$file"
        zed $file
    end
end
