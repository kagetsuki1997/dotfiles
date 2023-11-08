local fn = vim.fn
local api = vim.api

if fn.executable("xclip") == 1 then
    api.nvim_set_keymap("n", "<F7>", "<cmd>write! xclip<cr><cr>", {})
    api.nvim_set_keymap("v", "<F7>", "\"*y", {})
    api.nvim_set_keymap("n", "<S-F7>", ":read! xclip -o<cr>", {})
end
