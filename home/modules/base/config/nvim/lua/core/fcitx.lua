local fn = vim.fn
local g = vim.g
local autocmd = vim.api.nvim_create_autocmd

local function fcitx2en()
    local input_status = tonumber(fn.system("fcitx5-remote"))
    if input_status == 2 then
        fn.system("fcitx5-remote -c")
        g.fcitx_input_inactivated = true
    end
end

local function fcitx2zh()
    local input_status = tonumber(fn.system("fcitx5-remote"))
    if input_status ~= 2 and g.fcitx_input_inactivated then
        fn.system("fcitx5-remote -o")
        g.fcitx_input_inactivated = false
    end
end

if fn.has("unix") == 1 then
    if fn.executable("fcitx5-remote") == 1 then
        autocmd({ "InsertLeave" }, { pattern = { "*" }, callback = fcitx2en })
        autocmd({ "InsertEnter" }, { pattern = { "*" }, callback = fcitx2zh })
    end
end
