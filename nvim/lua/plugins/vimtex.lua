-- plugins/vimtex.lua
return {
  {
    "lervag/vimtex",
    lazy = false, -- VimTeX handles its own lazy-loading via ft detection
    init = function()
      -- Use Zathura as the PDF viewer
      vim.g.vimtex_view_method = "zathura"

      -- Compiler: latexmk with pdflatex (default engine)
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        options = {
          "-pdf",
          "-interaction=nonstopmode",
          "-synctex=1",
        },
      }

      -- Disable VimTeX's default mappings on <localleader>l to avoid conflicts;
      -- we define our own below for discoverability with which-key
      vim.g.vimtex_mappings_prefix = "<localleader>l"

      -- Suppress some noisy warnings
      vim.g.vimtex_quickfix_mode = 0
    end,
    keys = {
      { "<localleader>ll", "<cmd>VimtexCompile<CR>",       ft = "tex", desc = "Toggle continuous compile" },
      { "<localleader>lv", "<cmd>VimtexView<CR>",          ft = "tex", desc = "View PDF (forward search)" },
      { "<localleader>lk", "<cmd>VimtexStop<CR>",          ft = "tex", desc = "Stop compiler" },
      { "<localleader>le", "<cmd>VimtexErrors<CR>",        ft = "tex", desc = "Show errors" },
      { "<localleader>lc", "<cmd>VimtexClean<CR>",         ft = "tex", desc = "Clean aux files" },
      { "<localleader>lt", "<cmd>VimtexTocToggle<CR>",     ft = "tex", desc = "Toggle table of contents" },
    },
  },
}
