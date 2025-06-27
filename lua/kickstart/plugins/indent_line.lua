vim.api.nvim_set_hl(0, 'IblScope', { fg = '#d5d8da' }) -- active color
vim.api.nvim_set_hl(0, 'IblIndent', { fg = '#666666' }) -- inactive color

return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {
      indent = {
        char = '┊',
        highlight = 'IblIndent', -- use this for all indents
      },
      scope = {
        enabled = true,
        highlight = { 'IblScope' }, -- use this for active scope
      },
    },
  },
}
