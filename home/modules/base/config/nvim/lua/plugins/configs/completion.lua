-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.api.nvim_set_option("updatetime", 300)

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error
-- Show inlay_hints more frequently
vim.o.signcolumn = "yes"

vim.api.nvim_create_autocmd("CursorHold", {
    pattern = "*",
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end,
})

require("luasnip.loaders.from_lua").load({ paths = "./snippets/lua" })

-- Completion Plugin Setup
local luasnip = require("luasnip")
local lspkind = require("lspkind")
local cmp = require("cmp")

local function select_next_item(fallback)
    if cmp.visible() then
        cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    else
        fallback()
    end
end

local function select_prev_item(fallback)
    if cmp.visible() then
        cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
    else
        fallback()
    end
end

cmp.setup({
    -- Enable LSP snippets
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        -- select next item
        ["<Tab>"] = cmp.mapping(select_next_item, { "i", "s" }),
        ["<C-n>"] = cmp.mapping(select_next_item, { "i", "s" }),
        ["<Down>"] = cmp.mapping(select_next_item, { "i", "s" }),

        -- select previous item
        ["<S-Tab>"] = cmp.mapping(select_prev_item, { "i", "s" }),
        ["<C-p>"] = cmp.mapping(select_prev_item, { "i", "s" }),
        ["<Up>"] = cmp.mapping(select_prev_item, { "i", "s" }),

        ["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-v>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<cr>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
    },
    -- Installed sources:
    sources = {
        { name = "buffer", keyword_length = 2 }, -- source current buffer
        { name = "calc" }, -- source for math calculation
        { name = "luasnip" },
        { name = "nvim_lsp", keyword_length = 3 }, -- from language server
        { name = "nvim_lsp_signature_help" }, -- display function signatures with current parameter emphasized
        { name = "nvim_lua", keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
        { name = "path" }, -- file paths
        { name = "vsnip", keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            fields = { "menu", "abbr", "kind" },
            before = function(entry, item)
                local menu_icon = { nvim_lsp = "λ", vsnip = "⋗", buffer = "Ω", path = "🖫" }
                item.menu = menu_icon[entry.source.name]
                return item
            end,
        }),
    },
})
