local lualine = require('lualine')

local icons = {
    git = "",
    vim_modes = {
        normal = "N",
        visual = "V",
        insert = "I",
        command = "C",
    },
    diagnostic = {
        error = " ",
        warn = " ",
        info = " "
    },
    diff = {
        add = " ",
        modified = " ",
        remove = " "
    },
    file = {
        read_only = '',
        modified = '✎',
    },
}
local colors = {
    bg       = '#202328',
    fg       = '#bbc2cf',
    yellow   = '#ECBE7B',
    cyan     = '#008080',
    darkblue = '#081633',
    green    = '#98be65',
    orange   = '#FF8800',
    violet   = '#a9a1e1',
    magenta  = '#c678dd',
    blue     = '#51afef',
    red      = '#ec5f67',
}
local mode_color = {
    n = colors.green,
    i = colors.blue,
    v = colors.magenta,
    [''] = colors.magenta,
    V = colors.magenta,
    c = colors.yellow,
    no = colors.red,
    s = colors.orange,
    S = colors.orange,
    [''] = colors.orange,
    ic = colors.yellow,
    R = colors.red,
    Rv = colors.red,
    cv = colors.red,
    ce = colors.red,
    r = colors.red,
    rm = colors.cyan,
    ['r?'] = colors.cyan,
    ['!'] = colors.red,
    t = colors.red,
}

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 90
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end,
}

local config = {
    extensions = {
        "quickfix", "nvim-tree", "toggleterm"
    },
    options = {
        component_separators = '',
        section_separators = '',
        theme = {
            normal = { c = { fg = colors.fg, bg = colors.bg } },
            inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
    },
    sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {},
    },
    globalstatus = true,
}

local custom_fname = require('lualine.components.filename'):extend()
local highlight = require 'lualine.highlight'
local default_status_colors = { saved = colors.magenta, modified = colors.red }
function custom_fname:init(options)
    custom_fname.super.init(self, options)
    self.options.symbols.modified = ' '
    self.options.symbols.readonly = ' '
    self.status_colors = {
        saved = highlight.create_component_highlight_group(
            { bg = colors.bg, fg = default_status_colors.saved, gui = 'bold' }, 'filename_status_saved', self.options),
        modified = highlight.create_component_highlight_group(
            { bg = colors.bg, fg = default_status_colors.modified, gui = 'bold' }, 'filename_status_modified',
            self.options),
    }
    if self.options.color == nil then self.options.color = '' end
end

function custom_fname:update_status()
    local data = custom_fname.super.update_status(self)
    data = highlight.component_format_highlight(vim.bo.modified
        and self.status_colors.modified
        or self.status_colors.saved) .. data
    return data
end

local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
end

local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
end

ins_left {
    function()
        return '▊'
    end,
    color = function()
        return { fg = mode_color[vim.fn.mode()] }
    end,
    padding = { left = 0, right = 1 },
}

ins_left {
    function()
        local mode_icons = {
            n = icons.vim_modes.normal,
            i = icons.vim_modes.insert,
            c = icons.vim_modes.command,
            v = icons.vim_modes.visual,
            [''] = icons.vim_modes.visual .. "-Block",
            V = icons.vim_modes.visual .. "-Line",
            R = "R"
        }
        return mode_icons[vim.fn.mode()]
    end,
    color = function()
        return { fg = mode_color[vim.fn.mode()], gui = "bold,italic" }
    end,
    padding = { right = 1 },
}

ins_left {
    'filesize',
    cond = conditions.hide_in_width,
}

ins_left {
    'filetype',
    icon_only = true,
    cond = conditions.hide_in_width,
}


ins_left {
    custom_fname,
    cond = conditions.buffer_not_empty
}

ins_left {
    'location',
    cond = conditions.buffer_not_empty
}

ins_left {
    'progress',
    cond = conditions.buffer_not_empty,
    color = { fg = colors.fg, gui = 'bold' }
}

ins_left {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    symbols = {
        error = icons.diagnostic.error,
        warn = icons.diagnostic.warn,
        info = icons.diagnostic.info
    },
    diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.cyan },
    },
}

ins_left {
    function()
        return '%='
    end,
}

ins_left {
    function()
        local msg = 'No Active Lsp'
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
        return msg
    end,
    icon = ' LSP:',
    color = { fg = '#074d07', gui = 'bold' },
    cond = conditions.buffer_not_empty
}

ins_right {
    'o:encoding',
    fmt = string.upper,
    cond = conditions.hide_in_width,
    color = { fg = colors.fg },
}

ins_right {
    'fileformat',
    fmt = string.upper,
    icons_enabled = true,
    cond = conditions.hide_in_width,
    color = { fg = colors.fg },
}

ins_right {
    'branch',
    icon = icons.git,
    color = { fg = colors.orange, gui = 'bold' },
}

ins_right {
    'diff',
    symbols = {
        added = icons.diff.add,
        modified = icons.diff.modified,
        removed = icons.diff.remove,
    },
    diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.blue },
        removed = { fg = colors.red },
    },
}

ins_right {
    function()
        return '▊'
    end,
    color = function()
        return { fg = mode_color[vim.fn.mode()] }
    end,
    padding = { left = 1 },
}

lualine.setup(config)
