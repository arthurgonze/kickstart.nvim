return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('codecompanion').setup {
      adapters = {
        ollama = function()
          return require('codecompanion.adapters').extend('ollama', {
            schema = {
              model = {
                default = 'deepseek-coder-v2:16b',
              },
            },
          })
        end,
      },
      strategies = {
        chat = { adapter = 'ollama' },
        inline = { adapter = 'ollama' },
      },
      prompt_library = {
        ['Generate Docstring'] = {
          interaction = 'inline',
          description = 'Generate a docstring for the selected code',
          opts = {
            alias = 'doc',
            placement = 'before',
            modes = { 'v' },
          },
          prompts = {
            {
              role = 'user',
              content = function(context)
                return 'Write only the docstring comment for the following code, no explanation, no markdown, just the comment:\n\n' .. context.code
              end,
            },
          },
        },
      },
    }
  end,
  keys = {
    { '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', desc = '[A]I [C]hat' },
    { '<leader>aa', '<cmd>CodeCompanionActions<cr>', mode = { 'n', 'v' }, desc = '[A]I [A]ctions' },
    { '<leader>ad', '<cmd>CodeCompanion /doc<cr>', mode = 'v', desc = '[A]I [D]ocstring' },
  },
}

