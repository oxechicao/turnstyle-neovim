local p = require("turnstyle.palette")
local config = require("turnstyle.config")

local bg_base = p.base
if config.options.styles.transparency then
	bg_base = "NONE"
end

return {
	normal = {
		a = { bg = p.sole, fg = p.base, gui = "bold" },
		b = { bg = p.overlay, fg = p.sole },
		c = { bg = bg_base, fg = p.text },
	},
	insert = {
		a = { bg = p.sunshower, fg = p.base, gui = "bold" },
		b = { bg = p.overlay, fg = p.sunshower },
		c = { bg = bg_base, fg = p.text },
	},
	visual = {
		a = { bg = p.birds, fg = p.base, gui = "bold" },
		b = { bg = p.overlay, fg = p.birds },
		c = { bg = bg_base, fg = p.text },
	},
	replace = {
		a = { bg = p.gravity, fg = p.base, gui = "bold" },
		b = { bg = p.overlay, fg = p.gravity },
		c = { bg = bg_base, fg = p.text },
	},
	command = {
		a = { bg = p.never_enough, fg = p.base, gui = "bold" },
		b = { bg = p.overlay, fg = p.never_enough },
		c = { bg = bg_base, fg = p.text },
	},
	inactive = {
		a = { bg = bg_base, fg = p.muted, gui = "bold" },
		b = { bg = bg_base, fg = p.muted },
		c = { bg = bg_base, fg = p.muted },
	},
}
