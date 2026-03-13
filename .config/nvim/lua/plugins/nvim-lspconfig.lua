return {
  "neovim/nvim-lspconfig",
  lazy=false,
  config = function()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    vim.lsp.enable('lua_ls')
    vim.lsp.config('lua_ls', {
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc')) then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
            }
          }
        })
      end,
      settings = {
        Lua = {
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
        }
      },
      capabilities = capabilities
    })
    vim.lsp.enable('zls')
    vim.lsp.enable('bashls')
    vim.lsp.enable('clangd')
    vim.lsp.enable('jsonnet_ls')
  end
};
