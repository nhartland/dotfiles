-- This file is to trick lualine into thinking that the base16-nvim package is loaded
-- It is not, but we expose the same globals.
return {
    colors = require('mycolour').get_active_color_table()
}
