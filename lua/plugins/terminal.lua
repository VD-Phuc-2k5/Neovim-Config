-- terminal.lua
return {
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 10,
        open_mapping = [[<C-o>]],
        hide_numbers = true,
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        start_in_insert = true,
        insert_mappings = true,
        persist_size = true,
        direction = "horizontal",
        close_on_exit = true,
        shell = "powershell.exe",
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })

      -- PowerShell Core terminal
     local pwsh = Terminal:new({
        cmd = "pwsh.exe",
        dir = "git_dir", 
        direction = "horizontal",
        float_opts = {
          border = "double",
        },
        on_open = function(term)
          vim.cmd("startinsert!")
          vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
        end,
        on_close = function(term)
          vim.cmd("startinsert!")
        end,
      })

      local powershell_float = Terminal:new({
        cmd = "powershell.exe",
        dir = "git_dir",
        direction = "float",
        float_opts = {
          border = "curved",
          width = 120,
          height = 30,
        },
        on_open = function(term)
          vim.cmd("startinsert!")
        end,
      })

      function _POWERSHELL_TOGGLE()
        powershell:toggle()
      end

      function _PWSH_TOGGLE()
        pwsh:toggle()
      end

      function _POWERSHELL_FLOAT_TOGGLE()
        powershell_float:toggle()
      end

      vim.api.nvim_set_keymap("n", "<leader>tp", "<cmd>lua _POWERSHELL_TOGGLE()<CR>", {noremap = true, silent = true, desc = "Toggle PowerShell"})
      vim.api.nvim_set_keymap("n", "<leader>tc", "<cmd>lua _PWSH_TOGGLE()<CR>", {noremap = true, silent = true, desc = "Toggle PowerShell Core"})
      vim.api.nvim_set_keymap("n", "<leader>tf", "<cmd>lua _POWERSHELL_FLOAT_TOGGLE()<CR>", {noremap = true, silent = true, desc = "Toggle Floating PowerShell"})
    end,
  },
}
