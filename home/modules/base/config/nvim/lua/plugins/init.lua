local packer_bootstrap = nil
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    if fn.executable("git") == 1 then
        local packer_repo_url = "https://github.com/wbthomason/packer.nvim"
        packer_bootstrap = fn.system({ "git", "clone", "--depth", "1", packer_repo_url, install_path })
    else
        print("Git not found!")
    end
end

-- Plugins
vim.cmd("packadd packer.nvim")

return require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    -- Tool for speeding up loading Lua modules in Neovim to improve startup time.
    use("lewis6991/impatient.nvim")

    -- Color scheme
    use("joshdick/onedark.vim")
    use({ "sonph/onehalf", rtp = "vim/" })
    use("mhartington/oceanic-next")

    -- Icon
    use("kyazdani42/nvim-web-devicons")

    -- Status
    use({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    })
    use("arkav/lualine-lsp-progress")

    -- Buffer management
    use({
        "akinsho/bufferline.nvim",
        tags = "v2.*",
        requires = "kyazdani42/nvim-web-devicons",
    })

    -- File tree
    use({
        "kyazdani42/nvim-tree.lua",
        requires = {
            "kyazdani42/nvim-web-devicons", -- optional, for file icons
        },
        tag = "nightly", -- optional, updated every week. (see issue #1193)
    })

    -- Todo comments
    use({
        "folke/todo-comments.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("todo-comments").setup()
        end,
    })

    --  Finder
    use({ "nvim-telescope/telescope.nvim", tag = "0.1.0", requires = "nvim-lua/plenary.nvim" })

    -- Trouble
    use({
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
    })

    -- Indent line
    use("lukas-reineke/indent-blankline.nvim")

    -- EditorConfig
    use("editorconfig/editorconfig-vim")

    use("tpope/vim-surround")

    -- Git
    use("tpope/vim-fugitive")
    use("airblade/vim-gitgutter")

    -- Auto-pairing
    use({
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end,
    })

    -- Better whitespace
    use("ntpeters/vim-better-whitespace")

    -- Code formatter
    use("sbdchd/neoformat")

    -- moving
    use({
        "phaazon/hop.nvim",
        branch = "v2",
    })

    use("s1n7ax/nvim-search-and-replace")

    -- Language Server Protocol
    use("neovim/nvim-lspconfig")
    use("simrat39/rust-tools.nvim")

    use({
        "SmiteshP/nvim-navic",
        requires = "neovim/nvim-lspconfig",
    })

    -- show symbols on sidebar
    use("simrat39/symbols-outline.nvim")

    -- pictograms for LSP-client
    use("onsails/lspkind.nvim")

    -- Completion framework:
    use("hrsh7th/nvim-cmp") -- Autocompletion plugin

    -- LSP completion source:
    use("hrsh7th/cmp-nvim-lsp")

    -- Useful completion sources:
    use("hrsh7th/cmp-nvim-lua")
    use("hrsh7th/cmp-nvim-lsp-signature-help")
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/vim-vsnip")

    -- Snippets source for nvim-cmp
    use("saadparwaiz1/cmp_luasnip")
    -- Snippets plugin
    use("L3MON4D3/LuaSnip")

    -- tree-sitter
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    })

    -- vim-easygrep
    use("dkprice/vim-easygrep")

    -- Comment
    use({
        "numToStr/Comment.nvim",
        config = function()
            require("Comment").setup()
        end,
    })

    -- Auto close tag
    use("windwp/nvim-ts-autotag")

    -- Language
    -- VIM rego
    use("tsandall/vim-rego")

    -- Fast HTML
    use({ "mattn/emmet-vim", { ft = { "html" } } })

    -- LaTeX
    use({ "lervag/vimtex", { ft = { "tex" } } })

    -- Mermaid
    use({ "chazmcgarvey/vim-mermaid", { ft = { "mermaid" } } })

    -- HTTP client
    use({
        "NTBBloodbath/rest.nvim",
        requires = { "nvim-lua/plenary.nvim" },
    })

    -- Rusty Object Notation
    -- TODO: replace with nvim-treesitter
    use("ron-rs/ron.vim")

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end

    require("plugins.configs.lualine")
    require("plugins.configs.bufferline")
    require("plugins.configs.better-whitespace")
    require("plugins.configs.indent-blankline")
    require("plugins.configs.completion")
    require("plugins.configs.neoformat")
    require("plugins.configs.nvim-tree")
    require("plugins.configs.rust-tools")
    require("plugins.configs.telescope")
    require("plugins.configs.hop")
    require("plugins.configs.tree-sitter")
    require("plugins.configs.symbols-outline")
    require("plugins.configs.trouble")
    require("plugins.configs.rest")
    require("plugins.configs.vimtex")
    require("plugins.configs.nvim-search-and-replace")
    require("plugins.configs.lsp-config")
end)
