vim.g.neoformat_enabled_lua = { "lua-format" }

vim.g.neoformat_enabled_rego = { "opa" }

vim.g.neoformat_rego_opa = { exe = "opa", args = "fmt", stdin = 1 }

vim.api.nvim_set_keymap("n", "<leader>nf", "<cmd>Neoformat<cr>", { noremap = true })
