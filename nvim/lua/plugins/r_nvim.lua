return {
	"R-nvim/R.nvim",
	ft = { "r", "rmd", "rnoweb" },
	opts = {
		rconsole_width = 0,   -- 0 disables vertical split; always opens below
		-- Disable R.nvim's quarto preview/render/stop maps so quarto-nvim's \qp works directly
		disable_cmds = { "RQuartoPreview", "RQuartoStop", "RQuartoRender" },
	},
	init = function()
		-- Set BEFORE ftplugin runs so R.nvim's ftplugin/quarto_rnvim.lua skips quarto files
		vim.g.R_filetypes = { "r", "rmd", "rnoweb" }
	end,
	config = function(_, opts)
		require("r").setup(opts)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "r", "rmd" },
			callback = function()
				vim.keymap.set("n", "<C-CR>", "<Plug>RSendLine", { buffer = true, desc = "Send line to R" })
				vim.keymap.set("i", "<C-CR>", "<Esc><Plug>RSendLine", { buffer = true, desc = "Send line to R" })
				vim.keymap.set("v", "<C-CR>", "<Plug>RSendSelection", { buffer = true, desc = "Send selection to R" })
			end,
		})
	end,
}
