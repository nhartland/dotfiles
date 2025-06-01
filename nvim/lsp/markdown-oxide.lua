return {
    root_markers = {
        ".obsidian",
        ".git",
        ".moxide.toml",
    },
    cmd = { 'markdown-oxide' },
    filetypes = { 'markdown' },
    single_file_support = true,
    settings = {},
    capabilities = {
        workspace = {
            didChangeWatchedFiles = {
                dynamicRegistration = true,
            },
        },
    },
}
