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

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
          side = "left",
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
        update_focused_file = {
          enable = true,
        },
      })
    end,
  },
})

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>f", ":NvimTreeFocus<CR>", { noremap = true, silent = true })
