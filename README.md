## My Productivity Workflow

### Main Applications

- OS: [Arch Linux](https://archlinux.org/)
- Desktop Environment: [qtile](https://qtile.org/)
- Terminal: [kitty](https://sw.kovidgoyal.net/kitty/) + [tmux](https://github.com/tmux/tmux/wiki)
- Shell: [fish](https://fishshell.com/)
- Editor: [neovim](https://neovim.io/)
- Browser: [firefox](https://www.mozilla.org/en-US/firefox/new/)
- File Manager: [ranger](https://github.com/ranger/ranger)

Other applications in the workflow is found at (TODO add files).

## Installation

You will need `git` and GNU `stow`

Clone into your `$HOME` directory or `~`

```bash
git clone https://github.com/itsdawei/dotfiles ~
```

Run `stow` to symlink everything or just select what you want

```bash
stow */ # Everything (the '/' ignores the README)
```

```bash
stow zsh # Just my zsh config
```

