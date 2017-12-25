local pairs = pairs

return function(font, size)
	local units_per_em = 1000 -- font.units_per_em
	
	local characters = {}
	do
		local font_glyphs = font.glyphs
		local font_glyphmin, font_glyphmax = font.glyphmin, font.glyphmax
		
		local mag = size / units_per_em
		
		local name2index = {}
		
		for i = font_glyphmin, font_glyphmax do
			local glyph = font_glyphs[i]
			if glyph then
				name2index[glyph.name] = glyph.unicode
			end
		end
		
		for i = font_glyphmin, font_glyphmax do
			local glyph = font_glyphs[i]
			if glyph then
				local kerns
				do
					local glyph_kerns = glyph.kerns
					if glyph_kerns then
						kerns = {}
						for _, kern in pairs(glyph_kerns) do
							local dest = name2index[kern.char]
							if dest > 0 then
								kerns[dest] = kern.off * mag
							end
						end
					end
				end
				
				local code_point = glyph.unicode
				
				local glyph_boundingbox = glyph.boundingbox
				
				characters[code_point] = {
					index = i,
					--tounicode = code_point,
					name = glyph.name,
					width = glyph.width * mag,
					height = glyph_boundingbox[4] * mag,
					depth = -glyph_boundingbox[2] * mag,
					kerns = kerns
				}
			end
		end
	end
	
	return {
		psname = font.fontname,
		fullname = font.fullname,
		encodingbytes = 2,
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
		--tounicode = 1,
		nomath = true,
		--cidinfo = {
		--	registry = "Adobe",
		--	ordering = "Identity",
		--	supplement = 0,
		--	version = 1
		--}
	}
end
