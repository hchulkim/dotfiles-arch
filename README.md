# dotfiles-arch

Dotfiles for my Arch Linux setup.

## Setup notes

When restoring this config on a fresh machine, the dotfiles alone are not enough — a few system packages need to be installed separately so things render and behave as expected.

### Korean (Hangul) support

The CJK font package is not part of this repo and must be installed manually, otherwise Korean text shows as tofu (□□□) in browsers, terminals, PDFs, and editors:

```sh
sudo pacman -S noto-fonts-cjk
```

Notes:
- The Arch package ships a `fontconfig` hook, so `fc-cache` runs automatically on install — no manual cache rebuild needed.
- Already-running apps (especially Chromium/Electron) cache font lookups at startup; restart the app if Korean still doesn't render right after install.
- Verify with: `fc-list :lang=ko | head`.
- This covers **display only**. To also *type* Hangul, install an IME (e.g. `ibus-hangul`) and wire up the env vars — the `ibus/` config in this repo expects ibus to be present on the system.
- For Korean in Quarto/LaTeX papers, additionally install `texlive-langkorean`.

### Neovim — tree-sitter parsers

`nvim-treesitter` builds parsers from source on first launch, which requires the tree-sitter CLI. Without it, `:TSInstall` fails silently and syntax for several languages stays broken.

```sh
sudo pacman -S tree-sitter-cli
```

### Neovim — vimtex (LaTeX editing)

The `nvim/lua/plugins/vimtex.lua` config assumes three external pieces are present. The plugin will *partially* work without them, which makes the gaps annoying to diagnose.

1. **A LaTeX distribution with `latexmk`.** I use TinyTeX, installed from R so the `~/.local/bin` symlinks get created automatically:
   ```sh
   R -e 'tinytex::install_tinytex()'
   tlmgr option autoinstall 1   # so missing .sty files install on demand
   ```
   Alternative: `sudo pacman -S texlive-basic texlive-latexextra texlive-binextra` if you'd rather use the system TeX Live.

2. **A SyncTeX-aware PDF viewer** (forward search: nvim → PDF):
   ```sh
   sudo pacman -S zathura zathura-pdf-mupdf
   ```

3. **`neovim-remote` for inverse search** (PDF → nvim — Ctrl+click in zathura jumps to the source line). This is the easy-to-miss one; without it, compile and forward search still work, so it looks fine until you try to click around in the PDF:
   ```sh
   pipx install neovim-remote   # provides the `nvr` binary
   ```

Verify the full chain with `:checkhealth vimtex` inside neovim — it lists each dependency it found or didn't.
