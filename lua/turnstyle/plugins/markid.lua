--- Turnstyle for markid
--- https://github.com/David-Kunz/markid
---
--- @usage
--- local highlights = require("turnstyle.plugins.markid")
--- require("nvim-treesitter.configs").setup({ markid = { enable = true, colors = highlights } })

local p = require("turnstyle.palette")

return { p.sunshower, p.sole, p.birds }
