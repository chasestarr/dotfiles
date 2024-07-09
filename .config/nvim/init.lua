local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "vim-scripts/candyman.vim",
  "sbdchd/neoformat",
  "tpope/vim-commentary",
  {
    "zbirenbaum/copilot.lua",
    auto_trigger = true,
    cmd = "Copilot",
    config = function()
      require("copilot").setup()
    end,
  },
  "sebdah/vim-delve",
})

vim.cmd.colorscheme("candyman")
vim.api.nvim_set_keymap("n", ";", ":", {noremap = true})
vim.api.nvim_set_keymap("i", "jk", "<esc>l", {noremap = true})
vim.api.nvim_set_keymap("n", "<up>", "<C-w><up>", {noremap = true})
vim.api.nvim_set_keymap("n", "<down>", "<C-w><down>", {noremap = true})
vim.api.nvim_set_keymap("n", "<left>", "<C-w><left>", {noremap = true})
vim.api.nvim_set_keymap("n", "<right>", "<C-w><right>", {noremap = true})
vim.api.nvim_set_keymap("n", "<C-t>", ":Term<CR>", {noremap = true})
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", {noremap = true})

vim.opt.wrap = false
vim.opt.autoindent = true
vim.opt.smartindent = false
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.swapfile = false
vim.opt.splitright = true 
vim.opt.splitbelow = true

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = -28
vim.g.neoformat_try_node_exe = 1
vim.g.neoformat_enabled_typescript = {'prettier'}
vim.g.neoformat_enabled_cpp = {}
vim.g.neoformat_try_typescript = 1
vim.cmd([[
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat 
augroup END
]])

-- Open a Terminal on the right tab
autocmd('CmdlineEnter', {
  command = 'command! Term :botright vsplit term://$SHELL'
})

-- Enter insert mode when switching to terminal
autocmd('TermOpen', {
  command = 'setlocal listchars= nonumber norelativenumber nocursorline',
})

autocmd('TermOpen', {
  pattern = '',
  command = 'startinsert'
})

-- Close terminal buffer on process exit
autocmd('BufLeave', {
  pattern = 'term://*',
  command = 'stopinsert'
})

function get_visual_selection(bufn, startpos, endpos)
    local n_lines = math.abs(endpos[2] - startpos[2]) + 1
    local lines = vim.api.nvim_buf_get_lines(bufn, startpos[2] - 1, endpos[2], false)
    lines[1] = string.sub(lines[1], startpos[3], -1)
    if n_lines == 1 then
        lines[n_lines] = string.sub(lines[n_lines], 1, endpos[3] - startpos[3] + 1)
    else
        lines[n_lines] = string.sub(lines[n_lines], 1, endpos[3])
    end
    return lines
end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

vim.api.nvim_create_user_command('OT',function(t)
  local s = get_visual_selection(0, vim.fn.getpos("'<"), vim.fn.getpos("'>"))
  local c = table.concat(s, "")
  vim.cmd.vsplit()
  vim.cmd.terminal()
  vim.api.nvim_chan_send(vim.bo.channel, c .. "\r")
end,{ range = true })
 
