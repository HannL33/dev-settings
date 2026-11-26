# AeroSpace settings

`Option-F` toggles AeroSpace fullscreen with no outer gaps. `Option-1` through `Option-9` switch workspaces as usual.

Fullscreen keeps the window in an AeroSpace workspace. App-specific tabs and toolbars may still be visible. macOS still draws the rounded corners of regular windows.

## Install

This setup expects AeroSpace from Homebrew under `/opt/homebrew/bin` on Apple Silicon. The macOS menu bar and Dock settings determine how much of the display AeroSpace can use.

From this directory, run the following on a clean setup. Back up or merge existing AeroSpace files first.

```sh
cp aerospace.toml "$HOME/.aerospace.toml"
/opt/homebrew/bin/aerospace reload-config
```

[AeroSpace fullscreen](https://nikitabobko.github.io/AeroSpace/commands#fullscreen)
