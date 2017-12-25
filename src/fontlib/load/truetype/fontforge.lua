local fontloader_open = fontloader.open

return function(ttf_path)
	return fontloader_open(ttf_path)
end
