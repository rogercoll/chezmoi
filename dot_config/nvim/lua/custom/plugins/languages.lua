return {
  {
    'fatih/vim-go',
    ft = 'go',
    config = function()
      vim.g.go_fmt_autosave = 1
      vim.g.go_fmt_experimental = 1
      vim.g.go_fmt_command = 'goimports'
    end,
  },
  -- Using Neovim's built-in LSP client API (see :h lsp) or nvim-lspconfig.rust_analyzer for now
  -- {
  --   'mrcjkb/rustaceanvim',
  --   ft = 'rust',
  --   lazy = false,
  --   -- or lazy = false,
  --   config = function()
  --     vim.g.rustfmt_autosave = 1
  --     vim.g.rustfmt_emit_files = 1
  --   end,
  -- },
  {
    'rogercoll/open-browser-rustdoc.vim',
    dependencies = {
      'tyru/open-browser.vim',
    },
  },
  {
    'mrcjkb/haskell-tools.nvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
  },
}
