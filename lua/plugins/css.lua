return {
  -- CSS Language Server with enhanced completion
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.cssls = {
        settings = {
          css = {
            validate = true,
            lint = {
              unknownAtRules = "ignore",
              duplicateProperties = "warning",
              emptyRules = "warning",
              importStatement = "ignore",
              boxModel = "ignore",
              universalSelector = "ignore",
              zeroUnits = "ignore",
              fontFaceProperties = "warning",
              hexColorLength = "error",
              argumentsInColorFunction = "error",
              unknownProperties = "warning",
              validProperties = {},
            },
            completion = {
              triggerPropertyValueCompletion = true,
              completePropertyWithSemicolon = true,
            },
            hover = {
              documentation = true,
              references = true,
            },
          },
          scss = {
            validate = true,
            lint = {
              unknownAtRules = "ignore",
              duplicateProperties = "warning",
              emptyRules = "warning",
              importStatement = "ignore",
              boxModel = "ignore",
              universalSelector = "ignore",
              zeroUnits = "ignore",
              fontFaceProperties = "warning",
              hexColorLength = "error",
              argumentsInColorFunction = "error",
              unknownProperties = "warning",
              validProperties = {},
            },
            completion = {
              triggerPropertyValueCompletion = true,
              completePropertyWithSemicolon = true,
            },
            hover = {
              documentation = true,
              references = true,
            },
          },
          less = {
            validate = true,
            lint = {
              unknownAtRules = "ignore",
              duplicateProperties = "warning",
              emptyRules = "warning",
              importStatement = "ignore",
              boxModel = "ignore",
              universalSelector = "ignore",
              zeroUnits = "ignore",
              fontFaceProperties = "warning",
              hexColorLength = "error",
              argumentsInColorFunction = "error",
              unknownProperties = "warning",
              validProperties = {},
            },
            completion = {
              triggerPropertyValueCompletion = true,
              completePropertyWithSemicolon = true,
            },
            hover = {
              documentation = true,
              references = true,
            },
          },
        },
        filetypes = { "css", "scss", "less", "sass" },
        single_file_support = true,
      }
      
      -- Emmet Language Server for CSS abbreviations
      opts.servers.emmet_ls = {
        filetypes = {
          "html",
          "htmldjango",
          "css",
          "scss",
          "sass",
          "less",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "svelte",
        },
        init_options = {
          html = {
            options = {
              ["bem.enabled"] = true,
            },
          },
        },
      }
      
      return opts
    end,
  },
  
  -- Mason tool installer
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "css-lsp",
        "emmet-ls",
        "stylelint-lsp",
        "prettier",
      })
      return opts
    end,
  },
  
  -- Enhanced completion with additional CSS sources
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      {
        "roobert/tailwindcss-colorizer-cmp.nvim",
        config = function()
          require("tailwindcss-colorizer-cmp").setup({
            color_square_width = 2,
          })
        end,
      },
    },
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      
      -- Add CSS-specific completion sources
      vim.list_extend(opts.sources, {
        { name = "nvim_lsp", group_index = 1, keyword_length = 1 },
        { name = "emmet_vim", group_index = 2 },
        { name = "buffer", group_index = 3, keyword_length = 3 },
        { name = "path", group_index = 3 },
      })
      
      -- Enhanced formatting for CSS completion
      local format_kinds = opts.formatting and opts.formatting.format
      opts.formatting = opts.formatting or {}
      opts.formatting.format = function(entry, item)
        -- Apply existing formatting
        if format_kinds ~= nil then
          format_kinds(entry, item)
        end
        
        -- Add Tailwind color squares (safe call)
        local ok, colorizer = pcall(require, "tailwindcss-colorizer-cmp")
        if ok then
          item = colorizer.formatter(entry, item)
        end
        
        -- Enhance CSS property completion display
        if entry.source.name == "nvim_lsp" then
          local doc = entry.completion_item.documentation
          if doc and type(doc) == "table" and doc.value then
            item.menu = string.sub(doc.value, 1, 50) .. (string.len(doc.value) > 50 and "..." or "")
          end
        end
        
        return item
      end
      
      return opts
    end,
  },
  
  -- Treesitter for better syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "css",
        "scss",
      })
      return opts
    end,
  },
  
  -- Color highlighting for CSS
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      filetypes = {
        "css",
        "scss",
        "sass",
        "html",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "vue",
        "svelte",
      },
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        names = true,
        RRGGBBAA = false,
        AARRGGBB = false,
        rgb_fn = false,
        hsl_fn = false,
        css = false,
        css_fn = false,
        mode = "background",
        tailwind = true,
        sass = { enable = true, parsers = { "css" } },
        virtualtext = "■",
      },
      buftypes = {},
    },
  },
  
  -- Auto-pairs for CSS brackets and quotes
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = function(_, opts)
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")
      
      -- CSS-specific rules
      npairs.add_rules({
        Rule("{", "}", { "css", "scss", "sass" })
          :with_pair(cond.not_after_regex("%w"))
          :with_move(cond.none()),
        Rule("(", ")", { "css", "scss", "sass" })
          :with_pair(cond.not_after_regex("%w"))
          :with_move(cond.none()),
      })
      
      return opts
    end,
  },
}
