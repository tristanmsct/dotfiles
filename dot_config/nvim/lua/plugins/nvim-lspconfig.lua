return {
  "neovim/nvim-lspconfig",
  config = function()
    -- Setup keymaps on LspAttach
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf
        local opts = { noremap = true, silent = true, buffer = bufnr }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      end,
    })

    -- Configure servers using vim.lsp.config (Neovim 0.11+)
    for server_name, config in pairs({
      lua_ls = {},
      pylsp = {},
    }) do
      vim.lsp.config(server_name, config)
      vim.lsp.enable(server_name)
    end
  end,
}
