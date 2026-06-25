return {
  "ojroques/nvim-osc52",
  config = function()
    require("osc52").setup({
      max_length = 0,
      silent = false,
      trim = false,
    })

    local osc52 = require("osc52")
    local clipboard_cache = {
      ["+"] = { {}, "v" },
      ["*"] = { {}, "v" },
    }

    local function copy(lines, regtype)
      clipboard_cache["+"] = { vim.deepcopy(lines), regtype }
      clipboard_cache["*"] = { vim.deepcopy(lines), regtype }
      return osc52.copy(table.concat(lines, "\n"))
    end

    local function paste(register)
      return clipboard_cache[register]
    end

    local function set_osc52_clipboard()
      vim.opt.clipboard = "unnamedplus"
      vim.g.clipboard = {
        name = "osc52",
        copy = {
          ["+"] = copy,
          ["*"] = copy,
        },
        paste = {
          ["+"] = function()
            return paste("+")
          end,
          ["*"] = function()
            return paste("*")
          end,
        },
      }
    end

    set_osc52_clipboard()

    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = set_osc52_clipboard,
    })

    vim.keymap.set("n", "<leader>y", require("osc52").copy_operator, { expr = true })
    vim.keymap.set("n", "<leader>yy", "<leader>y_", { remap = true })
    vim.keymap.set("v", "<leader>y", require("osc52").copy_visual)
  end,
}
