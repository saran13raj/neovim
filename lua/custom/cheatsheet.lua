-- lua/cheatsheet.lua
local M = {}

-- Cheatsheet content
local cheatsheet_content = [[
# Neovim Motion Cheat Sheet

## Custom Key Bindings (Modified from defaults)
- `1` → Start of line (replaces `0`)
- `0` → End of line (replaces `$`)
- `<Space>z` → Undo (replaces `u`)

## Basic Cursor Movements
- `h` → Move left
- `j` → Move down
- `k` → Move up
- `l` → Move right
- `w` → Move to beginning of next word
- `b` → Move to beginning of previous word
- `e` → Move to end of current word
- `gg` → Go to first line
- `G` → Go to last line
- `{` → Move to previous paragraph
- `}` → Move to next paragraph
- `%` → Jump to matching bracket/parenthesis

## Insert Mode Options
- `i` → Insert before cursor
- `I` → Insert at beginning of line
- `a` → Insert after cursor
- `A` → Insert at end of line
- `o` → Open new line below and insert
- `O` → Open new line above and insert
- `s` → Delete character and insert
- `S` → Delete line and insert
- `c` → Change (delete and insert)
- `C` → Change to end of line

## Window Navigation
- `<Ctrl>h` → Move focus to left window
- `<Ctrl>l` → Move focus to right window
- `<Ctrl>j` → Move focus to lower window
- `<Ctrl>k` → Move focus to upper window

## File Tree (nvim-tree)
- `<Space>.` → Toggle tree view
- Within tree:
  - `Enter` → Open file/directory
  - `a` → Create new file/directory
  - `d` → Delete file/directory
  - `r` → Rename file/directory
  - `x` → Cut file/directory
  - `c` → Copy file/directory
  - `p` → Paste file/directory

## Search and Navigation
- `<Space>sf` → Search files
- `<Space>sg` → Search by grep (live search)
- `<Space>sw` → Search current word
- `<Space>s.` → Search recent files
- `<Space><Space>` → Find existing buffers
- `<Space>/` → Fuzzy search in current buffer
- `<Space>sh` → Search help
- `<Space>sk` → Search keymaps

## Text Manipulation
- `x` → Delete character under cursor
- `X` → Delete character before cursor
- `dd` → Delete entire line
- `yy` → Yank (copy) entire line
- `p` → Paste after cursor
- `P` → Paste before cursor
- `u` → Undo (also `<Space>z`)
- `<Ctrl>r` → Redo
- `.` → Repeat last command
- `>` → Indent line
- `<` → Unindent line

## Visual Mode
- `v` → Enter visual mode (character selection)
- `V` → Enter visual line mode
- `<Ctrl>v` → Enter visual block mode
- In visual mode:
  - `y` → Yank selection
  - `d` → Delete selection
  - `c` → Change selection

## LSP Features
- `grn` → Rename variable/function
- `gra` → Code action
- `grr` → Go to references
- `gri` → Go to implementation
- `grd` → Go to definition
- `grD` → Go to declaration
- `grt` → Go to type definition
- `gO` → Open document symbols
- `gW` → Open workspace symbols

## Git Integration
- `<Space>gs` → Open git status (Neogit)
- `<Space>gb` → Open git branches

## General Utilities
- `<Esc>` → Clear search highlights (in normal mode)
- `<Esc><Esc>` → Exit terminal mode
- `<Space>f` → Format buffer
- `<Space>q` → Open diagnostic quickfix list
- `<Space>th` → Toggle inlay hints
- `:w` → Save file
- `:q` → Quit
- `:wq` → Save and quit
- `:q!` → Quit without saving

## Quick Comments
- `gcc` → Toggle line comment (Mini.nvim)
- `gc` → Toggle comment in visual mode
- `gco` → Add comment below
- `gcO` → Add comment above

## Tab/Buffer Management
- `:tabnew` → Create new tab
- `:tabc` → Close current tab
- `gt` → Go to next tab
- `gT` → Go to previous tab
- `:bn` → Next buffer
- `:bp` → Previous buffer
- `:bd` → Delete buffer

## Advanced Motions
- `f{char}` → Find character forward in line
- `F{char}` → Find character backward in line
- `t{char}` → Till character forward in line
- `T{char}` → Till character backward in line
- `;` → Repeat last f/F/t/T motion
- `,` → Repeat last f/F/t/T motion in reverse
- `*` → Search for word under cursor forward
- `#` → Search for word under cursor backward
- `n` → Next search result
- `N` → Previous search result

## Text Objects (Mini.ai enhanced)
- `iw` → Inner word
- `aw` → A word (including spaces)
- `ip` → Inner paragraph
- `ap` → A paragraph
- `i"` → Inner quotes
- `a"` → A quotes (including quotes)
- `i(` → Inner parentheses
- `a(` → A parentheses (including parens)

## Surround Operations (Mini.surround)
- `sa{motion}{char}` → Surround add
- `sd{char}` → Surround delete
- `sr{old}{new}` → Surround replace
- Example: `saiw)` → Surround word with parentheses

## Special Features
- `:Tutor` → Open Neovim tutorial
- `:checkhealth` → Check Neovim health
- `:Lazy` → Open plugin manager
- `:Mason` → Open LSP installer
- `:cheat` → Open this cheat sheet
]]

-- Function to open cheatsheet in a floating window

function M.open_cheatsheet()
  -- check existing buffer
  local existing_buf = nil
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) then
      local buf_name = vim.api.nvim_buf_get_name(buf)
      if buf_name:match 'Cheatsheet' then
        existing_buf = buf
        break
      end
    end
  end

  -- Use existing buffer or create a new one
  local buf = existing_buf or vim.api.nvim_create_buf(false, true)

  -- Set buffer content and options only if it's a new buffer
  if not existing_buf then
    local lines = vim.split(cheatsheet_content, '\n')
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    -- Set buffer options
    vim.api.nvim_buf_set_option(buf, 'modifiable', false)
    vim.api.nvim_buf_set_option(buf, 'filetype', 'markdown')
    vim.api.nvim_buf_set_name(buf, 'Cheatsheet')
  end

  -- Calculate window dimensions

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Window options

  local opts = {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
    title = ' Neovim Cheat Sheet ',
    title_pos = 'center',
  }

  -- Create the floating window

  local win = vim.api.nvim_open_win(buf, true, opts)

  -- Set window options

  vim.api.nvim_win_set_option(win, 'wrap', true)
  vim.api.nvim_win_set_option(win, 'linebreak', true)

  -- Set keymaps for the cheatsheet buffer (only if it's a new buffer)
  if not existing_buf then
    local keymap_opts = { buffer = buf, silent = true }

    -- Close with q or Escape

    vim.keymap.set('n', 'q', '<cmd>close<cr>', keymap_opts)
    vim.keymap.set('n', '<Esc>', '<cmd>close<cr>', keymap_opts)

    -- Enable search with /

    vim.keymap.set('n', '/', '/', keymap_opts)

    -- Navigation keymaps

    vim.keymap.set('n', 'j', 'j', keymap_opts)
    vim.keymap.set('n', 'k', 'k', keymap_opts)
    vim.keymap.set('n', '<C-d>', '<C-d>', keymap_opts)
    vim.keymap.set('n', '<C-u>', '<C-u>', keymap_opts)
    vim.keymap.set('n', 'gg', 'gg', keymap_opts)
    vim.keymap.set('n', 'G', 'G', keymap_opts)
  end

  -- Focus on search when opening

  vim.cmd 'normal! gg'
  vim.cmd 'nohlsearch'
end

return M
