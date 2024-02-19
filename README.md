# LynxVim 0.1.2

This is a very lightweight NeoVim configuration, made after that another plugin broke LionVim for no reason.

The goal with this configuration is to stay under 30 plugins and 300 lines (the lines limit might be removed some days).

## Why I made this ?

I wanted a very light and easy to fix configuration that is doing the bare minimum that I need in my everyday life.

The name came from this. Lions are heavy, Lynxes are light.

## What is installed in this ?

    - Catppuccin (default) and Fleet for colorschemes
    - Telescope as file-tree, live grep, and buffers manager
    - Treesitter, lspconfig and Mason
    - nvim-cmp for autocompletion
    - nvim-autopairs
    - lsp_signature

## Many key(re)binds ?

My default nvim binds that I REALLY need and some whichkey like bindings coming from LionVim

It also comes with some custom commands and functions to avoid using some plugins

## Installation

Clean (and backup if needed) your previous nvim installation. (This also serve as an uninstaller for LynxVim)

```sh
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
```

And then start the installer
```sh
./install.sh
```

If you are on Arch based distro, everything is automatic.

If you are on Debian based distro, you'll need to add Deno to your path. The instructions are written during the installation script.

If you are on something else. Install the dependencies : git ripgrep. And copy the init.lua into ~/.config/nvim/
