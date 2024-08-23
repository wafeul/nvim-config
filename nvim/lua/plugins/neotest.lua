return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "V13Axel/neotest-pest",
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-pest")({
                    dap = { justMyCode = false },
                    ignore_dirs = { "vendor" },
                    test_file_suffixes = { "Test.php" },
                    sail_enabled = function()
                        return false
                    end,
                    pest_cmd = "vendor/bin/pest",
                }),
            },
        })
    end,
}
