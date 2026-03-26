# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal Neovim configuration using lazy.nvim as the plugin manager. The config is written entirely in Lua.

## Architecture

**Bootstrap flow:** `init.lua` → checks for VSCode → requires `config`, `keymap`, `autocmd`

- `lua/config/init.lua` — editor settings, diagnostic config, `vim.lsp.enable()` for LSP servers
- `lua/config/lazy.lua` — lazy.nvim bootstrap and plugin loader (auto-imports `lua/plugins/`)
- `lua/keymap/init.lua` — global keybindings (leader = Space, localleader = `\`)
- `lua/autocmd/init.lua` — autocommands (auto-mkdir, auto-cd, cursor restore, skeleton templates, etc.)
- `lua/utils/init.lua` — utility module, notably `run(exec)` for sending commands to toggleterm

**LSP setup:** Uses native Neovim LSP (`vim.lsp.Config`) without nvim-lspconfig. Each server has its own file in `lsp/` (clangd, pyright, lua_ls) returning a config table with `cmd`, `filetypes`, `root_markers`, `on_attach`, `on_init`.

**Filetype plugins:** `after/ftplugin/` sets buffer-local options and defines `vim.b.run_command` for per-filetype execution (C/C++ compile+run with sanitizers, Python run).

**Plugin specs:** Each file in `lua/plugins/` returns a lazy.nvim spec table. Lazy loading via `event`, `ft`, `cmd`, or `keys`.

## Conventions

- Plugin keybindings go in the plugin spec's `keys = {}` table, not in `lua/keymap/`
- `lua/keymap/` is for editor-level bindings only
- Terminal commands route through `utils.run()` which manages toggleterm state
- LSP configs are standalone files in `lsp/`, not embedded in plugin specs
- 语言：注释和 commit message 使用中文
