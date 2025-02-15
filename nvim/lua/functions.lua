local M = {}
local Path = require("plenary.path")

function M.find_project_root()
    local markers = {
        -- Python
        "pyproject.toml",
        "setup.py",
        "requirements.txt",
        "Pipfile",
        "poetry.lock",
        "tox.ini",
        "pytest.ini",
        "pyrightconfig.json",
        ".pylintrc",
        ".python-version",

        -- Lua
        "selene.toml",
        ".luarc.json",
        ".luacheckrc",
        "init.lua",
        ".nvim.lua",

        -- General Development
        ".git",
        ".editorconfig",
        ".vscode",
        ".idea",
        "Makefile",
        "CMakeLists.txt",
        "Dockerfile",
    }

    local path = Path:new(vim.fn.expand("%:p:h"))

    while path and path.filename ~= "/" do
        for _, marker in ipairs(markers) do
            local marker_path = path:joinpath(marker)
            if marker_path:exists() then
                return path.filename
            end
        end
        path = path:parent() -- Move up one directory
    end

    return vim.fn.getcwd()
end

function M.get_relative_path()
    --- Returns the path of the current buffer relative to the project root.
    local root = M.find_project_root()
    local filepath = vim.fn.expand("%:p") -- Get full file path
    if filepath:sub(1, #root) == root then
        return filepath:sub(#root + 2) -- Return relative path from root
    end
    return filepath                    -- Fallback to full path if outside the project
end

function M.get_poetry_venv()
    local output = vim.fn.system("poetry env info --path")
    return vim.fn.trim(output)
end

-- Credit: https://rrethy.github.io/book/colorscheme.html
-- this is our single source of truth created above
local base16_theme_fname = vim.fn.expand(vim.env.HOME .. "/.config/.base16_theme")
-- this function is the only way we should be setting our colorscheme
function M.set_colorscheme(name)
    -- write our colorscheme back to our single source of truth
    vim.fn.writefile({ name }, base16_theme_fname)
    -- set Neovim's colorscheme
    vim.cmd("colorscheme " .. name)
    -- execute `kitty @ set-colors -c <color>` to change terminal window's
    -- colors and newly created terminal windows colors
    vim.loop.spawn("kitten", {
        args = {
            "@",
            "set-colors",
            "--all",
            "-c",
            string.format(vim.env.HOME .. "/base16-kitty/colors/%s.conf", name),
        },
    }, nil)
end

return M
