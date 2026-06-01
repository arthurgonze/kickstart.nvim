return {
  'Wansmer/treesj',
  keys = {
    { '<space>m', desc = '[T]ree [S]plit [J]oin' },
    { '<space>j', desc = '[T]ree [J]oin' },
    { '<space>s', desc = '[T]ree [S]plit' },
  },
  dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
  config = function()
    require('treesj').setup()
  end,
}
