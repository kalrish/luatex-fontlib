local pairs = pairs
--local string_gsub = string.gsub

return function(font, size)
	local units_per_em = font.units_per_em or 2048
	
	local characters = {}
	do
		local font_glyphs = font.glyphs
		local font_map = font.map
		local font_map_map = font_map.map
		local font_map_backmap = font_map.backmap
	
		local mag = size / units_per_em
		
		local names_of_char = {}
		
		for code_point, glyph in pairs(font_map_map) do
			names_of_char[font_glyphs[glyph].name] = font_map_backmap[glyph]
		end
		
		for code_point, glyph in pairs(font_map_map) do
			local glyph_table = font_glyphs[glyph]
			if glyph_table then
				local kerns
				
				do
					local glyph_kerns = glyph_table.kerns
					if glyph_kerns then
						kerns = {}
						for _, kern in pairs(glyph_kerns) do
							kerns[names_of_char[kern.char]] = kern.off * mag
						end
					end
				end
				
				local glyph_boundingbox = glyph_table.boundingbox
				
				characters[code_point] = {
					index = glyph,
					--tounicode = code_point,
					name = glyph_table.name,
					width = glyph_table.width * mag,
					height = glyph_boundingbox[4] * mag,
					depth = -glyph_boundingbox[2] * mag,
					kerns = kerns
					--right_protruding = 1000
				}
			end
		end
	end
	
	return {
		--psname = font.names[1].postscriptname or string_gsub(font.names[1].names.fullname, "[^abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-]", ""),
		psname = font.fontname,
		fullname = font.names[1].names.fullname,
		size = size,
		designsize = size, -- font.designsize * 6553.6
		direction = 0,
		units_per_em = units_per_em,
		parameters = {
			slant = font.italicangle,
			space = size * 0.25,
			space_stretch = size * 0.3,
			space_shrink = size * 0.1,
			--x_height = size * 0.4,
			x_height = font.pfminfo.os2_xheight,
			quad = size * 1.0,
			extra_space = 0
		},
		characters = characters,
		nomath = true,
		--cidinfo = {
		--	registry = "Adobe",
		--	ordering = "Identity",
		--	supplement = 0,
		--	version = 1
		--}
	}
end
