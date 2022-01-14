-- Setup {{{
require("which-key").setup({
	plugins = {
		marks = true,
		registers = true,
		spelling = { enabled = false, suggestions = 20 },
		presets = {
			operators = true,
			motions = true,
			text_objects = true,
			windows = true,
			nav = true,
			z = true,
			g = true,
		},
	},
	operators = { gc = "Comments" },
	key_labels = {
		["<space>"] = "SPACE",
		["<cr>"] = "Enter",
		["<tab>"] = "TAB",
		["<C>"] = "Ctrl",
	},
	icons = { breadcrumb = "»", separator = "➜", group = "+" },
	popup_mappings = { scroll_down = "<c-j>", scroll_up = "<c-k>" },
	window = {
		border = "single",
		position = "bottom",
		margin = { 1, 6, 1, 6 },
		padding = { 2, 2, 2, 2 },
		winblend = 10,
	},
	layout = {
		height = { min = 4, max = 25 },
		width = { min = 20, max = 50 },
		spacing = 13,
		align = "center",
	},
	ignore_missing = false,
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
	show_help = true,
	triggers = "auto",
	triggers_blacklist = { i = { "j", "k" }, v = { "j", "k" } },
})
-- }}}

local wk = require("which-key")
wk.register({
	["b"] = { name = "Previous/Next Buffer" },
	["b["] = { ":bprev<CR>", "Previous Buffer" },
	["b]"] = { ":bnext<CR>", "Next Buffer" },
	["<F2>"] = { ":NvimTreeToggle<CR>", "Open/Close NvimTree" },
	["<C-s>"] = { ":wall<CR>", "Save All Files" },
	["<leader>"] = {
		name = "Leader Key Actions",
		r = {
			name = "Rename",
			n = {
				":lua vim.lsp.buf.rename()<CR>",
				"Change Word Under Cursor",
			},
		},
		f = { ":lua vim.lsp.buf.formatting()<CR>", "Format File" },
		-- Session {{{
		s = {
			name = "Session",
			s = { "<cmd>SessionSave<CR>", "Save this session" },
			l = { "<cmd>SessionLoad<CR>", "Load saved session" },
		}, -- }}}
		-- Telescope {{{
		t = {
			name = "Telescope",
			p = {
				"<cmd>lua require('telescope.builtin').pickers()<CR>",
				"Open Pickers",
			},
			e = {
				"<cmd>lua require('telescope.builtin').registers()<CR>",
				"Open Registers",
			},
			g = {
				"<cmd>lua require('telescope.builtin').git_files()<CR>",
				"Open Git Files",
			},
			m = {
				"<cmd>lua require('telescope.builtin').marks()<CR>",
				"Open Marks",
			},
			r = {
				"<cmd>lua require('telescope.builtin').oldfiles()<CR>",
				"Open Recent Files",
			},
			b = {
				"<cmd>lua require('telescope.builtin').buffers()<CR>",
				"Open Current Buffers",
			},
			f = {
				"<cmd>lua require('telescope.builtin').find_files()<CR>",
				"Find Files",
			},
			w = {
				"<cmd>lua require('telescope.builtin').live_grep()<CR>",
				"Find Word",
			},
			h = {
				"<cmd>lua require('telescope.builtin').help_tags()<CR>",
				"Help Tags",
			},
			t = { "<cmd>lua require('telescope.builtin').tags()<CR>", "Tags" },
			d = { "<cmd>Telescope diagnostics<CR>", "Workspace Diagnostics" },
			s = {
				"<cmd>lua require('telescope.builtin').grep_string()<CR>",
				"Find String",
			},
			o = {
				"<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>",
				"Tags (Only Current Buffers)",
			},
		},
		-- }}}
		-- Diagnostics {{{
		d = {
			name = "Diagnostics",
			s = {
				"<cmd>lua vim.diagnostic.open_float()<CR>",
				"Show Diagnostic Line",
			},
			p = {
				"<cmd>lua vim.diagnostic.goto_prev()<CR>",
				"Jump To Previous Diagnostic Line",
			},
			n = {
				"<cmd>lua vim.diagnostic.goto_next()<CR>",
				"Jump To Next Diagnostic Line",
			},
			l = {
				"<cmd>lua vim.diagnostic.setloclist()<CR>",
				"Location List",
			},
		},
		-- }}}
		-- Workspaces {{{
		w = {
			name = "Workspaces",
			a = {
				"<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
				"Add Workspace Folder",
			},
			r = {
				"<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
				"Remove Workspace Folder",
			},
			l = {
				"<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
				"Workspace Folder's List",
			},
		},
		-- }}}
	},
})
