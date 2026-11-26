# =============================================================================
#  fish shell configuration
#  File: ~/.config/fish/config.fish
# =============================================================================

# Homebrew on Apple Silicon, including when Ghostty starts from Finder.
fish_add_path --path /opt/homebrew/bin /opt/homebrew/sbin

# User-installed commands and Rust tools, when those directories exist.
fish_add_path --path "$HOME/.local/bin"
fish_add_path --path "$HOME/.cargo/bin"

if status is-interactive
    # Starship prompt with the current directory and Git status.
    starship init fish | source

    # fzf shortcuts for history (Ctrl+R), paths (Ctrl+T), and directories (Alt+C).
    fzf --fish | source

    # zoxide jumps to known directories by name with 'z name'.
    zoxide init fish | source

    # The eza icons use the Nerd Font configured in ghostty/config.ghostty.
    alias ls 'eza -l --icons --header --group-directories-first'
    alias la 'eza -la --icons --header --group-directories-first'
end
