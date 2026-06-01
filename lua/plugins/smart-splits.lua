return {
  'mrjones2014/smart-splits.nvim',
  -- Wezterm Integration
  lazy = false,
  priority = 1000,

  config = function()
    local ss = require 'smart-splits'

    ss.setup {
      multiplexer_integration = 'wezterm',
      default_amount = 3,
      at_edge = 'wrap',
    }

    -- Moving between splits
    vim.keymap.set('n', '<C-h>', ss.move_cursor_left, { desc = 'Move focus to the left window' })
    vim.keymap.set('n', '<C-j>', ss.move_cursor_down, { desc = 'Move focus to the lower window' })
    vim.keymap.set('n', '<C-k>', ss.move_cursor_up, { desc = 'Move focus to the upper window' })
    vim.keymap.set('n', '<C-l>', ss.move_cursor_right, { desc = 'Move focus to the right window' })

    -- Resizing splits
    vim.keymap.set('n', '<A-h>', ss.resize_left, { desc = 'Resize split left' })
    vim.keymap.set('n', '<A-j>', ss.resize_down, { desc = 'Resize split down' })
    vim.keymap.set('n', '<A-k>', ss.resize_up, { desc = 'Resize split up' })
    vim.keymap.set('n', '<A-l>', ss.resize_right, { desc = 'Resize split right' })
  end,
}
