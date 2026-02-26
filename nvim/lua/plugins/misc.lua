return {
  -- File explorer (sidebar)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup()
      vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
    end,
  },

  -- Status line (looks nice)
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup()
    end,
  },

  -- Fuzzy file finder (like Ctrl+P in VSCode)
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>", { desc = "Find files" })
      vim.keymap.set("n", "<C-f>", ":Telescope live_grep<CR>", { desc = "Search in files" })
    end,
  },

  -- iron.nvim: REPL for Python and Julia
  {
    "Vigemus/iron.nvim",
    config = function()
      require("iron.core").setup({
        config = {
          repl_definition = {
            python = { command = { "python3" } },
            julia = { command = { "julia" } },
          },
          repl_open_cmd = require("iron.view").right(40),
        },
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "python", "julia" },
        callback = function()
          vim.keymap.set("n", "<C-CR>", function()
            require("iron.core").send_line()
          end, { buffer = true, desc = "Send line to REPL" })
          vim.keymap.set("v", "<C-CR>", function()
            require("iron.core").visual_send()
          end, { buffer = true, desc = "Send selection to REPL" })
          vim.keymap.set("i", "<C-CR>", function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
            vim.schedule(function() require("iron.core").send_line() end)
          end, { buffer = true, desc = "Send line to REPL" })
        end,
      })
    end,
  },

  -- LSP config
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config("r_language_server", {
        cmd = { "R", "--slave", "-e", "languageserver::run()" },
        filetypes = { "r", "rmd" },
      })
      vim.lsp.enable("r_language_server")

      -- Ctrl+/ to toggle comments (visual + normal mode)
      vim.keymap.set("n", "<C-/>", "gcc", { remap = true, desc = "Toggle comment line" })
      vim.keymap.set("v", "<C-/>", "gc", { remap = true, desc = "Toggle comment" })
      vim.keymap.set("n", "<C-_>", "gcc", { remap = true, desc = "Toggle comment line" })
      vim.keymap.set("v", "<C-_>", "gc", { remap = true, desc = "Toggle comment" })

      -- R shortcuts (insert mode)
      vim.keymap.set("i", "<M-->", " <- ", { desc = "R assign" })
      vim.keymap.set("i", "<M-m>", " |> ", { desc = "R pipe" })
    end,
  },


}
