# My Neovim config

Inspired by:

- https://github.com/2kabhishek/nvim2k
- https://www.jakewiesler.com/blog
- https://github.com/vuki656/nvim-config
- https://github.com/LunarVim/nvim-basic-ide
- https://github.com/LunarVim/Neovim-from-scratch
- https://github.com/Allaman/nvim/
- https://github.com/nvim-lua/kickstart.nvim

## Videos with good instructions

- [How I Setup LSP In Neovim For An Amazing Dev Experience - Full Guide](https://www.youtube.com/watch?v=NL8D8EkphUw)
- [How to setup Neovim from Scratch - Complete Guide (Including TMUX, Lazy and LSP)](https://www.youtube.com/watch?v=ZjMzBd1Dqz8&t=6842s)
- [0 to LSP : Neovim RC From Scratch](https://www.youtube.com/watch?v=w7i4amO_zaE)
- [pluginless neovim](https://www.youtube.com/watch?v=I5kT2c2XX38)
- [How to set up Neovim for coding React, TypeScript, Tailwind CSS, etc on a new M2 MacBook Air](https://www.youtube.com/watch?v=ajmK0ZNcM4Q)
- [The (almost) perfect Neovim setup for Node.js](https://www.youtube.com/watch?v=CVCBHHFXWNE)
- [Code Folding in Neovim](https://www.youtube.com/watch?v=f_f08KnAJOQ)
- [How To Setup Linting And Formatting In Neovim To Replace null-ls](https://www.youtube.com/watch?v=ybUE4D80XSk&pp=ygUGbmVvdmlt)
- [How to Do 90% of What Plugins Do (With Just Vim)](https://www.youtube.com/watch?v=XA2WjJbmmoM)
- [Vim Navigation Commands](https://www.youtube.com/watch?v=Qem8cpbJeYc)
- [Mastering the Vim Language](https://www.youtube.com/watch?v=wlR5gYd6um0)

# Setup new system configuration

## 1. Install nix package manager

```
sh <(curl -L https://nixos.org/nix/install) --daemon
```

## 2. Install packages with nix

### [Lazygit](https://github.com/jesseduffield/lazygit#installation)

```
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
```

Or use Nix. Nix might be a version behind the github repo.

```
nix-env -iA nixpkgs.lazygit
```

### [Nodejs](https://search.nixos.org/packages?channel=23.05&show=nodejs_20&from=0&size=50&sort=relevance&type=packages&query=nodejs)

```
nix-env -iA nixpkgs.nodejs_20
```

When installing global node packages on Linux you need to edit `~/.npmrc` so that it tells npm to install and find "global" packages in your home folder instead of the root location:

```
prefix=~/.npm-packages
```

now any time you run npm i -g <some-package> you will see that it will be installed inside of ~/.npm-packages.

Now in your shell rc file (f.e. .bashrc or .zshrc or similar), you'll need to update your PATH to include executables from the new location:

### Add NPM executables to your PATH so that they are available as commands:

```
export PATH="$HOME/.npm-packages/bin:$PATH"
```

Often it is more convenient to manage ephemeral dependencies outside of the system-level package manager.

If you use something like n or nvm to manage specific node versions, you can do a similar thing by managing them in your home folder.
Taken from https://stackoverflow.com/a/59606924/2527950

### [Neovim](https://search.nixos.org/packages?channel=23.05&show=neovim&from=0&size=50&sort=relevance&type=packages&query=neovim)

```

nix-env -iA nixpkgs.neovim

```

Install ripgrep for telescope grep search

```

sudo apt-get install ripgrep
# or
nix-env -iA nixpkgs.ripgrep

```

Install [Nerd font](https://www.nerdfonts.com/font-downloads) for terminal icons in Neovim
