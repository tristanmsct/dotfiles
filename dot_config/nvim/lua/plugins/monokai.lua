return {
  {
    "tanvirtin/monokai.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("monokai")

      local transparent = {
        "Normal",
        "NormalNC",
        "NormalFloat",
        "FloatBorder",
        "SignColumn",
        "Pmenu",
        "TabLine",
        "TabLineFill",
        "StatusLine",
        "StatusLineNC",
        "NonText",
      }

      for _, hl in ipairs(transparent) do
        local current = vim.api.nvim_get_hl(0, { name = hl, link = false }) or {}
        vim.api.nvim_set_hl(0, hl, vim.tbl_extend("force", current, { bg = "NONE" }))
      end
    end,
  },
}
