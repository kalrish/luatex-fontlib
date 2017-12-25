local fontloader_open = fontloader.open

return function(otf_path)
	return fontloader_open(otf_path)
end
