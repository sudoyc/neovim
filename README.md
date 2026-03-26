# neovim 配置

一份纯 `lua` 的 neovim 配置，主要面向竞赛编程和日常开发使用。

## 特性

- 基于 `lazy.nvim` 的插件管理，支持懒加载
- 原生 `lsp` 支持（不依赖 `nvim-lspconfig`），配置了 `clangd`、`pyright`、`lua_ls`
- 单文件编译运行，支持通过 `snacks.picker` 选择编译参数，`snacks.toggle` 切换输入输出重定向
- C/C++ 标准选择（c++14 ~ c++23），自动同步到 `clangd` 并写入 `compile_flags.txt`
- 编译选项持久化，重启后记忆上次的选择
- 基于 `libuv fs_event` 的文件系统监听，外部修改文件后自动刷新缓冲区

## 快捷键

### 运行

| 键 | 功能 |
|---|---|
| `<leader>r` | 编译运行（记忆上次参数） |
| `<leader>R` | 选择编译方式 |
| `<leader>S` | 选择 C/C++ 标准 |
| `<leader>ti` | 切换 `input.txt` 重定向 |
| `<leader>to` | 切换 `output.txt` 重定向 |

### 文件 / 编辑

| 键 | 功能 |
|---|---|
| `<leader>w` | 保存 |
| `<leader>mv` | 重命名当前文件（LSP 感知） |
| `<leader>n` | LSP rename |
| `<leader>F` | 格式化 |
| `<leader>os` | 打开 scratch buffer |

### 查找

| 键 | 功能 |
|---|---|
| `<leader>ff` | 查找文件 |
| `<leader>fr` | 最近文件 |
| `<leader>fb` | 打开的 buffer |
| `<leader>gg` | 当前文件搜索 |
| `<leader>gw` | 搜索当前词 |
| `gd` | 跳转到定义 |

### 窗口 / 终端

| 键 | 功能 |
|---|---|
| `<C-t>` | 切换终端 |
| `alt+hjkl` | 窗口间移动 |
| `<leader>v` | 垂直分屏 |
| `<leader>s` | 水平分屏 |
| `<leader>q` | 关闭窗口 |

## 目录结构

```
.
├── init.lua              # 入口
├── lsp/                  # LSP 配置（clangd, pyright, lua_ls）
├── after/ftplugin/       # 各语言的编译运行配置
├── lua/
│   ├── config/           # 编辑器设置、lazy.nvim 初始化
│   ├── keymap/           # 全局快捷键
│   ├── autocmd/          # 自动命令
│   ├── plugins/          # 插件配置
│   └── utils/            # 工具函数
└── .build_config.lua     # 编译选项持久化（gitignore）
```

## 依赖

- neovim >= 0.10
- `clangd`、`pyright`、`lua-language-server`（按需安装）
- `lazygit`（可选）
