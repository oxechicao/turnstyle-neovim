local p = require("turnstyle.palette")
local config = require("turnstyle.config")

local bg_base = p.base
if config.options.styles.transparency then
	bg_base = "NONE"
end

return {
	normal = {
		a = { bg = p.surface, fg = p.sole, gui = "bold" },
		b = { bg = p.surface, fg = p.text },
		c = { bg = p.surface, fg = p.mistery, gui = "italic" },
	},
	insert = {
		a = { bg = p.surface, fg = p.sunshower, gui = "bold" },
	},
	visual = {
		a = { bg = p.surface, fg = p.birds, gui = "bold" },
	},
	replace = {
		a = { bg = p.surface, fg = p.gravity, gui = "bold" },
	},
	command = {
		a = { bg = p.surface, fg = p.never_enough, gui = "bold" },
	},
	inactive = {
		a = { bg = bg_base, fg = p.mistery, gui = "bold" },
		b = { bg = bg_base, fg = p.mistery },
		c = { bg = bg_base, fg = p.mistery, gui = "italic" },
	},
}
