-- plugins/quarto.lua
return {
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto", "qmd" },
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      lspFeatures = {
        languages = { "r", "python", "julia" },
        chunks = "all",
        diagnostics = {
          enabled = true,
          triggers = { "BufWritePost" },
        },
        completion = {
          enabled = true,
        },
      },
      codeRunner = {
        enabled = true,
        default_method = "slime",
      },
    },
    keys = {
      { "<localleader>qp", function()
          local file = vim.fn.expand("%:p")
          vim.fn.jobstart({ "quarto", "preview", file }, { detach = true })
        end, desc = "Quarto preview" },
      { "<localleader>qc", function()
          vim.fn.jobstart({ "quarto", "preview", "--stop" }, { detach = true })
        end, desc = "Quarto close preview" },
      { "<localleader>qr", ":QuartoSendAbove<CR>",      desc = "Quarto run above" },
      { "<localleader>qa", ":QuartoSendAll<CR>",        desc = "Quarto run all" },
    },
  },
}
