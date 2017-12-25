local fontloader_open = fontloader.open

return function(ttc_path, name)
	return fontloader_open(ttc_path, name)
end
