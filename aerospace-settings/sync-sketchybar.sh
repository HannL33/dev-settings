#!/bin/bash
# Follow the current focus so the bar comes back on a normal or empty workspace.
fullscreen=$(/opt/homebrew/bin/aerospace list-windows --focused --format '%{window-is-fullscreen}') || fullscreen=
if [[ $fullscreen == true ]]; then
    /opt/homebrew/bin/sketchybar --bar hidden=on
else
    /opt/homebrew/bin/sketchybar --bar hidden=off
fi

# Temporarily hide borders on all displays and restore the configured palette on exit.
bordersrc="$HOME/.config/borders/bordersrc"
if [[ -x /opt/homebrew/bin/borders && -r "$bordersrc" ]] && /usr/bin/pgrep -qx borders; then
    if [[ $fullscreen == true ]]; then
        /opt/homebrew/bin/borders active_color=0x00000000 inactive_color=0x00000000
    else
        PATH="/opt/homebrew/bin:$PATH" /bin/bash "$bordersrc"
    fi
fi
