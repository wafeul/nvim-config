return {
    "adisen99/apprentice.nvim",
    lazy=false,
    name = "apprentice",
    priority = 1000,
    dependencies = { "rktjmp/lush.nvim" },
    config = function()
        -- Load and setup function to choose plugin and language highlights
        require('lush')(require('apprentice').setup({
            plugins = {
                "buftabline",
                "coc",
                "cmp", -- nvim-cmp
                "fzf",
                "gitgutter",
                "gitsigns",
                "lsp",
                "lspsaga",
                "nerdtree",
                "netrw",
                "nvimtree",
                "neogit",
                "packer",
                "signify",
                "startify",
                "syntastic",
                "telescope",
                "treesitter"
            },
            langs = {
                "c",
                "clojure",
                "coffeescript",
                "csharp",
                "css",
                "elixir",
                "golang",
                "haskell",
                "html",
                "java",
                "js",
                "json",
                "jsx",
                "lua",
                "markdown",
                "moonscript",
                "objc",
                "ocaml",
                "purescript",
                "python",
                "ruby",
                "rust",
                "scala",
                "typescript",
                "viml",
                "xml"
            }
        }))
    end
}