return {
  'coder/claudecode.nvim',
  dependencies = { 'folke/snacks.nvim' },
  opts = {
    -- Use floating window for Claude Code display
    terminal = {
      provider = 'auto', -- Use snacks.nvim for terminal management
      snacks_win_opts = {
        position = 'float', -- Floating window instead of split
        width = 0.95, -- 95% of screen width
        height = 0.95, -- 95% of screen height
        border = 'rounded', -- Rounded borders
        backdrop = 80, -- Dim background when floating
      },
    },
  },
  config = function(_, opts)
    require('claudecode').setup(opts)

    -- Add keybind to close Claude window from terminal mode
    vim.api.nvim_create_autocmd('TermOpen', {
      pattern = 'term://*',
      callback = function()
        local bufname = vim.api.nvim_buf_get_name(0)
        if bufname:match('claude') then
          -- Double Esc to close Claude window from terminal mode
          vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>:q<CR>', { buffer = true, silent = true, desc = 'Close Claude' })
        end
      end,
    })
  end,
  keys = {
    { '<leader>a', nil, desc = 'AI/Claude Code' },
    { '<leader>ac', '<cmd>ClaudeCode<cr>', desc = 'Toggle Claude' },
    { '<leader>af', '<cmd>ClaudeCodeFocus<cr>', desc = 'Focus Claude' },
    { '<leader>ar', '<cmd>ClaudeCode --resume<cr>', desc = 'Resume Claude' },
    { '<leader>aC', '<cmd>ClaudeCode --continue<cr>', desc = 'Continue Claude' },
    { '<leader>am', '<cmd>ClaudeCodeSelectModel<cr>', desc = 'Select Claude model' },
    { '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>', desc = 'Add current buffer' },
    { '<leader>as', '<cmd>ClaudeCodeSend<cr>', mode = 'v', desc = 'Send to Claude' },
    {
      '<leader>as',
      '<cmd>ClaudeCodeTreeAdd<cr>',
      desc = 'Add file',
      ft = { 'NvimTree', 'neo-tree', 'oil', 'minifiles', 'netrw' },
    },
    { '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>', desc = 'Accept diff' },
    { '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>', desc = 'Deny diff' },
  },
}
