return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  config = function(_, opts)
    require('notify').setup {
      background_colour = '#000000',
    }

    require('noice').setup(opts)
  end,
  opts = {
    lsp = {
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
        ['cmp.entry.get_documentation'] = true,
      },
      signature = {
        enabled = false,
      },
      progress = {
        enabled = false,
      },
    },
    presets = {
      -- bottom_search = true,
      -- command_palette = true,
      long_message_to_split = true,
      lsp_doc_border = true,
    },
    routes = {
      -- suppress annoying "written" message on save
      {
        filter = { event = 'msg_show', kind = '', find = 'written' },
        opts = { skip = true },
      },

      -- suppress generic Neovim/plugin deprecation noise
      {
        filter = {
          event = 'msg_show',
          find = 'deprecated',
        },
        opts = { skip = true },
      },
    },
  },
}
