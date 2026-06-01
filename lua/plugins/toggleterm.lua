return {
  'akinsho/toggleterm.nvim',
  version = '*',
  keys = {
    { '<C-\\>', desc = 'Toggle terminal' },
    { '<leader>tf', desc = 'Toggle floating terminal' },
    { '<leader>th', desc = 'Toggle horizontal terminal' },
  },
  opts = {
    size = function(term)
      if term.direction == 'horizontal' then
        return 15
      elseif term.direction == 'vertical' then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<C-\>]],
    direction = 'float',
    float_opts = {
      border = 'curved',
    },
    shade_terminals = true,
  },
  config = function(_, opts)
    require('toggleterm').setup(opts)

    local machine = require 'machine'
    local Terminal = require('toggleterm.terminal').Terminal

    local function get_python_cmd()
      local ue_python = machine.get('ue_python', '')
      if ue_python ~= '' then return ue_python end
      local python = vim.fn.exepath 'python'
      if python ~= '' then return python end
      return 'python'
    end

    -- Floating terminal shortcut
    local float_term = Terminal:new { direction = 'float' }
    vim.keymap.set('n', '<leader>tf', function()
      float_term:toggle()
    end, { desc = '[T]oggle [F]loating terminal' })

    -- Horizontal terminal shortcut
    local h_term = Terminal:new { direction = 'horizontal' }
    vim.keymap.set('n', '<leader>th', function()
      h_term:toggle()
    end, { desc = '[T]oggle [H]orizontal terminal' })

    vim.keymap.set('n', '<leader>rp', function()
      local file = vim.fn.expand '%:p'
      Terminal:new({
        cmd = '"' .. get_python_cmd() .. '" "' .. file .. '"',
        close_on_exit = false,
        direction = 'horizontal',
      }):toggle()
    end, { desc = '[R]un [P]ython File' })

    vim.keymap.set('n', '<leader>rf', function()
      local file = vim.fn.expand '%:p'
      local ext = vim.fn.expand '%:e'
      local cmd
      if ext == 'py' then
        cmd = '"' .. get_python_cmd() .. '" "' .. file .. '"'
      elseif ext == 'lua' then
        cmd = 'nvim -l "' .. file .. '"'
      else
        cmd = '"' .. file .. '"'
      end
      Terminal:new({
        cmd = cmd,
        close_on_exit = false,
        direction = 'horizontal',
      }):toggle()
    end, { desc = '[R]un [F]ile' })
  end,
}
