local fontloader_to_table = fontloader.to_table
local fontloader_close = fontloader.close

return function(font, metrics, ...)
	--print_table(font)
	
	metrics = metrics(font, ...)
	
	fontloader_close(font)
	
	return metrics
end
