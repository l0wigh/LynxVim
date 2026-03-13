# LynxVim 0.3.0

Carefully crafted Neovim **config** that aims to be lightweight and reliable.

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

There is also stuff related to [Soluna](https://github.com/L0Wigh/Soluna), that might be useless for you.

## LynxLine 0.2.X

The LynxLine is probably the heaviest part of the config. At first (0.1.0) it was a pretty simple bar that showed almost no informations.
It has been now pushed to the max. It might not be your cup of tea. Basically it contains a large number of informations that are showed dynamically.

The bar is mostly vibe-coded. The code is still heavily reviewed and tested. If you don't like that I respect, you can easily disable the bar if you want.

- Left side
    - Glyph bar (Nothing Phone 4a inspired) modes representation + Macro recording indicator
    - Filename that becomes red when the file isn't saved
    - Postion in the file
    - Current function or function definition or pinned text
- Right side
    - LynxVim branding when no LSP diagnostics or LSP diagnostics
    - LSP server name (animated on loading)
    - Vibe meter (Keystrokes counter kind of)

## Feels empty...

That's right, I wanted something really basic and where I do my own "plugins". That avoid breaking changes and unwanted behaviors.

If you need more stuff, fork the repo, install and configure new plugins, and you are good to go with your brand new personnal config.

This is just a good starting point, do whatever you want.

## NVChad

Yep, folder structure and a (small) part of the config is based on NVChad.

If you want a fully fledge IDE, go for NVChad (or any other well known "distro", they are awesome).
