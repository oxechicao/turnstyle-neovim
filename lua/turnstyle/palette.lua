local options = require("turnstyle.config").options
local variants = {
	darker = {
		_nc = "#0f1524",
		base = "#0f1524",
		surface = "#172436",
		overlay = "#182b3e",
		muted = "#687a87",
		mistery = "#a3cbd2", -- mistery
		text = "#e0f0f0",
		never_enough = "#a3cbd2", --never_enough
		tlc = "#da81aa", -- tlc
		sole = "#d7a275", -- sole
		gravity = "#75a6eb", -- gravity
		sunshower = "#dfdf90", --sunshower
		birds = "#4fa190", -- birds
		generator = "#da8881",
		light_design_low = "#192034",
		light_design_med = "#222c44",
		light_design_high = "#363f53",
		none = "NONE",
	},
	main = {
		_nc = "#1d263a",
		base = "#1d263a",
		surface = "#223244",
		overlay = "#2c4259",
		muted = "#687a87",
		mistery = "#a3cbd2",
		text = "#e0f0f0",
		tlc = "#da81aa",
		sunshower = "#dfdf90",
		sole = "#d7a275",
		birds = "#4fa190",
		never_enough = "#a3cbd2",
		gravity = "#75a6eb",
		generator = "#da8881",
		light_design_low = "#222b44",
		light_design_med = "#3c465d",
		light_design_high = "#545b6d",
		none = "NONE",
	},
}

if options.palette ~= nil and next(options.palette) then
	-- handle variant specific overrides
	for variant_name, override_palette in pairs(options.palette) do
		if variants[variant_name] then
			variants[variant_name] = vim.tbl_extend("force", variants[variant_name], override_palette or {})
		end
	end
end

if variants[options.variant] ~= nil then
	return variants[options.variant]
end

return variants[options.dark_variant or "main"]
