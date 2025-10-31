local utils = require("config.utils")

-- LSP lists
local language_servers = {
	basics = {
		"bashls",
		"hyprls",
		"jsonls",
		"lua_ls",
	},

	devops_and_infra = {
		"docker_compose_language_service",
		"docker_language_server",
		"dockerls",
		"gh_actions_ls",
		"helm_ls",
		"kcl",
		"nginx_language_server",
		"terraformls",
		"tflint",
		"yamlls",
	},

	web_dev = {
		"ts_ls",

		-- Backend
		"jqls",
		"prismals",
		"pylsp",

		-- Frontend
		"astro",
		"cssls",
		"css_variables",
		"cssmodules_ls",
		"html",
		"htmx",
		"svelte",
		"tailwindcss",
	},
}

local formatters = {
	basics = {
		"ast-grep",
		"prettier",
		"prettierd",
		"shfmt",
		"stylua",
	},

	devops_and_infra = {
		"nginx-config-formatter",
		"terraform",
	},

	web_dev = {
		"jq",
	},
}

local linters = {
	basics = {
		"jsonlint",
		"shellharden",
	},

	devops_and_infra = {
		"sonarlint-language-server",
	},

	web_dev = {
		"eslint_d",
		"stylelint",
	},
}

local function setup_mason()
	local mason = require("mason")

	mason.setup()
end

local function setup_lspconfig()
	local lspconfig = require("mason-lspconfig")

	lspconfig.setup({
		ensure_installed = utils.table_join({
			language_servers.basics,
			language_servers.devops_and_infra,
			language_servers.web_dev,
		}),

		-- automatic_enable = utils.table_join({ language_servers.basics, language_servers.devops_and_infra })
		automatic_enable = true,
	})
end

local function setup_tools()
	local tool_installer = require("mason-tool-installer")

	tool_installer.setup({
		auto_update = true,

		ensure_installed = utils.table_join({
			formatters.basics,
			formatters.devops_and_infra,
			formatters.web_dev,

			linters.basics,
			linters.devops_and_infra,
			linters.web_dev,
		}),

		integrations = {
			["mason-lspconfig"] = true,
		},

		run_on_start = true,
		start_delay = 5000,
	})
end

local function setup_conform()
	local conform = require("conform")

	conform.setup({
		formatters_by_ft = {
			-- Basics
			bash = { "shfmt", "shellharden", stop_after_first = true },
			json = { "prettier" },
			lua = { "stylua" },

			-- DevOps and Infra
			terraform = { "terraform" },
			yaml = { "prettier", "helm_ls" },

			-- Web dev
			css = { "prettier", "ast-grep", stop_after_first = true },
			scss = { "prettier", "ast-grep", stop_after_first = true },
			html = { "prettier", "ast-grep", stop_after_first = true },
			htmx = { "prettier", "ast-grep", stop_after_first = true },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },

			-- Misc
			rust = { "ast-grep" },
			python = { "ast-grep" },
		},
	})
end

local function setup()
	setup_mason()
	setup_lspconfig()
	setup_tools()

	setup_conform()
end

setup()
