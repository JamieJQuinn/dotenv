return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    "nvim-neotest/nvim-nio",
    "williamboman/mason.nvim",
  },
  event = "BufEnter",
  config = function()
    local dap = require "dap"
    local ui = require "dapui"

    dap.set_log_level('TRACE')
    require("dapui").setup()
    require("nvim-dap-virtual-text").setup {}

    dap.configurations.zig = {
      {
        name = "Launch",
        type = 'zigbuild',
        request = 'launch',
      },
    }

    dap.adapters.zigbuild = {
        id = 'zigbuild',
        type = "executable",
        command = "zig",
        args = {'build', 'debug_dap'},
    }

    vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
    vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)

    -- Eval var under cursor
    vim.keymap.set("n", "<leader>?", function()
      require("dapui").eval(nil, { enter = true })
    end)

    vim.keymap.set("n", "<leader>dd", dap.continue)
    vim.keymap.set("n", "<leader>dp", dap.pause)
    vim.keymap.set("n", "<leader>j", dap.down)
    vim.keymap.set("n", "<leader>k", dap.up)
    -- vim.keymap.set("n", "<leader>j", dap.step_into)
    -- vim.keymap.set("n", "<leader>l", dap.step_over)
    -- vim.keymap.set("n", "<leader>k", dap.step_out)
    -- vim.keymap.set("n", "<leader>di", dap.step_back)
    vim.keymap.set("n", "<leader>dr", dap.restart)
    vim.keymap.set("n", "<leader>dt", dap.terminate)

    dap.listeners.before.attach.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      ui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      ui.close()
    end

    vim.api.nvim_create_user_command("DapCloseUI", function()
        require("dapui").close()
    end, {})

    local sign = vim.fn.sign_define

    sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
    sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
    sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
    sign('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStopped', numhl = 'DapStopped' })
  end,
}
