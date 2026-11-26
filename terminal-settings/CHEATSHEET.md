# Mac terminal cheat sheet

**Ghostty** provides the terminal window. **Fish** runs commands and offers suggestions. **Starship** draws the prompt. This setup shows the current directory, Git status, the duration of longer commands, and the local time when the prompt redraws. A red arrow means the previous command failed.

## Which command should I use?

| I want to… | Command | What it does |
| --- | --- | --- |
| List files in a directory | `ls` or `la` | Both aliases use `eza`. `la` also shows hidden files. |
| Jump back to a project | `z dev-settings` | Zoxide changes to the best matching directory you have visited. |
| Choose from matching directories | `zi dev` or just `zi` | Zoxide uses `fzf` to list remembered directories. Enter changes to the selected directory. |
| Filter a list | `fzf` | Opens a picker without a preview. Enter prints the selected item. You can pipe in your own list, for example `fd -t f \| fzf`. |
| Find a file, preview it, and open it in Zed | `zf` | A custom fish function. `fd` finds files in the current directory tree, `fzf` lets you pick one, and `bat` shows a preview. Enter opens the file through `zed`. |
| Find a file by name | `fd starship` | `fd` prints matching paths. `fd -e rs` finds files with the `.rs` extension. |
| Search the contents of files | `rg -n 'TODO' .` | Ripgrep (`rg`) shows matching lines and line numbers. |
| Read a specific file | `bat terminal-settings/starship.toml` | `bat` displays the file with syntax highlighting. Run this example from the root of `dev-settings`. |
| Open the current directory in the editor | `zed .` | The Zed CLI opens the directory as a project. |
| Put the Mac to sleep | `sleepmac` | A custom fish function that runs `pmset sleepnow`. |

Zoxide starts with an empty database on a new Mac. Visit a project with `cd`, then use `z` to return to it later. [Zoxide](https://github.com/ajeetdsouza/zoxide#-getting-started) · [fzf preview](https://github.com/junegunn/fzf#preview-window)

## Fish shortcuts

| Shortcut | What it does |
| --- | --- |
| **Tab** | Completes a command, path, or option. If several matches are available, fish shows a list. |
| **→** at the end of the line | Accepts the gray autosuggestion. |
| **Ctrl+R** | Searches command history in `fzf`. The selection goes into the command line for editing. Press Enter again to run it. |
| **Ctrl+T** | Inserts a selected path into the command line. For example, type `bat `, use the shortcut, pick a file, and run the command. |
| **Alt+C** | Uses `fzf` to pick a directory below the current one and jump to it. Use `zi` to search directories remembered by zoxide. |
| **Ctrl+C** | Interrupts the running command or clears the current input at the prompt. |

[Fish interactive features](https://fishshell.com/docs/current/interactive.html) · [fzf key bindings](https://github.com/junegunn/fzf#key-bindings-for-command-line)

## Ghostty shortcuts on macOS

| Shortcut | What it does |
| --- | --- |
| **⌥ Space** | Shows or hides the quick terminal, even outside Ghostty when the app has Accessibility permission. |
| **⌘ T** / **⌘ N** | Opens a new tab or window. |
| **⌘ D** / **⌘ ⇧ D** | Opens a split to the right or below. |
| **⌘ W** | Closes the active split, or the tab if it has no splits. |
| **⌘ C** / **⌘ V** | Copies selected text or pastes from the clipboard. |
| **⌘ ⇧ ,** | Reloads the Ghostty configuration. |

**⌥** is Option (Alt), **⌘** is Command, and **⇧** is Shift. [Ghostty actions](https://ghostty.org/docs/config/keybind/reference)

## Other tools

- `brew` installs and updates packages. `brew list` shows the installed Homebrew packages.
- `jq` reads and filters JSON. It is available on this Mac at `/usr/bin/jq`. From the repository root, check Zed's default model with `jq '.agent.default_model' zed-settings/settings.json`.
- `uv` and `uvx` are optional. Use `uv` to manage Python environments and dependencies, and `uvx` to run Python tools in isolated environments. See the [installation instructions](README.md).
