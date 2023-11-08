local vim = vim
local nvim_lsp = require("lspconfig")
local navic = require("nvim-navic")

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local diagnostic_opts = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, diagnostic_opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, diagnostic_opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, diagnostic_opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, diagnostic_opts)

-- function to attach completion when setting up lsp
local on_attach = function(client, buf)
    -- Mappings.
    local bufopts = { noremap = true, silent = true, buffer = buf }

    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "gR", vim.lsp.buf.references, bufopts)

    -- Set some keybinds conditional on server capabilities
    if client.server_capabilities.documentFormattingProvider then
        vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, bufopts)
    elseif client.server_capabilities.documentRangeFormattingProvider then
        vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, bufopts)
    end

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
        vim.api.nvim_exec(
            [[
      hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
      hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
            false
        )
    end

    navic.attach(client, buf)
end

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = {
        "*.rs",
        "*.c",
        "*.cpp",
        "*.cxx",
        "*.java",
        "*.go",
        "*.lua",
        "*.nix",
        "*.py",
        "*.ts",
        "*.js",
        "*.css",
        "*.html",
        "*.htm",
        "*.json",
        "*.vim",
    },
    callback = function()
        vim.lsp.buf.format({ timeout_ms = 1000 })
    end,
})

vim.g.completion_chain_complete_list = {
    default = {
        { complete_items = { "lsp" } },
        { complete_items = { "buffers" } },
        { mode = { "<c-p>" } },
        { mode = { "<c-n>" } },
    },
}
vim.g.completion_auto_change_source = 1

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics,
    { underline = true, virtual_text = true, signs = true, update_in_insert = true }
)

nvim_lsp.rust_analyzer.setup({
    cmd = { "rustup", "run", "--install", "nightly", "rust-analyzer" },
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                loadOutDirsFromCheck = true,
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true,
            },
        },
    },
    on_attach = on_attach,
    capabilities = capabilities,
})

nvim_lsp.clangd.setup({ on_attach = on_attach, capabilities = capabilities })
nvim_lsp.gopls.setup({ on_attach = on_attach, capabilities = capabilities })

nvim_lsp.tsserver.setup({
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
    init_options = { hostInfo = "neovim" },
    root_dir = nvim_lsp.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
    on_attach = on_attach,
    capabilities = capabilities,
})

nvim_lsp.vimls.setup({ on_attach = on_attach, capabilities = capabilities })
nvim_lsp.rnix.setup({ on_attach = on_attach, capabilities = capabilities })

nvim_lsp.yamlls.setup({
    settings = {
        yaml = {
            schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
            },
        },
    },
    filetypes = { "yaml", "yaml.docker-compose" },
    on_attach = on_attach,
    capabilities = capabilities,
})

nvim_lsp.sqls.setup({ on_attach = on_attach, capabilities = capabilities })
nvim_lsp.html.setup({ on_attach = on_attach, capabilities = capabilities })
nvim_lsp.cssls.setup({ on_attach = on_attach, capabilities = capabilities })
nvim_lsp.jsonls.setup({
    commands = {
        Format = {
            function()
                vim.lsp.buf.format()
            end,
        },
    },
    on_attach = on_attach,
    capabilities = capabilities,
})

nvim_lsp.bashls.setup({ on_attach = on_attach, capabilities = capabilities })
nvim_lsp.dockerls.setup({ on_attach = on_attach, capabilities = capabilities })
nvim_lsp.terraformls.setup({
    settings = {
        filetypes = { "terraform", "hcl" },
    },
    on_attach = on_attach,
    capabilities = capabilities,
})

nvim_lsp.sumneko_lua.setup({
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { "vim" },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = { enable = false },
        },
    },
    on_attach = on_attach,
    capabilities = capabilities,
})

-- LSP Diagnostics Options Setup
local sign = function(opts)
    vim.fn.sign_define(opts.name, { texthl = opts.name, text = opts.text, numhl = "" })
end

sign({ name = "DiagnosticSignError", text = "E" })
sign({ name = "DiagnosticSignWarn", text = "W" })
sign({ name = "DiagnosticSignHint", text = "H" })
sign({ name = "DiagnosticSignInfo", text = "I" })

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = { border = "rounded", source = "always", header = "", prefix = "" },
})
