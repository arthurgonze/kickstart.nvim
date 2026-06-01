return {
  'tpope/vim-fugitive',
  cmd = { 'Git', 'G' },
  keys = {
    { '<leader>gs', '<cmd>Git<CR>', desc = '[G]it [S]tatus' },
    { '<leader>gc', '<cmd>Git commit<CR>', desc = '[G]it [C]ommit' },
    { '<leader>gd', '<cmd>Gdiffsplit<CR>', desc = '[G]it [D]iff' },
    { '<leader>gf', '<cmd>Git fetch<CR>', desc = '[G]it [F]etch' },
    { '<leader>gb', '<cmd>Git blame<CR>', desc = '[G]it [B]lame' },
    { '<leader>gB', '<cmd>Git branch<CR>', desc = '[G]it [B]ranch' },
    { '<leader>gl', '<cmd>Git log<CR>', desc = '[G]it [L]og' },
    { '<leader>gp', '<cmd>Git push<CR>', desc = '[G]it [P]ush' },
    { '<leader>gP', '<cmd>Git pull<CR>', desc = '[G]it [P]ull' },
    { '<leader>gS', '<cmd>Git stash<CR>', desc = '[G]it [S]tash' },
  },
}
