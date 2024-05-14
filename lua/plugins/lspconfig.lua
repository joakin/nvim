-- LSP servers
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Useful status updates for LSP
    { "j-hui/fidget.nvim", opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    "folke/neodev.nvim",

    {
      "nvimtools/none-ls.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
    },

    -- These two are used in the config below
    "hrsh7th/nvim-cmp",
  },
  config = function()
    local null_ls = require("null-ls")
    local nvim_lsp = require("lspconfig")
    local _ = require("cmp_nvim_lsp")

    local flags = {
      debounce_text_changes = 500,
    }

    local lsp_formatting_augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    local setup_code_formatting = function(bufnr)
      vim.api.nvim_clear_autocmds({ group = lsp_formatting_augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = lsp_formatting_augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            timeout_ms = 1000,
            filter = function(client)
              if client.name == "tsserver" then
                return false
              end
              -- Local project autosave settings
              local path = vim.fn.expand("#" .. bufnr .. ":p")
              local ft = vim.opt.filetype:get()

              if ft == "jst" and client.name == "html" then
                return false
              end

              if string.find(path, "/wikimedia/") then
                if ft == "json" then
                  return false
                elseif ft == "vue" or ft == "javascript" then
                  return client.name == "eslint"
                end
              end
              return true
            end,
          })
        end,
      })
    end

    local on_attach = function(client, bufnr)
      local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
      end

      -- Enable completion triggered by <c-x><c-o>
      buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

      -- print(vim.inspect(vim.lsp.get_active_clients()[1].resolved_capabilities))

      -- Enable format on save if the language server supports it
      if client.server_capabilities.documentFormattingProvider then
        setup_code_formatting(bufnr)
      end

      -- Mappings.
      local function opts(desc)
        return { noremap = true, silent = true, desc = desc }
      end

      vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts("Go to definition"))
      vim.keymap.set("n", "<leader>ld", "<cmd>Telescope lsp_definitions<CR>", opts("Go to definition"))
      vim.keymap.set("n", "gD", "<cmd>Telescope lsp_type_definitions<CR>", opts("Go to type definition"))
      vim.keymap.set("n", "<leader>lt", "<cmd>Telescope lsp_type_definitions<CR>", opts("Go to type definition"))
      vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, opts("Go to declaration"))

      vim.keymap.set("n", "<leader>li", "<cmd>Telescope lsp_implementations<CR>", opts("List implementations"))

      vim.keymap.set("n", "gh", vim.lsp.buf.hover, opts("Show hover information"))
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("Show hover information"))

      vim.keymap.set("n", "<leader>lh", vim.lsp.buf.signature_help, opts("Show signature help"))

      vim.keymap.set("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
      vim.keymap.set("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
      vim.keymap.set("n", "<leader>lwl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, opts("List workspace folders"))

      vim.keymap.set("n", "<leader>ls", "<cmd>Telescope lsp_document_symbols<CR>", opts("Document symbols"))
      vim.keymap.set("n", "<leader>lws", "<cmd>Telescope lsp_workspace_symbols<CR>", opts("Workspace symbols"))

      vim.keymap.set("n", "<leader>lR", vim.lsp.buf.rename, opts("Rename symbol"))
      vim.keymap.set("n", "gR", vim.lsp.buf.rename, opts("Rename symbol"))

      vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts("Code actions"))

      vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts("References"))
      vim.keymap.set("n", "<leader>lr", "<cmd>Telescope lsp_references<CR>", opts("References"))

      vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts("Format buffer"))
      vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<CR>", opts("LS information"))

      vim.keymap.set("n", "<leader>lE", "<cmd>Telescope diagnostics bufnr=0<CR>", opts("File diagnostics"))
      vim.keymap.set("n", "<leader>lwe", "<cmd>Telescope diagnostics<CR>", opts("Workspace diagnostics"))
      vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float, opts("Show diagnostic under cursor"))
      vim.keymap.set("n", "[w", vim.diagnostic.goto_prev, opts("Go to previous diagnostic"))
      vim.keymap.set("n", "[@", vim.diagnostic.goto_prev, opts("Go to previous diagnostic"))
      vim.keymap.set("n", "<leader>lp", vim.diagnostic.goto_prev, opts("Go to previous diagnostic"))
      vim.keymap.set("n", "]w", vim.diagnostic.goto_next, opts("Go to next diagnostic"))
      vim.keymap.set("n", "]@", vim.diagnostic.goto_next, opts("Go to next diagnostic"))
      vim.keymap.set("n", "<leader>ln", vim.diagnostic.goto_next, opts("Go to next diagnostic"))
      vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, opts("Diagnostics to loclist"))
    end

    local servers = {
      gleam = {},
      clangd = {},
      ols = {},
      ocamllsp = {},
      rust_analyzer = {},
      tsserver = {
        root_dir = nvim_lsp.util.root_pattern("package.json", "tsconfig.json", "node_modules"),
      },
      denols = {
        root_dir = nvim_lsp.util.root_pattern("deno.json", "import_map.json"),
        init_options = {
          lint = true,
        },
      },
      cssls = {},
      elmls = {
        settings = {
          elmLS = {
            onlyUpdateDiagnosticsOnSave = true,
            -- This disables elmls specific diagnostics like unused code, missing
            -- signature, etc. The elm make errors still show up.
            disableElmLSDiagnostics = true,
          },
        },
        on_attach = function(client, bufnr)
          -- Force incremental sync to true since elm language server always assumes
          -- it like that.
          -- https://github.com/elm-tooling/elm-language-server/issues/503#issuecomment-773922548
          if client.config.flags then
            client.config.flags.allow_incremental_sync = true
          end
          on_attach(client, bufnr)
        end,
      },
      html = {},
      vuels = {},
      eslint = {
        on_attach = function(client, bufnr)
          -- https://github.com/neovim/nvim-lspconfig/pull/1299#issuecomment-942214556
          client.server_capabilities.documentFormattingProvider = true
          on_attach(client, bufnr)
        end,
      },
      lua_ls = {
        settings = {
          Lua = {
            runtime = {
              -- LuaJIT in the case of Neovim
              version = "LuaJIT",
            },
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
              enable = false,
            },
          },
        },
      },
      dartls = {},
      bashls = {},
    }

    for lsp, options in pairs(servers) do
      nvim_lsp[lsp].setup(vim.tbl_deep_extend("force", {
        on_attach = on_attach,
        flags = flags,
      }, options))
    end

    null_ls.setup({
      diagnostics_format = "#{m} [#{c} #{s}]",
      debounce = 500,
      on_attach = on_attach,
      sources = {
        null_ls.builtins.formatting.stylua.with({
          condition = function(utils)
            return utils.root_has_file("stylua.toml")
          end,
        }),
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.shellharden,
        null_ls.builtins.formatting.ocamlformat,
      },
    })
  end,
}
