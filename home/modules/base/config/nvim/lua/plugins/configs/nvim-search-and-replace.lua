require("nvim-search-and-replace").setup({
    -- file patters to ignore
    ignore = { "**/node_modules/**", "**/.git/**", "**/.gitignore", "**/.gitmodules", "build/**" },

    -- save the changes after replace
    update_changes = false,

    -- keymap for search and replace
    replace_keymap = "<leader>sr",

    -- keymap for search and replace ( this does not care about ignored files )
    replace_all_keymap = "<leader>sR",

    -- keymap for search and replace
    replace_and_save_keymap = "<leader>su",

    -- keymap for search and replace ( this does not care about ignored files )
    replace_all_and_save_keymap = "<leader>sU",
})
