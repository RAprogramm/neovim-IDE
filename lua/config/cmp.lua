local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    preselect = cmp.PreselectMode.None,
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    completion = { completeopt = 'menu,menuone,noselect' },
    mapping = {
        ['<Down>'] = cmp.mapping(
            cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
            { 'i' }
        ),
        ['<Up>'] = cmp.mapping(
            cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
            { 'i' }
        ),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.expand_or_jumpable(-1) then
                luasnip.expand_or_jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = {
        { name = 'latex_symbols' },
        { name = 'luasnip' },
        { name = 'nvim_lua' },
        { name = 'nvim_lsp' },
        { name = 'calc' },
        { name = 'path' },
        { name = 'buffer' },
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.kind = require('lspkind').presets.default[vim_item.kind]
                .. ' '
                .. vim_item.kind
            vim_item.menu = ({
                buffer = '[Buf]',
                nvim_lsp = '[LSP]',
                luasnip = '[Snip]',
                calc = '[Calc]',
                path = '[Path]',
                latex_symbols = '[Latex]',
            })[entry.source.name]
            return vim_item
        end,
    },
}
