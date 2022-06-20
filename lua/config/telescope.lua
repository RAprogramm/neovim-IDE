local telescope = require("telescope")
local themes = require("telescope.themes")
local telescope_actions = require("telescope.actions.set")

telescope.setup({
    pickers = {
        buffers = {
            theme = "dropdown",
            initial_mode = 'normal',
            previewer = false,
            sort_lastused = true
        },
        file_browser = {
            attach_mappings = function(_)
                telescope_actions.select:enhance({
                    post = function()
                        vim.cmd(":normal! zX")
                    end,
                })
                return true
            end,
        },
        find_files = {
            attach_mappings = function(_)
                telescope_actions.select:enhance({
                    post = function()
                        vim.cmd(":normal! zX")
                    end,
                })
                return true
            end,
            layout_strategy = "horizontal",
            layout_config = {
                height = 0.7,
                width = 0.7,
                prompt_position = "top",
                preview_width = 0.7,
                scroll_speed = 2,
            },
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
        },
        live_grep = {
            attach_mappings = function(_)
                telescope_actions.select:enhance({
                    post = function()
                        vim.cmd(":normal! zX")
                    end,
                })
                return true
            end,
            layout_strategy = "horizontal",
            layout_config = {
                width = 0.8,
                height = 0.5,
                prompt_position = "top",
                preview_width = 0.5,
                scroll_speed = 2,
            }
        },
        oldfiles = {
            attach_mappings = function(_)
                telescope_actions.select:enhance({
                    post = function()
                        vim.cmd(":normal! zX")
                    end,
                })
                return true
            end,
            previewer = false,
            theme = "dropdown",
            layout_config = {
                width = 0.6,
                height = 0.5,
            }
        },
        help_tags = {
            layout_strategy = "horizontal",
            layout_config = {
                height = 0.9,
                width = 0.7,
                prompt_position = "top",
                scroll_speed = 2,
                preview_width = 0.7,
            },
        },
        man_pages = {
            layout_strategy = "vertical",
            layout_config = {
                height = 0.8,
                prompt_position = "top",
                prview_height = 0.8,
                mirror = true,
                scroll_speed = 2
            },
        },
        lsp_document_symbols = {
            initial_mode = "normal",
            previewer = false,
            theme = "dropdown",
            layout_config = {
                height = 0.9,
                width = 0.38
            },
        },
    },
    defaults = {
        prompt_prefix = " 🔍 ",
        selection_caret = "➤ ",
        dynamic_preview_title = true,
        use_less = true,
        mappings = {
            i = {
                ["<C-j>"] = "preview_scrolling_down",
                ["<C-k>"] = "preview_scrolling_up",
            },
            n = {
                ["<C-j>"] = "preview_scrolling_down",
                ["<C-k>"] = "preview_scrolling_up",
            },
        }
    },
    extensions = {
        ["ui-select"] = {
            themes.get_cursor {}
        },
        project = {
            preview = {
                disable = false, -- default
                dir_only = false, -- default
                additional_readmes = { "notes.md", "notes.txt" } -- not default
            },
            base_dirs = {
                '~/.config/',
                '~/Projects',
            },
            hidden_files = false,
            theme = "dropdown",
        },
        file_browser = {
            theme = "dropdown",
            layout_config = {
                height = 0.5,
                prompt_position = "top",
            },
            initial_mode = 'normal',
            hijack_netrw = true,
            -- NOTE: default keymaps for telescope_file_browser
            --    enter:    opens the currently selected file
            --    c:        Create file/folder at current `path`\
            --    r:        Rename multi-selected files/folders
            --    m:        Move multi-selected files/folders to current `path`
            --    y:        Copy (multi-)selected files/folders to current `path`
            --    d:        Delete (multi-)selected files/folders
            --    o:        Open file/folder with default system application
            --    g:        Go to parent directory
            --    e:        Go to home directory
            --    w:        Go to current working directory (cwd)
            --    t:        Change nvim's cwd to selected folder/file(parent)
            --    f:        Toggle between file and folder browser
            --    h:        Toggle hidden files/folders
            --    s:        Toggle all entries ignoring `./` and `../`
        },
    },
})

telescope.load_extension 'project'
telescope.load_extension "file_browser"
telescope.load_extension("ui-select")
