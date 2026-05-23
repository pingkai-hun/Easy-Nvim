[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Neovim](https://img.shields.io/badge/Neovim-0.10+-blue.svg)](https://neovim.io)
[![Lua](https://img.shields.io/badge/Lua-5.1-blue.svg)](https://www.lua.org)

## ✨ 特性

| 功能 | 插件 | 说明 |
|------|------|------|
| 🎨 主题 | catppuccin | 柔和优雅的深色主题 |
| 📁 文件树 | nvim-tree.lua | 文件/目录浏览 |
| 🔍 模糊搜索 | telescope.nvim | 文件、文本、LSP 符号搜索 |
| 📊 状态栏 | lualine.nvim | 美观的状态信息 |
| 🌳 语法高亮 | nvim-treesitter | 精准的语法解析 |
| 🔧 LSP | mason.nvim + lspconfig | 代码补全、跳转、诊断 |
| ✍️ 自动补全 | nvim-cmp | 智能代码补全 |
| 📝 代码片段 | LuaSnip + friendly-snippets | 快捷代码模板 |
| 🔄 代码格式化 | conform.nvim | 保存时自动格式化 |
| ✅ 代码检查 | nvim-lint | 实时语法检查 |
| 💬 注释 | Comment.nvim | 快捷注释 |
| 🔖 Git 集成 | gitsigns.nvim | 行内 Git 标记 |
目前启动页还尚未完善，后续更新会替换为Lazy管理器
##快捷键说明
快捷键	功能	模式
<leader>e	打开/关闭文件树	普通
<leader>ff	搜索文件	普通
<leader>fg	全文搜索	普通
gd	跳转到定义	普通
K	查看文档	普通
<leader>rn	重命名符号	普通
<leader>ca	代码操作	普通
<leader>f	格式化代码	普通
gc	注释	普通/可视
<leader>w	保存文件	普通
<leader>q	退出	普通
<C-h/j/k/l>	窗口导航	普通
<leader> 键为空格键

## 🚀 快速安装

### 前置要求

- Neovim 0.10+
- git
- curl
- 可选：ripgrep（用于 telescope 全文搜索）
在Nvim执行:Mason安装LSP服务器选择你需要的语言服务器进行安装
##自动格式化说明(需要在保存时触发)
语言	格式化工具
Lua	    stylua
Python	black
C/C++	clang-format
Rust	rustfmt
Bash	shfmt
### 一键安装

```bash
git clone https://github.com/pingkai-hun/Easy-Nvim.git ~/.config/nvim
nvim +PlugInstall +qall
MIT © pingkai-hun
