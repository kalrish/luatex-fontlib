local fontloader_open = fontloader.open

return function(name)
	return fontloader_open(ttf_path)
end
