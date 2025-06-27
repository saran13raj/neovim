--[[
~/.local/state/nvim/shada -- neovim shada
What is Kickstart?

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
-- vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = false

--Line numbers
vim.wo.number = true

vim.cmd [[ set termguicolors ]]

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
-- vim.o.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- custom keymap set

-- move to first char of line
vim.keymap.set('n', '1', '0', { desc = 'Start of line' })

-- move to 1st non white space char
vim.keymap.set('n', '2', '^', { desc = 'First non-whitespace character' })

-- move to end char of line
vim.keymap.set('n', '0', '$', { desc = 'End of line' })

-- jump/scroll with cursor in center
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '{', '{zz')
vim.keymap.set('n', '}', '}zz')

-- nav buffers
vim.keymap.set('n', 'gn', ':bnext<CR>', { noremap = true, silent = true, desc = 'Next buffer' })
vim.keymap.set('n', 'gN', ':bprevious<CR>', { noremap = true, silent = true, desc = 'Previous buffer' })
vim.keymap.set('n', 'gbd', ':%bd|edit#|bd#<CR>', { noremap = true, silent = true, desc = 'Clear all buffers except current' })

-- spell check
-- vim.opt.spell = true
-- vim.opt.spelllang = 'en_us'

-- tabstop width
vim.o.tabstop = 4

-- delete but dont copy
vim.keymap.set('n', 'd', '"_d', { noremap = true })
vim.keymap.set('x', 'd', '"_d', { noremap = true })

-- disable auto comment on continuation
vim.api.nvim_create_autocmd('FileType', {
  pattern = '*',
  callback = function()
    vim.opt_local.formatoptions:remove { 'r', 'o' }
  end,
})

-- set 2 cols for signs near line number
vim.o.signcolumn = 'yes:2'

-- pop up menu to show 10 items
vim.o.pumheight = 10

-- split screen
vim.keymap.set('n', '|', ':vsplit<CR>', { noremap = true, silent = true })

-- custom macros
local esc = vim.api.nvim_replace_termcodes('<Esc>', true, true, true)

vim.api.nvim_create_augroup('JSLogMacro', { clear = true })

-- console.log ts, js
vim.api.nvim_create_autocmd('FileType', {
  group = 'JSLogMacro',
  pattern = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  callback = function()
    vim.fn.setreg('l', "veyoconsole.log('" .. esc .. "pa:::', " .. esc .. 'pa)')
  end,
})

-- for harpoon2
local keys = {
  {
    '<leader>A',
    function()
      require('harpoon'):list():add()
    end,
    desc = 'Harpoon add file',
  },
  {
    '<leader>ad',
    function()
      require('harpoon'):list():remove()
    end,
    desc = 'Harpoon remove file',
  },
}

-- Add keys for selecting harpoon marks 1-5
for i = 1, 5 do
  table.insert(keys, {
    '<leader>' .. i,
    function()
      require('harpoon'):list():select(i)
    end,
    desc = 'Harpoon go to file ' .. i,
  })
end

-- toggle format on save (Custom)
vim.keymap.set('n', '<leader>uf', function()
  vim.g.disable_autoformat = not vim.g.disable_autoformat
  vim.notify('Autoformat on save: ' .. (vim.g.disable_autoformat and 'OFF' or 'ON'))
end, { desc = 'Toggle autoformat on save' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- mdx syntax highlight
vim.filetype.add {
  extension = {
    mdx = 'mdx',
  },
}

-- tell treesitte to use markdown parser for mdx
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'mdx',
  callback = function(args)
    vim.treesitter.start(args.buf, 'markdown')
    vim.bo[args.buf].syntax = 'on' -- optional, for legacy syntax support
  end,
})

-- to move line up or down
-- Normal mode
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move line down', noremap = true, silent = true })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up', noremap = true, silent = true })

-- Insert mode
vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { desc = 'Move line down', noremap = true, silent = true })
vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { desc = 'Move line up', noremap = true, silent = true })

-- Visual mode
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down', noremap = true, silent = true })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up', noremap = true, silent = true })

-- for cheatsheet
-- local cheatsheet = require 'custom.cheatsheet'
-- vim.keymap.set('n', '<leader>cs', cheatsheet.open_cheatsheet, {
--   noremap = true,
--   silent = true,
--   desc = 'Cheatsheet',
-- })

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

-- list running lsp clients
local function lsp_clients()
  local clients = vim.lsp.get_clients { bufnr = 0 }
  if #clients == 0 then
    return ''
  end
  local names = {}
  for _, client in ipairs(clients) do
    table.insert(names, client.name)
  end
  return ' [ ' .. table.concat(names, ', ') .. ' ]'
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
  --

  -- Alternatively, use `config = function() ... end` for full control over the configuration.
  -- If you prefer to call `setup` explicitly, use:
  --    {
  --        'lewis6991/gitsigns.nvim',
  --        config = function()
  --            require('gitsigns').setup({
  --                -- Your gitsigns configuration here
  --            })
  --        end,
  --    }
  --
  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`.
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      signs_staged_enable = true,
      current_line_blame = true,
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.o.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  -- { -- for file dir (custom)
  --   'nvim-tree/nvim-tree.lua',
  --   config = function()
  --     require('nvim-tree').setup {
  --       filters = {
  --         custom = { '^\\.git$', '^\\.github$' },
  --       },
  --       view = {
  --         side = 'right',
  --         width = 30,
  --         -- mappings = {
  --         --   list = {
  --         --     { key = '?', action = 'toggle_help' },
  --         --     { key = "'", action = 'close_node' },
  --         --     { key = '"', action = 'collapse_all' },
  --         --   },
  --         -- },
  --       },
  --       diagnostics = { enable = true, show_on_dirs = true },
  --       update_focused_file = {
  --         enable = true,
  --         update_root = true,
  --         ignore_list = { 'help' },
  --       },
  --       renderer = {
  --         indent_markers = {
  --           enable = true,
  --         },
  --         icons = {
  --           git_placement = 'signcolumn',
  --           show = {
  --             file = true,
  --             folder = false,
  --             folder_arrow = true,
  --             git = true,
  --           },
  --         },
  --       },
  --     }
  --     -- toggle file dir with space + dot
  --     vim.keymap.set('n', '<c-.>', ':NvimTreeFindFile<CR>')
  --     -- vim.keymap.set('n', '\\', ':NvimTreeToggle<CR>', { desc = 'Toggle tree view' })
  --     vim.keymap.set('n', '\\', ':NvimTreeToggle<CR>', { desc = 'Toggle tree view', noremap = true, nowait = true })
  --   end,
  -- },

  { -- auto session manager (custom)
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      }
    end,
  },

  { -- undo tree (custom)
    'mbbill/undotree',
    opts = {},
    config = function()
      vim.keymap.set('n', '<leader>z', vim.cmd.UndotreeToggle)
    end,
  },

  -- { -- for tagbar
  --   'preservim/tagbar',
  --   cmd = { 'TagbarToggle', 'TagbarOpen', 'TagbarClose' },
  --   keys = {
  --     { '<leader>tt', '<cmd>TagbarToggle<CR>', desc = 'Toggle Tagbar' },
  --   },
  --   config = function()
  --     -- Optional: set Tagbar options here, e.g.
  --     -- vim.g.tagbar_autofocus = 1
  --   end,
  -- },

  { -- for prettierd - nyll-ls (custom)
    'nvimtools/none-ls.nvim',
    config = function()
      local null_ls = require 'null-ls'

      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.diagnostics.credo.with {
            condition = function(utils)
              return utils.root_has_file '.credo.exs'
            end,
          },
        },
      }
    end,
  },

  { -- for colorizer (custom)
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end,
  },

  { -- for scrollbar
    'petertriho/nvim-scrollbar',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'kevinhwang91/nvim-hlslens',
    },
    opts = {
      handle = {
        color = '#5c7a91',
      },
    },
  },

  { -- for fold
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async',
    },
    event = 'VeryLazy',
    config = function()
      require('ufo').setup {
        provider_selector = function(bufnr, filetype, buftype)
          return { 'lsp', 'indent' }
        end,
      }
      -- vim.o.foldcolumn = '1' -- Optional: show fold column
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
  },

  { -- for tailwindcss

    'luckasRanarison/tailwind-tools.nvim',
    name = 'tailwind-tools',
    build = ':UpdateRemotePlugins',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim', -- optional
      'neovim/nvim-lspconfig', -- optional
    },
    opts = {}, -- your configuration
  },

  { -- for mouse hover
    'lewis6991/hover.nvim',
    config = function()
      require 'hover.providers.diagnostic'
      require 'hover.providers.highlight'
      require('hover').setup {
        init = function()
          require 'hover.providers.lsp'
          require 'hover.providers.gh'
          require 'hover.providers.gh_user'
          require 'hover.providers.jira'
          require 'hover.providers.dap'
          require 'hover.providers.fold_preview'
          require 'hover.providers.diagnostic'
          require 'hover.providers.man'
          require 'hover.providers.dictionary'
          require 'hover.providers.highlight'
        end,
        preview_opts = {
          border = 'single',
        },
        -- Whether the contents of a currently open hover window should be moved
        -- to a :h preview-window when pressing the hover keymap.
        preview_window = false,
        title = true,
        mouse_providers = {
          'LSP',
          'Diagnostics',
          -- 'Highlight',
        },
        mouse_delay = 800,
      }

      -- Setup keymaps
      vim.keymap.set('n', '<C-p>', function()
        require('hover').hover_switch 'previous'
      end, { desc = 'hover.nvim (previous source)' })
      vim.keymap.set('n', '<C-n>', function()
        require('hover').hover_switch 'next'
      end, { desc = 'hover.nvim (next source)' })

      -- Mouse support
      vim.keymap.set('n', '<MouseMove>', require('hover').hover_mouse, { desc = 'hover.nvim (mouse)' })
      vim.o.mousemoveevent = true
    end,
  },

  { -- for icons (custom)
    'nvim-tree/nvim-web-devicons',
    opts = {},
  },

  { -- for context line
    'nvim-treesitter/nvim-treesitter-context',
    opts = {
      max_lines = 4,
    },
  },

  { -- for lualine (custom)
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          -- theme = 'dracula',
          -- theme = 'tokyonight',
          theme = 'synthweave',
          component_separators = { left = '|', right = '|' },
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = {
            {
              'filename',
              path = 1,
              shorting_target = 80,
            },
          },
          lualine_c = {},
          lualine_x = {
            lsp_clients,
            'encoding',
            'filetype',
          },
        },
        tabline = {
          -- lualine_a = {
          --   {
          --     'tabs',
          --     mode = 2, -- 0: tab number, 1: tab name, 2: tab number + name
          --   },
          -- },
          lualine_z = {
            {
              'buffers',
              mode = 4,
            },
          },
        },
      }
    end,
  },

  { -- for multi cursor (custom)
    'mg979/vim-visual-multi',
    branch = 'master',
  },

  { -- for marks near the line number (custom)
    'chentoast/marks.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    opts = {
      menu = {
        width = vim.api.nvim_win_get_width(0) - 4,
      },
      settings = {
        save_on_toggle = true,
      },
    },
    keys = keys,
    config = function()
      require('harpoon').setup()
    end,
  },

  { -- for typescript lsp - faster (custom)
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
    config = function()
      require('typescript-tools').setup {
        -- spawn additional tsserver instance to calculate diagnostics on it
        separate_diagnostic_server = false,
        tsserver_max_memory = 256, -- in mb
        -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
        complete_function_calls = true,
        single_file_support = true,
        include_completions_with_insert_text = true,
        settings = {
          jsx_close_tag = {
            enable = true,
            filetypes = { 'javascriptreact', 'typescriptreact' },
          },
        },
      }
    end,
  },

  { -- git (custom)
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'sindrets/diffview.nvim', -- optional - diff integration
    },
    config = function()
      -- neogit
      local neogit = require 'neogit'

      -- neogit open
      vim.keymap.set('n', '<leader>gs', neogit.open, {
        silent = true,
        noremap = true,
        desc = 'Open git',
      })

      -- neogit branches
      vim.keymap.set('n', '<leader>gb', ':Telescope git_branches<CR>', {
        silent = true,
        noremap = true,
        desc = 'Open git branches',
      })
    end,
  },

  { -- for autoclose and autorename tags
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup {
        opts = {
          -- Defaults
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = true, -- Auto close on trailing </
        },
      }
    end,
  },

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })

      -- for harpoon2
      -- basic telescope configuration
      local conf = require('telescope.config').values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require('telescope.pickers')
          .new({}, {
            prompt_title = 'Harpoon files',
            finder = require('telescope.finders').new_table {
              results = file_paths,
            },
            previewer = conf.file_previewer {},
            sorter = conf.generic_sorter {},
          })
          :find()
      end
      vim.keymap.set('n', '<C-e>', function()
        toggle_telescope(require('harpoon'):list())
      end, { desc = 'Open harpoon window' })
    end,
  },

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          -- Find references for the word under your cursor.
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- for ufo: nvim lsp as LSP client
      -- Tell the server the capability of foldingRange,
      -- Neovim hasn't added foldingRange to default capabilities, users must add it manually
      local capabilities2 = vim.lsp.protocol.make_client_capabilities()
      capabilities2.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      local language_servers = vim.lsp.get_clients() -- or list servers manually like {'gopls', 'clangd'}
      for _, ls in ipairs(language_servers) do
        require('lspconfig')[ls].setup {
          capabilities = capabilities2,
          -- you can add other fields for setting up lsp server in this table
        }
      end
      require('ufo').setup()
      --

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        -- ts_ls = {},
        --

        lua_ls = {
          -- cmd = { ... },
          -- filetypes = { ... },
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },

        elixirls = {
          keys = {
            {
              '<leader>cp',
              function()
                local params = vim.lsp.util.make_position_params()
                LazyVim.lsp.execute {
                  command = 'manipulatePipes:serverid',
                  arguments = { 'toPipe', params.textDocument.uri, params.position.line, params.position.character },
                }
              end,
              desc = 'To Pipe',
            },
            {
              '<leader>cP',
              function()
                local params = vim.lsp.util.make_position_params()
                LazyVim.lsp.execute {
                  command = 'manipulatePipes:serverid',
                  arguments = { 'fromPipe', params.textDocument.uri, params.position.line, params.position.character },
                }
              end,
              desc = 'From Pipe',
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { 'prettierd', 'prettier', stop_after_first = true },

        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        css = { 'prettierd', 'prettier' },
        scss = { 'prettierd', 'prettier' },
        markdown = { 'prettierd', 'prettier' },
        html = { 'prettierd', 'prettier' },
        json = { 'prettierd', 'prettier' },
        yaml = { 'prettierd', 'prettier' },
        graphql = { 'prettierd', 'prettier' },
        md = { 'prettierd', 'prettier' },
        txt = { 'prettierd', 'prettier' },
      },
      formatters = {
        stylua = {
          args = { '--indent-width', '2', '--indent-type', 'Spaces', '-' },
        },
        prettier = {
          require_cwd = true,
          -- No need to set cwd or use conform.util.root_file
          prepend_args = { '--single-quote', '--config-precedence', 'prefer-file' },
        },
      },
    },
  },

  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              -- require('luasnip.loaders.from_vscode').lazy_load()

              require('luasnip.loaders.from_lua').load { paths = '~/.config/nvim/lua/custom/luasnippets/' }
            end,
          },
        },
        opts = {},
        config = function()
          require('luasnip.loaders.from_lua').load { paths = './lua/custom/luasnippets/' }
        end,
      },
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default' (recommended) for mappings similar to built-in completions
        --   <c-y> to accept ([y]es) the completion.
        --    This will auto-import if your LSP supports it.
        --    This will expand snippets if the LSP sent a snippet.
        -- 'super-tab' for tab to accept
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- For an understanding of why the 'default' preset is recommended,
        -- you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        --
        -- All presets have the following mappings:
        -- <tab>/<s-tab>: move to right/left of your snippet expansion
        -- <c-space>: Open menu or open docs if already open
        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
        -- <c-e>: Hide menu
        -- <c-k>: Toggle signature help
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = 'default',

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },

      snippets = { preset = 'luasnip' },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = 'lua' },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
  },

  {
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.

    -- synthweave theme
    'samharju/synthweave.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      -- local synthweave = require 'synthweave'
      -- synthweave.setup {
      --   transparent = false,
      --   overrides = {
      --     Normal = {
      --       bg = '#202222',
      --     },
      --     NormalFloat = {
      --       bg = '#262335',
      --     },
      --     LineNr = {
      --       fg = '#576c7d',
      --     },
      --   },
      --   palette = {
      --     -- bg0 = '#202222',
      --     bg0 = '#090909', -- for vitesse theme
      --   },
      -- }
      -- synthweave.load()

      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      -- vim.cmd.colorscheme = 'synthweave'

      -- set undercurl for error and warnings
      vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { undercurl = true, sp = '#f38ba8' })
      vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { undercurl = true, sp = '#FCEF91' })

      -- vim.cmd 'luafile ~/.config/nvim/lua/custom/colors/vitesse_dark.lua'

      vim.cmd 'luafile ~/.config/nvim/lua/custom/colors/horizon_italic.lua'
    end,
  },

  -- { -- for lualine
  --   'folke/tokyonight.nvim',
  --   lazy = false,
  --   priority = 1000,
  --   opts = {},
  -- },

  -- { -- gruvbox dark theme
  --   'morhetz/gruvbox',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     vim.o.background = 'dark'
  --     vim.cmd 'colorscheme gruvbox'
  --     -- Override the Normal highlight group background
  --     vim.api.nvim_set_hl(0, 'Normal', { bg = '#202222' })
  --   end,
  -- },

  -- {
  --   'sainnhe/everforest',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     -- Optionally configure and load the colorscheme
  --     -- directly inside the plugin declaration.
  --     vim.g.everforest_enable_italic = true
  --     vim.g.everforest_background = 'hard'
  --     vim.o.background = 'dark'
  --     vim.cmd.colorscheme 'everforest'
  --     vim.api.nvim_set_hl(0, 'Normal', { bg = '#101010' })
  --
  --     vim.api.nvim_set_hl(0, 'Accent1', { fg = '#F85552' }) -- Red
  --     vim.api.nvim_set_hl(0, 'Accent2', { fg = '#F57D26' }) -- Orange
  --     vim.api.nvim_set_hl(0, 'Accent3', { fg = '#DFA000' }) -- Yellow/Gold
  --     vim.api.nvim_set_hl(0, 'Accent4', { fg = '#8DA101' }) -- Olive Green
  --     vim.api.nvim_set_hl(0, 'Accent5', { fg = '#35A77C' }) -- Teal
  --     vim.api.nvim_set_hl(0, 'Accent6', { fg = '#3A94C5' }) -- Blue
  --     vim.api.nvim_set_hl(0, 'Accent7', { fg = '#DF69BA' }) -- Pink
  --
  --     vim.api.nvim_set_hl(0, 'Identifier', { fg = '#F85552' })
  --     vim.api.nvim_set_hl(0, 'Function', { fg = '#F57D26' })
  --
  --     -- vim.api.nvim_create_autocmd('ColorScheme', {
  --     --   group = vim.api.nvim_create_augroup('custom_highlights_everforest', {}),
  --     --   pattern = 'everforest',
  --     --   callback = function()
  --     --     -- Get the light palette
  --     --     local palette = vim.fn['everforest#get_palette']('light', {}) -- fetch light palette
  --     --
  --     --     -- Example: Override the accent colors for Identifier, Function, etc.
  --     --     vim.api.nvim_set_hl(0, 'Identifier', { fg = palette.blue })
  --     --     vim.api.nvim_set_hl(0, 'Function', { fg = palette.green })
  --     --     vim.api.nvim_set_hl(0, 'Statement', { fg = palette.orange })
  --     --   end,
  --     -- })
  --   end,
  -- },

  -- Highlight todo, notes, etc in comments
  -- TODO:
  -- HACK:
  -- PERF:
  -- FIX:
  -- WARNING:
  -- NOTE:
  -- TEST:
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = true } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    -- event = { 'BufReadPre', 'BufNewFile' },
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'json',
        'javascript',
        'typescript',
        'tsx',
        'css',
        'yaml',
        'elixir',
        'heex',
        'eex',
        'go',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
      -- custom incremental selection
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<C-space>',
          node_incremental = '<C-space>',
          scope_incremental = false,
          node_decremental = '<bs>',
        },
      },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  -- { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
