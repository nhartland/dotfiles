return {
    "nhartland/base16-nvim",
    priority = 1000,
    opts = {},
    config = function(_, opts)
        require('base16-colorscheme').setup(
        )
    end
    --config = function(_, opts)
    --    require('base16-colorscheme').with_config({
    --        telescope = true,
    --        indentblankline = true,
    --        notify = true,
    --        ts_rainbow = true,
    --        cmp = true,
    --        illuminate = true,
    --        dapui = true,
    --    })
    --end
}
