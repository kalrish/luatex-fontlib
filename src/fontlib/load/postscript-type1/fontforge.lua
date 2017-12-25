local fontloader_open = fontloader.open
local fontloader_apply_afmfile = fontloader.apply_afmfile
local fontloader_close = fontloader.close

return function(afm_path, pfx_path)
	local font, warnings = fontloader_open(pfx_path)
	if font then
		local errors = fontloader_apply_afmfile(font, afm_path)
		if not errors then
			return font, warnings
		else
			-- couldn't apply AFM file
			
			fontloader_close(font)
			
			return font, warnings, errors
		end
	else
		return nil, warnings
	end
end
