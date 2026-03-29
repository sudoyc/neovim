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
| `<leader>Ti` | 切换 `input.txt` 重定向 |
| `<leader>To` | 切换 `output.txt` 重定向 |

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
| `<leader>ff` | 查找文件（从 `~/` 开始） |
| `<leader>fg` | 查找 git 追踪的文件 |
| `<leader>fr` | 最近文件 |
| `<leader>fb` | 打开的 buffer |
| `<leader>fp` | 项目列表 |
| `<leader>gg` | 当前文件搜索 |
| `<leader>gb` | 在所有打开的 buffer 里 grep |
| `<leader>gw` | 搜索当前词 |
| `gd` | 跳转到定义 |

### 窗口 / 终端

| 键 | 功能 |
|---|---|
| `<C-t>` | 切换运行终端 |
| `<leader>t` | 切换 shell 终端（可用数字前缀开多个） |
| `<Esc>` | 终端 normal 模式 |
| `alt+hjkl` | 窗口间移动 |
| `<leader>v` | 垂直分屏 |
| `<leader>s` | 水平分屏 |
| `<leader>q` | 关闭窗口 |
| `<leader>1~9` | 跳转到第 n 个窗口 |

### Claude Code

| 键 | 功能 |
|---|---|
| `<leader>ac` | 打开/关闭 Claude 面板 |
| `<leader>af` | 聚焦 Claude 面板 |
| `<leader>ar` | 恢复上次会话 |
| `<leader>as` | 发送选中代码给 Claude（visual） |
| `<leader>ab` | 把当前文件加入 Claude 上下文 |
| `<leader>aa` | 接受 Claude 提出的 diff |
| `<leader>ad` | 拒绝 Claude 提出的 diff |

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

---

## 后记

其实最开始用 `neovim` 纯粹是因为觉得酷。

那时候看到别人在终端里飞速敲代码，各种高亮、补全、跳转，感觉像是在操控某种很厉害的东西。于是就跟风装了，然后花了大概一个下午把 `vimtutor` 过了一遍，觉得自己学会了，结果第二天打开发现连怎么退出都忘了。

~~（`:wq` 这种东西真的需要肌肉记忆。）~~

后来慢慢开始折腾配置。最开始是抄的，从各种 github 上找别人的 `init.vim`，复制粘贴，然后发现有些东西跑不起来，再去找原因，再改。就这样一点一点地，开始理解这些配置到底在干什么。

转向纯 `lua` 配置是某次看到有人说 `vimscript` 是"历史遗留问题"之后……虽然不完全认同，但确实 `lua` 写起来顺手很多。

`after/ftplugin` 那套编译运行的逻辑是我比较在意的部分。竞赛的时候最烦的就是切来切去——写完代码要开终端、要编译、要跑、要看输出，手速再快也架不住这些摩擦。所以就想着能不能一个键搞定。最开始写的很粗糙，就是硬编码了一条 `g++` 命令，后来慢慢加了 `input.txt` 的支持，加了 `sanitizer`，加了标准选择……每次加一点，感觉配置越来越像自己的东西了。

有时候会觉得在折腾配置上花的时间比真正写代码的时间还多。但好像也不完全是浪费——至少现在打开编辑器的时候，看到那些快捷键、那些高亮，会有一种"这是我的地方"的感觉。

也许这就够了。
