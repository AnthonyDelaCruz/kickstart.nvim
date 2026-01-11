return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    -- Configure oil behavior
    default_file_explorer = true, -- Oil handles directory buffers (nvim .)
    columns = {
      'icon',
      'permissions',
      'size',
      'mtime',
    },
    view_options = {
      show_hidden = true,
    },
  },
  -- Optional dependencies
  dependencies = { { 'nvim-mini/mini.icons', opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
  keys = {
    {
      '<leader>o',
      '<cmd>Oil<cr>',
      desc = 'Open oil at current file',
    },
    {
      '<leader>O',
      function()
        require('oil').open(vim.fn.getcwd())
      end,
      desc = 'Open oil at working directory',
    },
    {
      '<leader>fo',
      '<cmd>Oil --float<cr>',
      desc = 'Open oil in floating window',
    },
  },
}
