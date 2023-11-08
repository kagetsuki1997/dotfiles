vim.g.indent_blankline_filetype_exclude = { "tex", "markdown", "txt", "startify", "packer" }
vim.g.indent_blankline_show_first_indent_level = false
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_use_treesitter = true

vim.opt.list = true
vim.opt.listchars:append("space:⋅")

require("indent_blankline").setup({
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "json",
    callback = function()
        vim.g.vim_json_syntax_conceal = 0
    end,
})
