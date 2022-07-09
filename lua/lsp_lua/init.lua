local null_ls = require("null-ls")
local lspconfig = require("lspconfig")
local border = {

    { "╭", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╮", "FloatBorder" },
    { "│", "FloatBorder" },
    { "╯", "FloatBorder" },
    { "─", "FloatBorder" },
    { "╰", "FloatBorder" },
    { "│", "FloatBorder" },
}
vim.diagnostic.config({
    severity_sort = true,
    update_in_insert = false,
    float = {
        source = "if_many",
        border = "rounded",
        header = { "   Diagnostics: ", "diagnostic" },
        focusable = false,
        focus = false,
    },
})
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    underline = true,
    update_in_insert = false }
)


local function goto_definition(split_cmd)
    local util = vim.lsp.util
    local log = require("vim.lsp.log")
    local api = vim.api
    local handler = function(_, method, result)
        if result == nil or vim.tbl_isempty(result) then
            local _ = log.info() and log.info(method, "No location found")
            return nil
        end
        if split_cmd then
            vim.cmd(split_cmd)
        end

        if vim.tbl_islist(result) then
            util.jump_to_location(result[1])
            if #result > 1 then
                util.set_qflist(util.locations_to_items(result))
                api.nvim_command("copen")
                api.nvim_command("wincmd p")
            end
        else
            util.jump_to_location(result)
        end
    end
    return handler
end

vim.lsp.handlers["textDocument/definition"] = goto_definition("vsplit")
-- FIX: type_definition in float window
-- vim.lsp.handlers["textDocument/typeDefinition"] = vim.lsp.with(
--     vim.lsp.handlers.type_definition,
--     { border = border }
-- )

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.documentationFormat = {
    "markdown",
    "plaintext",
}
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = {
    valueSet = { 1 },
}
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
}

local signature_config = {
    bind = true,
    hint_enable = false,
    handler_opts = {
        border = "rounded"
    },
    floating_window = true,
    floating_window_above_cur_line = true,
    cursorhold_update = false
}
print()
local on_attach = function(client, bufnr)
    require 'lsp_signature'.on_attach(signature_config, bufnr)
    if client.name == 'tsserver' then
        client.resolved_capabilities.document_formatting = false
    end

    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }
    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = border,
        focusable = true,
    })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = border, focusable = true }
    )
    require("lspkind").init({
        mode = "symbol_text",
        preset = "codicons",
        symbol_map = {
            Text = "",
            Method = "",
            Function = "",
            Constructor = "",
            Field = "ﰠ",
            Variable = "",
            Class = "ﴯ",
            Interface = "",
            Module = "",
            Property = "ﰠ",
            Unit = "塞",
            Value = "",
            Enum = "",
            Keyword = "",
            Snippet = "",
            Color = "",
            File = "",
            Reference = "",
            Folder = "",
            EnumMember = "",
            Constant = "",
            Struct = "פּ",
            Event = "",
            Operator = "",
            TypeParameter = "",
        },
    })
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec(
            [[
                hi LspReferenceRead  gui=bold guibg=#41495A
                hi LspReferenceText  gui=bold guibg=#41495A
                hi LspReferenceWrite gui=bold guibg=#41495A
                augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                augroup END
            ]],
            false
        )
    end
end


local lsp_installer = require("nvim-lsp-installer")
lsp_installer.setup({
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗",
        },
    },
})
lspconfig.sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
        },
    }
}
lspconfig.emmet_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },
    filetypes = { 'htmldjango', 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
})

local servers = { 'vuels', 'dockerls', 'tsserver', 'esbonio', 'yamlls', 'pyright' }
for _, server in ipairs(servers) do
    lspconfig[server].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = { debounce_text_changes = 150 },
    }
end
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.prettier,
        -- null_ls.builtins.formatting.prettier.with({
        --     disabled_filetypes = { 'vue' }
        -- }),
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.djlint,
        null_ls.builtins.diagnostics.djlint,
        null_ls.builtins.diagnostics.rstcheck,
        null_ls.builtins.completion.tags
    },
})
require("lsp_signature").setup(signature_config)
