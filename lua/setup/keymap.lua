vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = '[Esc] Clear Search Highlight' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, { desc = '[Q]uickfix Diagnostics' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = '[Esc][Esc] Exit Terminal Mode' })

-- Disables <Space> as a normal/visual key, so it only works as leader
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { desc = '[Space] Disable Space Key', silent = true })

-- Remap jk to esc
vim.keymap.set({ 'n', 'v', 'i' }, '<leader>jk', '<Esc>', { desc = '[J][K] Escape' })
vim.keymap.set('t', '<leader>jk', '<C-\\><C-n>', { desc = '[J][K] Exit Terminal Mode' })

-- Quickly remove search highlight with <leader><space> (now <Space><Space>)
vim.keymap.set('n', '<space><space>', ':noh<cr>', { desc = '[Space][Space] Clear Search Highlight' })

-- Makes 'j'/'k' move by visual lines when no count is given
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { desc = '[K] Move Up by Display Line', expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { desc = '[J] Move Down by Display Line', expr = true, silent = true })

-- Move cursor right/left in insert mode with Ctrl+l/h.
vim.keymap.set('i', '<c-l>', '<Right>', { desc = '[Ctrl+L] Move Right' })
vim.keymap.set('i', '<c-h>', '<Left>', { desc = '[Ctrl+H] Move Left' })
vim.keymap.set('i', '<c-j>', '<Down>', { desc = '[Ctrl+J] Move Down' })
vim.keymap.set('i', '<c-k>', '<Up>', { desc = '[Ctrl+K] Move Up' })

-- Move selected lines up/down in visual mode with J/K.
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = '[J] Move Selection Down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = '[K] Move Selection Up' })

-- Scroll half-page down/up and center cursor.
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = '[Ctrl+D] Scroll Down and Center' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = '[Ctrl+U] Scroll Up and Center' })

-- Next/previous search result and center cursor.
vim.keymap.set('n', 'n', 'nzzzv', { desc = '[N] Next Search Result' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = '[Shift+N] Previous Search Result' })

-- Paste over selection without overwriting the default register.
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = '[P]aste Without Yank' })

-- Delete to black hole register (doesn't overwrite yank buffer).
vim.keymap.set({ 'n', 'v' }, '<leader>d', [["_d]], { desc = '[D]elete to Black Hole' })

-- In insert mode, Ctrl+c acts as <Esc>.
vim.keymap.set('i', '<C-c>', '<Esc>', { desc = '[Ctrl+C] Escape Insert Mode' })

-- Diagnostic navigation
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = '[D]iagnostic Next' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = '[D]iagnostic Previous' })

-- Buffer navigation
vim.keymap.set('n', ']b', '<cmd>bnext<CR>', { desc = '[B]uffer Next' })
vim.keymap.set('n', '[b', '<cmd>bprev<CR>', { desc = '[B]uffer Previous' })

-- Quickfix navigation
vim.keymap.set('n', ']q', '<cmd>cnext<CR>', { desc = '[Q]uickfix Next' })
vim.keymap.set('n', '[q', '<cmd>cprev<CR>', { desc = '[Q]uickfix Previous' })
