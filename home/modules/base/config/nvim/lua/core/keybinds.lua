-- navigate through QuickFix errors using Ctrl-j and Ctrl-k
vim.api.nvim_set_keymap("", "<C-j>", "<cmd>cn<cr>", {})
vim.api.nvim_set_keymap("", "<C-k>", "<cmd>cp<cr>", {})

-- Edit and source $MYVIMRC
vim.api.nvim_set_keymap("n", "<leader>vs", "<cmd>source $MYVIMRC<cr>", { noremap = true })

vim.api.nvim_set_keymap("n", "<F12>", "<cmd>edit ++enc=utf-8<cr>", { noremap = true })
