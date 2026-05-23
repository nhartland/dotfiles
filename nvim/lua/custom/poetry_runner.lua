local py_term_bufnr, py_term_winid = nil, nil

local function project_root()
    local toml = vim.fn.findfile("pyproject.toml", ".;")
    if toml == "" then return nil end
    return vim.fn.fnamemodify(toml, ":p:h")
end

local function is_poetry_project()
    return project_root() ~= nil
end

local function current_module()
    local root = project_root()
    local abs = vim.fn.expand("%:p")
    -- strip root prefix and .py suffix, replace path separators with dots
    local rel = abs:sub(#root + 2)  -- +2 to skip trailing slash
    return rel:gsub("%.py$", ""):gsub("/", ".")
end

local function should_spawn()
    if not (py_term_bufnr and vim.api.nvim_buf_is_valid(py_term_bufnr)) then return true end
    local ok, job_id = pcall(function() return vim.b[py_term_bufnr].terminal_job_id end)
    return not ok or not job_id or vim.fn.jobwait({ job_id }, 0)[1] ~= -1
end

local function open_terminal(script)
    vim.cmd("botright split | resize 15 | terminal poetry run python " .. vim.fn.shellescape(script))
    py_term_bufnr = vim.api.nvim_get_current_buf()
    py_term_winid = vim.api.nvim_get_current_win()
    vim.api.nvim_buf_set_name(py_term_bufnr, "Poetry Terminal")
    vim.bo[py_term_bufnr].buflisted = true

    vim.api.nvim_create_autocmd("TermClose", {
        buffer = py_term_bufnr,
        once = true,
        callback = function()
            if vim.api.nvim_win_is_valid(py_term_winid) then vim.api.nvim_win_close(py_term_winid, true) end
            py_term_bufnr, py_term_winid = nil, nil
            vim.notify("[INFO] Poetry runner closed.")
        end,
    })

    vim.notify("[Poetry] Running: poetry run python " .. script)
    vim.cmd("startinsert")
end

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.py",
    callback = function()
        if not is_poetry_project() then return end
        vim.keymap.set("n", "<leader>b", function()
            local script = vim.fn.expand("%:.")
            if should_spawn() then
                open_terminal(script)
            else
                local cmd = "poetry run python " .. vim.fn.shellescape(script) .. "\r"
                vim.api.nvim_chan_send(vim.b[py_term_bufnr].terminal_job_id, cmd)
                if not vim.api.nvim_win_is_valid(py_term_winid) then
                    vim.cmd("botright split | resize 15 | buffer " .. py_term_bufnr)
                    py_term_winid = vim.api.nvim_get_current_win()
                end
            end
        end, { buffer = 0, desc = "Run Python (Poetry)" })
    end,
})
