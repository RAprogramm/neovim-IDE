local onedark = require("onedark")
onedark.setup({
    highlights = {
        TSKeywordFunction = { fg = "#c678dd", fmt = "italic,bold" },
        TSInclude = { fg = "#c678dd", fmt = "italic,bold" },
        CursorLineNr = { fmt = "bold" },
        NormalFloat = { bg = "none" },
        FloatBorder = { fg = "Gray", bg = "none" },
        Diagnostic = { fg = "Yellow", fmt = "italic,bold,underline" },
        Folded = { fg = "#5c6370", bg = "none" },
        TSComment = { fmt = "none" },
        Comment = { fmt = "none" },
        StatusLine = { bg = "none" },
        LspSignatureActiveParameter = { fg = "LightGreen", fmt = "bold,underline" },
    },
    diagnostics = {
        background = false,
    },
    code_style = {
        strings = "italic",
        keywords = "italic,bold",
    },
})
onedark.load()
