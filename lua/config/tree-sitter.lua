require("nvim-treesitter.configs").setup({
    context_commmentstring = { enable = true, enable_autocmd = true },
    ensure_installed = {
        "vim",
        "lua",
        "html",
        "css",
        "javascript",
        "typescript",
        "json",
        "vue",
        "python",
        "bash",
        "markdown",
        "yaml",
        "rst",
        "fish",
        "dockerfile"
    },
    highlight = {
        enable = true, -- false will disable the whole extension
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = 1000,
        colors = {
            "#B52A5B",
            "#FF4971",
            "#bd93f9",
            "#ffffff",
            "#F18FB0",
            "#8897F4",
            "#f1c4e0",
        },
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
    indent = { enable = true },
    query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
    },
    textsubjects = { enable = true, keymaps = { [","] = "textsubjects-smart" } },
    autopairs = { enable = true },
    textobjects = {
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["il"] = "@loop.outer",
                ["al"] = "@loop.outer",
                ["icd"] = "@conditional.inner",
                ["acd"] = "@conditional.outer",
                ["acm"] = "@comment.outer",
                ["ast"] = "@statement.outer",
                ["isc"] = "@scopename.inner",
                ["iB"] = "@block.inner",
                ["aB"] = "@block.outer",
                ["p"] = "@parameter.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true, -- Whether to set jumps in the jumplist
            goto_next_start = {
                ["gnf"] = "@function.outer",
                ["gnif"] = "@function.inner",
                ["gnp"] = "@parameter.inner",
                ["gnc"] = "@call.outer",
                ["gnic"] = "@call.inner",
            },
            goto_next_end = {
                ["gnF"] = "@function.outer",
                ["gniF"] = "@function.inner",
                ["gnP"] = "@parameter.inner",
                ["gnC"] = "@call.outer",
                ["gniC"] = "@call.inner",
            },
            goto_previous_start = {
                ["gpf"] = "@function.outer",
                ["gpif"] = "@function.inner",
                ["gpp"] = "@parameter.inner",
                ["gpc"] = "@call.outer",
                ["gpic"] = "@call.inner",
            },
            goto_previous_end = {
                ["gpF"] = "@function.outer",
                ["gpiF"] = "@function.inner",
                ["gpP"] = "@parameter.inner",
                ["gpC"] = "@call.outer",
                ["gpiC"] = "@call.inner",
            },
        },
    },
    playground = {
        enable = true,
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
            toggle_query_editor = "o",
            toggle_hl_groups = "I",
            toggle_language_display = "i",
            toggle_injected_languages = "t",
            toggle_anonymous_nodes = "a",
            focus_language = "f",
            unfocus_language = "F",
            update = "R",
            goto_node = "<cr>",
            show_help = "?",
        },
    },
    tree_docs = { enable = true }, -- Currently experimental, doesn't work well
    context_commentstring = { enable = true },
})
