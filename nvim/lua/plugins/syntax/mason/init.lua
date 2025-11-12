return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},

	require("plugins.syntax.mason.lspconfig"),
	require("plugins.syntax.mason.tool-installer"),
}
