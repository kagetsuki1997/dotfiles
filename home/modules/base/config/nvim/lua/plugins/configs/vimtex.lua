vim.g.vimtex_view_general_viewer = "evince"
vim.g.vimtex_view_general_options = "-w"
vim.g.vimtex_compiler_latexmk = {
    backend = "nvim",
    background = 1,
    build_dir = "target",
    callback = 1,
    continuous = 1,
    options = {
        "-xelatex",
        "-pdf",
        "-verbose",
        "-file-line-error",
        "-synctex=1",
        "-interaction=nonstopmode",
    },
}
