return {
  'ibhagwan/fzf-lua',
  dependencies = { 'echasnovski/mini.icons' },
  opts = {},
  keys = {
    { '<leader>sf', '<cmd>FzfLua files<cr>', desc = 'Search files in project' }, -- Note that the root of the search would be on the directory where you ran "nvim"
    { '<leader>sg', '<cmd>FzfLua live_grep<cr>', desc = 'Grep current project' },
    { '<leader><leader>', '<cmd>FzfLua buffers<cr>', desc = 'Open current buffers' },
    { '<leader>sk', '<cmd>FzfLua keymaps<cr>', desc = 'Search keymaps' },
    { '<leader>sh', '<cmd>FzfLua helptags<cr>', desc = 'Search Nvim help tags' },
    { '<leader>sd', '<cmd>FzfLua diagnostics_document<cr>', desc = 'Search Document Diagnostics' },
    { '<leader>sD', '<cmd>FzfLua diagnostics_workspace<cr>', desc = 'Search Workspace Diagnostics' },
    { '<leader>/', '<cmd>FzfLua grep_curbuf<cr>', desc = 'Search current buffer' },
    { '<leader>fw', '<cmd>FzfLua grep_cword<cr>', desc = 'Find word under cursor' },
    { '<leader>fW', '<cmd>FzfLua grep_cWORD<cr>', desc = 'Find WORD under cursor' },
  },
}
