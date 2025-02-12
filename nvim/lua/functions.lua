local M = {}
local Path = require("plenary.path")

function M.find_project_root()
    local markers = {
        -- Python
        "pyproject.toml", "setup.py", "requirements.txt", "Pipfile", "poetry.lock",
        "tox.ini", "pytest.ini", "pyrightconfig.json", ".pylintrc", ".python-version",

        -- Lua
        "selene.toml", ".luarc.json", ".luacheckrc", "init.lua", ".nvim.lua",

        -- General Development
        ".git", ".editorconfig", ".vscode", ".idea", "Makefile", "CMakeLists.txt", "Dockerfile"
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
        return filepath:sub(#root + 2)    -- Return relative path from root
    end
    return filepath                       -- Fallback to full path if outside the project
end

return M
