local fontloader_to_table = fontloader.to_table
local fontloader_close = fontloader.close

return function(font, metrics, ...)
	local font_table = fontloader_to_table(font)
	
	fontloader_close(font)
	
	--print_table(font_table)
	
	return metrics(font_table, ...)
end
