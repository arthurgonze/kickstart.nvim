local function find_uproject()
  local cwd = vim.fn.getcwd()
  local matches = vim.fn.glob(cwd .. '/*.uproject', false, true)

  if #matches > 0 then
    return matches[1]
  end

  local ok, unreal = pcall(require, 'unreal-nvim')
  if ok and unreal.find_uproject then
    return unreal.find_uproject()
  end

  return nil
end

local function get_project_info()
  local project = find_uproject()

  if not project or project == '' then
    vim.notify('No .uproject found from current working directory', vim.log.levels.ERROR)
    return nil
  end

  local project_dir = vim.fn.fnamemodify(project, ':h')
  local project_name = vim.fn.fnamemodify(project, ':t:r')
  local target = project_name .. 'Editor'

  return {
    project = project,
    project_dir = project_dir,
    project_name = project_name,
    target = target,
  }
end

local function run_ubt(args, success_message)
  local info = get_project_info()
  if not info then
    return
  end

  local build_bat = 'C:/Program Files/Epic Games/UE_5.7/Engine/Build/BatchFiles/Build.bat'

  local command = '& "' .. build_bat .. '" ' .. info.target .. ' Win64 Development ' .. '-Project="' .. info.project .. '" ' .. args

  vim.cmd 'botright 20split'
  vim.cmd 'terminal'

  local chan = vim.b.terminal_job_id
  if not chan then
    vim.notify('[Unreal] Failed to open terminal buffer', vim.log.levels.ERROR)
    return
  end

  vim.fn.chansend(chan, {
    'cd "' .. info.project_dir .. '"\r\n',
    command .. '\r\n',
  })

  vim.cmd 'startinsert'
  vim.notify(success_message .. ' started', vim.log.levels.INFO)
end

local function build_project()
  run_ubt('', '[Unreal] Project build')
end

local function generate_compile_commands()
  local info = get_project_info()
  if not info then
    return
  end

  run_ubt(
    '-Mode=GenerateClangDatabase ' .. '-OutputDir="' .. info.project_dir .. '" ' .. '-game -engine -NoHotReload',
    '[Unreal] compile_commands.json generation'
  )
end

local function run_project()
  local info = get_project_info()
  if not info then
    return
  end

  local cmd = {
    'cmd.exe',
    '/c',
    'start',
    '',
    info.project,
  }

  vim.notify('[Unreal] Launching project...', vim.log.levels.INFO)

  vim.system(cmd, { text = true, cwd = info.project_dir }, function(result)
    if result.code ~= 0 then
      vim.schedule(function()
        local msg = result.stderr ~= '' and result.stderr or result.stdout
        vim.notify(msg, vim.log.levels.ERROR)
      end)
    end
  end)
end

local function set_unreal_keymaps()
  vim.keymap.set('n', '<leader>ub', build_project, {
    desc = '[U]E [B]uild Project',
    silent = true,
  })

  vim.keymap.set('n', '<leader>uc', generate_compile_commands, {
    desc = '[U]E [C]ompile Commands',
    silent = true,
  })

  vim.keymap.set('n', '<leader>ur', run_project, {
    desc = '[U]E [R]un Project',
    silent = true,
  })

  vim.keymap.set('n', '<leader>uh', '<cmd>UEHeaderProject<CR>', {
    desc = '[U]E Generate [H]eaders',
    silent = true,
  })

  vim.keymap.set('n', '<leader>ul', '<cmd>UEClangdConfigProject<CR>', {
    desc = '[U]E C[l]angd Config',
    silent = true,
  })

  vim.keymap.set('n', '<leader>uB', '<cmd>UEBuildEngine<CR>', {
    desc = '[U]E [B]uild Engine',
    silent = true,
  })

  vim.keymap.set('n', '<leader>uH', '<cmd>UEHeaderEngine<CR>', {
    desc = '[U]E Engine [H]eaders',
    silent = true,
  })

  vim.keymap.set('n', '<leader>uC', '<cmd>UECompileCommandsEngine<CR>', {
    desc = '[U]E Engine [C]ompile Commands',
    silent = true,
  })
end

local function setup_unreal()
  require('unreal-nvim').setup {}

  -- Unreal-Nvim creates its own mappings during setup.
  -- Defer ours so they override the plugin mappings.
  vim.schedule(set_unreal_keymaps)
end

return {
  'PlayKigai/Unreal-Nvim',
  cmd = { 'Unreal' },

  init = function()
    local group = vim.api.nvim_create_augroup('UnrealAutoInit', { clear = true })
    local initialized = false

    local function try_init()
      if initialized then
        return
      end

      initialized = true
      vim.api.nvim_del_augroup_by_id(group)

      require('lazy').load { plugins = { 'Unreal-Nvim' } }
    end

    vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufNewFile' }, {
      group = group,
      pattern = { '*.uproject', '*.uplugin', '*.Build.cs', '*.Target.cs' },
      callback = try_init,
    })

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
    setup_unreal()

    vim.api.nvim_create_user_command('Unreal', function()
      setup_unreal()
    end, { desc = 'Manually initialize Unreal-Nvim' })
  end,
}
