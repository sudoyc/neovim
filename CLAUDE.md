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
- `lua/utils/init.lua` — utility module: `run(exec)` 发送命令到 toggleterm，`compile_and_run(compiler, flags, io_mode)` 编译运行，`pick(title, items, on_confirm)` 通用 snacks picker，`restart_clangd()` 重启 LSP，`load/save_build_config()` 持久化编译选项到 `.build_config.lua`

**LSP setup:** Uses native Neovim LSP (`vim.lsp.Config`) without nvim-lspconfig. Each server has its own file in `lsp/` (clangd, pyright, lua_ls). `LspRestart` 不可用，用 `utils.restart_clangd()` 代替。

**Filetype plugins:** `after/ftplugin/` 定义三个 buffer-local 函数：
- `vim.b.run_command` — 直接运行（记忆上次 `_G.last_run`）
- `vim.b.pick_run` — 弹 snacks picker 选编译/运行方式
- `vim.b.pick_std` — 弹 snacks picker 选 C/C++ 标准（仅 c/cpp）

**编译选项持久化:** `_G.cpp_std` 和 `_G.last_run` 存储在 `.build_config.lua`，Neovim 启动时由 `utils` 模块自动加载。`.build_config.lua` 已加入 `.gitignore`。

**Plugin specs:** Each file in `lua/plugins/` returns a lazy.nvim spec table. Lazy loading via `event`, `ft`, `cmd`, or `keys`.

## Key Bindings

- `<leader>r` — 运行（记忆上次）, `<leader>R` — picker 选运行方式, `<leader>S` — picker 选 C/C++ 标准
- `<leader>F` — format, `<leader>n` — LSP rename
- `<C-t>` — 终端 toggle
- `<leader>f*` — snacks 文件查找, `<leader>g*` — grep
- `gs*` — mini.surround（gsa/gsd/gsf/gsF/gsh/gsr）

## Conventions

- Plugin keybindings go in the plugin spec's `keys = {}` table, not in `lua/keymap/`
- `lua/keymap/` is for editor-level bindings only
- 快捷键不能有前缀冲突（如 `<leader>b` 和 `<leader>bs` 会导致 timeoutlen 延迟）
- Terminal commands route through `utils.run()` which manages toggleterm state
- LSP configs are standalone files in `lsp/`, not embedded in plugin specs
- 语言：注释和 commit message 使用中文
