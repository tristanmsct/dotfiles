return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      -- python = { "pylint" },
      -- javascript = { "eslint" },
      -- typescript = { "eslint" },
      -- lua = { "luacheck" },
    }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      callback = function()
        pcall(function()
          lint.try_lint()
        end)
      end,
    })
  end,
}
