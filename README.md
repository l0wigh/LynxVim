# LynxVim 0.2.0

Carefully crafted Neovim *config* that aims to be lightweight and reliable.

This is a good starting point for anyone trying to make their own config from (almost) scratch.

## Install

Backup your existing config if needed. Then do :

```sh
git clone https://github.com/L0Wigh/LynxVim ~/.config/nvim
```

Finally, simply run neovim and wait for Lazy to install the required plugins.

## Plugins

Mostly LSP stuff and themes. It also contains a custom LynxLine and some scripts.

Scripts included:
- <leader>mm -> Compile with current makeprg command and open the quickfix list
- <leader>ms -> Let user set a custom command for the current buffer (will work with <leader>mm or :make)

## Feels empty...

That's right, I wanted something really basic and where I do my own "plugins". That avoid breaking changes and unwanted behaviors.

If you need more stuff, fork the repo, install and configure new plugins, and you are good to go with your brand new personnal config.

This is just a good starting point, do whatever you want.

## NVChad

Yep, folder structure and a (small) part of the config is based on NVChad.

If you want a fully fledge IDE, go for NVChad (or any other well known "distro", they are awesome).
