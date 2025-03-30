return {
    cmd = { 'basedpyright-langserver', '--stdio' },
    filetypes = { 'python' },
    root_markers = {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "pyrightconfig.json",
    },
    settings = {
        basedpyright = {
            analysis = {
                -- Use this to instead use ruff's organiser
                disableOrganizeImports = true,
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = "basic",
                useLibraryCodeForTypes = true,
                -- Overlap with ruff
                reportUndefinedVariable = false,
                reportUnusedImport = false,
                --reportMissingTypeStubs = "none",
                --reportUnknownMemberType = false,
                --reportUnknownVariableType = "none",
                --reportUnknownArgumentType = "none",
                --reportUnknownLambdaType = "none",
                -- Use this to disable all linting
                --ignore = { '*' },
            },
        },
        python = {
            pythonPath = require("custom.functions").get_poetry_interpreter()
        },
    }
}
