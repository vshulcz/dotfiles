# dotfiles

Personal macOS dotfiles managed with [chezmoi](https://chezmoi.io).

## What's included

| File | Description |
|------|-------------|
| `~/.config/aerospace/aerospace.toml` | [AeroSpace](https://github.com/nikitabobko/AeroSpace) tiling window manager |
| `~/.config/ghostty/config` | [Ghostty](https://ghostty.org) terminal — Catppuccin Mocha, splits, quick terminal |
| `~/.config/tmux/tmux.conf` | tmux — mouse on, vi copy mode, splits keep cwd |
| `~/.config/starship.toml` | [Starship](https://starship.rs) prompt — Tokyo Night powerline style |
| `~/.gitconfig` | Git config — rebase pulls, auto push upstream, auto stash, SSH commit signing when the key is present |
| `~/.gitignore_global` | Global gitignore — `.DS_Store`, `.env`, `*.local`, editor dirs, Claude local settings |

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

# 5. Install Ghostty and tmux
brew install --cask ghostty
brew install tmux

# 6. Install JetBrainsMono Nerd Font (required for prompt icons)
brew install --cask font-jetbrains-mono-nerd-font
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

chezmoi stores sources in `~/.local/share/chezmoi/`. Dots in paths become `dot_` prefix, and
templated files end in `.tmpl`:

- `~/.config/` → `dot_config/`
- `~/.gitconfig` → `dot_gitconfig.tmpl`

`.gitconfig` is a template so the SSH signing paths resolve per machine. Commit signing turns
itself off when `~/.ssh/id_ed25519_signing.pub` is missing, so a fresh machine can still commit.

`README.md` is listed in `.chezmoiignore` — it belongs to the repo, not to `$HOME`.
