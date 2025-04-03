return {
  'stevearc/oil.nvim',
  config = function()
    local allowed_dotfiles = {
      '.gitignore',
      '.env',
      '.env.local',
      '.env.production',
      '.eslintrc',
      '.eslintrc.js',
      '.eslintrc.json',
      '.prettierrc',
      '.prettierrc.js',
      '.prettierrc.json',
    }

    ---@type oil.SetupOpts
    require('oil').setup {
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, bufnr)
          -- Check if it's a dotfile
          if name:sub(1, 1) == '.' then
            -- Hide it if it's NOT in the allowed list
            return not vim.tbl_contains(allowed_dotfiles, name)
          end

          -- Show all non-dotfiles
          return false
        end,
      },
    }
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
  end,
  -- Optional dependencies
  dependencies = { { 'echasnovski/mini.icons', opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
