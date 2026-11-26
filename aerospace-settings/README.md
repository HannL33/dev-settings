# AeroSpace settings

`Option-F` toggles AeroSpace fullscreen with no outer gaps. SketchyBar is hidden while a fullscreen window has focus and returns when focus moves to a normal window or empty workspace. `Option-1` through `Option-9` switch workspaces as usual.

Fullscreen keeps the window in an AeroSpace workspace. App-specific tabs and toolbars may still be visible. SketchyBar and JankyBorders follow the focused window across all displays. Running JankyBorders is made transparent in fullscreen and restored from `~/.config/borders/bordersrc` on exit. macOS still draws the rounded corners of regular windows.

## Install

This setup expects AeroSpace and SketchyBar from Homebrew under `/opt/homebrew/bin` on Apple Silicon. It also works without a custom SketchyBar theme. To use the entire display area, set the macOS menu bar and Dock to hide automatically.

From this directory, run the following on a clean setup. Back up or merge existing AeroSpace files first.

```sh
mkdir -p "$HOME/.config/aerospace"
cp sync-sketchybar.sh "$HOME/.config/aerospace/"
cp aerospace.toml "$HOME/.aerospace.toml"
/opt/homebrew/bin/aerospace reload-config
```

[AeroSpace fullscreen](https://nikitabobko.github.io/AeroSpace/commands#fullscreen) · [SketchyBar visibility](https://felixkratz.github.io/SketchyBar/config/bar) · [JankyBorders runtime settings](https://github.com/FelixKratz/JankyBorders#updating-the-border-properties-during-runtime)
