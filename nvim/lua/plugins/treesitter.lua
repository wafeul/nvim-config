----------------------------------------------------------------------------------------------------
--                                      Tree-Sitter setup
----------------------------------------------------------------------------------------------------

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        ensure_installed = {"php", "lua", "javascript", "python"}
        highlight = {enable = "true"}
    end
}

