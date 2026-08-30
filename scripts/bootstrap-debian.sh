#!/usr/bin/env bash
#
# Set up a Debian box (or container) for these dotfiles — shell sessions only.
# The yabai/skhd window-manager configs are macOS-only and are removed at the end.
#
# Works on bookworm (12) and trixie (13+).

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SUDO=""; [ "$(id -u)" -eq 0 ] || SUDO=sudo

$SUDO apt-get update -qq
$SUDO apt-get install -y --no-install-recommends \
  zsh git curl ca-certificates gnupg python3 \
  ncurses-bin `# tic, for the kitty terminfo step` \
  build-essential `# telescope-fzf-native builds with make` \
  fzf zoxide ripgrep less locales

# eza is not packaged before trixie; config/zshrc skips the alias without it.
$SUDO apt-get install -y --no-install-recommends eza 2>/dev/null || true

# This config needs nvim >= 0.11 (vim.lsp.config, nvim/lsp/); no Debian release
# ships that yet, so take it from upstream unless a new enough one is present.
if ! nvim --version 2>/dev/null | head -1 | grep -qE 'v0\.(1[1-9]|[2-9][0-9])|v[1-9]'; then
  arch=$([ "$(uname -m)" = aarch64 ] && echo arm64 || echo x86_64)
  curl -fsSL "https://github.com/neovim/neovim/releases/download/v0.11.2/nvim-linux-${arch}.tar.gz" \
    | $SUDO tar xz -C /opt
  $SUDO ln -sf "/opt/nvim-linux-${arch}/bin/nvim" /usr/local/bin/nvim
fi

# Debian ships ~/.bashrc as a real file; dotbot only relinks symlinks, so the
# link fails and ./install exits 1.
if [ -e "$HOME/.bashrc" ] && [ ! -L "$HOME/.bashrc" ]; then
  mv "$HOME/.bashrc" "$HOME/.bashrc.orig"
fi

"$DOTFILES/install"

# macOS-only configs that dotbot links regardless of platform.
rm -f "$HOME/.skhdrc" "$HOME/.yabairc" "$HOME/.Brewfile"
rm -rf "$HOME/.config/yabai"

echo "Done. Start a shell with: zsh -l"
