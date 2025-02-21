local dap, dapui = require("dap"), require("dapui")

dap.configurations.zig = {
  {
    name = "Launch",
    type = 'zigbuild',
    request = 'launch',
    program = "${workspaceFolder}/zig-out/${workspaceFolderBasename}",
    cwd = '${workspaceFolder}/zig-out',
    stopOnEntry = false,
    args = {},
  },
}

dap.adapters.zigbuild = {
    id = 'zigbuild',
    type = "executable",
    command = "zig",
    args = {'build', 'debug_dap'},
}

-- open Dap UI automatically when debug starts (e.g. after <F5>)
dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end

-- close Dap UI with :DapCloseUI
vim.api.nvim_create_user_command("DapCloseUI", function()
    require("dapui").close()
end, {})

local sign = vim.fn.sign_define

sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
sign('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })
