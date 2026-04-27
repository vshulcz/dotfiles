# dotfiles

Personal macOS dotfiles managed with [chezmoi](https://chezmoi.io).

## What's included

| File | Description |
|------|-------------|
| `~/.config/aerospace/aerospace.toml` | [AeroSpace](https://github.com/nikitabobko/AeroSpace) tiling window manager |
| `~/.config/opencode/AGENTS.md` | [opencode](https://opencode.ai) AI agent instructions (Caveman mode) |
| `~/.config/starship.toml` | [Starship](https://starship.rs) prompt — Tokyo Night powerline style |
| `~/.gitconfig` | Git config — rebase pulls, auto push upstream, auto stash |
| `~/.gitignore_global` | Global gitignore — `.DS_Store`, `.env`, `.idea/`, `.vscode/` |

## Install on a new machine

```bash
# 1. Install chezmoi
brew install chezmoi

# 2. Clone and apply dotfiles in one command
chezmoi init --apply https://github.com/vshulcz/dotfiles

# 3. Install AeroSpace
brew install --cask nikitabobko/tap/aerospace

# 4. Install Starship
brew install starship

# 5. Install JetBrainsMono Nerd Font (required for prompt icons)
brew install --cask font-jetbrains-mono-nerd-font
# Then set the font in your terminal preferences
```

## Daily workflow

```bash
# After editing a dotfile directly (e.g. aerospace.toml):
chezmoi re-add ~/.config/aerospace/aerospace.toml

# Pull changes from GitHub (e.g. on another machine):
chezmoi update

# Add a new file to manage:
chezmoi add ~/.some/config/file

# See what's out of sync:
chezmoi diff
```

## Structure

chezmoi stores sources in `~/.local/share/chezmoi/`. Dots in paths become `dot_` prefix:
- `~/.config/` → `dot_config/`
- `~/.zshrc` → `dot_zshrc`
