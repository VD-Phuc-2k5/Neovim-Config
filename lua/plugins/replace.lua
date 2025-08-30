return {
  "VonHeikemen/searchbox.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "stevearc/dressing.nvim"
  },
  config = function()
    require("searchbox").setup({
      popup = {
        relative = "cursor",
        position = { row = 1, col = 0 },
        border = { style = "single" },
      },
    })
    
    require("dressing").setup({
      input = {
        relative = "cursor",
        prefer_width = 40,
        max_width = { 140, 0.9 },
        min_width = { 20, 0.1 },
      },
      select = {
        backend = { "telescope", "fzf", "builtin" },
        builtin = {
          relative = "cursor",
        },
      },
    })
    
    local function replace_current_word()
      local current_word = vim.fn.expand("<cword>")
      if current_word == "" then
        print("No word under cursor")
        return
      end
      
      vim.ui.input({
        prompt = "Replace with: ",
        default = current_word,
      }, function(replacement)
        if not replacement or replacement == "" or replacement == current_word then
          return
        end
        
        local search_pattern = "\\<" .. vim.fn.escape(current_word, '/\\') .. "\\>"
        vim.cmd("normal! mz")
        
        local original_pos = vim.fn.getpos(".")
        vim.fn.setpos(".", {0, 1, 1, 0})
        
        local matches = {}
        while true do
          local pos = vim.fn.searchpos(search_pattern, "W")
          if pos[1] == 0 then break end
          table.insert(matches, { line = pos[1], col = pos[2] })
        end
        
        vim.fn.setpos(".", original_pos)
        
        if #matches == 0 then
          print("No matches found for: " .. current_word)
          return
        end
        
        local idx = 1
        
        local function process_next()
          if idx > #matches then
            vim.cmd("normal! `z")
            return 
          end
          
          local match = matches[idx]
          local adjusted_col = match.col
          if idx > 1 then
            for i = 1, idx - 1 do
              local prev_match = matches[i]
              if prev_match.line == match.line and prev_match.col < match.col then
                adjusted_col = adjusted_col + (string.len(replacement) - string.len(current_word))
              end
            end
          end
          
          vim.fn.cursor(match.line, adjusted_col)
          
          vim.ui.select({"Yes", "No", "All", "Quit"}, {
            prompt = string.format("Replace '%s' at line %d? (%d/%d)", 
                                   current_word, match.line, idx, #matches),
            format_item = function(item)
              return item
            end,
          }, function(choice)
            if choice == "Yes" then
              local line = vim.fn.getline(match.line)
              local start_col = adjusted_col - 1
              local end_col = start_col + string.len(current_word)
              
              local new_line = string.sub(line, 1, start_col) .. replacement .. string.sub(line, end_col + 1)
              vim.fn.setline(match.line, new_line)
              
              idx = idx + 1
              vim.schedule(process_next)
            elseif choice == "No" then
              idx = idx + 1
              vim.schedule(process_next)
            elseif choice == "All" then
              for i = #matches, idx, -1 do
                local m = matches[i]
                local adj_col = m.col
                
                for j = 1, i - 1 do
                  local prev_match = matches[j]
                  if prev_match.line == m.line and prev_match.col < m.col and j < idx then
                    adj_col = adj_col + (string.len(replacement) - string.len(current_word))
                  end
                end
                
                vim.fn.cursor(m.line, adj_col)
                local line = vim.fn.getline(m.line)
                local start_col = adj_col - 1
                local end_col = start_col + string.len(current_word)
                local new_line = string.sub(line, 1, start_col) .. replacement .. string.sub(line, end_col + 1)
                vim.fn.setline(m.line, new_line)
              end
              vim.cmd("normal! `z")
              return
            elseif choice == "Quit" then
              vim.cmd("normal! `z")
              return
            end
          end)
        end
        
        process_next()
      end)
    end
    
    vim.keymap.set("n", "<leader>r", replace_current_word, { desc = "Replace word under cursor" })
  end,
}
