# Ghostty and fish on Apple Silicon

This is the terminal setup from my Mac mini. Ghostty starts fish directly. The export includes the Everforest theme, the JetBrainsMono Nerd Font setting, the Starship prompt, the shell integrations and shortcuts, and my fish functions.

[Terminal commands and shortcuts](CHEATSHEET.md)

## Install on a clean Mac

1. Install Homebrew and follow its setup instructions to put it on your PATH. [Homebrew installation](https://brew.sh/)
2. Open Terminal and run the following commands from this `terminal-settings` directory.

   ```sh
   brew install fish zoxide fzf starship eza fd bat ripgrep
   brew install --cask ghostty font-jetbrains-mono-nerd-font zed

   config_dir="${XDG_CONFIG_HOME:-$HOME/.config}"
   mkdir -p "$config_dir/ghostty" "$config_dir/fish"
   cp -R ghostty/. "$config_dir/ghostty/"
   cp -R fish/. "$config_dir/fish/"
   cp starship.toml "$config_dir/starship.toml"
   ```

   Use the copy commands as written on a clean installation. On a Mac with existing settings, back up and merge the matching files first. Ghostty can also load macOS-specific settings from `~/Library/Application Support/com.mitchellh.ghostty/`. Check that directory if Ghostty uses different values after restoration. [Ghostty configuration](https://ghostty.org/docs/config) · [fish configuration](https://fishshell.com/docs/current/language.html#configuration-files)

3. Open Ghostty. It uses `/opt/homebrew/bin/fish` without changing the macOS login shell. For the global `Option-Space` quick-terminal shortcut, grant Accessibility access to Ghostty if macOS prompts you. The `zf` function uses the `zed` CLI. If you already installed Zed without Homebrew, use Zed's `cli: install cli binary` command instead. [Zed CLI](https://zed.dev/docs/reference/cli)

If you also want the Python tools `uv` and `uvx`, run `brew install uv`. The fish configuration adds `~/.local/bin` and `~/.cargo/bin` to PATH when those directories exist. [uv installation](https://docs.astral.sh/uv/getting-started/installation/)

## What to try

| Command or shortcut | Behavior |
| --- | --- |
| `z <name>`, `zi` | Jump to a known directory or choose one with a fuzzy picker. Visit a few directories first so zoxide can learn them. |
| `Ctrl-R`, `Ctrl-T`, `Alt-C` | fzf widgets for history, file paths, and changing directories. |
| `Tab` | fish completions. Installed packages supply their own completions where available. |
| `zf` | Pick a file with `fd` and `fzf`, preview it with `bat`, and open it in Zed. |
| `ls`, `la` | Detailed file listings with icons via `eza`. |
| `sleepmac` | Put the Mac to sleep. |
| `Option-Space` | Toggle Ghostty's quick terminal. |

Shell history and zoxide's directory database are local to each Mac.
