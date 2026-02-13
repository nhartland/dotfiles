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
                -- Defer all lint-style diagnostics to ruff
                diagnosticSeverityOverrides = {
                    reportUndefinedVariable = "none",
                    reportUnusedImport = "none",
                    reportUnusedVariable = "none",
                    reportMissingImports = "none",
                    reportMissingModuleSource = "none",
                    reportUnusedExpression = "none",
                    reportDuplicateImport = "none",
                },
            },
        },
        python = {
            pythonPath = require("custom.functions").get_poetry_interpreter()
        },
    }
}
