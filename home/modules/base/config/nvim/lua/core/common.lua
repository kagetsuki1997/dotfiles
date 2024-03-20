local opt = vim.opt
local fn = vim.fn
local wo = vim.wo
local cmd = vim.cmd

-- General
opt.hidden = true -- Hide buffers when abandoned instead of unload
opt.fileformats = "unix,dos,mac" -- Use Unix as the standard file type
opt.clipboard = "unnamedplus"
opt.mouse = "a" -- Enable mouse support in Normal mode, Visual mode, Insert mode, Command-line mode

opt.endofline = true -- Write for the last line in the file
-- opt.foldmethod='syntax'
wo.foldenable = true

-- Appearance
cmd([[
    syntax on
]])

opt.number = true
opt.wrap = true
-- opt.colorcolumn = "100" -- Highlight the 100th character limit
opt.scrolloff = 5 -- Keep at least 5 lines above/below
opt.showcmd = true -- Show command in status line
opt.cursorline = true -- Show cursorline

-- Tabs and Indents
opt.cindent = true
opt.autoindent = true -- Use same indenting on new lines
opt.smartindent = true -- Smart autoindenting on new lines

-- Space
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4

-- Encoding
opt.encoding = "UTF-8"
opt.fileencodings = "UTF-8,CP950"

-- Grep program
if fn.executable("rg") == 1 then
    opt.grepprg = "rg --vimgrep --no-heading"
    opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end

-- set alacritty cursor back to underline while exiting neovim
vim.api.nvim_create_autocmd(
    { "VimLeave" },
    { pattern = "*", command = "set guicursor=a:hor20-blinkwait400-blinkoff400-blinkon400" }
)
