vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "text", "gitcommit" },
    callback = function()
        vim.opt.spell = true                                                   -- Enable spellcheck
        vim.opt.spelllang = "en_gb"                                            -- Use British English
        vim.opt.spellfile = vim.fn.expand("~/.config/nvim/spell/en.utf-8.add") -- Custom spellfile
    end
})
