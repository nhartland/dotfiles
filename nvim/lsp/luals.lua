return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.luarc.json', '.luarc.jsonc' },
    -- https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
    settings = {
        Lua = {
            completion = {
                callSnippet = "Replace",
            },
            diagnostics = {
                globals = { "vim", "love" },
                -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                disable = { 'missing-fields' },
            },
            runtime = {
                version = 'LuaJIT',
            }
        }
    }
}
