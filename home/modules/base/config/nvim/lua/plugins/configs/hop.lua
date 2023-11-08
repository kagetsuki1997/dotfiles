local present, hop = pcall(require, "hop")

if not present then
    return
end

hop.setup({ keys = "etovxqpdygfblzhckisuran" })

vim.api.nvim_set_keymap("n", "<leader>m", "<cmd>HopWord<cr>", { noremap = true })
