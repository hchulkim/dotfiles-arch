return {
	"R-nvim/R.nvim",
	lazy = false,
	opts = {
		rconsole_width = 0,   -- 0 disables vertical split; always opens below
	},
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
