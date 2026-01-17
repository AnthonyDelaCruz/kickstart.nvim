# AGENTS.md

Guide for AI coding agents working on this Neovim configuration (kickstart.nvim-based with lazy.nvim plugin management).

**Key concept**: Configuration project, not traditional software. No build/test cycle—changes take effect on reload.

## Validation & Testing

**Health checks & validation:**
```vim
:checkhealth          " Full system check (LSP, plugins, dependencies)
:Lazy check           " Plugin status
:LspInfo              " LSP server status for buffer
:ConformInfo          " Formatter availability
:Mason                " LSP/tool management
:messages             " Startup messages/errors
```

**Testing changes:**
- Reload: `:source $MYVIMRC` or `:source %` | Restart: `:qa` then reopen
- Format: `stylua .` or `<space>f` in normal mode
- Test keymap: `:verbose map <leader>xy`

## File Structure

```
~/.config/nvim/
├── init.lua                   # Main config (~1031 lines)
├── .stylua.toml               # Formatter config: 2 spaces, 160 chars, single quotes
├── lua/kickstart/plugins/     # Optional plugins (autopairs, gitsigns enabled)
└── lua/custom/plugins/        # Custom plugins (auto-imported, one file per plugin)
```

**Pattern**: Each plugin = separate file in `lua/custom/plugins/*.lua` returning lazy.nvim spec table.

## Code Style

### Formatting & Conventions

- **2 spaces**, 160 chars, Unix `\n`, **single quotes**, trailing commas
- Imports: `require 'module'` (no parens), `vim.keymap.set('n', ...)` (with parens)
- Naming: `snake_case` vars/funcs, descriptive (`builtin` not `b`)
- Types: `---@module 'oil'` `---@type oil.SetupOpts` (optional but encouraged)
- Comments: `desc` for keymaps/autocmds, `--` single-line, `--[[ ]]` multi-line, `-- [[ Section ]]` headers
- Tables: Align keys when readable, always trailing commas

```lua
-- Example: imports, types, tables
local builtin = require 'telescope.builtin'
---@type oil.SetupOpts
local opts = {
  ts_ls   = {},
  eslint  = {},  -- trailing comma
}
```

### Error Handling

```lua
-- Use pcall for optional/risky operations
local ok, result = pcall(require, 'optional-module')
if not ok then
  vim.notify('Module not available', vim.log.levels.WARN)
  return
end

-- Check executables: vim.fn.executable('cmd') == 1
```

## Plugin Management

**Add plugin:** Create `lua/custom/plugins/pluginname.lua`

```lua
-- Minimal (opts auto-calls setup)
return { 'author/plugin', opts = {} }

-- Full spec with lazy loading
return {
  'author/plugin',
  lazy = true,
  event = 'VimEnter',        -- OR cmd/ft/keys
  dependencies = { 'dep' },
  opts = { setting = val },  -- OR config = function() ... end for complex setup
  keys = { { '<leader>x', '<cmd>Cmd<cr>', desc = 'Desc' } },
}
```

**Lazy loading:** `event` (VimEnter=UI, InsertEnter=completion), `cmd`, `ft`, `keys` | `lazy=false` for essential

## LSP & Formatters

### Adding LSP Server

**Location:** `init.lua` around line 699

```lua
local servers = {
  ts_ls = {},
  lua_ls = { settings = { Lua = { completion = { callSnippet = 'Replace' } } } },
  rust_analyzer = {},  -- Add your server
}
```

Mason auto-installs on next start, or `:Mason` manually.

### Adding Formatter

**Location:** `init.lua` around line 793

```lua
formatters_by_ft = {
  lua = { 'stylua' },
  javascript = { 'prettierd', 'prettier', stop_after_first = true },
  python = { 'black', 'isort' },  -- Add your language
}
```

Formatters auto-install via Mason. Check: `:ConformInfo`

## Keymaps

**Always provide descriptions:**
```lua
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
```

**Modes:** `'n'` (normal), `'i'` (insert), `'v'` (visual), `'t'` (terminal), `''` (all)

**Leader groups:** `<leader>s` [S]earch | `<leader>t` [T]oggle | `<leader>h` Git [H]unk | `<leader>l` [L]azyGit | `<leader>o` [O]il | `gr*` LSP goto

**Where:** Plugin keymaps in `keys` field (lazy loads) | Global in `init.lua` `[[ Basic Keymaps ]]` section

## Common Patterns

**Autocommands:**
```lua
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('my-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})
```

**Conditional loading:**
```lua
{ 'plugin/name', cond = function() return vim.fn.executable('make') == 1 end }
```

## Debugging & Troubleshooting

- Plugin not loading → `:Lazy` shows errors
- LSP not working → `:LspInfo` and `:Mason`
- Formatter not found → `:ConformInfo`
- Keymap conflict → `:verbose map <key>`
- Startup errors → `:messages`

## Best Practices

1. Read `init.lua` before editing
2. Test with `:checkhealth` or `:Lazy check` after changes
3. Match code style (single quotes, 2 spaces, trailing commas)
4. Add plugins as separate files in `lua/custom/plugins/`
5. Prefer `opts` over `config` when possible
6. Lazy load non-essential plugins (`keys`, `cmd`, `ft`)
7. Always add `desc` fields for keymaps/autocmds
8. Preserve kickstart.nvim principles

## Reference

- Neovim: `:help` | https://neovim.io/doc/
- Lazy.nvim: https://github.com/folke/lazy.nvim
- Kickstart: https://github.com/nvim-lua/kickstart.nvim
