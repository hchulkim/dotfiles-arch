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
