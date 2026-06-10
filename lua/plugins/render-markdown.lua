-- Beautiful markdown
return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = { 'markdown', 'md' },
  opts = {
    file_types = { 'markdown', 'md' },

    ignore = function(buf)
      local ft = vim.bo[buf].filetype
      local bt = vim.bo[buf].buftype

      return ft == 'notify' or ft == 'noice' or bt == 'nofile' or bt == 'prompt' or bt == 'terminal'
    end,
  },
}
