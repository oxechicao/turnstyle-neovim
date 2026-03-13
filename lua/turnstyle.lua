local M = {}
local config = require("turnstyle.config")

local function set_highlights()
	local utilities = require("turnstyle.utilities")
	local palette = require("turnstyle.palette")
	local styles = config.options.styles

	local groups = {}
	for group, color in pairs(config.options.groups) do
		groups[group] = utilities.parse_color(color)
	end

	local function make_border(fg)
		fg = fg or groups.border
		return {
			fg = fg,
			bg = (config.options.extend_background_behind_borders and not styles.transparency) and palette.base
				or "NONE",
		}
	end

	local highlights = {}
	local legacy_highlights = {
		["@attribute.diff"] = { fg = palette.tlc },
		["@boolean"] = { link = "Boolean" },
		["@class"] = { fg = palette.sunshower },
		["@conditional"] = { link = "Conditional" },
		["@field"] = { fg = palette.sunshower },
		["@include"] = { link = "Include" },
		["@interface"] = { fg = palette.sunshower },
		["@macro"] = { link = "Macro" },
		["@method"] = { fg = palette.sole },
		["@namespace"] = { link = "Include" },
		["@number"] = { link = "Number" },
		["@parameter"] = { fg = palette.birds, italic = styles.italic },
		["@preproc"] = { link = "PreProc" },
		["@punctuation"] = { fg = palette.mistery },
		["@punctuation.bracket"] = { link = "@punctuation" },
		["@punctuation.delimiter"] = { link = "@punctuation" },
		["@punctuation.special"] = { link = "@punctuation" },
		["@regexp"] = { link = "String" },
		["@repeat"] = { link = "Repeat" },
		["@storageclass"] = { link = "StorageClass" },
		["@symbol"] = { link = "Identifier" },
		["@text"] = { fg = palette.text },
		["@text.danger"] = { fg = groups.error },
		["@text.diff.add"] = { fg = groups.git_add, bg = groups.git_add, blend = 20 },
		["@text.diff.delete"] = { fg = groups.git_delete, bg = groups.git_delete, blend = 20 },
		["@text.emphasis"] = { italic = styles.italic },
		["@text.environment"] = { link = "Macro" },
		["@text.environment.name"] = { link = "Type" },
		["@text.math"] = { link = "Special" },
		["@text.note"] = { link = "SpecialComment" },
		["@text.strike"] = { strikethrough = true },
		["@text.strong"] = { bold = styles.bold },
		["@text.title"] = { link = "Title" },
		["@text.title.1.markdown"] = { link = "markdownH1" },
		["@text.title.1.marker.markdown"] = { link = "markdownH1Delimiter" },
		["@text.title.2.markdown"] = { link = "markdownH2" },
		["@text.title.2.marker.markdown"] = { link = "markdownH2Delimiter" },
		["@text.title.3.markdown"] = { link = "markdownH3" },
		["@text.title.3.marker.markdown"] = { link = "markdownH3Delimiter" },
		["@text.title.4.markdown"] = { link = "markdownH4" },
		["@text.title.4.marker.markdown"] = { link = "markdownH4Delimiter" },
		["@text.title.5.markdown"] = { link = "markdownH5" },
		["@text.title.5.marker.markdown"] = { link = "markdownH5Delimiter" },
		["@text.title.6.markdown"] = { link = "markdownH6" },
		["@text.title.6.marker.markdown"] = { link = "markdownH6Delimiter" },
		["@text.underline"] = { underline = true },
		["@text.uri"] = { fg = groups.link },
		["@text.warning"] = { fg = groups.warn },
		["@todo"] = { link = "Todo" },

		-- lukas-reineke/indent-blankline.nvim
		IndentBlanklineChar = { fg = palette.muted, nocombine = true },
		IndentBlanklineSpaceChar = { fg = palette.muted, nocombine = true },
		IndentBlanklineSpaceCharBlankline = { fg = palette.muted, nocombine = true },
	}
	local default_highlights = {
		ColorColumn = { bg = palette.light_design_low },
		Conceal = { bg = "NONE" },
		CurSearch = { fg = palette.base, bg = palette.tlc },
		Cursor = { fg = palette.text, bg = palette.light_design_med },
		CursorColumn = { bg = palette.overlay },
		-- CursorIM = {},
		CursorLine = { bg = palette.light_design_low },
		CursorLineNr = { fg = palette.mistery, bold = styles.bold },
		-- DarkenedPanel = { },
		-- DarkenedStatusline = {},
		DiffAdd = { bg = groups.git_add, blend = 20 },
		DiffChange = { bg = groups.git_change, blend = 20 },
		DiffDelete = { bg = groups.git_delete, blend = 20 },
		DiffText = { bg = groups.git_text, blend = 40 },
		diffAdded = { link = "DiffAdd" },
		diffChanged = { link = "DiffChange" },
		diffRemoved = { link = "DiffDelete" },
		Directory = { fg = palette.never_enough, bold = styles.bold },
		-- EndOfBuffer = {},
		ErrorMsg = { fg = groups.error, bold = styles.bold },
		FloatBorder = make_border(),
		FloatTitle = { fg = palette.birds, bg = groups.panel, bold = styles.bold },
		FoldColumn = { fg = palette.muted },
		Folded = { fg = palette.text, bg = groups.panel },
		IncSearch = { link = "CurSearch" },
		LineNr = { fg = palette.muted },
		MatchParen = { fg = palette.gravity, bg = palette.gravity, blend = 25 },
		ModeMsg = { fg = palette.mistery },
		MoreMsg = { fg = palette.birds },
		NonText = { fg = palette.muted },
		Normal = { fg = palette.text, bg = palette.base },
		NormalFloat = { bg = groups.panel },
		NormalNC = { fg = palette.text, bg = config.options.dim_inactive_windows and palette._nc or palette.base },
		NvimInternalError = { link = "ErrorMsg" },
		Pmenu = { fg = palette.mistery, bg = groups.panel },
		PmenuExtra = { fg = palette.muted, bg = groups.panel },
		PmenuExtraSel = { fg = palette.mistery, bg = palette.overlay },
		PmenuKind = { fg = palette.sunshower, bg = groups.panel },
		PmenuKindSel = { fg = palette.mistery, bg = palette.overlay },
		PmenuSbar = { bg = groups.panel },
		PmenuSel = { fg = palette.text, bg = palette.overlay },
		PmenuThumb = { bg = palette.muted },
		Question = { fg = palette.tlc },
		QuickFixLine = { fg = palette.sunshower },
		-- RedrawDebugNormal = {},
		RedrawDebugClear = { fg = palette.base, bg = palette.tlc },
		RedrawDebugComposed = { fg = palette.base, bg = palette.gravity },
		RedrawDebugRecompose = { fg = palette.base, bg = palette.never_enough },
		Search = { fg = palette.text, bg = palette.tlc, blend = 20 },
		SignColumn = { fg = palette.text, bg = "NONE" },
		SpecialKey = { fg = palette.sunshower },
		SpellBad = { sp = palette.mistery, undercurl = true },
		SpellCap = { sp = palette.mistery, undercurl = true },
		SpellLocal = { sp = palette.mistery, undercurl = true },
		SpellRare = { sp = palette.mistery, undercurl = true },
		StatusLine = { fg = palette.mistery, bg = groups.panel },
		StatusLineNC = { fg = palette.muted, bg = groups.panel, blend = 60 },
		StatusLineTerm = { fg = palette.base, bg = palette.gravity },
		StatusLineTermNC = { fg = palette.base, bg = palette.gravity, blend = 60 },
		Substitute = { link = "IncSearch" },
		TabLine = { fg = palette.mistery, bg = groups.panel },
		TabLineFill = { bg = groups.panel },
		TabLineSel = { fg = palette.text, bg = palette.overlay, bold = styles.bold },
		Title = { fg = palette.gravity, bold = styles.bold },
		VertSplit = { fg = groups.border },
		Visual = { bg = palette.birds, blend = 15 },
		-- VisualNOS = {},
		WarningMsg = { fg = groups.warn, bold = styles.bold },
		-- Whitespace = {},
		WildMenu = { link = "IncSearch" },
		WinBar = { fg = palette.mistery, bg = groups.panel },
		WinBarNC = { fg = palette.muted, bg = groups.panel, blend = 60 },
		WinSeparator = { fg = groups.border },

		DiagnosticError = { fg = groups.error },
		DiagnosticHint = { fg = groups.hint },
		DiagnosticInfo = { fg = groups.info },
		DiagnosticOk = { fg = groups.ok },
		DiagnosticWarn = { fg = groups.warn },
		DiagnosticDefaultError = { link = "DiagnosticError" },
		DiagnosticDefaultHint = { link = "DiagnosticHint" },
		DiagnosticDefaultInfo = { link = "DiagnosticInfo" },
		DiagnosticDefaultOk = { link = "DiagnosticOk" },
		DiagnosticDefaultWarn = { link = "DiagnosticWarn" },
		DiagnosticFloatingError = { link = "DiagnosticError" },
		DiagnosticFloatingHint = { link = "DiagnosticHint" },
		DiagnosticFloatingInfo = { link = "DiagnosticInfo" },
		DiagnosticFloatingOk = { link = "DiagnosticOk" },
		DiagnosticFloatingWarn = { link = "DiagnosticWarn" },
		DiagnosticSignError = { link = "DiagnosticError" },
		DiagnosticSignHint = { link = "DiagnosticHint" },
		DiagnosticSignInfo = { link = "DiagnosticInfo" },
		DiagnosticSignOk = { link = "DiagnosticOk" },
		DiagnosticSignWarn = { link = "DiagnosticWarn" },
		DiagnosticUnderlineError = { sp = groups.error, undercurl = true },
		DiagnosticUnderlineHint = { sp = groups.hint, undercurl = true },
		DiagnosticUnderlineInfo = { sp = groups.info, undercurl = true },
		DiagnosticUnderlineOk = { sp = groups.ok, undercurl = true },
		DiagnosticUnderlineWarn = { sp = groups.warn, undercurl = true },
		DiagnosticVirtualTextError = { fg = groups.error, bg = groups.error, blend = 10 },
		DiagnosticVirtualTextHint = { fg = groups.hint, bg = groups.hint, blend = 10 },
		DiagnosticVirtualTextInfo = { fg = groups.info, bg = groups.info, blend = 10 },
		DiagnosticVirtualTextOk = { fg = groups.ok, bg = groups.ok, blend = 10 },
		DiagnosticVirtualTextWarn = { fg = groups.warn, bg = groups.warn, blend = 10 },

		Boolean = { fg = palette.sole },
		Character = { fg = palette.tlc },
		Comment = { fg = palette.mistery, italic = styles.italic },
		Conditional = { fg = palette.gravity },
		Constant = { fg = palette.tlc },
		Debug = { fg = palette.sole },
		Define = { fg = palette.birds },
		Delimiter = { fg = palette.mistery },
		Error = { fg = palette.never_enough },
		Exception = { fg = palette.gravity },
		Float = { fg = palette.tlc },
		Function = { fg = palette.sole },
		Identifier = { fg = palette.text },
		Include = { fg = palette.gravity },
		Keyword = { fg = palette.gravity },
		Label = { fg = palette.sunshower },
		LspCodeLens = { fg = palette.mistery },
		LspCodeLensSeparator = { fg = palette.muted },
		LspInlayHint = { fg = palette.muted, bg = palette.muted, blend = 10 },
		LspReferenceRead = { bg = palette.light_design_med },
		LspReferenceText = { bg = palette.light_design_med },
		LspReferenceWrite = { bg = palette.light_design_med },
		Macro = { fg = palette.birds },
		Number = { fg = palette.tlc },
		Operator = { fg = palette.mistery },
		PreCondit = { fg = palette.birds },
		PreProc = { link = "PreCondit" },
		Repeat = { fg = palette.gravity },
		Special = { fg = palette.sunshower },
		SpecialChar = { link = "Special" },
		SpecialComment = { fg = palette.birds },
		Statement = { fg = palette.gravity, bold = styles.bold },
		StorageClass = { fg = palette.sunshower },
		String = { fg = palette.tlc },
		Structure = { fg = palette.sunshower },
		Tag = { fg = palette.sunshower },
		Todo = { fg = palette.sole, bg = palette.sole, blend = 20 },
		Type = { fg = palette.sunshower },
		TypeDef = { link = "Type" },
		Underlined = { fg = palette.birds, underline = true },

		healthError = { fg = groups.error },
		healthSuccess = { fg = groups.info },
		healthWarning = { fg = groups.warn },

		htmlArg = { fg = palette.birds },
		htmlBold = { bold = styles.bold },
		htmlEndTag = { fg = palette.mistery },
		htmlH1 = { link = "markdownH1" },
		htmlH2 = { link = "markdownH2" },
		htmlH3 = { link = "markdownH3" },
		htmlH4 = { link = "markdownH4" },
		htmlH5 = { link = "markdownH5" },
		htmlItalic = { italic = styles.italic },
		htmlLink = { link = "markdownUrl" },
		htmlTag = { fg = palette.mistery },
		htmlTagN = { fg = palette.text },
		htmlTagName = { fg = palette.sunshower },

		markdownDelimiter = { fg = palette.mistery },
		markdownH1 = { fg = groups.h1, bold = styles.bold },
		markdownH1Delimiter = { link = "markdownH1" },
		markdownH2 = { fg = groups.h2, bold = styles.bold },
		markdownH2Delimiter = { link = "markdownH2" },
		markdownH3 = { fg = groups.h3, bold = styles.bold },
		markdownH3Delimiter = { link = "markdownH3" },
		markdownH4 = { fg = groups.h4, bold = styles.bold },
		markdownH4Delimiter = { link = "markdownH4" },
		markdownH5 = { fg = groups.h5, bold = styles.bold },
		markdownH5Delimiter = { link = "markdownH5" },
		markdownH6 = { fg = groups.h6, bold = styles.bold },
		markdownH6Delimiter = { link = "markdownH6" },
		markdownLinkText = { link = "markdownUrl" },
		markdownUrl = { fg = groups.link, sp = groups.link, underline = true },

		mkdCode = { fg = palette.sunshower, italic = styles.italic },
		mkdCodeDelimiter = { fg = palette.sole },
		mkdCodeEnd = { fg = palette.sunshower },
		mkdCodeStart = { fg = palette.sunshower },
		mkdFootnotes = { fg = palette.sunshower },
		mkdID = { fg = palette.sunshower, underline = true },
		mkdInlineURL = { link = "markdownUrl" },
		mkdLink = { link = "markdownUrl" },
		mkdLinkDef = { link = "markdownUrl" },
		mkdListItemLine = { fg = palette.text },
		mkdRule = { fg = palette.mistery },
		mkdURL = { link = "markdownUrl" },

		--- Treesitter
		--- |:help treesitter-highlight-groups|
		["@variable"] = { fg = palette.text, italic = styles.italic },
		["@variable.builtin"] = { fg = palette.never_enough, italic = styles.italic, bold = styles.bold },
		["@variable.parameter"] = { fg = palette.birds, italic = styles.italic },
		["@variable.parameter.builtin"] = { fg = palette.birds, italic = styles.italic, bold = styles.bold },
		["@variable.member"] = { fg = palette.sunshower },

		["@constant"] = { fg = palette.tlc },
		["@constant.builtin"] = { fg = palette.tlc, bold = styles.bold },
		["@constant.macro"] = { fg = palette.tlc },

		["@module"] = { fg = palette.text },
		["@module.builtin"] = { fg = palette.text, bold = styles.bold },
		["@label"] = { link = "Label" },

		["@string"] = { link = "String" },
		-- ["@string.documentation"] = {},
		["@string.regexp"] = { fg = palette.birds },
		["@string.escape"] = { fg = palette.gravity },
		["@string.special"] = { link = "String" },
		["@string.special.symbol"] = { link = "Identifier" },
		["@string.special.url"] = { fg = groups.link },
		-- ["@string.special.path"] = {},

		["@character"] = { link = "Character" },
		["@character.special"] = { link = "Character" },

		["@boolean"] = { link = "Boolean" },
		["@number"] = { link = "Number" },
		["@number.float"] = { link = "Number" },
		["@float"] = { link = "Number" },

		["@type"] = { fg = palette.sunshower },
		["@type.builtin"] = { fg = palette.sunshower, bold = styles.bold },
		-- ["@type.definition"] = {},

		["@attribute"] = { fg = palette.birds },
		["@attribute.builtin"] = { fg = palette.birds, bold = styles.bold },
		["@property"] = { fg = palette.sunshower, italic = styles.italic },

		["@function"] = { fg = palette.sole },
		["@function.builtin"] = { fg = palette.sole, bold = styles.bold },
		-- ["@function.call"] = {},
		["@function.macro"] = { link = "Function" },

		["@function.method"] = { fg = palette.sole },
		["@function.method.call"] = { fg = palette.birds },

		["@constructor"] = { fg = palette.sunshower },
		["@operator"] = { link = "Operator" },

		["@keyword"] = { link = "Keyword" },
		-- ["@keyword.coroutine"] = {},
		-- ["@keyword.function"] = {},
		["@keyword.operator"] = { fg = palette.mistery },
		["@keyword.import"] = { fg = palette.gravity },
		["@keyword.storage"] = { fg = palette.sunshower },
		["@keyword.repeat"] = { fg = palette.gravity },
		["@keyword.return"] = { fg = palette.gravity },
		["@keyword.debug"] = { fg = palette.sole },
		["@keyword.exception"] = { fg = palette.gravity },

		["@keyword.conditional"] = { fg = palette.gravity },
		["@keyword.conditional.ternary"] = { fg = palette.gravity },

		["@keyword.directive"] = { fg = palette.birds },
		["@keyword.directive.define"] = { fg = palette.birds },

		--- Punctuation
		["@punctuation.delimiter"] = { fg = palette.mistery },
		["@punctuation.bracket"] = { fg = palette.mistery },
		["@punctuation.special"] = { fg = palette.mistery },

		--- Comments
		["@comment"] = { link = "Comment" },
		-- ["@comment.documentation"] = {},

		["@comment.error"] = { fg = groups.error },
		["@comment.warning"] = { fg = groups.warn },
		["@comment.todo"] = { fg = groups.todo, bg = groups.todo, blend = 15 },
		["@comment.hint"] = { fg = groups.hint, bg = groups.hint, blend = 15 },
		["@comment.info"] = { fg = groups.info, bg = groups.info, blend = 15 },
		["@comment.note"] = { fg = groups.note, bg = groups.note, blend = 15 },

		--- Markup
		["@markup.strong"] = { bold = styles.bold },
		["@markup.italic"] = { italic = styles.italic },
		["@markup.strikethrough"] = { strikethrough = true },
		["@markup.underline"] = { underline = true },

		["@markup.heading"] = { fg = palette.sunshower, bold = styles.bold },

		["@markup.quote"] = { fg = palette.text },
		["@markup.math"] = { link = "Special" },
		["@markup.environment"] = { link = "Macro" },
		["@markup.environment.name"] = { link = "@type" },
		-- ["@markup.link"] = {},
		["@markup.link.markdown_inline"] = { fg = palette.mistery },
		["@markup.link.label.markdown_inline"] = { fg = palette.sunshower },
		["@markup.link.url"] = { fg = groups.link },

		-- ["@markup.raw"] = { bg = palette.surface },
		-- ["@markup.raw.block"] = { bg = palette.surface },
		["@markup.raw.delimiter.markdown"] = { fg = palette.mistery },

		["@markup.list"] = { fg = palette.gravity },
		["@markup.list.checked"] = { fg = palette.sunshower, bg = palette.sunshower, blend = 10 },
		["@markup.list.unchecked"] = { fg = palette.text },

		-- Markdown headings
		["@markup.heading.1.markdown"] = { link = "markdownH1" },
		["@markup.heading.2.markdown"] = { link = "markdownH2" },
		["@markup.heading.3.markdown"] = { link = "markdownH3" },
		["@markup.heading.4.markdown"] = { link = "markdownH4" },
		["@markup.heading.5.markdown"] = { link = "markdownH5" },
		["@markup.heading.6.markdown"] = { link = "markdownH6" },
		["@markup.heading.1.marker.markdown"] = { link = "markdownH1Delimiter" },
		["@markup.heading.2.marker.markdown"] = { link = "markdownH2Delimiter" },
		["@markup.heading.3.marker.markdown"] = { link = "markdownH3Delimiter" },
		["@markup.heading.4.marker.markdown"] = { link = "markdownH4Delimiter" },
		["@markup.heading.5.marker.markdown"] = { link = "markdownH5Delimiter" },
		["@markup.heading.6.marker.markdown"] = { link = "markdownH6Delimiter" },

		["@diff.plus"] = { fg = groups.git_add, bg = groups.git_add, blend = 20 },
		["@diff.minus"] = { fg = groups.git_delete, bg = groups.git_delete, blend = 20 },
		["@diff.delta"] = { bg = groups.git_change, blend = 20 },

		["@tag"] = { link = "Tag" },
		["@tag.attribute"] = { fg = palette.birds },
		["@tag.delimiter"] = { fg = palette.mistery },

		--- Non-highlighting captures
		-- ["@none"] = {},
		["@conceal"] = { link = "Conceal" },
		["@conceal.markdown"] = { fg = palette.mistery },

		-- ["@spell"] = {},
		-- ["@nospell"] = {},

		--- Semantic
		["@lsp.type.comment"] = {},
		["@lsp.type.comment.c"] = { link = "@comment" },
		["@lsp.type.comment.cpp"] = { link = "@comment" },
		["@lsp.type.enum"] = { link = "@type" },
		["@lsp.type.interface"] = { link = "@interface" },
		["@lsp.type.keyword"] = { link = "@keyword" },
		["@lsp.type.namespace"] = { link = "@namespace" },
		["@lsp.type.namespace.python"] = { link = "@variable" },
		["@lsp.type.parameter"] = { link = "@parameter" },
		["@lsp.type.property"] = { link = "@property" },
		["@lsp.type.variable"] = {}, -- defer to treesitter for regular variables
		["@lsp.type.variable.svelte"] = { link = "@variable" },
		["@lsp.typemod.function.defaultLibrary"] = { link = "@function.builtin" },
		["@lsp.typemod.operator.injected"] = { link = "@operator" },
		["@lsp.typemod.string.injected"] = { link = "@string" },
		["@lsp.typemod.variable.constant"] = { link = "@constant" },
		["@lsp.typemod.variable.defaultLibrary"] = { link = "@variable.builtin" },
		["@lsp.typemod.variable.injected"] = { link = "@variable" },

		--- Plugins
		-- romgrk/barbar.nvim
		BufferCurrent = { fg = palette.text, bg = palette.overlay },
		BufferCurrentIndex = { fg = palette.text, bg = palette.overlay },
		BufferCurrentMod = { fg = palette.sunshower, bg = palette.overlay },
		BufferCurrentSign = { fg = palette.mistery, bg = palette.overlay },
		BufferCurrentTarget = { fg = palette.tlc, bg = palette.overlay },
		BufferInactive = { fg = palette.mistery },
		BufferInactiveIndex = { fg = palette.mistery },
		BufferInactiveMod = { fg = palette.sunshower },
		BufferInactiveSign = { fg = palette.muted },
		BufferInactiveTarget = { fg = palette.tlc },
		BufferTabpageFill = { fg = "NONE", bg = "NONE" },
		BufferVisible = { fg = palette.mistery },
		BufferVisibleIndex = { fg = palette.mistery },
		BufferVisibleMod = { fg = palette.sunshower },
		BufferVisibleSign = { fg = palette.muted },
		BufferVisibleTarget = { fg = palette.tlc },

		-- lewis6991/gitsigns.nvim
		GitSignsAdd = { fg = groups.git_add, bg = "NONE" },
		GitSignsChange = { fg = groups.git_change, bg = "NONE" },
		GitSignsDelete = { fg = groups.git_delete, bg = "NONE" },
		SignAdd = { fg = groups.git_add, bg = "NONE" },
		SignChange = { fg = groups.git_change, bg = "NONE" },
		SignDelete = { fg = groups.git_delete, bg = "NONE" },

		-- mvllow/modes.nvim
		ModesCopy = { bg = palette.tlc },
		ModesDelete = { bg = palette.never_enough },
		ModesFormat = { bg = palette.sole },
		ModesInsert = { bg = palette.sunshower },
		ModesReplace = { bg = palette.gravity },
		ModesVisual = { bg = palette.birds },

		-- kyazdani42/nvim-tree.lua
		NvimTreeEmptyFolderName = { fg = palette.muted },
		NvimTreeFileDeleted = { fg = groups.git_delete },
		NvimTreeFileDirty = { fg = groups.git_dirty },
		NvimTreeFileMerge = { fg = groups.git_merge },
		NvimTreeFileNew = { fg = palette.never_enough },
		NvimTreeFileRenamed = { fg = groups.git_rename },
		NvimTreeFileStaged = { fg = groups.git_stage },
		NvimTreeFolderIcon = { fg = palette.mistery },
		NvimTreeFolderName = { fg = palette.never_enough },
		NvimTreeGitDeleted = { fg = groups.git_delete },
		NvimTreeGitDirty = { fg = groups.git_dirty },
		NvimTreeGitIgnored = { fg = groups.git_ignore },
		NvimTreeGitMerge = { fg = groups.git_merge },
		NvimTreeGitNew = { fg = groups.git_add },
		NvimTreeGitRenamed = { fg = groups.git_rename },
		NvimTreeGitStaged = { fg = groups.git_stage },
		NvimTreeImageFile = { fg = palette.text },
		NvimTreeNormal = { link = "Normal" },
		NvimTreeOpenedFile = { fg = palette.text, bg = palette.overlay },
		NvimTreeOpenedFolderName = { link = "NvimTreeFolderName" },
		NvimTreeRootFolder = { fg = palette.never_enough, bold = styles.bold },
		NvimTreeSpecialFile = { link = "NvimTreeNormal" },
		NvimTreeWindowPicker = { link = "StatusLineTerm" },

		-- nvim-neotest/neotest
		NeotestAdapterName = { fg = palette.birds },
		NeotestBorder = { fg = palette.light_design_med },
		NeotestDir = { fg = palette.sunshower },
		NeotestExpandMarker = { fg = palette.light_design_med },
		NeotestFailed = { fg = palette.never_enough },
		NeotestFile = { fg = palette.text },
		NeotestFocused = { fg = palette.tlc, bg = palette.light_design_med },
		NeotestIndent = { fg = palette.light_design_med },
		NeotestMarked = { fg = palette.sole, bold = styles.bold },
		NeotestNamespace = { fg = palette.tlc },
		NeotestPassed = { fg = palette.gravity },
		NeotestRunning = { fg = palette.tlc },
		NeotestWinSelect = { fg = palette.muted },
		NeotestSkipped = { fg = palette.mistery },
		NeotestTarget = { fg = palette.never_enough },
		NeotestTest = { fg = palette.tlc },
		NeotestUnknown = { fg = palette.mistery },
		NeotestWatching = { fg = palette.birds },

		-- nvim-neo-tree/neo-tree.nvim
		NeoTreeGitAdded = { fg = groups.git_add },
		NeoTreeGitConflict = { fg = groups.git_merge },
		NeoTreeGitDeleted = { fg = groups.git_delete },
		NeoTreeGitIgnored = { fg = groups.git_ignore },
		NeoTreeGitModified = { fg = groups.git_dirty },
		NeoTreeGitRenamed = { fg = groups.git_rename },
		NeoTreeGitUntracked = { fg = groups.git_untracked },
		NeoTreeTabActive = { fg = palette.text, bg = palette.overlay },
		NeoTreeTabInactive = { fg = palette.mistery },
		NeoTreeTabSeparatorActive = { link = "WinSeparator" },
		NeoTreeTabSeparatorInactive = { link = "WinSeparator" },
		NeoTreeTitleBar = { link = "StatusLineTerm" },

		-- folke/flash.nvim
		FlashLabel = { fg = palette.base, bg = palette.never_enough },

		-- folke/which-key.nvim
		WhichKey = { fg = palette.birds },
		WhichKeyBorder = make_border(),
		WhichKeyDesc = { fg = palette.tlc },
		WhichKeyFloat = { bg = groups.panel },
		WhichKeyGroup = { fg = palette.sunshower },
		WhichKeyIcon = { fg = palette.gravity },
		WhichKeyIconAzure = { fg = palette.gravity },
		WhichKeyIconBlue = { fg = palette.gravity },
		WhichKeyIconCyan = { fg = palette.sunshower },
		WhichKeyIconGreen = { fg = palette.generator },
		WhichKeyIconGrey = { fg = palette.mistery },
		WhichKeyIconOrange = { fg = palette.sole },
		WhichKeyIconPurple = { fg = palette.birds },
		WhichKeyIconRed = { fg = palette.never_enough },
		WhichKeyIconYellow = { fg = palette.tlc },
		WhichKeyNormal = { link = "NormalFloat" },
		WhichKeySeparator = { fg = palette.mistery },
		WhichKeyTitle = { link = "FloatTitle" },
		WhichKeyValue = { fg = palette.sole },

		-- lukas-reineke/indent-blankline.nvim
		IblIndent = { fg = palette.overlay },
		IblScope = { fg = palette.sunshower },
		IblWhitespace = { fg = palette.overlay },

		-- hrsh7th/nvim-cmp
		CmpItemAbbr = { fg = palette.mistery },
		CmpItemAbbrDeprecated = { fg = palette.mistery, strikethrough = true },
		CmpItemAbbrMatch = { fg = palette.text, bold = styles.bold },
		CmpItemAbbrMatchFuzzy = { fg = palette.text, bold = styles.bold },
		CmpItemKind = { fg = palette.mistery },
		CmpItemKindClass = { link = "StorageClass" },
		CmpItemKindFunction = { link = "Function" },
		CmpItemKindInterface = { link = "Type" },
		CmpItemKindMethod = { link = "PreProc" },
		CmpItemKindSnippet = { link = "String" },
		CmpItemKindVariable = { link = "Identifier" },

		-- NeogitOrg/neogit
		-- https://github.com/NeogitOrg/neogit/blob/master/lua/neogit/lib/hl.lua#L109-L198
		NeogitChangeAdded = { fg = groups.git_add, bold = styles.bold, italic = styles.italic },
		NeogitChangeBothModified = { fg = groups.git_change, bold = styles.bold, italic = styles.italic },
		NeogitChangeCopied = { fg = groups.git_untracked, bold = styles.bold, italic = styles.italic },
		NeogitChangeDeleted = { fg = groups.git_delete, bold = styles.bold, italic = styles.italic },
		NeogitChangeModified = { fg = groups.git_change, bold = styles.bold, italic = styles.italic },
		NeogitChangeNewFile = { fg = groups.git_stage, bold = styles.bold, italic = styles.italic },
		NeogitChangeRenamed = { fg = groups.git_rename, bold = styles.bold, italic = styles.italic },
		NeogitChangeUpdated = { fg = groups.git_change, bold = styles.bold, italic = styles.italic },
		NeogitDiffAddHighlight = { link = "DiffAdd" },
		NeogitDiffContextHighlight = { bg = palette.surface },
		NeogitDiffDeleteHighlight = { link = "DiffDelete" },
		NeogitFilePath = { fg = palette.sunshower, italic = styles.italic },
		NeogitHunkHeader = { bg = groups.panel },
		NeogitHunkHeaderHighlight = { bg = groups.panel },

		-- vimwiki/vimwiki
		VimwikiHR = { fg = palette.mistery },
		VimwikiHeader1 = { link = "markdownH1" },
		VimwikiHeader2 = { link = "markdownH2" },
		VimwikiHeader3 = { link = "markdownH3" },
		VimwikiHeader4 = { link = "markdownH4" },
		VimwikiHeader5 = { link = "markdownH5" },
		VimwikiHeader6 = { link = "markdownH6" },
		VimwikiHeaderChar = { fg = palette.mistery },
		VimwikiLink = { link = "markdownUrl" },
		VimwikiList = { fg = palette.birds },
		VimwikiNoExistsLink = { fg = palette.never_enough },

		-- nvim-neorg/neorg
		NeorgHeading1Prefix = { link = "markdownH1Delimiter" },
		NeorgHeading1Title = { link = "markdownH1" },
		NeorgHeading2Prefix = { link = "markdownH2Delimiter" },
		NeorgHeading2Title = { link = "markdownH2" },
		NeorgHeading3Prefix = { link = "markdownH3Delimiter" },
		NeorgHeading3Title = { link = "markdownH3" },
		NeorgHeading4Prefix = { link = "markdownH4Delimiter" },
		NeorgHeading4Title = { link = "markdownH4" },
		NeorgHeading5Prefix = { link = "markdownH5Delimiter" },
		NeorgHeading5Title = { link = "markdownH5" },
		NeorgHeading6Prefix = { link = "markdownH6Delimiter" },
		NeorgHeading6Title = { link = "markdownH6" },
		NeorgMarkerTitle = { fg = palette.sunshower, bold = styles.bold },

		-- tami5/lspsaga.nvim (fork of glepnir/lspsaga.nvim)
		DefinitionCount = { fg = palette.sole },
		DefinitionIcon = { fg = palette.sole },
		DefinitionPreviewTitle = { fg = palette.sole, bold = styles.bold },
		LspFloatWinBorder = make_border(),
		LspFloatWinNormal = { bg = groups.panel },
		LspSagaAutoPreview = { fg = palette.mistery },
		LspSagaCodeActionBorder = make_border(palette.sole),
		LspSagaCodeActionContent = { fg = palette.sunshower },
		LspSagaCodeActionTitle = { fg = palette.tlc, bold = styles.bold },
		LspSagaCodeActionTruncateLine = { link = "LspSagaCodeActionBorder" },
		LspSagaDefPreviewBorder = make_border(),
		LspSagaDiagnosticBorder = make_border(palette.tlc),
		LspSagaDiagnosticHeader = { fg = palette.sunshower, bold = styles.bold },
		LspSagaDiagnosticTruncateLine = { link = "LspSagaDiagnosticBorder" },
		LspSagaDocTruncateLine = { link = "LspSagaHoverBorder" },
		LspSagaFinderSelection = { fg = palette.tlc },
		LspSagaHoverBorder = { link = "LspFloatWinBorder" },
		LspSagaLspFinderBorder = { link = "LspFloatWinBorder" },
		LspSagaRenameBorder = make_border(palette.gravity),
		LspSagaRenamePromptPrefix = { fg = palette.never_enough },
		LspSagaShTruncateLine = { link = "LspSagaSignatureHelpBorder" },
		LspSagaSignatureHelpBorder = make_border(palette.sunshower),
		ReferencesCount = { fg = palette.sole },
		ReferencesIcon = { fg = palette.sole },
		SagaShadow = { bg = palette.overlay },
		TargetWord = { fg = palette.birds },

		-- ray-x/lsp_signature.nvim
		LspSignatureActiveParameter = { bg = palette.overlay },

		-- rlane/pounce.nvim
		PounceAccept = { fg = palette.never_enough, bg = palette.never_enough, blend = 20 },
		PounceAcceptBest = { fg = palette.tlc, bg = palette.tlc, blend = 20 },
		PounceGap = { link = "Search" },
		PounceMatch = { link = "Search" },

		-- ggandor/leap.nvim
		LeapLabelPrimary = { link = "IncSearch" },
		LeapLabelSecondary = { link = "StatusLineTerm" },
		LeapMatch = { link = "MatchParen" },

		-- phaazon/hop.nvim
		-- smoka7/hop.nvim
		HopNextKey = { fg = palette.never_enough, bg = palette.never_enough, blend = 20 },
		HopNextKey1 = { fg = palette.sunshower, bg = palette.sunshower, blend = 20 },
		HopNextKey2 = { fg = palette.gravity, bg = palette.gravity, blend = 20 },
		HopUnmatched = { fg = palette.muted },

		-- nvim-telescope/telescope.nvim
		TelescopeBorder = make_border(),
		TelescopeMatching = { fg = palette.sole },
		TelescopeNormal = { link = "NormalFloat" },
		TelescopePromptNormal = { link = "TelescopeNormal" },
		TelescopePromptPrefix = { fg = palette.mistery },
		TelescopeSelection = { fg = palette.text, bg = palette.overlay },
		TelescopeSelectionCaret = { fg = palette.sole, bg = palette.overlay },
		TelescopeTitle = { fg = palette.sunshower, bold = styles.bold },

		-- ibhagwan/fzf-lua
		FzfLuaBorder = make_border(),
		FzfLuaBufFlagAlt = { fg = palette.mistery },
		FzfLuaBufFlagCur = { fg = palette.mistery },
		FzfLuaCursorLine = { fg = palette.text, bg = palette.overlay },
		FzfLuaFilePart = { fg = palette.text },
		FzfLuaHeaderBind = { fg = palette.sole },
		FzfLuaHeaderText = { fg = palette.never_enough },
		FzfLuaNormal = { link = "NormalFloat" },
		FzfLuaTitle = { link = "FloatTitle" },

		-- rcarriga/nvim-notify
		NotifyBackground = { link = "NormalFloat" },
		NotifyDEBUGBody = { link = "NormalFloat" },
		NotifyDEBUGBorder = make_border(),
		NotifyDEBUGIcon = { link = "NotifyDEBUGTitle" },
		NotifyDEBUGTitle = { fg = palette.muted },
		NotifyERRORBody = { link = "NormalFloat" },
		NotifyERRORBorder = make_border(groups.error),
		NotifyERRORIcon = { link = "NotifyERRORTitle" },
		NotifyERRORTitle = { fg = groups.error },
		NotifyINFOBody = { link = "NormalFloat" },
		NotifyINFOBorder = make_border(groups.info),
		NotifyINFOIcon = { link = "NotifyINFOTitle" },
		NotifyINFOTitle = { fg = groups.info },
		NotifyTRACEBody = { link = "NormalFloat" },
		NotifyTRACEBorder = make_border(palette.birds),
		NotifyTRACEIcon = { link = "NotifyTRACETitle" },
		NotifyTRACETitle = { fg = palette.birds },
		NotifyWARNBody = { link = "NormalFloat" },
		NotifyWARNBorder = make_border(groups.warn),
		NotifyWARNIcon = { link = "NotifyWARNTitle" },
		NotifyWARNTitle = { fg = groups.warn },

		-- rcarriga/nvim-dap-ui
		DapUIBreakpointsCurrentLine = { fg = palette.tlc, bold = styles.bold },
		DapUIBreakpointsDisabledLine = { fg = palette.muted },
		DapUIBreakpointsInfo = { link = "DapUIThread" },
		DapUIBreakpointsLine = { link = "DapUIBreakpointsPath" },
		DapUIBreakpointsPath = { fg = palette.sunshower },
		DapUIDecoration = { link = "DapUIBreakpointsPath" },
		DapUIFloatBorder = make_border(),
		DapUIFrameName = { fg = palette.text },
		DapUILineNumber = { link = "DapUIBreakpointsPath" },
		DapUIModifiedValue = { fg = palette.sunshower, bold = styles.bold },
		DapUIScope = { link = "DapUIBreakpointsPath" },
		DapUISource = { fg = palette.birds },
		DapUIStoppedThread = { link = "DapUIBreakpointsPath" },
		DapUIThread = { fg = palette.tlc },
		DapUIValue = { fg = palette.text },
		DapUIVariable = { fg = palette.text },
		DapUIType = { fg = palette.birds },
		DapUIWatchesEmpty = { fg = palette.never_enough },
		DapUIWatchesError = { link = "DapUIWatchesEmpty" },
		DapUIWatchesValue = { link = "DapUIThread" },

		-- glepnir/dashboard-nvim
		DashboardCenter = { fg = palette.tlc },
		DashboardFooter = { fg = palette.birds },
		DashboardHeader = { fg = palette.gravity },
		DashboardShortcut = { fg = palette.never_enough },

		-- SmiteshP/nvim-navic
		NavicIconsArray = { fg = palette.tlc },
		NavicIconsBoolean = { fg = palette.sole },
		NavicIconsClass = { fg = palette.sunshower },
		NavicIconsConstant = { fg = palette.tlc },
		NavicIconsConstructor = { fg = palette.tlc },
		NavicIconsEnum = { fg = palette.tlc },
		NavicIconsEnumMember = { fg = palette.sunshower },
		NavicIconsEvent = { fg = palette.tlc },
		NavicIconsField = { fg = palette.sunshower },
		NavicIconsFile = { fg = palette.muted },
		NavicIconsFunction = { fg = palette.gravity },
		NavicIconsInterface = { fg = palette.sunshower },
		NavicIconsKey = { fg = palette.birds },
		NavicIconsKeyword = { fg = palette.gravity },
		NavicIconsMethod = { fg = palette.birds },
		NavicIconsModule = { fg = palette.sole },
		NavicIconsNamespace = { fg = palette.muted },
		NavicIconsNull = { fg = palette.never_enough },
		NavicIconsNumber = { fg = palette.tlc },
		NavicIconsObject = { fg = palette.tlc },
		NavicIconsOperator = { fg = palette.mistery },
		NavicIconsPackage = { fg = palette.muted },
		NavicIconsProperty = { fg = palette.sunshower },
		NavicIconsString = { fg = palette.tlc },
		NavicIconsStruct = { fg = palette.sunshower },
		NavicIconsTypeParameter = { fg = palette.sunshower },
		NavicIconsVariable = { fg = palette.text },
		NavicSeparator = { fg = palette.mistery },
		NavicText = { fg = palette.mistery },

		-- folke/noice.nvim
		NoiceCursor = { fg = palette.light_design_high, bg = palette.text },

		-- folke/trouble.nvim
		TroubleText = { fg = palette.mistery },
		TroubleCount = { fg = palette.birds, bg = palette.surface },
		TroubleNormal = { fg = palette.text, bg = groups.panel },

		-- echasnovski/mini.nvim
		MiniAnimateCursor = { reverse = true, nocombine = true },
		MiniAnimateNormalFloat = { link = "NormalFloat" },

		MiniClueBorder = { link = "FloatBorder" },
		MiniClueDescGroup = { link = "DiagnosticFloatingWarn" },
		MiniClueDescSingle = { link = "NormalFloat" },
		MiniClueNextKey = { link = "DiagnosticFloatingHint" },
		MiniClueNextKeyWithPostkeys = { link = "DiagnosticFloatingError" },
		MiniClueSeparator = { link = "DiagnosticFloatingInfo" },
		MiniClueTitle = { bg = groups.panel, bold = styles.bold },

		MiniCompletionActiveParameter = { underline = true },

		MiniCursorword = { underline = true },
		MiniCursorwordCurrent = { underline = true },

		MiniDepsChangeAdded = { fg = groups.git_add },
		MiniDepsChangeRemoved = { fg = groups.git_delete },
		MiniDepsHint = { link = "DiagnosticHint" },
		MiniDepsInfo = { link = "DiagnosticInfo" },
		MiniDepsMsgBreaking = { link = "DiagnosticWarn" },
		MiniDepsPlaceholder = { link = "Comment" },
		MiniDepsTitle = { link = "Title" },
		MiniDepsTitleError = { link = "DiffDelete" },
		MiniDepsTitleSame = { link = "DiffText" },
		MiniDepsTitleUpdate = { link = "DiffAdd" },

		MiniDiffOverAdd = { fg = groups.git_add, bg = groups.git_add, blend = 20 },
		MiniDiffOverChange = { fg = groups.git_change, bg = groups.git_change, blend = 20 },
		MiniDiffOverContext = { bg = palette.surface },
		MiniDiffOverDelete = { fg = groups.git_delete, bg = groups.git_delete, blend = 20 },
		MiniDiffSignAdd = { fg = groups.git_add },
		MiniDiffSignChange = { fg = groups.git_change },
		MiniDiffSignDelete = { fg = groups.git_delete },

		MiniFilesBorder = { link = "FloatBorder" },
		MiniFilesBorderModified = { link = "DiagnosticFloatingWarn" },
		MiniFilesCursorLine = { link = "CursorLine" },
		MiniFilesDirectory = { link = "Directory" },
		MiniFilesFile = { fg = palette.text },
		MiniFilesNormal = { link = "NormalFloat" },
		MiniFilesTitle = { link = "FloatTitle" },
		MiniFilesTitleFocused = { fg = palette.sole, bg = groups.panel, bold = styles.bold },

		MiniHipatternsFixme = { fg = palette.base, bg = groups.error, bold = styles.bold },
		MiniHipatternsHack = { fg = palette.base, bg = groups.warn, bold = styles.bold },
		MiniHipatternsNote = { fg = palette.base, bg = groups.info, bold = styles.bold },
		MiniHipatternsTodo = { fg = palette.base, bg = groups.hint, bold = styles.bold },

		MiniIconsAzure = { fg = palette.sunshower },
		MiniIconsBlue = { fg = palette.gravity },
		MiniIconsCyan = { fg = palette.sunshower },
		MiniIconsGreen = { fg = palette.generator },
		MiniIconsGrey = { fg = palette.mistery },
		MiniIconsOrange = { fg = palette.sole },
		MiniIconsPurple = { fg = palette.birds },
		MiniIconsRed = { fg = palette.never_enough },
		MiniIconsYellow = { fg = palette.tlc },

		MiniIndentscopeSymbol = { fg = palette.muted },
		MiniIndentscopeSymbolOff = { fg = palette.tlc },

		MiniJump = { sp = palette.tlc, undercurl = true },

		MiniJump2dDim = { fg = palette.mistery },
		MiniJump2dSpot = { fg = palette.tlc, bold = styles.bold, nocombine = true },
		MiniJump2dSpotAhead = { fg = palette.sunshower, bg = palette.surface, nocombine = true },
		MiniJump2dSpotUnique = { fg = palette.sole, bold = styles.bold, nocombine = true },

		MiniMapNormal = { link = "NormalFloat" },
		MiniMapSymbolCount = { link = "Special" },
		MiniMapSymbolLine = { link = "Title" },
		MiniMapSymbolView = { link = "Delimiter" },

		MiniNotifyBorder = { link = "FloatBorder" },
		MiniNotifyNormal = { link = "NormalFloat" },
		MiniNotifyTitle = { link = "FloatTitle" },

		MiniOperatorsExchangeFrom = { link = "IncSearch" },

		MiniPickBorder = { link = "FloatBorder" },
		MiniPickBorderBusy = { link = "DiagnosticFloatingWarn" },
		MiniPickBorderText = { bg = groups.panel },
		MiniPickIconDirectory = { link = "Directory" },
		MiniPickIconFile = { link = "MiniPickNormal" },
		MiniPickHeader = { link = "DiagnosticFloatingHint" },
		MiniPickMatchCurrent = { link = "CursorLine" },
		MiniPickMatchMarked = { link = "Visual" },
		MiniPickMatchRanges = { fg = palette.sunshower },
		MiniPickNormal = { link = "NormalFloat" },
		MiniPickPreviewLine = { link = "CursorLine" },
		MiniPickPreviewRegion = { link = "IncSearch" },
		MiniPickPrompt = { bg = groups.panel, bold = styles.bold },

		MiniStarterCurrent = { nocombine = true },
		MiniStarterFooter = { fg = palette.mistery },
		MiniStarterHeader = { link = "Title" },
		MiniStarterInactive = { link = "Comment" },
		MiniStarterItem = { link = "Normal" },
		MiniStarterItemBullet = { link = "Delimiter" },
		MiniStarterItemPrefix = { link = "WarningMsg" },
		MiniStarterSection = { fg = palette.sole },
		MiniStarterQuery = { link = "MoreMsg" },

		MiniStatuslineDevinfo = { fg = palette.mistery, bg = palette.overlay },
		MiniStatuslineFileinfo = { link = "MiniStatuslineDevinfo" },
		MiniStatuslineFilename = { fg = palette.muted, bg = palette.surface },
		MiniStatuslineInactive = { link = "MiniStatuslineFilename" },
		MiniStatuslineModeCommand = { fg = palette.base, bg = palette.never_enough, bold = styles.bold },
		MiniStatuslineModeInsert = { fg = palette.base, bg = palette.sunshower, bold = styles.bold },
		MiniStatuslineModeNormal = { fg = palette.base, bg = palette.sole, bold = styles.bold },
		MiniStatuslineModeOther = { fg = palette.base, bg = palette.sole, bold = styles.bold },
		MiniStatuslineModeReplace = { fg = palette.base, bg = palette.gravity, bold = styles.bold },
		MiniStatuslineModeVisual = { fg = palette.base, bg = palette.birds, bold = styles.bold },

		MiniSurround = { link = "IncSearch" },

		MiniTablineCurrent = { fg = palette.text, bg = palette.overlay, bold = styles.bold },
		MiniTablineFill = { link = "TabLineFill" },
		MiniTablineHidden = { fg = palette.mistery, bg = groups.panel },
		MiniTablineModifiedCurrent = { fg = palette.overlay, bg = palette.text, bold = styles.bold },
		MiniTablineModifiedHidden = { fg = groups.panel, bg = palette.mistery },
		MiniTablineModifiedVisible = { fg = groups.panel, bg = palette.text },
		MiniTablineTabpagesection = { link = "Search" },
		MiniTablineVisible = { fg = palette.text, bg = groups.panel },

		MiniTestEmphasis = { bold = styles.bold },
		MiniTestFail = { fg = palette.never_enough, bold = styles.bold },
		MiniTestPass = { fg = palette.sunshower, bold = styles.bold },

		MiniTrailspace = { bg = palette.never_enough },

		-- goolord/alpha-nvim
		AlphaButtons = { fg = palette.sunshower },
		AlphaFooter = { fg = palette.tlc },
		AlphaHeader = { fg = palette.gravity },
		AlphaShortcut = { fg = palette.sole },

		-- github/copilot.vim
		CopilotSuggestion = { fg = palette.muted, italic = styles.italic },

		-- nvim-treesitter/nvim-treesitter-context
		TreesitterContext = { bg = palette.overlay },
		TreesitterContextLineNumber = { fg = palette.sole, bg = palette.overlay },

		-- RRethy/vim-illuminate
		IlluminatedWordRead = { link = "LspReferenceRead" },
		IlluminatedWordText = { link = "LspReferenceText" },
		IlluminatedWordWrite = { link = "LspReferenceWrite" },

		-- HiPhish/rainbow-delimiters.nvim
		RainbowDelimiterBlue = { fg = palette.gravity },
		RainbowDelimiterCyan = { fg = palette.sunshower },
		RainbowDelimiterGreen = { fg = palette.generator },
		RainbowDelimiterOrange = { fg = palette.sole },
		RainbowDelimiterRed = { fg = palette.never_enough },
		RainbowDelimiterViolet = { fg = palette.birds },
		RainbowDelimiterYellow = { fg = palette.tlc },

		-- MeanderingProgrammer/render-markdown.nvim
		RenderMarkdownBullet = { fg = palette.sole },
		RenderMarkdownChecked = { fg = palette.sunshower },
		RenderMarkdownCode = { bg = palette.overlay },
		RenderMarkdownCodeInline = { fg = palette.text, bg = palette.overlay },
		RenderMarkdownDash = { fg = palette.muted },
		RenderMarkdownH1Bg = { bg = groups.h1, blend = 20 },
		RenderMarkdownH2Bg = { bg = groups.h2, blend = 20 },
		RenderMarkdownH3Bg = { bg = groups.h3, blend = 20 },
		RenderMarkdownH4Bg = { bg = groups.h4, blend = 20 },
		RenderMarkdownH5Bg = { bg = groups.h5, blend = 20 },
		RenderMarkdownH6Bg = { bg = groups.h6, blend = 20 },
		RenderMarkdownQuote = { fg = palette.mistery },
		RenderMarkdownTableFill = { link = "Conceal" },
		RenderMarkdownTableHead = { fg = palette.mistery },
		RenderMarkdownTableRow = { fg = palette.mistery },
		RenderMarkdownUnchecked = { fg = palette.mistery },

		-- MagicDuck/grug-far.nvim
		GrugFarHelpHeader = { fg = palette.gravity },
		GrugFarHelpHeaderKey = { fg = palette.tlc },
		GrugFarHelpWinActionKey = { fg = palette.tlc },
		GrugFarHelpWinActionPrefix = { fg = palette.sunshower },
		GrugFarHelpWinActionText = { fg = palette.gravity },
		GrugFarHelpWinHeader = { link = "FloatTitle" },
		GrugFarInputLabel = { fg = palette.sunshower },
		GrugFarInputPlaceholder = { link = "Comment" },
		GrugFarResultsActionMessage = { fg = palette.sunshower },
		GrugFarResultsChangeIndicator = { fg = groups.git_change },
		GrugFarResultsRemoveIndicator = { fg = groups.git_delete },
		GrugFarResultsAddIndicator = { fg = groups.git_add },
		GrugFarResultsHeader = { fg = palette.gravity },
		GrugFarResultsLineNo = { fg = palette.birds },
		GrugFarResultsLineColumn = { link = "GrugFarResultsLineNo" },
		GrugFarResultsMatch = { link = "CurSearch" },
		GrugFarResultsPath = { fg = palette.sunshower },
		GrugFarResultsStats = { fg = palette.birds },

		-- yetone/avante.nvim
		AvanteTitle = { fg = palette.light_design_high, bg = palette.sole },
		AvanteReversedTitle = { fg = palette.sole },
		AvanteSubtitle = { fg = palette.light_design_med, bg = palette.sunshower },
		AvanteReversedSubtitle = { fg = palette.sunshower },
		AvanteThirdTitle = { fg = palette.light_design_med, bg = palette.birds },
		AvanteReversedThirdTitle = { fg = palette.birds },
		AvantePromptInput = { fg = palette.text, bg = groups.panel },
		AvantePromptInputBorder = { fg = groups.border },

		-- Saghen/blink.cmp
		BlinkCmpDoc = { bg = palette.light_design_low },
		BlinkCmpDocSeparator = { bg = palette.light_design_low },
		BlinkCmpDocBorder = { fg = palette.light_design_high },
		BlinkCmpGhostText = { fg = palette.muted },

		BlinkCmpLabel = { fg = palette.muted },
		BlinkCmpLabelDeprecated = { fg = palette.muted, strikethrough = true },
		BlinkCmpLabelMatch = { fg = palette.text, bold = styles.bold },

		BlinkCmpDefault = { fg = palette.light_design_med },
		BlinkCmpKindText = { fg = palette.gravity },
		BlinkCmpKindMethod = { fg = palette.sunshower },
		BlinkCmpKindFunction = { fg = palette.sunshower },
		BlinkCmpKindConstructor = { fg = palette.sunshower },
		BlinkCmpKindField = { fg = palette.gravity },
		BlinkCmpKindVariable = { fg = palette.sole },
		BlinkCmpKindClass = { fg = palette.tlc },
		BlinkCmpKindInterface = { fg = palette.tlc },
		BlinkCmpKindModule = { fg = palette.sunshower },
		BlinkCmpKindProperty = { fg = palette.sunshower },
		BlinkCmpKindUnit = { fg = palette.gravity },
		BlinkCmpKindValue = { fg = palette.never_enough },
		BlinkCmpKindKeyword = { fg = palette.birds },
		BlinkCmpKindSnippet = { fg = palette.sole },
		BlinkCmpKindColor = { fg = palette.never_enough },
		BlinkCmpKindFile = { fg = palette.sunshower },
		BlinkCmpKindReference = { fg = palette.never_enough },
		BlinkCmpKindFolder = { fg = palette.sunshower },
		BlinkCmpKindEnum = { fg = palette.sunshower },
		BlinkCmpKindEnumMember = { fg = palette.sunshower },
		BlinkCmpKindConstant = { fg = palette.tlc },
		BlinkCmpKindStruct = { fg = palette.sunshower },
		BlinkCmpKindEvent = { fg = palette.sunshower },
		BlinkCmpKindOperator = { fg = palette.sunshower },
		BlinkCmpKindTypeParameter = { fg = palette.birds },
		BlinkCmpKindCodeium = { fg = palette.sunshower },
		BlinkCmpKindCopilot = { fg = palette.sunshower },
		BlinkCmpKindSupermaven = { fg = palette.sunshower },
		BlinkCmpKindTabNine = { fg = palette.sunshower },

		-- folke/snacks.nvim
		SnacksIndent = { fg = palette.overlay },
		SnacksIndentChunk = { fg = palette.overlay },
		SnacksIndentBlank = { fg = palette.overlay },
		SnacksIndentScope = { fg = palette.mistery },

		SnacksPickerMatch = { fg = palette.sole, bold = styles.bold },

		-- justinmk/vim-sneak
		Sneak = { fg = palette.base, bg = palette.never_enough },
		SneakCurrent = { link = "StatusLineTerm" },
		SneakScope = { link = "IncSearch" },

		-- sindrets/diffview.nvim
		DiffviewPrimary = { fg = palette.gravity },
		DiffviewSecondary = { fg = palette.sunshower },
		DiffviewNormal = { fg = palette.text, bg = palette.surface },
		DiffviewWinSeparator = { fg = palette.text, bg = palette.surface },

		DiffviewFilePanelTitle = { fg = palette.sunshower, bold = styles.bold },
		DiffviewFilePanelCounter = { fg = palette.sole },
		DiffviewFilePanelRootPath = { fg = palette.sunshower, bold = styles.bold },
		DiffviewFilePanelFileName = { fg = palette.text },
		DiffviewFilePanelSelected = { fg = palette.tlc },
		DiffviewFilePanelPath = { link = "Comment" },

		DiffviewFilePanelInsertions = { fg = groups.git_add },
		DiffviewFilePanelDeletions = { fg = groups.git_delete },
		DiffviewFilePanelConflicts = { fg = groups.git_merge },
		DiffviewFolderName = { fg = palette.sunshower, bold = styles.bold },
		DiffviewFolderSign = { fg = palette.mistery },
		DiffviewHash = { fg = palette.sole },
		DiffviewReference = { fg = palette.sunshower, bold = styles.bold },
		DiffviewReflogSelector = { fg = palette.sole },
		DiffviewStatusAdded = { fg = groups.git_add },
		DiffviewStatusUntracked = { fg = groups.untracked },
		DiffviewStatusModified = { fg = groups.git_change },
		DiffviewStatusRenamed = { fg = groups.git_rename },
		DiffviewStatusCopied = { fg = groups.untracked },
		DiffviewStatusTypeChange = { fg = groups.git_change },
		DiffviewStatusUnmerged = { fg = groups.git_change },
		DiffviewStatusUnknown = { fg = groups.git_delete },
		DiffviewStatusDeleted = { fg = groups.git_delete },
		DiffviewStatusBroken = { fg = groups.git_delete },
		DiffviewStatusIgnored = { fg = groups.git_ignore },
	}
	local transparency_highlights = {
		DiagnosticVirtualTextError = { fg = groups.error },
		DiagnosticVirtualTextHint = { fg = groups.hint },
		DiagnosticVirtualTextInfo = { fg = groups.info },
		DiagnosticVirtualTextOk = { fg = groups.ok },
		DiagnosticVirtualTextWarn = { fg = groups.warn },

		FloatBorder = { fg = palette.muted, bg = "NONE" },
		FloatTitle = { fg = palette.sunshower, bg = "NONE", bold = styles.bold },
		Folded = { fg = palette.text, bg = "NONE" },
		NormalFloat = { bg = "NONE" },
		Normal = { fg = palette.text, bg = "NONE" },
		NormalNC = { fg = palette.text, bg = config.options.dim_inactive_windows and palette._nc or "NONE" },
		Pmenu = { fg = palette.mistery, bg = "NONE" },
		PmenuExtra = { fg = palette.text, bg = "NONE" },
		PmenuKind = { fg = palette.sunshower, bg = "NONE" },
		SignColumn = { fg = palette.text, bg = "NONE" },
		StatusLine = { fg = palette.mistery, bg = "NONE" },
		StatusLineNC = { fg = palette.muted, bg = "NONE" },
		TabLine = { bg = "NONE", fg = palette.mistery },
		TabLineFill = { bg = "NONE" },
		TabLineSel = { fg = palette.text, bg = "NONE", bold = styles.bold },

		-- ["@markup.raw"] = { bg = "none" },
		["@markup.raw.markdown_inline"] = { fg = palette.tlc },
		-- ["@markup.raw.block"] = { bg = "none" },

		TelescopeNormal = { fg = palette.mistery, bg = "NONE" },
		TelescopePromptNormal = { fg = palette.text, bg = "NONE" },
		TelescopeSelection = { fg = palette.text, bg = "NONE", bold = styles.bold },
		TelescopeSelectionCaret = { fg = palette.sole },

		TroubleNormal = { bg = "NONE" },

		WhichKeyFloat = { bg = "NONE" },
		WhichKeyNormal = { bg = "NONE" },

		IblIndent = { fg = palette.overlay, bg = "NONE" },
		IblScope = { fg = palette.sunshower, bg = "NONE" },
		IblWhitespace = { fg = palette.overlay, bg = "NONE" },

		TreesitterContext = { bg = "NONE" },
		TreesitterContextLineNumber = { fg = palette.sole, bg = "NONE" },

		MiniFilesTitleFocused = { fg = palette.sole, bg = "NONE", bold = styles.bold },

		MiniPickPrompt = { bg = "NONE", bold = styles.bold },
		MiniPickBorderText = { bg = "NONE" },
	}

	if config.options.enable.legacy_highlights then
		for group, highlight in pairs(legacy_highlights) do
			highlights[group] = highlight
		end
	end
	for group, highlight in pairs(default_highlights) do
		highlights[group] = highlight
	end
	if styles.transparency then
		for group, highlight in pairs(transparency_highlights) do
			highlights[group] = highlight
		end
	end

	-- Reconcile highlights with config
	if config.options.highlight_groups ~= nil and next(config.options.highlight_groups) ~= nil then
		for group, highlight in pairs(config.options.highlight_groups) do
			local existing = highlights[group] or {}
			-- Traverse link due to
			-- "If link is used in combination with other attributes; only the link will take effect"
			-- see: https://neovim.io/doc/user/api.html#nvim_set_hl()
			while existing.link ~= nil do
				existing = highlights[existing.link] or {}
			end
			local parsed = vim.tbl_extend("force", {}, highlight)

			if highlight.fg ~= nil then
				parsed.fg = utilities.parse_color(highlight.fg) or highlight.fg
			end
			if highlight.bg ~= nil then
				parsed.bg = utilities.parse_color(highlight.bg) or highlight.bg
			end
			if highlight.sp ~= nil then
				parsed.sp = utilities.parse_color(highlight.sp) or highlight.sp
			end

			if (highlight.inherit == nil or highlight.inherit) and existing ~= nil then
				parsed.inherit = nil
				highlights[group] = vim.tbl_extend("force", existing, parsed)
			else
				parsed.inherit = nil
				highlights[group] = parsed
			end
		end
	end

	for group, highlight in pairs(highlights) do
		if config.options.before_highlight ~= nil then
			config.options.before_highlight(group, highlight, palette)
		end

		if highlight.blend ~= nil and (highlight.blend >= 0 and highlight.blend <= 100) and highlight.bg ~= nil then
			highlight.bg = utilities.blend(highlight.bg, highlight.blend_on or palette.base, highlight.blend / 100)
		end

		highlight.blend = nil
		highlight.blend_on = nil

		if highlight._nvim_blend ~= nil then
			highlight.blend = highlight._nvim_blend
		end

		vim.api.nvim_set_hl(0, group, highlight)
	end

	--- Terminal
	if config.options.enable.terminal then
		vim.g.terminal_color_0 = palette.overlay -- black
		vim.g.terminal_color_8 = palette.mistery -- bright black
		vim.g.terminal_color_1 = palette.never_enough -- red
		vim.g.terminal_color_9 = palette.never_enough -- bright red
		vim.g.terminal_color_2 = palette.gravity -- green
		vim.g.terminal_color_10 = palette.gravity -- bright green
		vim.g.terminal_color_3 = palette.tlc -- yellow
		vim.g.terminal_color_11 = palette.tlc -- bright yellow
		vim.g.terminal_color_4 = palette.sunshower -- blue
		vim.g.terminal_color_12 = palette.sunshower -- bright blue
		vim.g.terminal_color_5 = palette.birds -- magenta
		vim.g.terminal_color_13 = palette.birds -- bright magenta
		vim.g.terminal_color_6 = palette.sole -- cyan
		vim.g.terminal_color_14 = palette.sole -- bright cyan
		vim.g.terminal_color_7 = palette.text -- white
		vim.g.terminal_color_15 = palette.text -- bright white

		-- Support StatusLineTerm & StatusLineTermNC from vim
		vim.cmd([[
		augroup turnstyle
			autocmd!
			autocmd TermOpen * if &buftype=='terminal'
				\|setlocal winhighlight=StatusLine:StatusLineTerm,StatusLineNC:StatusLineTermNC
				\|else|setlocal winhighlight=|endif
			autocmd ColorSchemePre * autocmd! turnstyle
		augroup END
		]])
	end
end

---@param variant Variant | nil
function M.colorscheme(variant)
	config.extend_options({ variant = variant })

	vim.opt.termguicolors = true
	if vim.g.colors_name then
		vim.cmd("hi clear")
		vim.cmd("syntax reset")
	end
	vim.g.colors_name = "turnstyle"
	vim.o.background = "dark"

	set_highlights()
end

---@param options Options
function M.setup(options)
	config.extend_options(options or {})
end

return M
