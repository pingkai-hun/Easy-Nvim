-- ============================================
-- Easy-Nvim 单文件版
-- ============================================

vim.deprecate = function() end

-- 基础设置
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.mouse = "a"
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.updatetime = 250
vim.opt.scrolloff = 5

-- 快捷键
local map = vim.keymap.set
map("n", "<leader>w", ":w<CR>")
map("n", "<leader>q", ":q<CR>")
map("n", "<leader>h", ":nohlsearch<CR>")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
map("n", "gd", "<cmd>Telescope lsp_definitions<CR>")
map("n", "K", vim.lsp.buf.hover)

-- 自动命令
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
autocmd("BufEnter", {
    group = augroup("EasyNvim", { clear = true }),
    pattern = "*",
    callback = function() vim.cmd("silent! lcd %:p:h") end,
})
autocmd("BufWritePre", {
    group = augroup("EasyNvim", { clear = true }),
    pattern = "*",
    callback = function() vim.cmd("%s/\\s\\+$//e") end,
})

-- vim-plug
local plug_path = vim.fn.stdpath("data") .. "/site/autoload/plug.vim"
if not vim.loop.fs_stat(plug_path) then
    vim.fn.system({
        "curl", "-fLo", plug_path, "--create-dirs",
        "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    })
end

vim.cmd([[
call plug#begin(stdpath('data') . '/site/plugged')
Plug 'catppuccin/nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'glepnir/dashboard-nvim'
Plug 'numToStr/Comment.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'rafamadriz/friendly-snippets'
Plug 'windwp/nvim-autopairs'
Plug 'stevearc/conform.nvim'
Plug 'mfussenegger/nvim-lint'
call plug#end()
]])

-- 主题
vim.cmd.colorscheme("catppuccin")

-- 其他插件配置
vim.defer_fn(function()
    pcall(function()
        require("nvim-tree").setup()
        require("telescope").setup()
        require("lualine").setup({ options = { theme = "catppuccin" } })
        require("gitsigns").setup()
        require("nvim-autopairs").setup()
        require("Comment").setup()

        require("conform").setup({
            format_on_save = { timeout_ms = 500, lsp_fallback = true },
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "black" },
                c = { "clang-format" },
                cpp = { "clang-format" },
            },
        })

        require("lint").linters_by_ft = { python = { "pylint" } }
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function() require("lint").try_lint() end,
        })

        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "pyright", "clangd" },
            handlers = {
                function(server_name)
                    lspconfig[server_name].setup({ capabilities = capabilities })
                end,
            },
        })

        local cmp = require("cmp")
        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif require("luasnip").expand_or_jumpable() then
                        require("luasnip").expand_or_jump()
                    else
                        fallback()
                    end
                end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
            }),
        })

        print("其他插件加载完成")
    end)
end, 500)

print("Easy-Nvim 入口加载完成")


