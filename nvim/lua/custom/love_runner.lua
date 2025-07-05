local love_term_bufnr, love_term_winid = nil, nil

local function is_love_project()
    return vim.fn.findfile("main.lua", ".;") ~= ""
end

local function should_spawn()
    if not (love_term_bufnr and vim.api.nvim_buf_is_valid(love_term_bufnr)) then return true end
    local ok, job_id = pcall(function() return vim.b.terminal_job_id end)
    return not ok or not job_id or vim.fn.jobwait({ job_id }, 0)[1] ~= -1
end

local function open_terminal()
    vim.cmd("botright split | resize 15 | terminal love .")
    love_term_bufnr = vim.api.nvim_get_current_buf()
    love_term_winid = vim.api.nvim_get_current_win()
    vim.api.nvim_buf_set_name(love_term_bufnr, "LOVE2D Terminal")
    vim.api.nvim_buf_set_option(love_term_bufnr, "buflisted", true)

    vim.api.nvim_create_autocmd("TermClose", {
        buffer = love_term_bufnr,
        once = true,
        callback = function()
            if vim.api.nvim_win_is_valid(love_term_winid) then vim.api.nvim_win_close(love_term_winid, true) end
            love_term_bufnr, love_term_winid = nil, nil
            vim.notify("[INFO] LOVE2D closed.")
        end,
    })

    vim.notify("[LOVE2D] Terminal opened and running.")
end

vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*.lua",
    callback = function()
        if not is_love_project() then return end
        vim.keymap.set("n", "<leader>b", function()
            if should_spawn() then open_terminal() else vim.api.nvim_chan_send(vim.b.terminal_job_id, "love .\r") end
        end, { buffer = 0, desc = "Run LOVE2D" })
    end,
})
