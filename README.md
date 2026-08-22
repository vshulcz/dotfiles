# dotfiles

Personal macOS dotfiles managed with [chezmoi](https://chezmoi.io).

## What's included

| File | Description |
|------|-------------|
| `~/.config/aerospace/aerospace.toml` | [AeroSpace](https://github.com/nikitabobko/AeroSpace) tiling window manager |
| `~/.config/ghostty/` | [Ghostty](https://ghostty.org) terminal — `config` plus `appearance` and `keybinds` includes |
| `~/.config/tmux/tmux.conf` | tmux — mouse on, vi copy mode, splits keep cwd |
| `~/.config/yazi/` | [yazi](https://yazi-rs.github.io) file manager — Catppuccin Mocha, image previews |
| `~/.local/bin/ytm` | search YouTube and stream the audio in the terminal (mpv + yt-dlp + fzf) |
| `~/.config/mpv/mpv.conf` | mpv — YouTube client workaround so ffmpeg can fetch streams |
| `~/.config/lazygit/config.yml` | [lazygit](https://github.com/jesseduffield/lazygit) — full commit graph, Catppuccin colors |
| `~/.config/k9s/` | [k9s](https://k9scli.io) Kubernetes TUI — Catppuccin Mocha skin (macOS gets a symlink from `Library/Application Support`) |
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

# 5. Install Ghostty, tmux and yazi
brew install --cask ghostty
brew install tmux yazi sevenzip poppler fd ripgrep fzf zoxide imagemagick ffmpeg lazygit k9s mpv yt-dlp

# yazi flavors are fetched separately
ya pkg install

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
