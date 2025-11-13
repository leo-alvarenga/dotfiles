local _table = require("config.utils.table")

local M = {}

M.languages = {
	-- Basics
	"c",
	"lua",
	"vim",
	"vimdoc",
	"query",
	"csv",
	"json",
	"json5",

	-- Scripting
	"bash",

	-- Configs
	"hyprlang",
	"ini",
	"rasi",

	-- Git
	"git_config",
	"git_rebase",
	"gitattributes",
	"gitignore",

	-- Languages
	"go",
	"gomod",
	"gosum",

	-- Web
	"javascript",
	"jsdoc",
	"typescript",
	"typespec",
	"html",
	"css",
	"scss",
	"sql",
	"svelte",
	"tsx",

	-- Infra/DevOps
	"nginx",
	"terraform",
	"toml",
	"yaml",

	"markdown",
	"markdown_inline",
}

M.language_servers = {
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
		"eslint",
		"tailwindcss",
	},
}

M.lang_server_list = _table.merge_arrays({
	M.language_servers.basics,
	M.language_servers.devops_and_infra,
	M.language_servers.web_dev,
})


M.formatters = {
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

M.linters = {
	basics = {
		"jsonlint",
		"shellharden",
	},

	devops_and_infra = {
		"sonarlint-language-server",
	},

	web_dev = {
		"eslint_d",
		"htmlhint",
		"stylelint",
	},
}

return M
