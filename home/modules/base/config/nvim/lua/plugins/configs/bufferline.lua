vim.opt.termguicolors = true

require("bufferline").setup({
    options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        always_show_bufferline = true,
        buffer_close_icon = "",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        separator_style = "slant",
        diagnostics = "nvim_lsp",
    },
})
