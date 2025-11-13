local _langs = require("config.utils.constants.languages")

local _table = require("config.utils.table")

local automatic_enable = {
	language_servers = true, -- Could be smth like this as well _table.merge_arrays({ language_servers.basics, language_servers.devops_and_infra })
}

local function setup_mason()
	local mason = require("mason")

	mason.setup()
end

local function setup_lspconfig()
	local lspconfig = require("mason-lspconfig")

	lspconfig.setup({
		ensure_installed = _langs.lang_server_list,
		automatic_enable = automatic_enable.language_servers,
	})
end

local function setup_linters()
	local lint = require("lint")

	local web_lint_combo = { "eslint_d", "ast-grep", stop_after_first = true }
	local css_lint = { "stylelint" }

	lint.linters_by_fmt = {
		-- Basics
		bash = { "shellharden", "shfmt", stop_after_first = true },
		json = { "jsonlint" },
		lua = { "stylua" },

		-- DevOps and Infra
		terraform = { "terraform" },
		smarty = { "sonarlint-language-server" }, -- Some helm files are described as smarty
		yaml = { "sonarlint-language-server" },

		-- Web dev
		css = css_lint,
		scss = css_lint,
		html = { "htmlhint" },
		htmx = { "htmlhint" },
		jsx = web_lint_combo,
		tsx = web_lint_combo,
		javascriptreact = web_lint_combo,
		typescriptreact = web_lint_combo,
		javascript = web_lint_combo,
		typescript = web_lint_combo,

		-- Misc
		rust = { "ast-grep" },
		python = { "ast-grep" },
	}
end

local function setup_tools()
	local tool_installer = require("mason-tool-installer")

	tool_installer.setup({
		auto_update = true,

		ensure_installed = _table.merge_arrays({
			_langs.formatters.basics,
			_langs.formatters.devops_and_infra,
			_langs.formatters.web_dev,

			_langs.linters.basics,
			_langs.linters.devops_and_infra,
			_langs.linters.web_dev,
		}),

		integrations = {
			["mason-lspconfig"] = true,
		},

		run_on_start = true,
		start_delay = 5000,
	})
end

local function setup_blink()
	local capabilities = require("blink.cmp").get_lsp_capabilities()

	for i, server in ipairs(_langs.lang_server_list) do
		local config = vim.lsp.config[server]
		vim.lsp.config[server] = _table.merge_arrays({ config, { capabilities = capabilities } })

		vim.lsp.enable(server)
	end
end

local function setup_conform()
	local conform = require("conform")

	local static_web_fmt_combo = { "prettier", "ast-grep", stop_after_first = true }
	local web_fmt_combo = { "prettierd", "prettier", stop_after_first = true }

	conform.setup({
		formatters_by_ft = {
			-- Basics
			bash = { "shellharden", "shfmt", stop_after_first = true },
			json = { "prettier" },
			lua = { "stylua" },

			-- DevOps and Infra
			terraform = { "terraform" },
			yaml = { "prettier", "helm_ls" },

			-- Web dev
			css = static_web_fmt_combo,
			scss = static_web_fmt_combo,
			html = static_web_fmt_combo,
			htmx = static_web_fmt_combo,
			jsx = web_fmt_combo,
			tsx = web_fmt_combo,
			javascriptreact = web_fmt_combo,
			typescriptreact = web_fmt_combo,
			javascript = web_fmt_combo,
			typescript = web_fmt_combo,

			-- Misc
			rust = { "ast-grep" },
			python = { "ast-grep" },
		},
	})
end

local function config()
	setup_mason()
	setup_lspconfig()
	setup_linters()
	setup_blink()
	setup_tools()

	setup_conform()
end

return {
	config = config,
}
