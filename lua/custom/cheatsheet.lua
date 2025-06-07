-- lua/cheatsheet.lua
local M = {}

-- module-level variables:
local cheatsheet_buf1 = nil
local cheatsheet_buf2 = nil
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
  -- Check if cheatsheet buffers already exist
  local buf
  if cheatsheet_buf1 and vim.api.nvim_buf_is_valid(cheatsheet_buf1) then
    buf = cheatsheet_buf1
    existing_buf = buf
  else
    buf = vim.api.nvim_create_buf(false, true)
    cheatsheet_buf1 = buf
    existing_buf = nil
  end

  local buf2
  if cheatsheet_buf2 and vim.api.nvim_buf_is_valid(cheatsheet_buf2) then
    buf2 = cheatsheet_buf2
  else
    buf2 = vim.api.nvim_create_buf(false, true)
    cheatsheet_buf2 = buf2
  end

  -- Set buffer content and options only if it's a new buffer
  if not existing_buf then
    local lines = vim.split(cheatsheet_content, '\n')
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

    -- Set buffer options
    -- vim.api.nvim_buf_set_option(buf, 'modifiable', false)
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
    title = 'Cheat Sheet 1',
    title_pos = 'center',
  }

  -- Create the floating window

  local win1 = vim.api.nvim_open_win(buf, true, opts)

  -- Calculate content split point
  local lines = vim.split(cheatsheet_content, '\n')
  local total_lines = #lines
  local split_point = math.floor(total_lines / 2)

  local lines2 = {}
  -- Set content for second buffer
  vim.api.nvim_buf_set_option(buf2, 'modifiable', true)
  for i = split_point + 1, total_lines do
    table.insert(lines2, lines[i])
  end
  vim.api.nvim_buf_set_lines(buf2, 0, -1, false, lines2)
  vim.api.nvim_buf_set_option(buf2, 'modifiable', false)
  vim.api.nvim_buf_set_option(buf2, 'filetype', 'markdown')

  vim.api.nvim_buf_set_name(buf2, 'Cheatsheet2')

  -- Modify first buffer to show only first half
  if existing_buf then
    vim.api.nvim_buf_set_option(buf, 'modifiable', true)
  end
  local lines1 = {}
  for i = 1, split_point do
    table.insert(lines1, lines[i])
  end
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines1)
  vim.api.nvim_buf_set_option(buf, 'modifiable', false)

  -- Adjust first window to take left half
  local half_width = math.floor(width / 2)
  vim.api.nvim_win_set_width(win1, half_width)

  -- Create second floating window for right pane
  local opts2 = {
    relative = 'editor',
    width = half_width,
    height = height,
    row = row,
    col = col + half_width,
    style = 'minimal',
    border = 'rounded',
    title = 'Cheat Sheet 2',
    title_pos = 'center',
  }

  local win2 = vim.api.nvim_open_win(buf2, true, opts2)
  vim.api.nvim_win_set_buf(win2, buf2)

  -- set pane1

  vim.api.nvim_win_set_option(win1, 'wrap', true)
  vim.api.nvim_win_set_option(win1, 'linebreak', true)

  -- Set window options for second pane
  vim.api.nvim_win_set_option(win2, 'wrap', true)
  vim.api.nvim_win_set_option(win2, 'linebreak', true)

  -- Set keymaps for the cheatsheet buffer

  local keymap_opts = { buffer = buf, silent = true }
  -- Close with q or Escape - close both windows
  vim.keymap.set('n', 'q', function()
    if vim.api.nvim_win_is_valid(win1) then
      vim.api.nvim_win_close(win1, true)
    end
    vim.cmd 'close'
  end, keymap_opts)

  vim.keymap.set('n', '<Esc>', function()
    if vim.api.nvim_win_is_valid(win1) then
      vim.api.nvim_win_close(win1, true)
    end
    vim.cmd 'close'
  end, keymap_opts)

  local keymap_opts2 = { buffer = buf2, silent = true }
  -- Close with q or Escape - close both windows
  vim.keymap.set('n', 'q', function()
    if vim.api.nvim_win_is_valid(win2) then
      vim.api.nvim_win_close(win2, true)
    end
    vim.cmd 'close'
  end, keymap_opts2)

  vim.keymap.set('n', '<Esc>', function()
    if vim.api.nvim_win_is_valid(win2) then
      vim.api.nvim_win_close(win2, true)
    end
    vim.cmd 'close'
  end, keymap_opts2)

  -- Focus on search when opening

  vim.cmd 'normal! gg'
  vim.cmd 'nohlsearch'
end

return M
