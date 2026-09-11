-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set the leader key (space is the common choice)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- optional visual settings
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true

-- keep transparent background like the legacy init.vim
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE", ctermfg = "NONE" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE", ctermfg = "NONE" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE", ctermfg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE", ctermfg = "NONE" })
vim.api.nvim_set_hl(0, "TabLine", { bg = "NONE", ctermfg = "NONE" })
vim.api.nvim_set_hl(0, "NonText", { bg = "NONE", ctermbg = "NONE" })

require("config.lazy")
