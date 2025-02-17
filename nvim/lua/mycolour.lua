local M = {}

-- Path to the colorschemes directory
local colorscheme_dir = vim.fn.expand("~/.config/nvim/colorschemes/")
-- Ensure Neovim can find colorschemes
package.path = colorscheme_dir .. "?.lua;" .. package.path

-- Path to kitty config
local kitty_path = vim.fn.expand("~/.config/kitty/current-theme.conf")

-- Path to last set colorscheme
local colorscheme_save_path = vim.fn.expand("~/.config/.base16_theme")

-- Get list of colorscheme files
function M.get_colorschemes()
    local handle = vim.loop.fs_scandir(colorscheme_dir)
    local colorschemes = {}
    if not handle then
        vim.api.nvim_err_writeln("Error: Could not scan colorschemes directory.")
        return colorschemes
    end

    while true do
        local name, _ = vim.loop.fs_scandir_next(handle)
        if not name then
            break
        end
        if name:match("%.lua$") then
            local colourscheme_name = name:gsub("%.lua$", "")
            table.insert(colorschemes, colourscheme_name)
        end
    end
    return colorschemes
end

-- Write selected colorscheme to a file for persistence
local function save_colorscheme(name)
    local file = io.open(colorscheme_save_path, "w")
    if file then
        file:write(name)
        file:close()
    else
        vim.api.nvim_err_writeln("Failed to save colorscheme")
    end
end

-- Read last used colorscheme from file
local function get_active_colorscheme()
    local file = io.open(colorscheme_save_path, "r")
    if file then
        local name = file:read("*l")
        file:close()
        return name
    end
    vim.notify("No active colourscheme found at " .. colorscheme_save_path)
end

local function load_last_colorscheme()
    local name = get_active_colorscheme()
    if name and name ~= "" then
        M.set_colorscheme(name)
    end
end

-- Load colorscheme from Lua file using require with error handling
local function load_colorscheme(name)
    local success, colors = pcall(require, name)
    if not success then
        vim.api.nvim_err_writeln("Error: Failed to load colorscheme '" .. name .. "'.")
        vim.api.nvim_err_writeln("Lua require error: " .. tostring(colors))
        return nil
    end

    if type(colors) ~= "table" then
        vim.api.nvim_err_writeln("Error: Colorscheme '" .. name .. "' did not return a valid table.")
        return nil
    end

    return colors
end

function M.get_active_color_table()
    -- Returns the underlying color table currently active
    local name = load_last_colorscheme()
    if name then
        return load_colorscheme(name)
    else
        return {}
    end
end

local function expose_base16_globals(colors)
    -- Writes the colorscheme to vim.g in order to make it available to other modules.
    -- Specifically, lualine uses these colors for theming
    for i = 0, 15 do
        local hex_key = string.format("base%02X", i)       -- e.g., "base00", "base01"
        local gui_key = string.format("base16_gui%02X", i) -- e.g., "base16_gui00", "base16_gui01"

        if colors[hex_key] then
            vim.g[gui_key] = colors[hex_key]
        else
            vim.api.nvim_err_writeln("Missing color key: " .. hex_key)
        end
    end
end

-- Apply colorscheme to Neovim
local function apply_nvim_colorscheme(colors)
    local hi = setmetatable({}, {
        __newindex = function(_, hlgroup, args)
            if type(args) == "string" then
                vim.api.nvim_set_hl(0, hlgroup, { link = args })
                return
            end
            local val = {}
            if args.guifg then
                val.fg = args.guifg
            end
            if args.guibg then
                val.bg = args.guibg
            end
            if args.guisp then
                val.sp = args.guisp
            end
            if args.gui then
                for attr in args.gui:gmatch("[^,]+") do
                    if attr ~= "none" then
                        val[attr] = true
                    end
                end
            end
            vim.api.nvim_set_hl(0, hlgroup, val)
        end,
    })

    M.current_colors = colors

    -- Standard Highlight Groups
    hi.Normal = { guifg = colors.base05, guibg = colors.base00 }
    hi.Bold = { gui = "bold" }
    hi.Italic = { gui = "italic" }
    hi.Underlined = { guifg = colors.base05, gui = "underline" }
    hi.Error = { guifg = colors.base08, guibg = colors.base00 }
    hi.Comment = { guifg = colors.base03, gui = "italic" }
    hi.Keyword = { guifg = colors.base0E, gui = "bold" }
    hi.String = { guifg = colors.base0B }
    hi.Function = { guifg = colors.base0D, gui = "bold" }
    hi.Type = { guifg = colors.base0A }
    hi.Identifier = { guifg = colors.base05 }
    hi.Number = { guifg = colors.base09 }
    hi.Parameter = { guifg = colors.base07 }
    hi.Special = { guifg = colors.base0C }

    -- Treesitter Groups (Link to Standard Syntax Groups)
    hi["@comment"] = "Comment"
    hi["@keyword"] = "Keyword"
    hi["@string"] = "String"
    hi["@function"] = "Function"
    hi["@type"] = "Type"
    hi["@variable"] = "Identifier"
    hi["@number"] = "Number"
    hi["@boolean"] = "Number"
    hi["@operator"] = "Keyword"
    hi["@field"] = "Identifier"
    hi["@property"] = "Identifier"
    hi["@parameter"] = "Parameter"
    hi["@constant"] = "Parameter"
    hi["@namespace"] = "Identifier"

    -- Telescope Groups
    hi.TelescopePromptPrefix = { guifg = colors.base0D }

    -- Terminal Colors
    for i = 0, 15 do
        vim.g["terminal_color_" .. i] = colors["base" .. string.format("%X", i)]
    end
end

-- Write Kitty config file
local function write_kitty_config(colors, name)
    local kitty_template = ""
        .. "# Base16 "
        .. name
        .. " - kitty color config\n"
        .. "background "
        .. colors.base00
        .. "\n"
        .. "foreground "
        .. colors.base05
        .. "\n"
        .. "selection_background "
        .. colors.base05
        .. "\n"
        .. "selection_foreground "
        .. colors.base00
        .. "\n"
        .. "url_color "
        .. colors.base04
        .. "\n"
        .. "cursor "
        .. colors.base05
        .. "\n"
        .. "cursor_text_color "
        .. colors.base00
        .. "\n"
        .. "# normal\n"
        .. "color0 "
        .. colors.base00
        .. "\n"
        .. "color1 "
        .. colors.base08
        .. "\n"
        .. "color2 "
        .. colors.base0B
        .. "\n"
        .. "color3 "
        .. colors.base0A
        .. "\n"
        .. "color4 "
        .. colors.base0D
        .. "\n"
        .. "color5 "
        .. colors.base0E
        .. "\n"
        .. "color6 "
        .. colors.base0C
        .. "\n"
        .. "color7 "
        .. colors.base05
        .. "\n"
        .. "# bright\n"
        .. "color8 "
        .. colors.base03
        .. "\n"
        .. "color9 "
        .. colors.base09
        .. "\n"
        .. "color10 "
        .. colors.base01
        .. "\n"
        .. "color11 "
        .. colors.base02
        .. "\n"
        .. "color12 "
        .. colors.base04
        .. "\n"
        .. "color13 "
        .. colors.base06
        .. "\n"
        .. "color14 "
        .. colors.base0F
        .. "\n"
        .. "color15 "
        .. colors.base07
        .. "\n"

    local file = io.open(kitty_path, "w")
    if file then
        file:write(kitty_template)
        file:close()
    else
        vim.api.nvim_err_writeln("Failed to write Kitty config")
    end
end

-- Main function to apply a colorscheme
function M.set_colorscheme(name)
    local colors = load_colorscheme(name)
    if not colors then
        vim.api.nvim_err_writeln("Failed to load colorscheme: " .. name)
        return
    end

    apply_nvim_colorscheme(colors)
    expose_base16_globals(colors)
    write_kitty_config(colors, name)
    save_colorscheme(name)

    vim.loop.spawn("kitten", {
        args = {
            "@",
            "set-colors",
            "--all",
            "-c",
            kitty_path,
        },
    }, nil)

    -- Reload lualine if already loaded to referesh colourscheme
    if package.loaded["lazy"] and package.loaded['lualine'] then
        require("lazy.core.loader").reload("lualine.nvim")
    end
    -- TODO: Call kitten to update live kitty colourschemes
end

load_last_colorscheme()

return M
