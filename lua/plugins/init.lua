return {
  { "jparise/vim-graphql" },
  {
    "MagicDuck/grug-far.nvim",
    config = function()
      require("grug-far").setup({})
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() and cmp.get_active_entry() then
            -- completion if a cmp item is selected
            cmp.confirm({ select = false, behavior = cmp.ConfirmBehavior.Replace })
          elseif vim.fn.exists("b:_codeium_completions") ~= 0 then
            -- accept codeium completion if visible
            vim.api.nvim_input(vim.fn["codeium#Accept"]())
            fallback()
          elseif cmp.visible() then
            -- select first item if visible
            cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
          elseif has_words_before() then
            -- show autocomplete
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
}
