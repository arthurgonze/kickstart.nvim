-- Unreal
return {
  'PlayKigai/Unreal-Nvim',
  cmd = { 'Unreal' },
  init = function()
    local group = vim.api.nvim_create_augroup('UnrealAutoInit', { clear = true })
    local initialized = false

    local function try_init()
      if initialized then return end
      initialized = true
      vim.api.nvim_del_augroup_by_id(group)
      require('lazy').load { plugins = { 'Unreal-Nvim' } }
      require('unreal-nvim').setup({})
    end

    -- Auto-init on explicit UE project/plugin/build files
    vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
      group = group,
      pattern = { '*.uproject', '*.uplugin', '*.Build.cs', '*.Target.cs' },
      callback = try_init,
    })

    -- Auto-init on C++ files when a .uproject exists in cwd (UE source code)
    vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
      group = group,
      pattern = { '*.cpp', '*.h', '*.hpp', '*.c' },
      callback = function()
        if vim.fn.glob(vim.fn.getcwd() .. '/*.uproject') ~= '' then
          try_init()
        end
      end,
    })
  end,
  config = function()
    -- Plugin is set up by try_init() above; this is only reached when
    -- loaded manually via :Unreal or by the auto-init path.
    vim.api.nvim_create_user_command('Unreal', function()
      require('unreal-nvim').setup({})
    end, { desc = 'Manually initialize Unreal-Nvim' })

    vim.keymap.set('n', '<leader>ub', '<cmd>UEBuildProject<CR>', { desc = '[U]E [B]uild Project' })
    vim.keymap.set('n', '<leader>uh', '<cmd>UEHeaderProject<CR>', { desc = '[U]E Generate [H]eaders' })
    vim.keymap.set('n', '<leader>uc', '<cmd>UECompileCommandsProject<CR>', { desc = '[U]E [C]ompile Commands' })
    vim.keymap.set('n', '<leader>ul', '<cmd>UEClangdConfigProject<CR>', { desc = '[U]E C[l]angd Config' })
    vim.keymap.set('n', '<leader>uB', '<cmd>UEBuildEngine<CR>', { desc = '[U]E [B]uild Engine' })
    vim.keymap.set('n', '<leader>uH', '<cmd>UEHeaderEngine<CR>', { desc = '[U]E Engine [H]eaders' })
    vim.keymap.set('n', '<leader>uC', '<cmd>UECompileCommandsEngine<CR>', { desc = '[U]E Engine [C]ompile Commands' })
  end,
}
