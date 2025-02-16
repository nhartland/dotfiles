local telescope = require("telescope")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local mc = require('mycolour')

local function base16_colorpicker()
    local colors = mc.get_colorschemes()

    pickers.new({}, {
        prompt_title = "Change Colorscheme",
        finder = finders.new_table {
            results = colors,
        },
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            local function apply_colorscheme()
                local selection = action_state.get_selected_entry()
                if selection then
                    mc.set_colorscheme(selection[1])
                end
                actions.close(prompt_bufnr)
            end

            map("i", "<CR>", apply_colorscheme)
            map("n", "<CR>", apply_colorscheme)

            return true
        end,
    }):find()
end

return telescope.register_extension({
    exports = {
        base16_colorpicker = base16_colorpicker
    },
})
