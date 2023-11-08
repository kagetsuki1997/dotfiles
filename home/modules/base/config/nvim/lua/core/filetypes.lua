local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
    pattern = { "yaml" },
    command = "setlocal ts=2 sts=2 sw=2 expandtab",
})

autocmd({ "BufNewFile", "BufRead" }, { pattern = { "Justfile", "justfile" }, command = "setf make" })

autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "*.vue" },
    command = "setlocal filetype=vue.html.javascript.css",
})
